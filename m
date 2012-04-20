From: Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH v8 4/4] git-rebase: add keep_empty flag
Date: Fri, 20 Apr 2012 10:36:17 -0400
Message-ID: <1334932577-31232-5-git-send-email-nhorman@tuxdriver.com>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334932577-31232-1-git-send-email-nhorman@tuxdriver.com>
Cc: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Clemens Buchacher <drizzd@aon.at>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Neil Horman <nhorman@tuxdriver.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 20 16:37:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLExt-0001lK-E9
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 16:37:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756765Ab2DTOh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 10:37:29 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:40367 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756691Ab2DTOhO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 10:37:14 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SLExM-00021B-1V; Fri, 20 Apr 2012 10:37:11 -0400
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <1334932577-31232-1-git-send-email-nhorman@tuxdriver.com>
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195992>

Add a command line switch to git-rebase to allow a user the ability to specify
that they want to keep any commits in a series that are empty.

When git-rebase's type is am, then this option will automatically keep any
commit that has a tree object identical to its parent.

This patch changes the default behavior of interactive rebases as well.  With
this patch, git-rebase -i will produce a revision set passed to
git-revision-editor, in which empty commits are commented out.  Empty commits
may be kept manually by uncommenting them.  If the new --keep-empty option is
used in an interactive rebase the empty commits will automatically all be
uncommented in the editor.

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
---
 Documentation/git-rebase.txt |    4 ++++
 git-rebase--am.sh            |   19 ++++++++++++++-----
 git-rebase--interactive.sh   |   36 +++++++++++++++++++++++++++++++++---
 git-rebase.sh                |    5 +++++
 4 files changed, 56 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 504945c..131c35d 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -238,6 +238,10 @@ leave out at most one of A and B, in which case it defaults to HEAD.
 	will be reset to where it was when the rebase operation was
 	started.
 
+--keep-empty::
+	Keep the commits that do not change anything from its
+	parents in the result.
+
 --skip::
 	Restart the rebasing process by skipping the current patch.
 
diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index c815a24..04d8941 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -20,11 +20,20 @@ esac
 
 test -n "$rebase_root" && root_flag=--root
 
-git format-patch -k --stdout --full-index --ignore-if-in-upstream \
-	--src-prefix=a/ --dst-prefix=b/ \
-	--no-renames $root_flag "$revisions" |
-git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" &&
-move_to_original_branch
+if test -n "$keep_empty"
+then
+	# we have to do this the hard way.  git format-patch completely squashes
+	# empty commits and even if it didn't the format doesn't really lend
+	# itself well to recording empty patches.  fortunately, cherry-pick
+	# makes this easy
+	git cherry-pick --allow-empty "$revisions"
+else
+	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
+		--src-prefix=a/ --dst-prefix=b/ \
+		--no-renames $root_flag "$revisions" |
+	git am $git_am_opt --rebasing --resolvemsg="$resolvemsg"
+fi && move_to_original_branch
+
 ret=$?
 test 0 != $ret -a -d "$state_dir" && write_basic_state
 exit $ret
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 5812222..ef263e0 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -167,6 +167,15 @@ has_action () {
 	sane_grep '^[^#]' "$1" >/dev/null
 }
 
+is_empty_commit() {
+	tree=$(git rev-parse -q --verify "$1"^{tree} 2>/dev/null ||
+		die "$1: not a commit that can be picked")
+	ptree=$(git rev-parse -q --verify "$1"^^{tree} 2>/dev/null ||
+		ptree=4b825dc642cb6eb9a060e54bf8d69288fbee4904)
+
+	return test "$tree" = "$ptree"
+}
+
 # Run command with GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and
 # GIT_AUTHOR_DATE exported from the current environment.
 do_with_author () {
@@ -191,12 +200,19 @@ git_sequence_editor () {
 
 pick_one () {
 	ff=--ff
+
 	case "$1" in -n) sha1=$2; ff= ;; *) sha1=$1 ;; esac
 	case "$force_rebase" in '') ;; ?*) ff= ;; esac
 	output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
+
+	if is_empty_commit "$sha1"
+	then
+		empty_args="--allow-empty"
+	fi
+
 	test -d "$rewritten" &&
 		pick_one_preserving_merges "$@" && return
-	output git cherry-pick $ff "$@"
+	output git cherry-pick $empty_args $ff "$@"
 }
 
 pick_one_preserving_merges () {
@@ -780,9 +796,17 @@ git rev-list $merges_option --pretty=oneline --abbrev-commit \
 	sed -n "s/^>//p" |
 while read -r shortsha1 rest
 do
+
+	if test -z "$keep_empty" && is_empty_commit $shortsha1
+	then
+		comment_out="#"
+	else
+		comment_out=""
+	fi
+
 	if test t != "$preserve_merges"
 	then
-		printf '%s\n' "pick $shortsha1 $rest" >> "$todo"
+		printf '%s%s\n' "$comment_out" "pick $shortsha1 $rest" >> "$todo"
 	else
 		sha1=$(git rev-parse $shortsha1)
 		if test -z "$rebase_root"
@@ -801,7 +825,7 @@ do
 		if test f = "$preserve"
 		then
 			touch "$rewritten"/$sha1
-			printf '%s\n' "pick $shortsha1 $rest" >> "$todo"
+			printf '%s%s\n' "$comment_out" "pick $shortsha1 $rest" >> "$todo"
 		fi
 	fi
 done
@@ -851,6 +875,12 @@ cat >> "$todo" << EOF
 #
 EOF
 
+if test -z "$keep_empty"
+then
+	echo "# Note that empty commits are commented out" >> "$todo"
+fi
+
+
 has_action "$todo" ||
 	die_abort "Nothing to do"
 
diff --git a/git-rebase.sh b/git-rebase.sh
index 69c1374..24a2840 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -43,6 +43,7 @@ s,strategy=!       use the given merge strategy
 no-ff!             cherry-pick all commits, even if unchanged
 m,merge!           use merging strategies to rebase
 i,interactive!     let the user edit the list of commits to rebase
+k,keep-empty	   preserve empty commits during rebase
 f,force-rebase!    force rebase even if branch is up to date
 X,strategy-option=! pass the argument through to the merge strategy
 stat!              display a diffstat of what changed upstream
@@ -97,6 +98,7 @@ state_dir=
 action=
 preserve_merges=
 autosquash=
+keep_empty=
 test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
 
 read_basic_state () {
@@ -220,6 +222,9 @@ do
 	-i)
 		interactive_rebase=explicit
 		;;
+	-k)
+		keep_empty=yes
+		;;
 	-p)
 		preserve_merges=t
 		test -z "$interactive_rebase" && interactive_rebase=implied
-- 
1.7.7.6
