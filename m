From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3] bisect: teach "skip" to accept a range using
 "-r|--range" option
Date: Sun, 30 Nov 2008 07:15:11 +0100
Message-ID: <20081130071511.e279e8bc.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sun Nov 30 07:18:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6fdg-0005oM-7k
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 07:18:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbYK3GNp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 01:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbYK3GNp
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 01:13:45 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:53350 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750757AbYK3GNo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 01:13:44 -0500
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id BA4B317B541;
	Sun, 30 Nov 2008 07:13:41 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g19.free.fr (Postfix) with SMTP id 195DD17B528;
	Sun, 30 Nov 2008 07:13:40 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101949>

The current "git bisect skip" syntax is "git bisect skip [<rev>...]",
so it's already possible to skip a range of revisions using
something like:

$ git bisect skip $(git rev-list A..B)

where A and B are the bounds of the range of commits we want to skip.
In this case A itself will not be skipped, but B will be, because
that's how "git rev-list" works.

This patch teaches "git bisect skip" to accept:

$ git bisect skip --range=A,B

or:

$ git bisect skip -r A,B

to skip the whole range of commits between A included and B included.

Because we believe that users, in most cases, will want the first
bound to be skipped too.

If either A or B is ommited, HEAD will be used instead.

This is done by expanding each range argument using:

git rev-list "${B:-HEAD}" --not $(git rev-parse "${A:-HEAD}^@")

So the following command:

$ git bisect skip A -r B,C D E --range=F, --range ,G

should work as expected.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-bisect.txt |   30 +++++++++++++++++++++++-
 git-bisect.sh                |   52 ++++++++++++++++++++++++++++++++++++++++-
 t/t6030-bisect-porcelain.sh  |   10 +++++++-
 3 files changed, 88 insertions(+), 4 deletions(-)

	Junio wrote:
	>
	> Although I fully realize that the established semantics of A..B in git is
	> bottom-exclusive, top-inclusive, and this suggestion breaks the UI
	> uniformity by deviating from that convention, I have to wonder if it would
	> be more useful if you let the bottom commit (A in your example) also be
	> skipped.

	I agree that it would be perhaps more usefull to skip the bottom commit.
	But in this case I think we should not use the .. notation as it would be
	inconsistent. So here is a patch that adds an all inclusive "-r|--range"
	option.

	This patch adds some documentation and a test case too.

	After coming up with this patch, I saw that the previous version has
	already been merged into "next" and "master", but perhaps it can be reverted
	and this version applied. Otherwise if the previous version is preferred, I
	will come up with another patch to just add some documentation and tests on
	top of the previous version.

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 39034ec..86f6ad2 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -19,7 +19,7 @@ on the subcommand:
  git bisect start [<bad> [<good>...]] [--] [<paths>...]
  git bisect bad [<rev>]
  git bisect good [<rev>...]
- git bisect skip [<rev>...]
+ git bisect skip [(<rev>|<range>)...]
  git bisect reset [<branch>]
  git bisect visualize
  git bisect replay <logfile>
@@ -164,6 +164,34 @@ But computing the commit to test may be slower afterwards and git may
 eventually not be able to tell the first bad among a bad and one or
 more "skip"ped commits.
 
+You can even skip a range of commits, instead of just one commit,
+using option -r|--range. For example:
+
+------------
+$ git bisect skip --range=v2.5,v2.6
+------------
+
+or:
+
+------------
+$ git bisect skip -r v2.5,v2.6
+------------
+
+would mean that no commit between versions 2.5 included and 2.6
+included can be tested.
+
+Note that you must take care that the first commit in the given range
+is an ancestor of the second commit.
+
+Also note that if you don't want to skip the first commit of a range
+you can use something like:
+
+------------
+$ git bisect skip $(git rev-list v2.5..v2.6)
+------------
+
+and the commit pointed to by v2.5 will not be skipped.
+
 Cutting down bisection by giving more parameters to bisect start
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/git-bisect.sh b/git-bisect.sh
index 0d0e278..29a5c2e 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -9,7 +9,7 @@ git bisect bad [<rev>]
         mark <rev> a known-bad revision.
 git bisect good [<rev>...]
         mark <rev>... known-good revisions.
-git bisect skip [<rev>...]
+git bisect skip [(<rev>|<range>)...]
         mark <rev>... untestable revisions.
 git bisect next
         find next bisection to test and check it out.
@@ -191,6 +191,52 @@ check_expected_revs() {
 	done
 }
 
+list_range() {
+	case "$1" in
+	*,*) ;; # Ok
+	*) die "Bad range: $1" ;;
+	esac
+
+	_A=$(expr "z$1" : 'z\([^,]*\),.*')
+	_B=$(expr "z$1" : 'z[^,]*,\(.*\)')
+
+	#
+	# We want a range with both bounds included.
+	# ("git rev-list ^A B" would exclude commit A.)
+	# This means we want to exclude starting from the parents of _A,
+	# not starting from _A itself.
+	#
+	git rev-list "${_B:-HEAD}" --not $(git rev-parse "${_A:-HEAD}^@")
+}
+
+bisect_skip() {
+        all=''
+	while test $# != 0
+	do
+		case "$1" in
+		-r|--range*)
+			case "$#,$1" in
+			*,*=*)
+				range=$(expr "z$1" : 'z-[^=]*=\(.*\)') ;;
+			1,*)
+				die "Bad or incomplete range: $1" ;;
+			*)
+				range="$2"; shift ;;
+			esac
+			revs=$(list_range "$range") ||
+				die "Bad rev input: $1"
+			;;
+		*)
+			revs="'$arg'"
+			;;
+		esac
+		shift
+		all="$all $revs"
+        done
+        bisect_state 'skip' $all
+}
+
+
 bisect_state() {
 	bisect_autostart
 	state=$1
@@ -630,8 +676,10 @@ case "$#" in
         git bisect -h ;;
     start)
         bisect_start "$@" ;;
-    bad|good|skip)
+    bad|good)
         bisect_state "$cmd" "$@" ;;
+    skip)
+        bisect_skip "$@" ;;
     next)
         # Not sure we want "next" at the UI level anymore.
         bisect_next "$@" ;;
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 85fa39c..e76546c 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -313,8 +313,16 @@ test_expect_success 'bisect run & skip: find first bad' '
 	grep "$HASH6 is first bad commit" my_bisect_log.txt
 '
 
-test_expect_success 'bisect starting with a detached HEAD' '
+test_expect_success 'bisect skip range' '
+	git bisect reset &&
+	git bisect start $HASH7 $HASH1 &&
+	git bisect skip --range=$HASH2,$HASH5 &&
+	test "$HASH6" = "$(git rev-parse --verify HEAD)" &&
+	test_must_fail git bisect bad > my_bisect_log.txt &&
+	grep "first bad commit could be any of" my_bisect_log.txt
+'
 
+test_expect_success 'bisect starting with a detached HEAD' '
 	git bisect reset &&
 	git checkout master^ &&
 	HEAD=$(git rev-parse --verify HEAD) &&
-- 
1.6.0.4.772.ge8f9a
