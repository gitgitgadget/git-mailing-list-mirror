From: Nanako Shiraishi <nanako3@bluebottle.com>
Subject: [PATCH] git-checkout --push/--pop
Date: Wed, 5 Dec 2007 07:04:06 +0900
Message-ID: <200712042204.lB4M4SVB002260@mi1.bluebottle.com>
References: <4755B3B3.80704@gmail.com> <vpqbq96jjrf.fsf@bauges.imag.fr> <m34peyur8r.fsf@roke.D-201> <7vir3e428i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Salikh Zakirov <salikh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 23:05:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Izft4-0002eL-5D
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 23:05:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357AbXLDWEa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Dec 2007 17:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbXLDWEa
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 17:04:30 -0500
Received: from mi1.bluebottle.com ([206.188.25.14]:39830 "EHLO
	mi1.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768AbXLDWE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 17:04:29 -0500
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi1.bluebottle.com (8.13.1/8.13.1) with ESMTP id lB4M4SVB002260
	for <git@vger.kernel.org>; Tue, 4 Dec 2007 14:04:28 -0800
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:date:subject:references:in-reply-to:
	mime-version:content-type:content-transfer-encoding:x-trusted-delivery;
	b=i9UYRt2olSTehFs64/XUQMobn/LGwl/S26pRDxLcsn5OIgu+ASz+en7+JRYzRP+dj
	HMZLUzBe1MdsNo4SsCvIPI6H6ZplZY+DITO+AX+DO0p4EgeAd/uBoWupYOyRmlF
Received: from nanako3.mail.bluebottle.com ([212.62.97.21])
	(authenticated bits=0)
	by fe1.bluebottle.com (8.13.1/8.13.1) with ESMTP id lB4M4B9H029048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 4 Dec 2007 14:04:18 -0800
In-Reply-To: <7vir3e428i.fsf@gitster.siamese.dyndns.org>
X-Trusted-Delivery: <9eee0bb7137a89eba2ad246a96ba66ad>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67088>

This introduces a branch-stack mechanism to record branch switching in =
$GIT_DIR/BRANCH_STACK file.  If you are switching to another branch and=
 plan to come back to the original branch soon, add '--push' option to =
record your current branch.
When you want to come back, 'git checkout --pop' will switch back to th=
e branch recorded at the top of the stack, while popping it.

Signed-off-by: =E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=
=81=93 <nanako3@bluebottle.com>
---
 git-checkout.sh |   42 +++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 41 insertions(+), 1 deletions(-)

diff --git a/git-checkout.sh b/git-checkout.sh
index f6d58ac..b53aea6 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -8,8 +8,10 @@ b=3D          create a new branch started at <branch>
 l           create the new branchs reflog
 track       tells if the new branch should track the remote branch
 f           proceed even if the index or working tree is not HEAD
-m           performa  three-way merge on local modifications if needed
+m           perform a three-way merge on local modifications if needed
 q,quiet     be quiet
+push        push the current branch to branch stack
+pop         come back to the previous branch by poping from branch sta=
ck
 "
 SUBDIRECTORY_OK=3DSometimes
 . git-sh-setup
@@ -27,6 +29,8 @@ newbranch=3D
 newbranch_log=3D
 merge=3D
 quiet=3D
+push=3D
+pop=3D
 v=3D-v
 LF=3D'
 '
@@ -49,6 +53,12 @@ while test $# !=3D 0; do
 	--track|--no-track)
 		track=3D"$1"
 		;;
+	--push)
+		push=3D1
+		;;
+	--pop)
+		pop=3D1
+		;;
 	-f)
 		force=3D1
 		;;
@@ -70,6 +80,27 @@ while test $# !=3D 0; do
 	shift
 done
=20
+if test -n "$pop"
+then
+	if test $# !=3D 0
+	then
+		die "git checkout: --pop is incompatible with branch name"
+	fi
+	if test -n "$push"
+	then
+		die "git checkout: --pop and --push are incompatible"
+	fi
+	last=3D$(tail -n 1 "$GIT_DIR/BRANCH_STACK")
+	if test -z "$last"
+	then
+		die "git checkout: empty branch stack"
+	fi
+	sed -e '$d' <"$GIT_DIR/BRANCH_STACK" >"$GIT_DIR/BRANCH_STACK.new"
+	mv "$GIT_DIR/BRANCH_STACK.new" "$GIT_DIR/BRANCH_STACK"
+	set x "$last"
+	shift
+fi
+
 arg=3D"$1"
 if rev=3D$(git rev-parse --verify "$arg^0" 2>/dev/null)
 then
@@ -113,6 +144,11 @@ esac
=20
 if test "$#" -ge 1
 then
+	# Checking out a path out of the index or a commit
+	if test -n "$push"
+	then
+		die "git checkout: --push while not switching branches"
+	fi
 	hint=3D
 	if test "$#" -eq 1
 	then
@@ -276,6 +312,10 @@ if [ "$?" -eq 0 ]; then
 		else
 			echo >&2 "Switched to${newbranch:+ a new} branch \"$branch\""
 		fi
+		if test -n "$push"
+		then
+			echo "$old_branch_name" >>"$GIT_DIR/BRANCH_STACK"
+		fi
 	elif test -n "$detached"
 	then
 		old_branch_name=3D`expr "z$oldbranch" : 'zrefs/heads/\(.*\)'`
--=20
1.5.3.6

--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Get a free email account with anti spam protection.
http://www.bluebottle.com/tag/2
