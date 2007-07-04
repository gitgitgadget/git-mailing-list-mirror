From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] filter-branch: fail gracefully when a filter fails
Date: Wed, 4 Jul 2007 15:36:01 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707041535420.4071@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 04 16:36:16 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I65xm-0001a4-CP
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 16:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759529AbXGDOgL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 10:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759411AbXGDOgL
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 10:36:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:56200 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759500AbXGDOgK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 10:36:10 -0400
Received: (qmail invoked by alias); 04 Jul 2007 14:36:09 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp017) with SMTP; 04 Jul 2007 16:36:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1++OLZwzDK+uL5pFz3eMmWpnn0gnOp1glkfI6egXo
	jyuKxj8XS6DAnh
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51617>


A common mistake is to provide a filter which fails unwantedly. For
example, this will stop in the middle:

	git filter-branch --env-filter '
		test $GIT_COMMITTER_EMAIL = xyz &&
		export GIT_COMMITTER_EMAIL = abc' rewritten

When $GIT_COMMITTER_EMAIL is not "xyz", the test fails, and consequently
the whole filter has a non-zero exit status. However, as demonstrated
in this example, filter-branch would just stop, and the user would be
none the wiser.

Also, a failing msg-filter would not have been caught, as was the
case with one of the tests.

This patch fixes both issues, by paying attention to the exit status
of msg-filter, and by saying what failed before exiting.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	It is slightly ugly that the output of msg-filter is written
	to a temporary file. But I do not know a better method to
	catch a failing msg-filter. Help?

 git-filter-branch.sh     |   39 +++++++++++++++++++++++++++++----------
 t/t7003-filter-branch.sh |    8 +++++++-
 2 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 3bf5d88..f0a5070 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -20,6 +20,16 @@ map()
 	cat "$workdir/../map/$1"
 }
 
+# override die(): this version puts in an extra line break, so that
+# the progress is still visible
+
+die()
+{
+	echo >&2
+	echo "$*" >&2
+	exit 1
+}
+
 # When piped a commit, output a script to set the ident of either
 # "author" or "committer
 
@@ -173,23 +183,29 @@ while read commit parents; do
 	export GIT_COMMIT=$commit
 	git cat-file commit "$commit" >../commit
 
-	eval "$(set_ident AUTHOR <../commit)"
-	eval "$(set_ident COMMITTER <../commit)"
-	eval "$filter_env" < /dev/null
+	eval "$(set_ident AUTHOR <../commit)" ||
+		die "setting author failed for commit $commit"
+	eval "$(set_ident COMMITTER <../commit)" ||
+		die "setting committer failed for commit $commit"
+	eval "$filter_env" < /dev/null ||
+		die "env filter failed: $filter_env"
 
 	if [ "$filter_tree" ]; then
 		git checkout-index -f -u -a
 		# files that $commit removed are now still in the working tree;
 		# remove them, else they would be added again
 		git ls-files -z --others | xargs -0 rm -f
-		eval "$filter_tree" < /dev/null
+		eval "$filter_tree" < /dev/null ||
+			die "tree filter failed: $filter_tree"
+
 		git diff-index -r $commit | cut -f 2- | tr '\n' '\0' | \
 			xargs -0 git update-index --add --replace --remove
 		git ls-files -z --others | \
 			xargs -0 git update-index --add --replace --remove
 	fi
 
-	eval "$filter_index" < /dev/null
+	eval "$filter_index" < /dev/null ||
+		die "index filter failed: $filter_index"
 
 	parentstr=
 	for parent in $parents; do
@@ -198,13 +214,15 @@ while read commit parents; do
 		done
 	done
 	if [ "$filter_parent" ]; then
-		parentstr="$(echo "$parentstr" | eval "$filter_parent")"
+		parentstr="$(echo "$parentstr" | eval "$filter_parent")" ||
+				die "parent filter failed: $filter_parent"
 	fi
 
 	sed -e '1,/^$/d' <../commit | \
-		eval "$filter_msg" | \
-		sh -c "$filter_commit" "git commit-tree" $(git write-tree) \
-			$parentstr > ../map/$commit
+		eval "$filter_msg" > ../message ||
+			die "msg filter failed: $filter_msg"
+	sh -c "$filter_commit" "git commit-tree" \
+		$(git write-tree) $parentstr < ../message > ../map/$commit
 done <../revs
 
 src_head=$(tail -n 1 ../revs | sed -e 's/ .*//')
@@ -241,7 +259,8 @@ if [ "$filter_tag_name" ]; then
 		[ -f "../map/$sha1" ] || continue
 		new_sha1="$(cat "../map/$sha1")"
 		export GIT_COMMIT="$sha1"
-		new_ref="$(echo "$ref" | eval "$filter_tag_name")"
+		new_ref="$(echo "$ref" | eval "$filter_tag_name")" ||
+			die "tag name filter failed: $filter_tag_name"
 
 		echo "$ref -> $new_ref ($sha1 -> $new_sha1)"
 
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 451ac86..4ddd656 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -107,13 +107,19 @@ test_expect_success 'use index-filter to move into a subdirectory' '
 		  mv \$GIT_INDEX_FILE.new \$GIT_INDEX_FILE" directorymoved &&
 	test -z "$(git diff HEAD directorymoved:newsubdir)"'
 
+test_expect_success 'stops when msg filter fails' '
+	! git-filter-branch --msg-filter false nonono &&
+	rm -rf .git-rewrite &&
+	! git rev-parse nonono
+'
+
 test_expect_success 'author information is preserved' '
 	: > i &&
 	git add i &&
 	test_tick &&
 	GIT_AUTHOR_NAME="B V Uips" git commit -m bvuips &&
 	git-filter-branch --msg-filter "cat; \
-			test \$GIT_COMMIT = $(git rev-parse master) && \
+			test \$GIT_COMMIT != $(git rev-parse master) || \
 			echo Hallo" \
 		preserved-author &&
 	test 1 = $(git rev-list --author="B V Uips" preserved-author | wc -l)
-- 
1.5.3.rc0.2646.g88600-dirty
