From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] commit: detect misspelled pathspec while making a partial commit.
Date: Tue, 14 Feb 2006 12:46:03 -0800
Message-ID: <7vfymlr7n8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 21:46:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F973s-0002sw-1k
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 21:46:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161073AbWBNUqI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 15:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161075AbWBNUqI
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 15:46:08 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:10412 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1161073AbWBNUqH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 15:46:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060214204426.GJEG20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 14 Feb 2006 15:44:26 -0500
To: pasky@suse.cz
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16171>

When you say "git commit Documentaiton" to make partial commit
for the files only in that directory, we did not detect that as
a misspelled pathname and attempted to commit index without
change.  If nothing matched, there is no harm done, but if the
index gets modified otherwise by having another valid pathspec
or after an explicit update-index, a user will not notice
without paying attention to the "git status" preview.

This introduces --error-unmatch option to ls-files, and uses it
to detect this common user error.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * Pasky, does this address the issue you mentioned earlier on
   the #git channnel?

 git-commit.sh |   16 +++++++++-------
 ls-files.c    |   51 ++++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 53 insertions(+), 14 deletions(-)

c49ee6e0bba6c800f2c36df819973f3caac20fa4
diff --git a/git-commit.sh b/git-commit.sh
index ab5e6bc..f7ee1aa 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -180,6 +180,7 @@ verify=t
 verbose=
 signoff=
 force_author=
+only_include_assumed=
 while case "$#" in 0) break;; esac
 do
   case "$1" in
@@ -340,12 +341,8 @@ case "$#,$also$only" in
 0,)
   ;;
 *,)
-  echo >&2 "assuming --only paths..."
+  only_include_assumed="# Explicit paths specified without -i nor -o; assuming --only paths..."
   also=
-
-  # If we are going to launch an editor, the message won't be
-  # shown without this...
-  test -z "$log_given$status_only" && sleep 1
   ;;
 esac
 unset only
@@ -380,6 +377,8 @@ t,)
 	;;
 ,t)
 	save_index &&
+	git-ls-files --error-unmatch -- "$@" >/dev/null || exit
+
 	git-diff-files --name-only -z -- "$@"  |
 	(
 		cd "$TOP"
@@ -408,7 +407,7 @@ t,)
 		refuse_partial "Different in index and the last commit:
 $dirty_in_index"
 	    fi
-	    commit_only=`git-ls-files -- "$@"`
+	    commit_only=`git-ls-files --error-unmatch -- "$@"` || exit
 
 	    # Build the temporary index and update the real index
 	    # the same way.
@@ -569,7 +568,10 @@ else
 	PARENTS=""
 fi
 
-run_status >>"$GIT_DIR"/COMMIT_EDITMSG
+{
+	test -z "$only_include_assumed" || echo "$only_include_assumed"
+	run_status
+} >>"$GIT_DIR"/COMMIT_EDITMSG
 if [ "$?" != "0" -a ! -f "$GIT_DIR/MERGE_HEAD" ]
 then
 	rm -f "$GIT_DIR/COMMIT_EDITMSG"
diff --git a/ls-files.c b/ls-files.c
index 7024cf1..a716e5f 100644
--- a/ls-files.c
+++ b/ls-files.c
@@ -25,6 +25,8 @@ static int line_terminator = '\n';
 static int prefix_len = 0, prefix_offset = 0;
 static const char *prefix = NULL;
 static const char **pathspec = NULL;
+static int error_unmatch = 0;
+static char *ps_matched = NULL;
 
 static const char *tag_cached = "";
 static const char *tag_unmerged = "";
@@ -325,7 +327,8 @@ static int cmp_name(const void *p1, cons
  * Match a pathspec against a filename. The first "len" characters
  * are the common prefix
  */
-static int match(const char **spec, const char *filename, int len)
+static int match(const char **spec, char *ps_matched,
+		 const char *filename, int len)
 {
 	const char *m;
 
@@ -333,17 +336,24 @@ static int match(const char **spec, cons
 		int matchlen = strlen(m + len);
 
 		if (!matchlen)
-			return 1;
+			goto matched;
 		if (!strncmp(m + len, filename + len, matchlen)) {
 			if (m[len + matchlen - 1] == '/')
-				return 1;
+				goto matched;
 			switch (filename[len + matchlen]) {
 			case '/': case '\0':
-				return 1;
+				goto matched;
 			}
 		}
 		if (!fnmatch(m + len, filename + len, 0))
-			return 1;
+			goto matched;
+		if (ps_matched)
+			ps_matched++;
+		continue;
+	matched:
+		if (ps_matched)
+			*ps_matched = 1;
+		return 1;
 	}
 	return 0;
 }
@@ -356,7 +366,7 @@ static void show_dir_entry(const char *t
 	if (len >= ent->len)
 		die("git-ls-files: internal error - directory entry not superset of prefix");
 
-	if (pathspec && !match(pathspec, ent->name, len))
+	if (pathspec && !match(pathspec, ps_matched, ent->name, len))
 		return;
 
 	fputs(tag, stdout);
@@ -444,7 +454,7 @@ static void show_ce_entry(const char *ta
 	if (len >= ce_namelen(ce))
 		die("git-ls-files: internal error - cache entry not superset of prefix");
 
-	if (pathspec && !match(pathspec, ce->name, len))
+	if (pathspec && !match(pathspec, ps_matched, ce->name, len))
 		return;
 
 	if (!show_stage) {
@@ -699,6 +709,10 @@ int main(int argc, const char **argv)
 			prefix_offset = 0;
 			continue;
 		}
+		if (!strcmp(arg, "--error-unmatch")) {
+			error_unmatch = 1;
+			continue;
+		}
 		if (*arg == '-')
 			usage(ls_files_usage);
 		break;
@@ -710,6 +724,14 @@ int main(int argc, const char **argv)
 	if (pathspec)
 		verify_pathspec();
 
+	/* Treat unmatching pathspec elements as errors */
+	if (pathspec && error_unmatch) {
+		int num;
+		for (num = 0; pathspec[num]; num++)
+			;
+		ps_matched = xcalloc(1, num);
+	}
+
 	if (show_ignored && !exc_given) {
 		fprintf(stderr, "%s: --ignored needs some exclude pattern\n",
 			argv[0]);
@@ -725,5 +747,20 @@ int main(int argc, const char **argv)
 	if (prefix)
 		prune_cache();
 	show_files();
+
+	if (ps_matched) {
+		/* We need to make sure all pathspec matched otherwise
+		 * it is an error.
+		 */
+		int num, errors = 0;
+		for (num = 0; pathspec[num]; num++) {
+			if (ps_matched[num])
+				continue;
+			error("pathspec '%s' did not match any.",
+			      pathspec[num] + prefix_len);
+		}
+		return errors ? 1 : 0;
+	}
+
 	return 0;
 }
-- 
1.2.0.g6552
