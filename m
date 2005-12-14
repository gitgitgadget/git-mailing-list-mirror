From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: [PATCH] Bugfixes for git-rebase
Date: Thu, 15 Dec 2005 00:36:35 +0100
Message-ID: <43A0AC83.5050206@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>,
	=?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
X-From: git-owner@vger.kernel.org Thu Dec 15 00:36:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Emg9w-0000mX-ON
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 00:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965087AbVLNXfm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 14 Dec 2005 18:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965089AbVLNXfm
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 18:35:42 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:7575 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S965087AbVLNXfl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2005 18:35:41 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout1-sn1.fre.skanova.net (7.2.069.1)
        id 43A06357000134C4; Thu, 15 Dec 2005 00:35:40 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13656>

=46ix bugs in git-rebase wrt rebasing another branch than
the current HEAD, rebasing with a dirty working dir,
and rebasing a proper decendant of the target branch.

Signed-off-by: Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>

---
Without this patch git rebase complains about
"fatal: cannot read mbox" when doing a fast-forward.

 git-rebase.sh |   29 +++++++++++++++++++----------
 1 files changed, 19 insertions(+), 10 deletions(-)

2c0e6289d37461abbadb878b9ca8d2bfe2ca1a1b
diff --git a/git-rebase.sh b/git-rebase.sh
index 638ff0d..1e9ddde 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -18,31 +18,30 @@ you still have something valuable there.
 	exit 1
 fi
=20
-# The other head is given.  Make sure it is valid.
-other=3D$(git-rev-parse --verify "$1^0") || exit
-
-# Make sure we have HEAD that is valid.
-head=3D$(git-rev-parse --verify "HEAD^0") || exit
-
 # The tree must be really really clean.
 git-update-index --refresh || exit
 diff=3D$(git-diff-index --cached --name-status -r HEAD)
-case "$different" in
+case "$diff" in
 ?*)	echo "$diff"
 	exit 1
 	;;
 esac
=20
+# The other head is given.  Make sure it is valid.
+other=3D$(git-rev-parse --verify "$1^0") || exit
+
+# Make sure the branch to rebase is valid.
+head=3D$(git-rev-parse --verify "${2:-HEAD^0}") || exit
+
 # If the branch to rebase is given, first switch to it.
 case "$#" in
 2)
 	git-checkout "$2" || exit
 esac
=20
-# If the HEAD is a proper descendant of $other, we do not even need
-# to rebase.  Make sure we do not do needless rebase.  In such a
-# case, merge-base should be the same as "$other".
 mb=3D$(git-merge-base "$other" "$head")
+
+#Check if we're already rebased.
 if test "$mb" =3D "$other"
 then
 	echo >&2 "Current branch `git-symbolic-ref HEAD` is up to date."
@@ -51,5 +50,15 @@ fi
=20
 # Rewind the head to "$other"
 git-reset --hard "$other"
+
+# If the previous HEAD was a proper descendant of $other, we do not ev=
en
+# need to rebase.  Make sure we do not do needless rebase.  In such a
+# case, merge-base should be the same as "$head".
+if test "$mb" =3D "$head"
+then
+	echo >&2 "Fast-forwarded $head to $other."
+	exit 0
+fi
+
 git-format-patch -k --stdout --full-index "$other" ORIG_HEAD |
 git am --binary -3 -k
--=20
0.99.9.GIT
