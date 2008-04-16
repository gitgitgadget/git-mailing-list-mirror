From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v2 02/12] merge, pull: introduce '--(no-)stat' options
Date: Wed, 16 Apr 2008 02:39:01 +0200
Message-ID: <1208306351-20922-3-git-send-email-szeder@ira.uka.de>
References: <7vzls7so8m.fsf@gitster.siamese.dyndns.org>
	<1208306351-20922-1-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-2-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 06:29:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jlvgx-0007Zm-Dy
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 02:40:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754692AbYDPAjT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Apr 2008 20:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753091AbYDPAjS
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 20:39:18 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:61172 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436AbYDPAjP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 20:39:15 -0400
Received: from [127.0.1.1] (p5B13305D.dip0.t-ipconnect.de [91.19.48.93])
	by mrelayeu.kundenserver.de (node=mrelayeu2) with ESMTP (Nemesis)
	id 0MKwtQ-1JlvgA0qHr-0002Kk; Wed, 16 Apr 2008 02:39:14 +0200
X-Mailer: git-send-email 1.5.5.76.g546c
In-Reply-To: <1208306351-20922-2-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V01U2FsdGVkX19GoIc4WGdI/XzFJGX79NG4CtavHwr8RtK5mfn
 7U97LKMGPAWVM6dLQGylNi5f9ERPpJ9ggXZS1qdyXTCJiCoNqO
 d620GG49k3GFsvOfFEBFw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79648>

These options have the same effect as the current '--(no-)summary'
options (i.e. whether to show a diffsat at the end of the merge or not)=
,
and are consistent with the '--stat' option of other git commands.

Documentation, tests, and bash completion are updated accordingly.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 Documentation/git-merge.txt            |    4 ++--
 Documentation/merge-options.txt        |    4 ++--
 contrib/completion/git-completion.bash |    2 +-
 git-merge.sh                           |   10 ++++++----
 git-pull.sh                            |   16 +++++++---------
 t/t7600-merge.sh                       |   21 ++++++++++++++++++---
 6 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 821e21b..c514e3b 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -9,8 +9,8 @@ git-merge - Join two or more development histories toge=
ther
 SYNOPSIS
 --------
 [verse]
-'git-merge' [-n] [--summary] [--no-commit] [--squash] [-s <strategy>].=
=2E.
-	[-m <msg>] <remote> <remote>...
+'git-merge' [-n | --no-stat | --no-summary] [--stat | --summary] [--no=
-commit]
+	[--squash] [-s <strategy>]... [-m <msg>] <remote> <remote>...
 'git-merge' <msg> HEAD <remote>...
=20
 DESCRIPTION
diff --git a/Documentation/merge-options.txt b/Documentation/merge-opti=
ons.txt
index 9f1fc82..c82bc7e 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -1,8 +1,8 @@
---summary::
+--stat, \--summary::
 	Show a diffstat at the end of the merge. The diffstat is also
 	controlled by the configuration option merge.diffstat.
=20
--n, \--no-summary::
+-n, \--no-stat, \--no-summary::
 	Do not show diffstat at the end of the merge.
=20
 --no-commit::
diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 4d81963..5221a1a 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -779,7 +779,7 @@ _git_merge ()
 		;;
 	--*)
 		__gitcomp "
-			--no-commit --no-summary --squash --strategy
+			--no-commit --no-stat --no-summary --squash --strategy
 			"
 		return
 	esac
diff --git a/git-merge.sh b/git-merge.sh
index 7dbbb1d..cda78de 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -8,8 +8,10 @@ OPTIONS_SPEC=3D"\
 git-merge [options] <remote>...
 git-merge [options] <msg> HEAD <remote>
 --
-summary              show a diffstat at the end of the merge
-n,no-summary         don't show a diffstat at the end of the merge
+stat                 show a diffstat at the end of the merge
+n,no-stat            don't show a diffstat at the end of the merge
+summary              equivalent to --stat
+no-summary           equivalent to --no-stat
 squash               create a single commit instead of doing a merge
 commit               perform a commit if the merge sucesses (default)
 ff                   allow fast forward (default)
@@ -148,9 +150,9 @@ merge_name () {
 parse_config () {
 	while test $# !=3D 0; do
 		case "$1" in
-		-n|--no-summary)
+		-n|--no-stat|--no-summary)
 			show_diffstat=3Dfalse ;;
