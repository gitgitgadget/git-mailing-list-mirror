From: Sven Verdoolaege <skimo@kotnet.org>
Subject: [PATCH v3] git-apply: apply submodule changes
Date: Sun, 12 Aug 2007 16:23:40 +0200
Message-ID: <20070812142340.GA10399MdfPADPa@greensroom.kotnet.org>
References: <20070810093049.GA868MdfPADPa@greensroom.kotnet.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Steffen Prohaska <prohaska@zib.de>, Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 12 16:23:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKEM7-0004x7-SO
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 16:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753230AbXHLOXo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 10:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753046AbXHLOXo
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 10:23:44 -0400
Received: from psmtp08.wxs.nl ([195.121.247.22]:38523 "EHLO psmtp08.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752665AbXHLOXn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 10:23:43 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp08.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JMN0020NZZG4B@psmtp08.wxs.nl> for git@vger.kernel.org; Sun,
 12 Aug 2007 16:23:42 +0200 (MEST)
Received: (qmail 14116 invoked by uid 500); Sun, 12 Aug 2007 14:23:40 +0000
In-reply-to: <20070810093049.GA868MdfPADPa@greensroom.kotnet.org>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55687>

Apply "Subproject commit HEX" changes produced by git-diff.
As usual in the current git, only the superproject itself is actually
modified (possibly creating empty directories for new submodules).
Any checked-out submodule is left untouched and is not required to
be up-to-date.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
The third version also works without --index and documents
the behaviour of git-apply in the presence of submodule changes.

skimo

 Documentation/git-apply.txt |   14 +++++++++
 builtin-apply.c             |   69 +++++++++++++++++++++++++++++++++++-------
 t/t7400-submodule-basic.sh  |    8 +++++
 3 files changed, 79 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index f03f661..804fdc3 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -171,6 +171,20 @@ apply.whitespace::
 	When no `--whitespace` flag is given from the command
 	line, this configuration item is used as the default.
 
+Submodules
+----------
+If the patch contains any changes to submodules then gitlink:git-apply[1]
+behaves as follows.
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
index da27075..eef596b 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1984,6 +1984,40 @@ static int apply_fragments(struct buffer_desc *desc, struct patch *patch)
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
@@ -1994,20 +2028,17 @@ static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *
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
 
@@ -2098,7 +2129,7 @@ static int check_patch(struct patch *patch, struct patch *prev_patch)
 			}
 			if (!cached)
 				changed = ce_match_stat(ce, &st, 1);
-			if (changed)
+			if (changed && !S_ISGITLINK(patch->old_mode))
 				return error("%s: does not match index",
 					     old_name);
 			if (cached)
@@ -2354,7 +2385,11 @@ static void remove_file(struct patch *patch, int rmdir_empty)
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
@@ -2387,7 +2422,10 @@ static void add_index_file(const char *path, unsigned mode, void *buf, unsigned
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
@@ -2398,6 +2436,13 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
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
1.5.3.rc4.30.gd0c97-dirty
