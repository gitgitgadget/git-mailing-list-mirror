From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [RFC/PATCH] Make git-{pull,rebase} no-tracking message
 friendlier
Date: Wed, 29 Feb 2012 04:57:34 +0100
Message-ID: <1330487854.691.24.camel@centaur.lab.cmartin.tk>
References: <1330013115-26355-1-git-send-email-cmn@elego.de>
	 <vpq399wc4ns.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 29 04:57:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2af7-0001xw-FE
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 04:57:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030669Ab2B2D5D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Feb 2012 22:57:03 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:33107 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757610Ab2B2D5B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 22:57:01 -0500
Received: from [192.168.1.17] (brln-4db9f055.pool.mediaWays.net [77.185.240.85])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id AE23346057;
	Wed, 29 Feb 2012 04:56:54 +0100 (CET)
In-Reply-To: <vpq399wc4ns.fsf@bauges.imag.fr>
X-Mailer: Evolution 3.2.2-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191809>

On Mon, 2012-02-27 at 23:06 +0100, Matthieu Moy wrote:
> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>=20
> > -		echo "You asked me to $cmd without telling me which branch you
> > -want to $op_type $op_prep, and 'branch.${branch_name#refs/heads/}.=
merge' in
> > -your configuration file does not tell me, either. Please
> > -specify which branch you want to use on the command line and
> > +		echo "You asked me to $cmd without telling me which branch you w=
ant to
> > +$op_type $op_prep, and there is no tracking information for the cu=
rrent branch.
> > +Please specify which branch you want to use on the command line an=
d
> >  try again (e.g. '$example').
>=20
> At this point, it may be better to actually give the full command
> instead of just this "(e.g. '$example')", i.e. stg like
>=20
>   git $op_type <remote> $example
>=20
> I also saw users confused by the message (indeed without reading it,
> but ...). Giving them something as close as possible to
> cut-and-paste-able command should help.


$example is a caller-given string which already contains the whole
command (i.e. it's already 'git rebase <upstream branch>' or 'git pull
<repository> <branch>').  In this patch I've moved that command to its
own paragraph so the usage part of the output gets more visibility.

Another version of the patch, this one somewhat more intrusive,
hopefully easier to digest.

---8<---
Subject: [PATCH] Make git-{pull,rebase} message without tracking inform=
ation
 friendlier

The current message is too long and at too low a level for anybody to
understand it if they don't know about the configuration format
already.

Reformat it to show the commands a user would be expected to use,
instead of the contents of the configuration file. Use <branch>
instead of <refspec> or <upstream branch> as they're bound to consfuse
new users more than help them. Use <remote> instead of <repository> in
the pull message.
---
 git-parse-remote.sh |   26 ++++++++++----------------
 git-pull.sh         |    2 +-
 git-rebase.sh       |    2 +-
 3 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index b24119d..bcb75a0 100644
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -66,25 +66,19 @@ line and try again (e.g. '$example').
 See git-${cmd}(1) for details."
 	else
 		echo "You asked me to $cmd without telling me which branch you
-want to $op_type $op_prep, and 'branch.${branch_name#refs/heads/}.merg=
e' in
-your configuration file does not tell me, either. Please
-specify which branch you want to use on the command line and
-try again (e.g. '$example').
-See git-${cmd}(1) for details.
+want to $op_type $op_prep, and the current branch doesn't have
+tracking information. Please specify which branch you want to
+use on the command line and try again. See git-${cmd}(1) for details.
+
+    $example
=20
 If you often $op_type $op_prep the same branch, you may want to
-use something like the following in your configuration file:
-    [branch \"${branch_name#refs/heads/}\"]
-    remote =3D <nickname>
-    merge =3D <remote-ref>"
-		test rebase =3D "$op_type" &&
-		echo "    rebase =3D true"
-		echo "
-    [remote \"<nickname>\"]
-    url =3D <url>
-    fetch =3D <refspec>
+run something like:
=20
-See git-config(1) for details."
+    git remote add <remote> <url>
+    git branch --set-upstream ${branch_name#refs/heads/} <remote>/<bra=
nch>"
+		test rebase =3D "$op_type" &&
+		echo "    git config branch.${branch_name#refs/heads/}.rebase true"
 	fi
 	exit 1
 }
diff --git a/git-pull.sh b/git-pull.sh
index d8b64d7..309c7db 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -176,7 +176,7 @@ error_on_no_merge_candidates () {
 	elif [ -z "$curr_branch" -o -z "$upstream" ]; then
 		. git-parse-remote
 		error_on_missing_default_upstream "pull" $op_type $op_prep \
-			"git pull <repository> <refspec>"
+			"git pull <remote> <branch>"
 	else
 		echo "Your configuration specifies to $op_type $op_prep the ref '${u=
pstream#refs/heads/}'"
 		echo "from the remote, but no such ref was fetched."
diff --git a/git-rebase.sh b/git-rebase.sh
index 00ca7b9..69c1374 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -380,7 +380,7 @@ then
 		then
 			. git-parse-remote
 			error_on_missing_default_upstream "rebase" "rebase" \
-				"against" "git rebase <upstream branch>"
+				"against" "git rebase <branch>"
 		fi
 		;;
 	*)	upstream_name=3D"$1"
--=20
1.7.9.2.3.g4346f