-		--summary)
+		--stat|--summary)
 			show_diffstat=3Dt ;;
 		--squash)
 			test "$allow_fast_forward" =3D t ||
diff --git a/git-pull.sh b/git-pull.sh
index 3ce32b5..0bac8ae 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -4,7 +4,7 @@
 #
 # Fetch one or more remote refs and merge it/them into the current HEA=
D.
=20
-USAGE=3D'[-n | --no-summary] [--[no-]commit] [--[no-]squash] [--[no-]f=
f] [-s strategy]... [<fetch-options>] <repo> <head>...'
+USAGE=3D'[-n | --no-stat | --no-summary] [--[no-]commit] [--[no-]squas=
h] [--[no-]ff] [-s strategy]... [<fetch-options>] <repo> <head>...'
 LONG_USAGE=3D'Fetch one or more remote refs and merge it/them into the=
 current HEAD.'
 SUBDIRECTORY_OK=3DYes
 OPTIONS_SPEC=3D
@@ -16,19 +16,17 @@ cd_to_toplevel
 test -z "$(git ls-files -u)" ||
 	die "You are in the middle of a conflicted merge."
=20
-strategy_args=3D no_summary=3D no_commit=3D squash=3D no_ff=3D
+strategy_args=3D no_stat=3D no_commit=3D squash=3D no_ff=3D
 curr_branch=3D$(git symbolic-ref -q HEAD)
 curr_branch_short=3D$(echo "$curr_branch" | sed "s|refs/heads/||")
 rebase=3D$(git config --bool branch.$curr_branch_short.rebase)
 while :
 do
 	case "$1" in
-	-n|--n|--no|--no-|--no-s|--no-su|--no-sum|--no-summ|\
-		--no-summa|--no-summar|--no-summary)
-		no_summary=3D-n ;;
-	--summary)
-		no_summary=3D$1
-		;;
+	-n|--no-stat|--no-summary)
+		no_stat=3D-n ;;
+	--stat|--summary)
+		no_stat=3D$1 ;;
 	--no-c|--no-co|--no-com|--no-comm|--no-commi|--no-commit)
 		no_commit=3D--no-commit ;;
 	--c|--co|--com|--comm|--commi|--commit)
@@ -176,5 +174,5 @@ merge_name=3D$(git fmt-merge-msg <"$GIT_DIR/FETCH_H=
EAD") || exit
 test true =3D "$rebase" &&
 	exec git-rebase $strategy_args --onto $merge_head \
 	${oldremoteref:-$merge_head}
-exec git-merge $no_summary $no_commit $squash $no_ff $strategy_args \
+exec git-merge $no_stat $no_commit $squash $no_ff $strategy_args \
 	"$merge_name" HEAD $merge_head
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 56869ac..e5b48fb 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -364,7 +364,22 @@ test_expect_success 'merge c1 with c2 (squash in c=
onfig)' '
=20
 test_debug 'gitk --all'
=20
-test_expect_success 'override config option -n' '
+test_expect_success 'override config option -n with --stat' '
+	git reset --hard c1 &&
+	git config branch.master.mergeoptions "-n" &&
+	test_tick &&
+	git merge --stat c2 >diffstat.txt &&
+	verify_merge file result.1-5 msg.1-5 &&
+	verify_parents $c1 $c2 &&
+	if ! grep "^ file |  *2 +-$" diffstat.txt
+	then
+		echo "[OOPS] diffstat was not generated"
+	fi
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'override config option -n with --summary' '
 	git reset --hard c1 &&
 	git config branch.master.mergeoptions "-n" &&
 	test_tick &&
@@ -379,9 +394,9 @@ test_expect_success 'override config option -n' '
=20
 test_debug 'gitk --all'
=20
-test_expect_success 'override config option --summary' '
+test_expect_success 'override config option --stat' '
 	git reset --hard c1 &&
-	git config branch.master.mergeoptions "--summary" &&
+	git config branch.master.mergeoptions "--stat" &&
 	test_tick &&
 	git merge -n c2 >diffstat.txt &&
 	verify_merge file result.1-5 msg.1-5 &&
--=20
1.5.5.76.g546c
