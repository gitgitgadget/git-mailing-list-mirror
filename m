From: Anders Kaseorg <andersk@MIT.EDU>
Subject: [PATCH v3] bisect reset: Allow resetting to any commit, not just a
 branch
Date: Tue, 13 Oct 2009 17:02:24 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.0910131700320.5105@dr-wily.mit.edu>
References: <alpine.DEB.1.10.0910121237540.2223@dr-wily.mit.edu> <7vaazw6uyi.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.0910131116300.5105@dr-wily.mit.edu> <200910132206.18460.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 23:12:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxofr-0005u2-Q1
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 23:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761318AbZJMVEM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Oct 2009 17:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761301AbZJMVEM
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 17:04:12 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:45517 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761121AbZJMVEL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 17:04:11 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n9DL2L9Z011133;
	Tue, 13 Oct 2009 17:02:21 -0400 (EDT)
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n9DL2Osu023451;
	Tue, 13 Oct 2009 17:02:24 -0400 (EDT)
In-Reply-To: <200910132206.18460.chriscool@tuxfamily.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130213>

=E2=80=98git bisect reset=E2=80=99 accepts an optional argument specify=
ing a branch to
check out after cleaning up the bisection state.  This lets you
specify an arbitrary commit.

In particular, this provides a way to clean the bisection state
without moving HEAD: =E2=80=98git bisect reset HEAD=E2=80=99.  This may=
 be useful if
you are not interested in the state before you began a bisect,
especially if checking out the old commit would be expensive and
invalidate most of your compiled tree.

Clarify the =E2=80=98git bisect reset=E2=80=99 documentation to explain=
 this optional
argument, which was previously mentioned only in the usage message.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 Documentation/git-bisect.txt |   23 +++++++++++++++++------
 git-bisect.sh                |    8 ++++----
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.tx=
t
index 63e7a42..d2ffae0 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -20,7 +20,7 @@ on the subcommand:
  git bisect bad [<rev>]
  git bisect good [<rev>...]
  git bisect skip [(<rev>|<range>)...]
- git bisect reset [<branch>]
+ git bisect reset [<commit>]
  git bisect visualize
  git bisect replay <logfile>
  git bisect log
@@ -81,16 +81,27 @@ will have been left with the first bad kernel revis=
ion in "refs/bisect/bad".
 Bisect reset
 ~~~~~~~~~~~~
=20
-To return to the original head after a bisect session, issue the
-following command:
+After a bisect session, to clean up the bisection state and return to
+the original HEAD, issue the following command:
=20
 ------------------------------------------------
 $ git bisect reset
 ------------------------------------------------
=20
-This resets the tree to the original branch instead of being on the
-bisection commit ("git bisect start" will also do that, as it resets
-the bisection state).
+By default, this will return your tree to the commit that was checked
+out before `git bisect start`.  (A new `git bisect start` will also do
+that, as it cleans up the old bisection state.)
+
+With an optional argument, you can return to a different commit
+instead:
+
+------------------------------------------------
+$ git bisect reset <commit>
+------------------------------------------------
+
+For example, `git bisect reset HEAD` will leave you on the current
+bisection commit and avoid switching commits at all, while `git bisect
+reset bisect/bad` will check out the first bad revision.
=20
 Bisect visualize
 ~~~~~~~~~~~~~~~~
diff --git a/git-bisect.sh b/git-bisect.sh
index 6f6f039..8b3c585 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -13,8 +13,8 @@ git bisect skip [(<rev>|<range>)...]
         mark <rev>... untestable revisions.
 git bisect next
         find next bisection to test and check it out.
-git bisect reset [<branch>]
-        finish bisection search and go back to branch.
+git bisect reset [<commit>]
+        finish bisection search and go back to commit.
 git bisect visualize
         show bisect status in gitk.
 git bisect replay <logfile>
@@ -311,8 +311,8 @@ bisect_reset() {
 	}
 	case "$#" in
 	0) branch=3D$(cat "$GIT_DIR/BISECT_START") ;;
-	1) git show-ref --verify --quiet -- "refs/heads/$1" ||
-	       die "$1 does not seem to be a valid branch"
+	1) git rev-parse --quiet --verify "$1^{commit}" > /dev/null ||
+	       die "'$1' is not a valid commit"
 	   branch=3D"$1" ;;
 	*)
 	    usage ;;
--=20
1.6.5
