From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 2/2] merge, pull: add option to put summary into the merge commit message
Date: Thu,  3 Apr 2008 11:03:16 +0200
Message-ID: <1207213396-17370-3-git-send-email-szeder@ira.uka.de>
References: <1207213396-17370-1-git-send-email-szeder@ira.uka.de>
 <1207213396-17370-2-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 03 11:04:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhLMn-00044H-4N
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 11:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbYDCJDd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Apr 2008 05:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755077AbYDCJD0
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 05:03:26 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:54868 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123AbYDCJDX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Apr 2008 05:03:23 -0400
Received: from elysium (p5B133679.dip0.t-ipconnect.de [91.19.54.121])
	by mrelayeu.kundenserver.de (node=mrelayeu7) with ESMTP (Nemesis)
	id 0ML2xA-1JhLLp0zRP-0000n9; Thu, 03 Apr 2008 11:03:19 +0200
Received: from fzi.de (neumann.wired [192.168.1.2])
	by elysium (Postfix) with SMTP id DB6BF124204;
	Thu,  3 Apr 2008 11:03:16 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.rc2.38.g3b417
In-Reply-To: <1207213396-17370-2-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V01U2FsdGVkX1/B96DSa+QthUGfO6stwo0/pc5g5sELXqMON9/
 yAJQYzrq5XEkB20p+f3jxMD0JC205MNJkGYju6UiqyLWx3gkcE
 duy+p4THCI2m/oEcbmBDw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78731>

These options are basically the command line option equivalents of the
'merge.summary' config variable, and are in sync with the options of
'fmt-merge-msg'.

The patch also updates documentation and bash completion accordingly, a=
nd
adds a test.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 Documentation/merge-options.txt        |    9 +++++++++
 contrib/completion/git-completion.bash |    3 ++-
 git-merge.sh                           |   10 +++++++++-
 git-pull.sh                            |   10 +++++++---
 t/t7600-merge.sh                       |   16 +++++++++++++++-
 5 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-opti=
ons.txt
index edd13a5..ece6040 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -5,6 +5,15 @@
 -n, \--no-diffstat::
 	Do not show diffstat at the end of the merge.
=20
+--summary::
+	In addition to branch names, populate the log message with
+	one-line descriptions from the actual commits that are being
+	merged.
+
+--no-summary::
+	Do not list one-line descriptions from the actual commits being
+	merged.
+
 --no-commit::
 	Perform the merge but pretend the merge failed and do
 	not autocommit, to give the user a chance to inspect and
diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 2e6cad7..8413b29 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -776,7 +776,8 @@ _git_merge ()
 		;;
 	--*)
 		__gitcomp "
-			--no-commit --no-diffstat --squash --strategy
+			--no-commit --no-diffstat --summary --no-summary
+			--squash --strategy
 			"
 		return
 	esac
diff --git a/git-merge.sh b/git-merge.sh
index 739b466..03bcfb1 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -10,6 +10,10 @@ git-merge [options] <msg> HEAD <remote>
 --
 diffstat             show a diffstat at the end of the merge
 n,no-diffstat        don't show a diffstat at the end of the merge
+summary              put one-line descriptions of the merged commits i=
nto
+                     the merge commit message
+no-summary           don't put one-line descriptions of the merged com=
mits
+                     into the merge commit message
 squash               create a single commit instead of doing a merge
 commit               perform a commit if the merge sucesses (default)
 ff                   allow fast forward (default)
@@ -152,6 +156,10 @@ parse_config () {
 			show_diffstat=3Dfalse ;;
 		--diffstat)
 			show_diffstat=3Dt ;;
+		--summary)
+			summary_arg=3D--summary ;;
+		--no-summary)
+			summary_arg=3D--no-summary ;;
 		--squash)
 			test "$allow_fast_forward" =3D t ||
 				die "You cannot combine --squash with --no-ff."
@@ -258,7 +266,7 @@ else
 	merge_name=3D$(for remote
 		do
 			merge_name "$remote"
-		done | git fmt-merge-msg
+		done | git fmt-merge-msg $summary_arg
 	)
 	merge_msg=3D"${merge_msg:+$merge_msg$LF$LF}$merge_name"
 fi
diff --git a/git-pull.sh b/git-pull.sh
index 6a46e14..99387c8 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -29,6 +29,10 @@ do
 	--diffstat)
 		no_diffstat=3D$1
 		;;
+	--no-s|--no-su|--no-sum|--no-summ|--no-summa|--no-summar|--no-summary=
)
+		summary_arg=3D--no-summary ;;
+	--s|--su|--sum|--summ|--summa|--summar|--summary)
+		summary_arg=3D--summary ;;
 	--no-c|--no-co|--no-com|--no-comm|--no-commi|--no-commit)
 		no_commit=3D--no-commit ;;
 	--c|--co|--com|--comm|--commi|--commit)
@@ -172,9 +176,9 @@ then
 	exit
 fi
=20
-merge_name=3D$(git fmt-merge-msg <"$GIT_DIR/FETCH_HEAD") || exit
+merge_name=3D$(git fmt-merge-msg $summary_arg <"$GIT_DIR/FETCH_HEAD") =
|| exit
 test true =3D "$rebase" &&
 	exec git-rebase $strategy_args --onto $merge_head \
 	${oldremoteref:-$merge_head}
-exec git-merge $no_diffstat $no_commit $squash $no_ff $strategy_args \
-	"$merge_name" HEAD $merge_head
+exec git-merge $no_diffstat $no_commit $summary_arg $squash $no_ff \
+	$strategy_args "$merge_name" HEAD $merge_head
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index bbbd580..a762d31 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -104,7 +104,11 @@ create_merge_msgs() {
 	git log --no-merges ^HEAD c2 >>squash.1-5 &&
 	echo "Squashed commit of the following:" >squash.1-5-9 &&
 	echo >>squash.1-5-9 &&
-	git log --no-merges ^HEAD c2 c3 >>squash.1-5-9
+	git log --no-merges ^HEAD c2 c3 >>squash.1-5-9 &&
+	echo > msg.nosummary &&
+	echo "* commit 'c3':" >msg.summary &&
+	echo "  commit 3" >>msg.summary &&
+	echo >>msg.summary
 }
=20
 verify_diff() {
@@ -441,6 +445,16 @@ test_expect_success 'merge c0 with c1 (ff override=
s no-ff)' '
 	verify_head $c1
 '
=20
+test_expect_success 'merge --summary' '
+	git reset --hard c0 &&
+	git merge --no-summary c2 &&
+	git show -s --pretty=3Dformat:%b HEAD >msg.act &&
+	verify_diff msg.nosummary msg.act "[OOPS] bad merge summary" &&
+	git merge --summary c3 &&
+	git show -s --pretty=3Dformat:%b HEAD >msg.act &&
+	verify_diff msg.summary msg.act "[OOPS] bad merge summary"
+'
+
 test_debug 'gitk --all'
=20
 test_done
--=20
1.5.5.rc2.38.g3b417
