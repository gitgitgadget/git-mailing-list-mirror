From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCH 1/3] Move pack_refs() and friends into libgit
Date: Sat, 22 Mar 2008 02:12:34 +0100
Message-ID: <200803220212.34429.johan@herland.net>
References: <200803220210.30957.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Mar 22 02:13:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcsIV-0005JI-7O
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 02:13:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282AbYCVBMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 21:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754136AbYCVBMm
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 21:12:42 -0400
Received: from smtp.getmail.no ([84.208.20.33]:35574 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754086AbYCVBMk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 21:12:40 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JY30070JY13OV00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 22 Mar 2008 02:12:39 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JY3000RCY0Y8R30@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 22 Mar 2008 02:12:34 +0100 (CET)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JY3001HMY0YJ930@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 22 Mar 2008 02:12:34 +0100 (CET)
In-reply-to: <200803220210.30957.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77781>

This moves pack_refs() and underlying functionality into the library,
to make pack-refs functionality easily available to all git programs.

Most of builtin-pack-refs.c has been moved verbatim into a new file
pack-refs.c that is compiled into libgit.a. A corresponding header
file, pack-refs.h, has also been added, declaring pack_refs() and
the #defines associated with the flags parameter to pack_refs().

This patch introduces no other changes in functionality.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Makefile            |    5 +-
 builtin-pack-refs.c |  121 +--------------------------------------------------
 pack-refs.c         |  117 +++++++++++++++++++++++++++++++++++++++++++++++++
 pack-refs.h         |   18 ++++++++
 4 files changed, 139 insertions(+), 122 deletions(-)
 create mode 100644 pack-refs.c
 create mode 100644 pack-refs.h

diff --git a/Makefile b/Makefile
index 623c639..0804904 100644
--- a/Makefile
+++ b/Makefile
@@ -307,7 +307,8 @@ LIB_H = \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
 	utf8.h reflog-walk.h patch-ids.h attr.h decorate.h progress.h \
-	mailmap.h remote.h parse-options.h transport.h diffcore.h hash.h ll-merge.h fsck.h pack-revindex.h
+	mailmap.h remote.h parse-options.h transport.h diffcore.h hash.h \
+	ll-merge.h fsck.h pack-revindex.h pack-refs.h
 
 DIFF_OBJS = \
 	diff.o diff-lib.o diffcore-break.o diffcore-order.o \
@@ -331,7 +332,7 @@ LIB_OBJS = \
 	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
 	convert.o attr.o decorate.o progress.o mailmap.o symlinks.o remote.o \
 	transport.o bundle.o walker.o parse-options.o ws.o archive.o branch.o \
-	ll-merge.o alias.o fsck.o pack-revindex.o
+	ll-merge.o alias.o fsck.o pack-revindex.o pack-refs.o
 
 BUILTIN_OBJS = \
 	builtin-add.o \
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
diff --git a/pack-refs.c b/pack-refs.c
new file mode 100644
index 0000000..848d311
--- /dev/null
+++ b/pack-refs.c
@@ -0,0 +1,117 @@
+#include "cache.h"
+#include "refs.h"
+#include "tag.h"
+#include "pack-refs.h"
+
+struct ref_to_prune {
+	struct ref_to_prune *next;
+	unsigned char sha1[20];
+	char name[FLEX_ARRAY];
+};
+
+struct pack_refs_cb_data {
+	unsigned int flags;
+	struct ref_to_prune *ref_to_prune;
+	FILE *refs_file;
+};
+
+static int do_not_prune(int flags)
+{
+	/* If it is already packed or if it is a symref,
+	 * do not prune it.
+	 */
+	return (flags & (REF_ISSYMREF|REF_ISPACKED));
+}
+
+static int handle_one_ref(const char *path, const unsigned char *sha1,
+			  int flags, void *cb_data)
+{
+	struct pack_refs_cb_data *cb = cb_data;
+	int is_tag_ref;
+
+	/* Do not pack the symbolic refs */
+	if ((flags & REF_ISSYMREF))
+		return 0;
+	is_tag_ref = !prefixcmp(path, "refs/tags/");
+
+	/* ALWAYS pack refs that were already packed or are tags */
+	if (!(cb->flags & PACK_REFS_ALL) && !is_tag_ref && !(flags & REF_ISPACKED))
+		return 0;
+
+	fprintf(cb->refs_file, "%s %s\n", sha1_to_hex(sha1), path);
+	if (is_tag_ref) {
+		struct object *o = parse_object(sha1);
+		if (o->type == OBJ_TAG) {
+			o = deref_tag(o, path, 0);
+			if (o)
+				fprintf(cb->refs_file, "^%s\n",
+					sha1_to_hex(o->sha1));
+		}
+	}
+
+	if ((cb->flags & PACK_REFS_PRUNE) && !do_not_prune(flags)) {
+		int namelen = strlen(path) + 1;
+		struct ref_to_prune *n = xcalloc(1, sizeof(*n) + namelen);
+		hashcpy(n->sha1, sha1);
+		strcpy(n->name, path);
+		n->next = cb->ref_to_prune;
+		cb->ref_to_prune = n;
+	}
+	return 0;
+}
+
+/* make sure nobody touched the ref, and unlink */
+static void prune_ref(struct ref_to_prune *r)
+{
+	struct ref_lock *lock = lock_ref_sha1(r->name + 5, r->sha1);
+
+	if (lock) {
+		unlink(git_path("%s", r->name));
+		unlock_ref(lock);
+	}
+}
+
+static void prune_refs(struct ref_to_prune *r)
+{
+	while (r) {
+		prune_ref(r);
+		r = r->next;
+	}
+}
+
+static struct lock_file packed;
+
+int pack_refs(unsigned int flags)
+{
+	int fd;
+	struct pack_refs_cb_data cbdata;
+
+	memset(&cbdata, 0, sizeof(cbdata));
+	cbdata.flags = flags;
+
+	fd = hold_lock_file_for_update(&packed, git_path("packed-refs"), 1);
+	cbdata.refs_file = fdopen(fd, "w");
+	if (!cbdata.refs_file)
+		die("unable to create ref-pack file structure (%s)",
+		    strerror(errno));
+
+	/* perhaps other traits later as well */
+	fprintf(cbdata.refs_file, "# pack-refs with: peeled \n");
+
+	for_each_ref(handle_one_ref, &cbdata);
+	if (ferror(cbdata.refs_file))
+		die("failed to write ref-pack file");
+	if (fflush(cbdata.refs_file) || fsync(fd) || fclose(cbdata.refs_file))
+		die("failed to write ref-pack file (%s)", strerror(errno));
+	/*
+	 * Since the lock file was fdopen()'ed and then fclose()'ed above,
+	 * assign -1 to the lock file descriptor so that commit_lock_file()
+	 * won't try to close() it.
+	 */
+	packed.fd = -1;
+	if (commit_lock_file(&packed) < 0)
+		die("unable to overwrite old ref-pack file (%s)", strerror(errno));
+	if (cbdata.flags & PACK_REFS_PRUNE)
+		prune_refs(cbdata.ref_to_prune);
+	return 0;
+}
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
1.5.5.rc0.117.ga5237
