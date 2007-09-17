From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] apply: get rid of --index-info in favor of --build-fake-ancestor
Date: Mon, 17 Sep 2007 23:34:06 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709172330400.28586@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 18 00:35:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXPBE-0003ja-PX
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 00:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757378AbXIQWe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 18:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757214AbXIQWez
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 18:34:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:55973 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752838AbXIQWey (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 18:34:54 -0400
Received: (qmail invoked by alias); 17 Sep 2007 22:34:52 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp018) with SMTP; 18 Sep 2007 00:34:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+gcdAVW7Wg1bhSejSTh+DLe+BWgq9FPbry9VRFB0
	uW7eGsUdXlXGlf
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58486>


git-am used "git apply -z --index-info" to find the original versions
of the files touched by the diff, to be able to do an inexpensive
three-way merge.

This operation makes only sense in a repository, since the index
information in the diff refers to blobs, which have to be present in
the current repository.

Therefore, teach "git apply" a mode to write out the result as an
index file to begin with, obviating the need for scripts to do it
themselves.

The primary user for --index-info is "git am", which is converted to
use --build-fake-ancestor in this patch.

Suggested by Junio.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Suggested by Junio, but the errors are all mine.

	I am not quite certain, though, if there is really no porcelain 
	using that option.  It has been around since Oct 7 2005 (!), so 
	there is a real chance that StGit, guilt or QGit use it.  In that 
	case, this patch is obviously wrong.

 Documentation/git-apply.txt |   11 +++++++----
 builtin-apply.c             |   35 ++++++++++++++++++++++-------------
 git-am.sh                   |    6 ++----
 3 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 4c7e3a2..c1c54bf 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git-apply' [--stat] [--numstat] [--summary] [--check] [--index]
-	  [--apply] [--no-add] [--index-info] [-R | --reverse]
+	  [--apply] [--no-add] [--build-fake-ancestor <file>] [-R | --reverse]
 	  [--allow-binary-replacement | --binary] [--reject] [-z]
 	  [-pNUM] [-CNUM] [--inaccurate-eof] [--cached]
 	  [--whitespace=<nowarn|warn|error|error-all|strip>]
@@ -63,12 +63,15 @@ OPTIONS
 	cached data, apply the patch, and store the result in the index,
 	without using the working tree. This implies '--index'.
 
---index-info::
+--build-fake-ancestor <file>::
 	Newer git-diff output has embedded 'index information'
 	for each blob to help identify the original version that
 	the patch applies to.  When this flag is given, and if
-	the original version of the blob is available locally,
-	outputs information about them to the standard output.
+	the original versions of the blobs is available locally,
+	builds a temporary index containing those blobs.
++
+When a pure mode change is encountered (which has no index information),
+the information is read from the current index instead.
 
 -R, --reverse::
 	Apply the patch in reverse.
diff --git a/builtin-apply.c b/builtin-apply.c
index 938fd61..1372169 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -42,7 +42,7 @@ static int apply_in_reverse;
 static int apply_with_reject;
 static int apply_verbosely;
 static int no_add;
-static int show_index_info;
+static const char *fake_ancestor;
 static int line_termination = '\n';
 static unsigned long p_context = ULONG_MAX;
 static const char apply_usage[] =
@@ -2236,9 +2236,12 @@ static int get_current_sha1(const char *path, unsigned char *sha1)
 	return 0;
 }
 
-static void show_index_list(struct patch *list)
+/* Build an index that contains the just the files needed for a 3way merge */
+static void build_fake_ancestor(struct patch *list, const char *filename)
 {
 	struct patch *patch;
+	struct index_state result = { 0 };
+	int fd;
 
 	/* Once we start supporting the reverse patch, it may be
 	 * worth showing the new sha1 prefix, but until then...
@@ -2246,11 +2249,12 @@ static void show_index_list(struct patch *list)
 	for (patch = list; patch; patch = patch->next) {
 		const unsigned char *sha1_ptr;
 		unsigned char sha1[20];
+		struct cache_entry *ce;
 		const char *name;
 
 		name = patch->old_name ? patch->old_name : patch->new_name;
 		if (0 < patch->is_new)
-			sha1_ptr = null_sha1;
+			continue;
 		else if (get_sha1(patch->old_sha1_prefix, sha1))
 			/* git diff has no index line for mode/type changes */
 			if (!patch->lines_added && !patch->lines_deleted) {
@@ -2265,13 +2269,16 @@ static void show_index_list(struct patch *list)
 		else
 			sha1_ptr = sha1;
 
-		printf("%06o %s	",patch->old_mode, sha1_to_hex(sha1_ptr));
-		if (line_termination && quote_c_style(name, NULL, NULL, 0))
-			quote_c_style(name, NULL, stdout, 0);
-		else
-			fputs(name, stdout);
-		putchar(line_termination);
+		ce = make_cache_entry(patch->old_mode, sha1_ptr, name, 0, 0);
+		if (add_index_entry(&result, ce, ADD_CACHE_OK_TO_ADD))
+			die ("Could not add %s to temporary index", name);
 	}
+
+	fd = open(filename, O_WRONLY | O_CREAT, 0666);
+	if (fd < 0 || write_index(&result, fd) || close(fd))
+		die ("Could not write temporary index to %s", filename);
+
+	discard_index(&result);
 }
 
 static void stat_patch_list(struct patch *patch)
@@ -2791,8 +2798,8 @@ static int apply_patch(int fd, const char *filename, int inaccurate_eof)
 	if (apply && write_out_results(list, skipped_patch))
 		exit(1);
 
-	if (show_index_info)
-		show_index_list(list);
+	if (fake_ancestor)
+		build_fake_ancestor(list, fake_ancestor);
 
 	if (diffstat)
 		stat_patch_list(list);
@@ -2900,9 +2907,11 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 			apply = 1;
 			continue;
 		}
-		if (!strcmp(arg, "--index-info")) {
+		if (!strcmp(arg, "--build-fake-ancestor")) {
 			apply = 0;
-			show_index_info = 1;
+			if (++i >= argc)
+				die ("need a filename");
+			fake_ancestor = argv[i];
 			continue;
 		}
 		if (!strcmp(arg, "-z")) {
diff --git a/git-am.sh b/git-am.sh
index 4db4701..8340125 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -62,10 +62,8 @@ fall_back_3way () {
     mkdir "$dotest/patch-merge-tmp-dir"
 
     # First see if the patch records the index info that we can use.
-    git apply -z --index-info "$dotest/patch" \
-	>"$dotest/patch-merge-index-info" &&
-    GIT_INDEX_FILE="$dotest/patch-merge-tmp-index" \
-    git update-index -z --index-info <"$dotest/patch-merge-index-info" &&
+    git apply --build-fake-ancestor "$dotest/patch-merge-tmp-index" \
+	"$dotest/patch" &&
     GIT_INDEX_FILE="$dotest/patch-merge-tmp-index" \
     git write-tree >"$dotest/patch-merge-base+" ||
     cannot_fallback "Repository lacks necessary blobs to fall back on 3-way merge."
-- 
1.5.3.1.989.g2059
