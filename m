From: Jeff King <peff@peff.net>
Subject: [PATCH 4/6] introduce a commit metapack
Date: Tue, 29 Jan 2013 04:16:11 -0500
Message-ID: <20130129091610.GD9999@sigill.intra.peff.net>
References: <20130129091434.GA6975@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 29 10:16:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U07J0-0007xh-28
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 10:16:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755409Ab3A2JQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 04:16:16 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53251 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754836Ab3A2JQO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 04:16:14 -0500
Received: (qmail 20025 invoked by uid 107); 29 Jan 2013 09:17:36 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Jan 2013 04:17:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jan 2013 04:16:11 -0500
Content-Disposition: inline
In-Reply-To: <20130129091434.GA6975@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214920>

When we are doing a commit traversal that does not need to
look at the commit messages themselves (e.g., rev-list,
merge-base, etc), we spend a lot of time accessing,
decompressing, and parsing the commit objects just to find
the parent and timestamp information. We can make a
space-time tradeoff by caching that information on disk in a
compact, uncompressed format.

TODO: document on-disk format in Documentation/technical
TODO: document API

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile          |   2 +
 commit-metapack.c | 175 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 commit-metapack.h |  12 ++++
 3 files changed, 189 insertions(+)
 create mode 100644 commit-metapack.c
 create mode 100644 commit-metapack.h

diff --git a/Makefile b/Makefile
index 3e4ae1b..6ca5320 100644
--- a/Makefile
+++ b/Makefile
@@ -619,6 +619,7 @@ LIB_H += column.h
 LIB_H += cache.h
 LIB_H += color.h
 LIB_H += column.h
+LIB_H += commit-metapack.h
 LIB_H += commit.h
 LIB_H += compat/bswap.h
 LIB_H += compat/cygwin.h
@@ -730,6 +731,7 @@ LIB_OBJS += combine-diff.o
 LIB_OBJS += color.o
 LIB_OBJS += column.o
 LIB_OBJS += combine-diff.o
+LIB_OBJS += commit-metapack.o
 LIB_OBJS += commit.o
 LIB_OBJS += compat/obstack.o
 LIB_OBJS += compat/terminal.o
