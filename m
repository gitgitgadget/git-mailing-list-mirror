From: Sven Verdoolaege <skimo@kotnet.org>
Subject: [PATCH v4] git-apply: apply submodule changes
Date: Mon, 13 Aug 2007 19:13:49 +0200
Message-ID: <20070813171349.GL999MdfPADPa@greensroom.kotnet.org>
References: <20070810093049.GA868MdfPADPa@greensroom.kotnet.org>
 <20070812142340.GA10399MdfPADPa@greensroom.kotnet.org>
 <7vwsw0ipp2.fsf@assigned-by-dhcp.cox.net>
 <20070812185006.GG999MdfPADPa@greensroom.kotnet.org>
 <7vr6m8imj6.fsf@assigned-by-dhcp.cox.net> <20070813093740.GA4684@liacs.nl>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>,
	Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 19:14:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKdUb-00014B-Nq
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 19:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S972616AbXHMROA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 13:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032376AbXHMRN6
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 13:13:58 -0400
Received: from psmtp09.wxs.nl ([195.121.247.23]:49912 "EHLO psmtp09.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S972616AbXHMRNx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 13:13:53 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp09.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JMQ00BL82J1VA@psmtp09.wxs.nl> for git@vger.kernel.org; Mon,
 13 Aug 2007 19:13:51 +0200 (MEST)
Received: (qmail 23222 invoked by uid 500); Mon, 13 Aug 2007 17:13:49 +0000
In-reply-to: <20070813093740.GA4684@liacs.nl>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55772>

Apply "Subproject commit HEX" changes produced by git-diff.
As usual in the current git, only the superproject itself is actually
modified (possibly creating empty directories for new submodules).
Any checked-out submodule is left untouched and is not required to
be up-to-date.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
This version adds an extra check to verify that a submodule
still looks like a submodule in the work tree.

 Documentation/git-apply.txt |   14 +++++++
 builtin-apply.c             |   91 +++++++++++++++++++++++++++++++++++++------
 t/t7400-submodule-basic.sh  |    8 ++++
 3 files changed, 101 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index f03f661..4c7e3a2 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -171,6 +171,20 @@ apply.whitespace::
 	When no `--whitespace` flag is given from the command
 	line, this configuration item is used as the default.
 
+Submodules
+----------
+If the patch contains any changes to submodules then gitlink:git-apply[1]
+treats these changes as follows.
+
+If --index is specified (explicitly or implicitly), then the submodule
+commits must match the index exactly for the patch to apply.  If any
+of the submodules are checked-out, then these check-outs are completely
+ignored, i.e., they are not required to be up-to-date or clean and they
+are not updated.
+
+If --index is not specified, then the submodule commits in the patch
+are ignored and only the absence of presence of the corresponding
+subdirectory is checked and (if possible) updated.
 
 Author
 ------
diff --git a/builtin-apply.c b/builtin-apply.c
index da27075..8ba20a6 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -12,6 +12,7 @@
 #include "blob.h"
 #include "delta.h"
 #include "builtin.h"
+#include "refs.h"
 
 /*
  *  --check turns on checking that the working tree matches the
@@ -1984,6 +1985,40 @@ static int apply_fragments(struct buffer_desc *desc, struct patch *patch)
 	return 0;
 }
 
+static int read_file_or_gitlink(struct cache_entry *ce, char **buf_p,
+				unsigned long *size_p)
+{
+	if (!ce)
+		return 0;
+
+	if (S_ISGITLINK(ntohl(ce->ce_mode))) {
+		*buf_p = xmalloc(100);
+		*size_p = snprintf(*buf_p, 100,
+			"Subproject commit %s\n", sha1_to_hex(ce->sha1));
+	} else {
+		enum object_type type;
+		*buf_p = read_sha1_file(ce->sha1, &type, size_p);
+		if (!*buf_p)
+			return -1;
+	}
+
+	return 0;
+}
+
+static int read_gitlink_or_skip(struct patch *patch, struct cache_entry *ce,
+				char *buf, unsigned long alloc)
+{
+	if (ce)
+		return snprintf(buf, alloc,
+				"Subproject commit %s\n", sha1_to_hex(ce->sha1));
+
+	/* We can't apply the submodule change without an index, so just
+	 * skip the patch itself and only create/remove directory.
+	 */
+	patch->fragments = NULL;
+	return 0;
+}
+
 static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *ce)
 {
 	char *buf;
@@ -1994,20 +2029,17 @@ static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *
 	alloc = 0;
 	buf = NULL;
 	if (cached) {
-		if (ce) {
-			enum object_type type;
-			buf = read_sha1_file(ce->sha1, &type, &size);
-			if (!buf)
-				return error("read of %s failed",
-					     patch->old_name);
-			alloc = size;
-		}
+		if (read_file_or_gitlink(ce, &buf, &size))
+			return error("read of %s failed", patch->old_name);
+		alloc = size;
 	}
 	else if (patch->old_name) {
 		size = xsize_t(st->st_size);
 		alloc = size + 8192;
 		buf = xmalloc(alloc);
-		if (read_old_data(st, patch->old_name, &buf, &alloc, &size))
+		if (S_ISGITLINK(patch->old_mode))
+			size = read_gitlink_or_skip(patch, ce, buf, alloc);
+		else if (read_old_data(st, patch->old_name, &buf, &alloc, &size))
 			return error("read of %s failed", patch->old_name);
 	}
 
@@ -2055,6 +2087,20 @@ static int check_to_create_blob(const char *new_name, int ok_if_exists)
 	return 0;
 }
 
