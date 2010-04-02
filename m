From: Jeff King <peff@peff.net>
Subject: [PATCH 4/7] introduce notes-cache interface
Date: Thu, 1 Apr 2010 20:07:40 -0400
Message-ID: <20100402000739.GD16462@coredump.intra.peff.net>
References: <20100402000159.GA15101@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 02 02:07:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxUQX-0000kZ-9w
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 02:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759004Ab0DBAHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 20:07:53 -0400
Received: from peff.net ([208.65.91.99]:60284 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755400Ab0DBAHv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 20:07:51 -0400
Received: (qmail 5205 invoked by uid 107); 2 Apr 2010 00:08:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 01 Apr 2010 20:08:27 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Apr 2010 20:07:40 -0400
Content-Disposition: inline
In-Reply-To: <20100402000159.GA15101@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143765>

Notes provide a fast lookup mechanism for data keyed by
sha1. This is ideal for caching certain operations, like
textconv filters.

This patch builds some infrastructure to make it simpler to
use notes trees as caches. In particular, caches:

  1. don't have arbitrary commit messages. They store a
     cache validity string in the commit, and clear the tree
     when the cache validity string changes.

  2. don't keep any commit history. The accumulated history
     of a a cache is just useless cruft.

  3. use a looser form of locking for ref updates. If two
     processes try to write to the cache simultaneously, it
     is OK if one overwrites the other, losing some changes.
     It's just a cache, so we will just end up with an extra
     miss.

Signed-off-by: Jeff King <peff@peff.net>
---
I tried lib-ifying commit_notes from builtin/notes.c, but for the
reasons mentioned above, plus the totally different error handling (we
need silent error returns because not writing to the cache should not be
fatal), the code ended up having more "if (quiet)" and "if (nohistory)"
than there was actual code. The notes_cache_write below ended up pretty
terse and readable, I think.

 Makefile      |    2 +
 notes-cache.c |   94 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 notes-cache.h |   20 ++++++++++++
 3 files changed, 116 insertions(+), 0 deletions(-)
 create mode 100644 notes-cache.c
 create mode 100644 notes-cache.h

diff --git a/Makefile b/Makefile
index 8a0f5c4..24e92ab 100644
--- a/Makefile
+++ b/Makefile
@@ -486,6 +486,7 @@ LIB_H += log-tree.h
 LIB_H += mailmap.h
 LIB_H += merge-recursive.h
 LIB_H += notes.h
+LIB_H += notes-cache.h
 LIB_H += object.h
 LIB_H += pack.h
 LIB_H += pack-refs.h
@@ -575,6 +576,7 @@ LIB_OBJS += merge-file.o
 LIB_OBJS += merge-recursive.o
 LIB_OBJS += name-hash.o
 LIB_OBJS += notes.o
+LIB_OBJS += notes-cache.o
 LIB_OBJS += object.o
 LIB_OBJS += pack-check.o
 LIB_OBJS += pack-refs.o
diff --git a/notes-cache.c b/notes-cache.c
new file mode 100644
index 0000000..dee6d62
--- /dev/null
+++ b/notes-cache.c
@@ -0,0 +1,94 @@
+#include "cache.h"
+#include "notes-cache.h"
+#include "commit.h"
+#include "refs.h"
+
+static int notes_cache_match_validity(const char *ref, const char *validity)
+{
+	unsigned char sha1[20];
+	struct commit *commit;
+	struct pretty_print_context pretty_ctx;
+	struct strbuf msg = STRBUF_INIT;
+	int ret;
+
+	if (read_ref(ref, sha1) < 0)
+		return 0;
+
+	commit = lookup_commit_reference_gently(sha1, 1);
+	if (!commit)
+		return 0;
+
+	memset(&pretty_ctx, 0, sizeof(pretty_ctx));
+	format_commit_message(commit, "%s", &msg, &pretty_ctx);
+	strbuf_trim(&msg);
+
+	ret = !strcmp(msg.buf, validity);
+	strbuf_release(&msg);
+
+	return ret;
+}
+
+void notes_cache_init(struct notes_cache *c, const char *name,
+		     const char *validity)
+{
+	struct strbuf ref = STRBUF_INIT;
+	int flags = 0;
+
+	memset(c, 0, sizeof(*c));
+	c->validity = xstrdup(validity);
+
+	strbuf_addf(&ref, "refs/notes/%s", name);
+	if (!notes_cache_match_validity(ref.buf, validity))
+		flags = NOTES_INIT_EMPTY;
+	init_notes(&c->tree, ref.buf, combine_notes_overwrite, flags);
+	strbuf_release(&ref);
+}
+
+int notes_cache_write(struct notes_cache *c)
+{
+	unsigned char tree_sha1[20];
+	unsigned char commit_sha1[20];
+
+	if (!c || !c->tree.initialized || !c->tree.ref || !*c->tree.ref)
+		return -1;
+	if (!c->tree.dirty)
+		return 0;
+
+	if (write_notes_tree(&c->tree, tree_sha1))
+		return -1;
+	if (commit_tree(c->validity, tree_sha1, NULL, commit_sha1, NULL) < 0)
+		return -1;
+	if (update_ref("update notes cache", c->tree.ref, commit_sha1, NULL,
+		       0, QUIET_ON_ERR) < 0)
+		return -1;
+
+	return 0;
+}
+
+char *notes_cache_get(struct notes_cache *c, unsigned char key_sha1[20],
+		      size_t *outsize)
+{
+	const unsigned char *value_sha1;
+	enum object_type type;
+	char *value;
+	unsigned long size;
+
+	value_sha1 = get_note(&c->tree, key_sha1);
+	if (!value_sha1)
+		return NULL;
+	value = read_sha1_file(value_sha1, &type, &size);
+
+	*outsize = size;
+	return value;
+}
+
+int notes_cache_put(struct notes_cache *c, unsigned char key_sha1[20],
+		    const char *data, size_t size)
+{
+	unsigned char value_sha1[20];
+
+	if (write_sha1_file(data, size, "blob", value_sha1) < 0)
+		return -1;
+	add_note(&c->tree, key_sha1, value_sha1, NULL);
+	return 0;
+}
diff --git a/notes-cache.h b/notes-cache.h
new file mode 100644
index 0000000..356f88f
--- /dev/null
+++ b/notes-cache.h
@@ -0,0 +1,20 @@
+#ifndef NOTES_CACHE_H
+#define NOTES_CACHE_H
+
+#include "notes.h"
+
+struct notes_cache {
+	struct notes_tree tree;
+	char *validity;
+};
+
+void notes_cache_init(struct notes_cache *c, const char *name,
+		     const char *validity);
+int notes_cache_write(struct notes_cache *c);
+
+char *notes_cache_get(struct notes_cache *c, unsigned char sha1[20], size_t
+		      *outsize);
+int notes_cache_put(struct notes_cache *c, unsigned char sha1[20],
+		    const char *data, size_t size);
+
+#endif /* NOTES_CACHE_H */
-- 
1.7.0.4.299.gba9d4
