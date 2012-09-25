From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: Problem completing remotes when .git/remotes exits
Date: Wed, 26 Sep 2012 01:00:45 +0200
Message-ID: <20120925230045.GA13266@goldbirke>
References: <505A2330.9040800@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Sep 26 01:00:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGe7d-0004Ly-PE
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 01:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318Ab2IYXAs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Sep 2012 19:00:48 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:57977 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053Ab2IYXAr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 19:00:47 -0400
Received: from localhost6.localdomain6 (p5B130672.dip0.t-ipconnect.de [91.19.6.114])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0LdyJ6-1TopkH2fXg-00psbK; Wed, 26 Sep 2012 01:00:45 +0200
Content-Disposition: inline
In-Reply-To: <505A2330.9040800@kdbg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:/mxnzSD8vzdrXPL8guVsosfCkhmKGimaWyIu3F8DRgS
 TS1fa70wardD78QzRKhAzTmWC+bwb/v6kd5Opvkoa7WxsuI2Sl
 g/wGYkdz51acnKoTkHDdvwmt223m32eFd+Qjh/+7f1tAn7HOxS
 chBxMF84dFbBTdHLHMrorbdi/j0wIdnBJl+6YjATfWR/ahMR8R
 2S94aRpabJ/H15+XPPvrwWbLTwU/JK0eNfV+iWv8CVW/iWaepv
 9PamDQxe0jfWrrSyta2t6HRH0gNE9zcXT4fpCnYpMW4I5AaICk
 xvJXepY+JsVB1YCnGlmIOb6f1StL/MEvIjPdA1vla4S0+4XdaX
 U1l6kqUKqVJpotZsyfOE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206381>

Hi,


On Wed, Sep 19, 2012 at 09:55:28PM +0200, Johannes Sixt wrote:
> I have an empty .git/remotes directory. Trying to complete the name o=
f
> a remote always reports an error:
>=20
> git@master:1023> git fetch <TAB>ls: invalid option -- ' '
> Try `ls --help' for more information.
>=20
> I have these:
>=20
> 	alias ls=3D'ls $LS_OPTIONS'
> and
> 	LS_OPTIONS=3D'-N --color=3Dtty -T 0'
>=20
> I instrumented __git_remotes with set -x, which shows:
>=20
> git@master:1006> git fetch <TAB>+++ __gitdir
> +++ '[' -z '' ']'
> +++ '[' -n '' ']'
> +++ '[' -n '' ']'
> +++ '[' -d .git ']'
> +++ echo .git
> ++ local i 'IFS=3D
> ' d=3D.git
> ++ test -d .git/remotes
> ++ ls '-N --color=3Dtty -T 0' -1 .git/remotes
> ls: invalid option -- ' '
> Try `ls --help' for more information.
> ...
>=20
> Notice that the expansion of $LS_OPTIONS is not split at the blanks,
> obviously, because $IFS does not contain a blank at that moment.
>=20
> The patch below helps, but it looks like a work-around rather than a
> solution. Ideas?

I've got two alternative solutions for this issue.

The first one is less intrusive: use the 'command' builtin to tell
the shell to ignore shell functions and aliases and just run the ls
command.

diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index be800e09..bcde9472 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -370,7 +370,7 @@ __git_refs_remotes ()
 __git_remotes ()
 {
 	local i IFS=3D$'\n' d=3D"$(__gitdir)"
-	test -d "$d/remotes" && ls -1 "$d/remotes"
+	test -d "$d/remotes" && command ls -1 "$d/remotes"
	for i in $(git --git-dir=3D"$d" config --get-regexp 'remote\..*\.url' =
2>/dev/null); do
 		i=3D"${i#remote.}"
 		echo "${i/.url*/}"


But then it got me thinking...  Notice how much effort we spend just
to get the list of remotes?  We could just run 'git remote' directly
instead...

diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index be800e09..1daeaccf 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -369,12 +369,8 @@ __git_refs_remotes ()
=20
 __git_remotes ()
 {
-	local i IFS=3D$'\n' d=3D"$(__gitdir)"
-	test -d "$d/remotes" && ls -1 "$d/remotes"
-	for i in $(git --git-dir=3D"$d" config --get-regexp 'remote\..*\.url'=
 2>/dev/null); do
-		i=3D"${i#remote.}"
-		echo "${i/.url*/}"
-	done
+	local d=3D"$(__gitdir)"
+	git --git-dir=3D"$d" remote
 }
=20
 __git_list_merge_strategies ()


I prefer the second one ;)

Best,
G=E1bor
