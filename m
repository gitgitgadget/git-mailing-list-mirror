From: Johan Herland <johan@herland.net>
Subject: [PATCH 2/4 v2] Move pack_refs() and friends into libgit
Date: Sun, 15 Jun 2008 23:27:24 +0200
Message-ID: <200806152327.24586.johan@herland.net>
References: <200806151602.03445.johan@herland.net>
 <200806151605.07008.johan@herland.net>
 <20080615175159.GA6127@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 15 23:29:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7zmh-0005wM-Rh
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 23:29:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596AbYFOV2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 17:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752644AbYFOV2S
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 17:28:18 -0400
Received: from smtp.getmail.no ([84.208.20.33]:54057 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752344AbYFOV2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 17:28:16 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K2I0032PWZ3UX00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 15 Jun 2008 23:28:15 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K2I00L4LWXO7050@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 15 Jun 2008 23:27:25 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K2I00HG6WXOC5E0@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 15 Jun 2008 23:27:24 +0200 (CEST)
In-reply-to: <20080615175159.GA6127@sigill.intra.peff.net>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85122>

This moves pack_refs() and underlying functionality into the library,
to make pack-refs functionality easily available to all git programs.

Most of builtin-pack-refs.c has been moved verbatim into a new file
pack-refs.c that is compiled into libgit.a. A corresponding header
file, pack-refs.h, has also been added, declaring pack_refs() and
the #defines associated with the flags parameter to pack_refs().

This patch introduces no other changes in functionality.

Signed-off-by: Johan Herland <johan@herland.net>
---

On Sunday 15 June 2008, Jeff King wrote:
> This patch would have been a lot easier to read, btw, if it had been
> generated with '-C' (then patch to pack-refs.c is based on
> builtin-pack-refs instead of /dev/null).

Sorry about that. Here you go.

...Johan	


 Makefile                           |    2 +
 builtin-pack-refs.c                |  121 +-----------------------------------
 builtin-pack-refs.c => pack-refs.c |   27 +--------
 pack-refs.h                        |   18 +++++
 4 files changed, 23 insertions(+), 145 deletions(-)
 copy builtin-pack-refs.c => pack-refs.c (80%)
 create mode 100644 pack-refs.h

diff --git a/Makefile b/Makefile
index 1937507..4a78388 100644
--- a/Makefile
+++ b/Makefile
@@ -354,6 +354,7 @@ LIB_H += log-tree.h
 LIB_H += mailmap.h
 LIB_H += object.h
 LIB_H += pack.h
+LIB_H += pack-refs.h
 LIB_H += pack-revindex.h
 LIB_H += parse-options.h
 LIB_H += patch-ids.h
@@ -429,6 +430,7 @@ LIB_OBJS += merge-file.o
 LIB_OBJS += name-hash.o
 LIB_OBJS += object.o
 LIB_OBJS += pack-check.o
+LIB_OBJS += pack-refs.o
 LIB_OBJS += pack-revindex.o
 LIB_OBJS += pack-write.o
 LIB_OBJS += pager.o
diff --git a/builtin-pack-refs.c b/builtin-pack-refs.c
index 1aaa76d..ff90aef 100644
--- a/builtin-pack-refs.c
+++ b/builtin-pack-refs.c
@@ -1,125 +1,6 @@
-#include "builtin.h"
 #include "cache.h"
-#include "refs.h"
-#include "object.h"
-#include "tag.h"
 #include "parse-options.h"
-
-struct ref_to_prune {
-	struct ref_to_prune *next;
-	unsigned char sha1[20];
-	char name[FLEX_ARRAY];
-};
-
-#define PACK_REFS_PRUNE	0x0001
-#define PACK_REFS_ALL	0x0002
-
-struct pack_refs_cb_data {
-	unsigned int flags;
-	struct ref_to_prune *ref_to_prune;
-	FILE *refs_file;
-};
-
-static int do_not_prune(int flags)
-{
-	/* If it is already packed or if it is a symref,
-	 * do not prune it.
-	 */
-	return (flags & (REF_ISSYMREF|REF_ISPACKED));
-}
-
-static int handle_one_ref(const char *path, const unsigned char *sha1,
-			  int flags, void *cb_data)
-{
-	struct pack_refs_cb_data *cb = cb_data;
-	int is_tag_ref;
-
-	/* Do not pack the symbolic refs */
-	if ((flags & REF_ISSYMREF))
-		return 0;
-	is_tag_ref = !prefixcmp(path, "refs/tags/");
-
-	/* ALWAYS pack refs that were already packed or are tags */
-	if (!(cb->flags & PACK_REFS_ALL) && !is_tag_ref && !(flags & REF_ISPACKED))
-		return 0;
-
-	fprintf(cb->refs_file, "%s %s\n", sha1_to_hex(sha1), path);
-	if (is_tag_ref) {
-		struct object *o = parse_object(sha1);
-		if (o->type == OBJ_TAG) {
-			o = deref_tag(o, path, 0);
-			if (o)
-				fprintf(cb->refs_file, "^%s\n",
-					sha1_to_hex(o->sha1));
-		}
-	}
-
-	if ((cb->flags & PACK_REFS_PRUNE) && !do_not_prune(flags)) {
-		int namelen = strlen(path) + 1;
-		struct ref_to_prune *n = xcalloc(1, sizeof(*n) + namelen);
-		hashcpy(n->sha1, sha1);
-		strcpy(n->name, path);
-		n->next = cb->ref_to_prune;
-		cb->ref_to_prune = n;
-	}
-	return 0;
-}
-
-/* make sure nobody touched the ref, and unlink */
-static void prune_ref(struct ref_to_prune *r)
-{
-	struct ref_lock *lock = lock_ref_sha1(r->name + 5, r->sha1);
-
-	if (lock) {
-		unlink(git_path("%s", r->name));
-		unlock_ref(lock);
-	}
-}
-
-static void prune_refs(struct ref_to_prune *r)
-{
-	while (r) {
-		prune_ref(r);
-		r = r->next;
-	}
-}
-
-static struct lock_file packed;
-
-static int pack_refs(unsigned int flags)
-{
-	int fd;
-	struct pack_refs_cb_data cbdata;
-
-	memset(&cbdata, 0, sizeof(cbdata));
-	cbdata.flags = flags;
-
-	fd = hold_lock_file_for_update(&packed, git_path("packed-refs"), 1);
-	cbdata.refs_file = fdopen(fd, "w");
-	if (!cbdata.refs_file)
-		die("unable to create ref-pack file structure (%s)",
-		    strerror(errno));
-
-	/* perhaps other traits later as well */
-	fprintf(cbdata.refs_file, "# pack-refs with: peeled \n");
-
-	for_each_ref(handle_one_ref, &cbdata);
-	if (ferror(cbdata.refs_file))
-		die("failed to write ref-pack file");
-	if (fflush(cbdata.refs_file) || fsync(fd) || fclose(cbdata.refs_file))
-		die("failed to write ref-pack file (%s)", strerror(errno));
-	/*
-	 * Since the lock file was fdopen()'ed and then fclose()'ed above,
-	 * assign -1 to the lock file descriptor so that commit_lock_file()
-	 * won't try to close() it.
-	 */
-	packed.fd = -1;
-	if (commit_lock_file(&packed) < 0)
-		die("unable to overwrite old ref-pack file (%s)", strerror(errno));
-	if (cbdata.flags & PACK_REFS_PRUNE)
-		prune_refs(cbdata.ref_to_prune);
-	return 0;
-}
+#include "pack-refs.h"
 
 static char const * const pack_refs_usage[] = {
 	"git-pack-refs [options]",
diff --git a/builtin-pack-refs.c b/pack-refs.c
similarity index 80%
copy from builtin-pack-refs.c
copy to pack-refs.c
index 1aaa76d..848d311 100644
--- a/builtin-pack-refs.c
+++ b/pack-refs.c
@@ -1,9 +1,7 @@
-#include "builtin.h"
 #include "cache.h"
 #include "refs.h"
-#include "object.h"
 #include "tag.h"
-#include "parse-options.h"
+#include "pack-refs.h"
 
 struct ref_to_prune {
 	struct ref_to_prune *next;
@@ -11,9 +9,6 @@ struct ref_to_prune {
 	char name[FLEX_ARRAY];
 };
 
-#define PACK_REFS_PRUNE	0x0001
-#define PACK_REFS_ALL	0x0002
-
 struct pack_refs_cb_data {
 	unsigned int flags;
 	struct ref_to_prune *ref_to_prune;
@@ -86,7 +81,7 @@ static void prune_refs(struct ref_to_prune *r)
 
 static struct lock_file packed;
 
-static int pack_refs(unsigned int flags)
+int pack_refs(unsigned int flags)
 {
 	int fd;
 	struct pack_refs_cb_data cbdata;
@@ -120,21 +115,3 @@ static int pack_refs(unsigned int flags)
 		prune_refs(cbdata.ref_to_prune);
 	return 0;
 }
-
-static char const * const pack_refs_usage[] = {
-	"git-pack-refs [options]",
-	NULL
-};
-
-int cmd_pack_refs(int argc, const char **argv, const char *prefix)
-{
-	unsigned int flags = PACK_REFS_PRUNE;
-	struct option opts[] = {
-		OPT_BIT(0, "all",   &flags, "pack everything", PACK_REFS_ALL),
-		OPT_BIT(0, "prune", &flags, "prune loose refs (default)", PACK_REFS_PRUNE),
-		OPT_END(),
-	};
-	if (parse_options(argc, argv, opts, pack_refs_usage, 0))
-		usage_with_options(pack_refs_usage, opts);
-	return pack_refs(flags);
-}
diff --git a/pack-refs.h b/pack-refs.h
new file mode 100644
index 0000000..518acfb
--- /dev/null
+++ b/pack-refs.h
@@ -0,0 +1,18 @@
+#ifndef PACK_REFS_H
+#define PACK_REFS_H
+
+/*
+ * Flags for controlling behaviour of pack_refs()
+ * PACK_REFS_PRUNE: Prune loose refs after packing
+ * PACK_REFS_ALL:   Pack _all_ refs, not just tags and already packed refs
+ */
+#define PACK_REFS_PRUNE 0x0001
+#define PACK_REFS_ALL   0x0002
+
+/*
+ * Write a packed-refs file for the current repository.
+ * flags: Combination of the above PACK_REFS_* flags.
+ */
+int pack_refs(unsigned int flags);
+
+#endif /* PACK_REFS_H */
-- 
1.5.6.rc2.128.gf64ae