+/* Check that the directory corresponding to a gitlink is either
+ * empty or a git repo.
+ */
+static int verify_gitlink_clean(const char *path)
+{
+	unsigned char sha1[20];
+
+	if (!rmdir(path)) {
+		mkdir(path, 0777);
+		return 0;
+	}
+	return resolve_gitlink_ref(path, "HEAD", sha1);
+}
+
 static int check_patch(struct patch *patch, struct patch *prev_patch)
 {
 	struct stat st;
@@ -2096,8 +2142,15 @@ static int check_patch(struct patch *patch, struct patch *prev_patch)
 				    lstat(old_name, &st))
 					return -1;
 			}
-			if (!cached)
+			if (!cached) {
 				changed = ce_match_stat(ce, &st, 1);
+				if (S_ISGITLINK(patch->old_mode)) {
+					changed &= TYPE_CHANGED;
+					if (!changed &&
+					    verify_gitlink_clean(patch->old_name))
+						changed |= TYPE_CHANGED;
+				}
+			}
 			if (changed)
 				return error("%s: does not match index",
 					     old_name);
@@ -2354,7 +2407,11 @@ static void remove_file(struct patch *patch, int rmdir_empty)
 		cache_tree_invalidate_path(active_cache_tree, patch->old_name);
 	}
 	if (!cached) {
-		if (!unlink(patch->old_name) && rmdir_empty) {
+		if (S_ISGITLINK(patch->old_mode)) {
+			if (rmdir(patch->old_name))
+				warning("unable to remove submodule %s",
+					patch->old_name);
+		} else if (!unlink(patch->old_name) && rmdir_empty) {
 			char *name = xstrdup(patch->old_name);
 			char *end = strrchr(name, '/');
 			while (end) {
@@ -2387,7 +2444,10 @@ static void add_index_file(const char *path, unsigned mode, void *buf, unsigned
 			die("unable to stat newly created file %s", path);
 		fill_stat_cache_info(ce, &st);
 	}
-	if (write_sha1_file(buf, size, blob_type, ce->sha1) < 0)
+	if (S_ISGITLINK(mode)) {
+		if (get_sha1_hex(buf + strlen("Subproject commit "), ce->sha1))
+			die("corrupt patch for subproject %s", path);
+	} else if (write_sha1_file(buf, size, blob_type, ce->sha1) < 0)
 		die("unable to create backing store for newly created file %s", path);
 	if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0)
 		die("unable to add cache entry for %s", path);
@@ -2398,6 +2458,13 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
 	int fd;
 	char *nbuf;
 
+	if (S_ISGITLINK(mode)) {
+		struct stat st;
+		if (!lstat(path, &st) && S_ISDIR(st.st_mode))
+			return 0;
+		return mkdir(path, 0777);
+	}
+
 	if (has_symlinks && S_ISLNK(mode))
 		/* Although buf:size is counted string, it also is NUL
 		 * terminated.
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index e8ce7cd..cede2e7 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -175,4 +175,12 @@ test_expect_success 'checkout superproject with subproject already present' '
 	git-checkout master
 '
 
+test_expect_success 'rebase with subproject changes' '
+	git-checkout initial &&
+	echo t > t &&
+	git add t &&
+	git-commit -m "change t" &&
+	git-rebase HEAD master
+'
+
 test_done
-- 
1.5.3.rc4.68.g4411e-dirty
