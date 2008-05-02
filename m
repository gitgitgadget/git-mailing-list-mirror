From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH amend] git-bisect.sh: don't accidentally override existing
	branch "bisect"
Date: Fri, 2 May 2008 08:56:20 +0000
Message-ID: <20080502085620.3361.qmail@17e811992e6d42.315fe32.mid.smarden.org>
References: <20080430164613.28314.qmail@b31db398e1accc.315fe32.mid.smarden.org> <200804302330.18354.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri May 02 10:57:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jrr4x-00088r-63
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 10:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757630AbYEBI4Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 May 2008 04:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757017AbYEBI4Y
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 04:56:24 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:45448 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756434AbYEBI4X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 04:56:23 -0400
Received: (qmail 3362 invoked by uid 1000); 2 May 2008 08:56:20 -0000
Content-Disposition: inline
In-Reply-To: <200804302330.18354.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80970>

If a branch named "bisect" or "new-bisect" already was created in the
repo by other means than git bisect, doing a git bisect used to overrid=
e
the branch without a warning.  Now if the branch "bisect" or
"new-bisect" already exists, and it was not created by git bisect itsel=
f,
git bisect start fails with an appropriate error message.  Additionally=
,
if checking out a new bisect state fails due to a merge problem, git
bisect cleans up the temporary branch "new-bisect".

The accidental override has been noticed by Andres Salomon, reported
through
 http://bugs.debian.org/478647

Signed-off-by: Gerrit Pape <pape@smarden.org>
---

On Wed, Apr 30, 2008 at 11:30:18PM +0200, Christian Couder wrote:
> >     echo "Bisecting: $bisect_nr revisions left to test after this"
> >     git branch -f new-bisect "$bisect_rev"
> > -   git checkout -q new-bisect || exit
> > +   git checkout -q new-bisect || {
> > +           git branch -d new-bisect
> > +           exit
>
> Here we "exit 0" if "git branch -d new-bisect" succeeds.
> That seems wrong.

Thanks, I changed it to first delete the new-bisect branch, and then us=
e
git checkout to create the branch and do the checkout.  So we have the
exit code from git branch if it fails.

On Thu, May 01, 2008 at 02:27:22PM +0200, Christian Couder wrote:
> Le jeudi 1 mai 2008, Richard Quirk a =E9crit :
> > Careful with that - it's a bashism and would fail if /bin/sh is
> > dash.
> > ie it would say that a branch called literally "{new-,}bisect" does
> > not exist, even if new-bisect and bisect do.
>
> You are right. Thanks.
> So what about a plain:
>
> git show-ref -q bisect new-bisect

I'm not sure we can rely on this, the exit code of that command if one
of the branches exists, but not the other, isn't documented.  The patch
now uses --verify -q on each branch, which is documented and should be
reliable.


 Documentation/git-bisect.txt |    2 +-
 git-bisect.sh                |   19 ++++++++++++-------
 t/t6030-bisect-porcelain.sh  |   18 ++++++++++++++++++
 3 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.tx=
t
index 698ffde..1c7e38d 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -85,7 +85,7 @@ Oh, and then after you want to reset to the original =
head, do a
 $ git bisect reset
 ------------------------------------------------
=20
-to get back to the master branch, instead of being in one of the
+to get back to the original branch, instead of being in one of the
 bisection branches ("git bisect start" will do that for you too,
 actually: it will reset the bisection state, and before it does that
 it checks that you're not using some old bisection branch).
diff --git a/git-bisect.sh b/git-bisect.sh
index d8d9bfd..f8c411a 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -69,14 +69,19 @@ bisect_start() {
 	head=3D$(GIT_DIR=3D"$GIT_DIR" git symbolic-ref -q HEAD) ||
 	head=3D$(GIT_DIR=3D"$GIT_DIR" git rev-parse --verify HEAD) ||
 	die "Bad HEAD - I need a HEAD"
+	#
+	# Check that we either already have BISECT_START, or that the
+	# branches bisect, new-bisect don't exist, to not override them.
+	#
+	test -s "$GIT_DIR/BISECT_START" ||
+		if git show-ref --verify -q refs/heads/bisect ||
+		    git show-ref --verify -q refs/heads/new-bisect; then
+			die 'The branches "bisect" and "new-bisect" must not exist.'
+		fi
 	start_head=3D''
 	case "$head" in
 	refs/heads/bisect)
-		if [ -s "$GIT_DIR/BISECT_START" ]; then
-		    branch=3D`cat "$GIT_DIR/BISECT_START"`
-		else
-		    branch=3Dmaster
-		fi
+		branch=3D`cat "$GIT_DIR/BISECT_START"`
 		git checkout $branch || exit
 		;;
 	refs/heads/*|$_x40)
@@ -328,8 +333,8 @@ bisect_next() {
 	exit_if_skipped_commits "$bisect_rev"
=20
 	echo "Bisecting: $bisect_nr revisions left to test after this"
-	git branch -f new-bisect "$bisect_rev"
-	git checkout -q new-bisect || exit
+	git branch -D new-bisect
+	git checkout -q -b new-bisect "$bisect_rev" || exit
 	git branch -M new-bisect bisect
 	git show-branch "$bisect_rev"
 }
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 5e3e544..05f1e15 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -284,6 +284,24 @@ test_expect_success 'bisect starting with a detach=
ed HEAD' '
=20
 '
=20
+test_expect_success 'bisect refuses to start if branch bisect exists' =
'
+	git bisect reset &&
+	git branch bisect &&
+	test_must_fail git bisect start &&
+	git branch -d bisect &&
+	git checkout -b bisect &&
+	test_must_fail git bisect start &&
+	git checkout master &&
+	git branch -d bisect
+'
+
+test_expect_success 'bisect refuses to start if branch new-bisect exis=
ts' '
+	git bisect reset &&
+	git branch new-bisect &&
+	test_must_fail git bisect start &&
+	git branch -d new-bisect
+'
+
 #
 #
 test_done
--=20
1.5.5.1