diff --git a/commit-metapack.c b/commit-metapack.c
new file mode 100644
index 0000000..2c19f48
--- /dev/null
+++ b/commit-metapack.c
@@ -0,0 +1,175 @@
+#include "cache.h"
+#include "commit-metapack.h"
+#include "metapack.h"
+#include "commit.h"
+#include "sha1-lookup.h"
+
+struct commit_metapack {
+	struct metapack mp;
+	uint32_t nr;
+	unsigned char *index;
+	unsigned char *data;
+	struct commit_metapack *next;
+};
+static struct commit_metapack *commit_metapacks;
+
+static struct commit_metapack *alloc_commit_metapack(struct packed_git *pack)
+{
+	struct commit_metapack *it = xcalloc(1, sizeof(*it));
+	uint32_t version;
+
+	if (metapack_init(&it->mp, pack, "commits", &version) < 0) {
+		free(it);
+		return NULL;
+	}
+	if (version != 1) {
+		/*
+		 * This file comes from a more recent git version. Don't bother
+		 * warning the user, as we'll just fallback to reading the
+		 * commits.
+		 */
+		metapack_close(&it->mp);
+		free(it);
+		return NULL;
+	}
+
+	if (it->mp.len < 4) {
+		warning("commit metapack for '%s' is truncated", pack->pack_name);
+		metapack_close(&it->mp);
+		free(it);
+		return NULL;
+	}
+	memcpy(&it->nr, it->mp.data, 4);
+	it->nr = ntohl(it->nr);
+
+	/*
+	 * We need 84 bytes for each entry: sha1(20), date(4), tree(20),
+	 * parents(40).
+	 */
+	if (it->mp.len < (84 * it->nr + 4)) {
+		warning("commit metapack for '%s' is truncated", pack->pack_name);
+		metapack_close(&it->mp);
+		free(it);
+		return NULL;
+	}
+
+	it->index = it->mp.data + 4;
+	it->data = it->index + 20 * it->nr;
+
+	return it;
+}
+
+static void prepare_commit_metapacks(void)
+{
+	static int initialized;
+	struct commit_metapack **tail = &commit_metapacks;
+	struct packed_git *p;
+
+	if (initialized)
+		return;
+
+	prepare_packed_git();
+	for (p = packed_git; p; p = p->next) {
+		struct commit_metapack *it = alloc_commit_metapack(p);
+
+		if (it) {
+			*tail = it;
+			tail = &it->next;
+		}
+	}
+
+	initialized = 1;
+}
+
+int commit_metapack(unsigned char *sha1,
+		    uint32_t *timestamp,
+		    unsigned char **tree,
+		    unsigned char **parent1,
+		    unsigned char **parent2)
+{
+	struct commit_metapack *p;
+
+	prepare_commit_metapacks();
+	for (p = commit_metapacks; p; p = p->next) {
+		unsigned char *data;
+		int pos = sha1_entry_pos(p->index, 20, 0, 0, p->nr, p->nr, sha1);
+		if (pos < 0)
+			continue;
+
+		/* timestamp(4) + tree(20) + parents(40) */
+		data = p->data + 64 * pos;
+		*timestamp = *(uint32_t *)data;
+		*timestamp = ntohl(*timestamp);
+		data += 4;
+		*tree = data;
+		data += 20;
+		*parent1 = data;
+		data += 20;
+		*parent2 = data;
+
+		return 0;
+	}
+
+	return -1;
+}
+
+static void get_commits(struct metapack_writer *mw,
+			const unsigned char *sha1,
+			void *data)
+{
+	struct commit_list ***tail = data;
+	enum object_type type = sha1_object_info(sha1, NULL);
+	struct commit *c;
+
+	if (type != OBJ_COMMIT)
+		return;
+
+	c = lookup_commit(sha1);
+	if (!c || parse_commit(c))
+		die("unable to read commit %s", sha1_to_hex(sha1));
+
+	/*
+	 * Our fixed-size parent list cannot represent root commits, nor
+	 * octopus merges. Just skip those commits, as we can fallback
+	 * in those rare cases to reading the actual commit object.
+	 */
+	if (!c->parents ||
+	    (c->parents && c->parents->next && c->parents->next->next))
+		return;
+
+	*tail = &commit_list_insert(c, *tail)->next;
+}
+
+void commit_metapack_write(const char *idx)
+{
+	struct metapack_writer mw;
+	struct commit_list *commits = NULL, *p;
+	struct commit_list **tail = &commits;
+	uint32_t nr = 0;
+
+	metapack_writer_init(&mw, idx, "commits", 1);
+
+	/* Figure out how many eligible commits we've got in this pack. */
+	metapack_writer_foreach(&mw, get_commits, &tail);
+	for (p = commits; p; p = p->next)
+		nr++;
+	metapack_writer_add_uint32(&mw, nr);
+
+	/* Then write an index of commit sha1s */
+	for (p = commits; p; p = p->next)
+		metapack_writer_add(&mw, p->item->object.sha1, 20);
+
+	/* Followed by the actual date/tree/parents data */
+	for (p = commits; p; p = p->next) {
+		struct commit *c = p->item;
+		metapack_writer_add_uint32(&mw, c->date);
+		metapack_writer_add(&mw, c->tree->object.sha1, 20);
+		metapack_writer_add(&mw, c->parents->item->object.sha1, 20);
+		metapack_writer_add(&mw,
+				    c->parents->next ?
+				    c->parents->next->item->object.sha1 :
+				    null_sha1, 20);
+	}
+
+	metapack_writer_finish(&mw);
+}
diff --git a/commit-metapack.h b/commit-metapack.h
new file mode 100644
index 0000000..4684573
--- /dev/null
+++ b/commit-metapack.h
@@ -0,0 +1,12 @@
+#ifndef METAPACK_COMMIT_H
+#define METAPACK_COMMIT_H
+
+int commit_metapack(unsigned char *sha1,
+		    uint32_t *timestamp,
+		    unsigned char **tree,
+		    unsigned char **parent1,
+		    unsigned char **parent2);
+
+void commit_metapack_write(const char *idx_file);
+
+#endif
-- 
1.8.0.2.16.g72e2fc9
