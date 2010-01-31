From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] bash: support user-supplied completion scripts for
	user's git commands
Date: Sun, 31 Jan 2010 20:19:36 +0100
Message-ID: <20100131191936.GA30466@neumann>
References: <9b69cfcf1001290457s6b7fad6cs5a915f16a11f5782@mail.gmail.com>
	<20100129151127.GA21821@spearce.org>
	<7v4om4kdt3.fsf@alter.siamese.dyndns.org>
	<20100129175950.GE21821@spearce.org>
	<7vockciyb8.fsf@alter.siamese.dyndns.org>
	<20100129190642.GA31303@neumann>
	<20100129191326.GD22101@spearce.org>
	<20100129200033.GA32636@neumann>
	<20100129200431.GE22101@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	David Rhodes Clymer <david@zettazebra.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jan 31 20:19:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbfKm-0008Vb-D5
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 20:19:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403Ab0AaTTm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Jan 2010 14:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753333Ab0AaTTm
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jan 2010 14:19:42 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:53679 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306Ab0AaTTm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2010 14:19:42 -0500
Received: from [127.0.1.1] (p5B130CE1.dip0.t-ipconnect.de [91.19.12.225])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0M0vAh-1NuQw209uR-00ulR6; Sun, 31 Jan 2010 20:19:38 +0100
Content-Disposition: inline
In-Reply-To: <20100129200431.GE22101@spearce.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Provags-ID: V01U2FsdGVkX1+yD+T4QQ3nNEqSRsHwp+rsVJOs5yq8v+Gp+2S
 RPesg3XkSTveXunNIB/k4WBp3yCeNrd+y4zHwa5EQ5jDaTyxUi
 eQjO3oAu6uwDKauJhxx2Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138550>

On Fri, Jan 29, 2010 at 12:04:31PM -0800, Shawn O. Pearce wrote:
> SZEDER G?bor <szeder@ira.uka.de> wrote:
> >=20
> > _git_lgm () {
> >         _git_log
> > }
> >=20
> > Unfortunately, it doesn't work at all.
> >=20
> > In _git() first we have 'lgm' in $command, which is ok, but then co=
mes
> > this alias handling thing
> >=20
> >         local expansion=3D$(__git_aliased_command "$command")
> >         [ "$expansion" ] && command=3D"$expansion"
> >=20
> > which writes '!sh' into $command, and that doesn't look quite right
>=20
> __git_aliased_command is returning the first word out of the alias.

Actually, it returns the first word from the alias which does not
start with a dash.  It behaves this way since its introduction in
367dce2a (Bash completion support for aliases, 2006-10-28).  I'm not
sure what the original intent was behind ignoring words starting with
a dash, but it gave me some ideas.

> I think we need to change this block here to:
>=20
>   case "$expansion" of
>   \!*) : leave command as alias ;;
>   '')  : leave command alone ;;
>   *)   command=3D"$expansion" ;;
>   esac
>=20
> Or something like that.  Because an alias whose value starts with
> ! is a shell command to be executed, so we want to use _git_$command
> for completion, but other aliases are builtin commands and we should
> use their first word token (what __git_aliased_command returns)
> as the name of the completion function.

After pondering about it for a while, I think that in this case the
real issue is not _git() not handling __git_aliased_command()'s return
value corretly, but rather __git_aliased_command() returning junk in
case of a more advanced alias.  And while fixing it up, we can also
improve on it to return the right command in some more cases, too.

Let's have an other look at Junio's alias:

    [alias]
        lgm =3D "!sh -c 'GIT_NOTES_REF=3Drefs/notes/amlog git log \"$@\=
" || :' -"

While it's clear that full parsing of something like that in the
completion code is unfeasible, we can easily get rid of stuff that is
definitely not a git command: !sh shell commands, options, and
environment variables.


diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 45a393f..faddbdf 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -625,10 +625,15 @@ __git_aliased_command ()
 	local word cmdline=3D$(git --git-dir=3D"$(__gitdir)" \
 		config --get "alias.$1")
 	for word in $cmdline; do
-		if [ "${word##-*}" ]; then
-			echo $word
+		case "$word" in
+		\!*)	: shell command alias ;;
+		-*)	: option ;;
+		*=3D*)	: setting env ;;
+		git)	: git itself ;;
+		*)
+			echo "$word"
 			return
-		fi
+		esac
 	done
 }

=20
and this way it would correctly return 'log' for Junio's 'lgm' alias.
With a bit tweaking we could also extend it to handle !gitk aliases,
too.

Of course, it isn't perfect either, and could be fooled easily.  It's
not hard to construct an alias, in which a word does not match any of
these filter patterns, but is still not a git command (e.g.  by
setting an environment variable to a value which contains spaces).  It
may even return false positives, when the output of a git command is
piped into an other git command, and the second gets the command line
options via $@, but the first command will be returned.  However, such
problematic cases could be handled by a custom completion function
provided by the user.

What do you think?


Best,
G=E1bor
