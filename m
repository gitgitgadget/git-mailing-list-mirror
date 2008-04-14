From: Johan Herland <johan@herland.net>
Subject: [PATCH 2/4] Move pack_refs() and friends into libgit
Date: Mon, 14 Apr 2008 10:02:50 +0200
Message-ID: <200804141002.50293.johan@herland.net>
References: <200803220210.30957.johan@herland.net>
 <alpine.LNX.1.00.0804140205040.19665@iabervon.org>
 <200804141000.09515.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Apr 14 10:04:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlJfy-0007Vw-SU
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 10:04:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755087AbYDNIDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 04:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755542AbYDNIDp
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 04:03:45 -0400
Received: from smtp.getmail.no ([84.208.20.33]:33890 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755087AbYDNIDn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 04:03:43 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JZB0000X2E6C900@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 14 Apr 2008 10:03:42 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JZB009M12CQRX40@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 14 Apr 2008 10:02:50 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JZB00K5U2CQMYA0@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 14 Apr 2008 10:02:50 +0200 (CEST)
In-reply-to: <200804141000.09515.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79484>

This moves pack_refs() and underlying functionality into the library,
to make pack-refs functionality easily available to all git programs.

Most of builtin-pack-refs.c has been moved verbatim into a new file
pack-refs.c that is compiled into libgit.a. A corresponding header
file, pack-refs.h, has also been added, declaring pack_refs() and
the #defines associated with the flags parameter to pack_refs().

This patch introduces no other changes in functionality.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Makefile            |    2 +
 builtin-pack-refs.c |  121 +--------------------------------------------------
 pack-refs.c         |  117 +++++++++++++++++++++++++++++++++++++++++++++++++
 pack-refs.h         |   18 ++++++++
 4 files changed, 138 insertions(+), 120 deletions(-)
 create mode 100644 pack-refs.c
 create mode 100644 pack-refs.h

diff --git a/Makefile b/Makefile
index 854527d..6a1c23c 100644
--- a/Makefile
+++ b/Makefile
@@ -353,6 +353,7 @@ LIB_H += log-tree.h
 LIB_H += mailmap.h
 LIB_H += object.h
 LIB_H += pack.h
+LIB_H += pack-refs.h
 LIB_H += pack-revindex.h
 LIB_H += parse-options.h
 LIB_H += patch-ids.h
@@ -425,6 +426,7 @@ LIB_OBJS += merge-file.o
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
1.5.5.159.g8c84b
