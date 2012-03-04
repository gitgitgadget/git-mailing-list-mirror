From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH] Make git-{pull,rebase} message without tracking
 information friendlier
Date: Sun, 04 Mar 2012 05:41:26 +0100
Message-ID: <1330836086.691.87.camel@centaur.lab.cmartin.tk>
References: <vpqbooit61u.fsf@bauges.imag.fr>
	 <1330540914-14515-1-git-send-email-cmn@elego.de>
	 <7vobshs8go.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 04 05:40:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S43Fb-0008Rh-Mh
	for gcvg-git-2@plane.gmane.org; Sun, 04 Mar 2012 05:40:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754305Ab2CDEkp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Mar 2012 23:40:45 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:60413 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754291Ab2CDEko (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 23:40:44 -0500
Received: from [192.168.1.17] (brln-4db9cfc3.pool.mediaWays.net [77.185.207.195])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 7473246082;
	Sun,  4 Mar 2012 05:40:35 +0100 (CET)
In-Reply-To: <7vobshs8go.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.2.2-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192145>

On Wed, 2012-02-29 at 12:14 -0800, Junio C Hamano wrote:
> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
> [...]
>=20
> This made me thinking again.  On the "detached HEAD" side of your pat=
ch,
> the concluding "Please specify which branch you mean" is the most use=
ful
> information; ", so I cannot use any tracking information in your
> configuration file" may help _education_, but does not immediately he=
lp
> the user to do what the user wanted to do.

> Perhaps it may read it better if we remove that part; the result beco=
mes
> even more concise and to the point.

Right. Less is more. I may have stared at it for too long, but I get th=
e
feeling that in the new message, "You are not on a branch" and "Please
specify which branch" don't really seem to go together. After the first
sentence, I'm left thinking "so what?". Maybe something like "On
detached HEAD, you must specify a branch to $op_type $op_prep. [...]"
would work better?

>=20
> Oh the "on a branch" side of your patch, the updated message is tryin=
g to
> help the user by doing two things:
>=20
>  - tell him to explicitly name the branch (by the way, you seem to ha=
ve
>    lost the $example---is it intended) in order to immediately perfor=
m
>    what he wanted to.

I did remove that on purpose because I couldn't figure out a good way t=
o
introduce both versions. I was stubbornly keeping the configuration par=
t
first and it wasn't clicking.

>=20
>  - educate him that he can configure upstream information and avoid
>    typing in a later invocation of the same command.
>=20
> I think it is easier to read if we have clear separation between the =
two,
> as the hasty users would want to stop reading after the first help.

Yes. This is why I wanted to put the configuration information first, a=
s
a user who calls 'git pull' expects things to happen automatically, so =
I
wanted to tell her how to get it.

>=20
> So after "See git-${cmd}(1) for details.", have a paragraph break, ad=
d
> an indented "$example" just like you have for the "detached HEAD" cas=
e,
> another paragraph break and then "To set the tracking information" as=
 a
> new pargraph, perhaps?
>=20

This way around looks much better and makes a lot more sense. Thanks fo=
r
the hint.

I couldn't come up with a better way to count remotes than
$(git remote | wc -l) as git config only uses the regex for the values
and $(git config --list | grep -c '^remote\..*\.url') seems even worse.=
=20

I'm kind of two minds about the remote thing. If the branch doesn't hav=
e
an upstream already (either via checkout -t origin/branch or push -u),
making pulling from a remote upstream branch easier might lead to more
senseless merges, which is the opposite direction to other changes in
pull which ask for a reason, so after we've given them most of the
command to run so pull magically works on its own, we ask them to
justify it... I don't know, maybe I'm overthinking this.

   cmn

--- 8< ---
Subject: [PATCH] Make git-{pull,rebase} message without tracking inform=
ation
 friendlier

The current message is too long and at too low a level for anybody to
understand it if they don't know about the configuration format
already.

The text about setting up a remote is superfluous and doesn't help
understand the error that has happened. Show the usage more
prominently and explain how to set up the tracking information. If
there is only one remote, that name is used instead of the generic
<remote>.

Also simplify the message we print on detached HEAD to remove
unnecessary information which is better left for the documentation.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---
 git-parse-remote.sh |   42 +++++++++++++++++++-----------------------
 git-pull.sh         |    2 +-
 git-rebase.sh       |    2 +-
 3 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index b24119d..4575309 100644
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -57,34 +57,30 @@ error_on_missing_default_upstream () {
 	op_prep=3D"$3"
 	example=3D"$4"
 	branch_name=3D$(git symbolic-ref -q HEAD)
+	# If there's only one remote, use that in the suggestion
+	remote=3D"<remote>"
+	if test $(git remote | wc -l) -eq 1; then
+	    remote=3D$(git remote)
+	fi
+
 	if test -z "$branch_name"
 	then
-		echo "You are not currently on a branch, so I cannot use any
-'branch.<branchname>.merge' in your configuration file.
-Please specify which branch you want to $op_type $op_prep on the comma=
nd
-line and try again (e.g. '$example').
-See git-${cmd}(1) for details."
+		echo "You are not currently on a branch. Please specify which
+branch you want to $op_type $op_prep. See git-${cmd}(1) for details.
+
+    $example
+"
 	else
-		echo "You asked me to $cmd without telling me which branch you
-want to $op_type $op_prep, and 'branch.${branch_name#refs/heads/}.merg=
e' in
-your configuration file does not tell me, either. Please
-specify which branch you want to use on the command line and
-try again (e.g. '$example').
-See git-${cmd}(1) for details.
+		echo "There is no tracking information for the current branch.
+Please specify which branch you want to $op_type $op_prep.
+See git-${cmd}(1) for details
+
+    $example
=20
-If you often $op_type $op_prep the same branch, you may want to
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
+If you whish to set tracking information for this branch you can do so=
 with:
=20
-See git-config(1) for details."
+    git branch --set-upstream ${branch_name#refs/heads/} $remote/<bran=
ch>
+"
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
