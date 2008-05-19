From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Git GUI vs interactive post-commit hooks
Date: Mon, 19 May 2008 15:19:42 +0200
Message-ID: <20080519131942.GA5526@atjola.homenet>
References: <c6c947f60805190348g3395f8degae81963b402856b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Alexander Gladysh <agladysh@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 19 15:21:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jy5Ig-0003R2-HI
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 15:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760830AbYESNTt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 May 2008 09:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760841AbYESNTs
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 09:19:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:52869 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760830AbYESNTq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 09:19:46 -0400
Received: (qmail invoked by alias); 19 May 2008 13:19:43 -0000
Received: from i577B8E25.versanet.de (EHLO atjola.local) [87.123.142.37]
  by mail.gmx.net (mp012) with SMTP; 19 May 2008 15:19:43 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18P1yknWhAPR/bcEJivaKMTAVwKekILoIjeoouwuc
	QzJptWrRvVD/Yz
Content-Disposition: inline
In-Reply-To: <c6c947f60805190348g3395f8degae81963b402856b6@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82427>

On 2008.05.19 14:48:14 +0400, Alexander Gladysh wrote:
> Hi, list!
>=20
> $ git --version
> git version 1.5.5.1
>=20
> I have a post-commit hook which does backups for me:
>=20
>   username=3Dagladysh
>   for name in `git branch | cut -b3-`
>   do
>     remote=3D$username-$name
>     echo pushing $name as $remote
>     git push backup +$name:refs/heads/$remote
>   done

Isn't that what "git push --all" does? And that will only ask for a
password once, not for every branch.

> The backup repo is behind ssh. Recently I have put password on my ssh
> key and post-commit hook ask me for password once for each branch.
> This makes unhappy commit process from Git GUI -- after I shut it
> down, there are multiple ssh key password prompts in the shell from
> where I launched it, and it does not display any input I enter.
>=20
> Any advice? I do want to input password for my key each time I use it=
=2E

=46or a graphical tool, you might want to use something like
gtk-led-askpass, which shows a window with a password prompt. SSH will
make use of it if SSH_ASKPASS contains its path _and_ ssh is not starte=
d
from a terminal. Unfortunately, the latter is probably not true for git
gui most of the time.

One way hack around this is to do "setsid git push ..." in your
post-commit hook. But that will break if you have no X or no tool for
SSH_ASKPASS.

Another really hackish work-around is to
replace:
 exec 'wish' "$argv0" -- "$@"
with
 exec 'setsid' 'wish' "$argv0" -- "$@"

in git-gui. Git gui will then get its own session, detached from the
terminal and ssh will start using SSH_ASKPASS. That at least won't brea=
k
when you're not running X (simply because you won't be running git gui
then ;-)), but doesn't feel smart either.

Maybe someone else can come up with a sane solution that makes git gui
more SSH_ASKPASS-friendly.

Bj=F6rn
