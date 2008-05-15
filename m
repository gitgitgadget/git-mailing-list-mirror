From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] Export GIT_DIR after setting it
Date: Thu, 15 May 2008 19:55:55 +0200
Message-ID: <20080515175555.GA13003@atjola.homenet>
References: <1210807401-11201-1-git-send-email-madduck@madduck.net> <7vod78i9r7.fsf@gitster.siamese.dyndns.org> <20080515101523.GA31719@lapse.madduck.net> <7vlk2bh45u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "martin f. krafft" <madduck@madduck.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 15 19:57:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwhhF-0004sG-Ty
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 19:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763132AbYEOR4A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 May 2008 13:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763121AbYEOR4A
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 13:56:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:40091 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763066AbYEORz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 13:55:59 -0400
Received: (qmail invoked by alias); 15 May 2008 17:55:57 -0000
Received: from i577AEBEF.versanet.de (EHLO atjola.local) [87.122.235.239]
  by mail.gmx.net (mp030) with SMTP; 15 May 2008 19:55:57 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19r4p1asOBrAtq1HfWtJIQrlqQp57o3hRMPgeBcLP
	9iYbe83NuQai9c
Content-Disposition: inline
In-Reply-To: <7vlk2bh45u.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82216>

On 2008.05.15 10:23:57 -0700, Junio C Hamano wrote:
> "martin f. krafft" <madduck@madduck.net> writes:
>=20
> > The only problem I see now is when an external command (or the shel=
l
> > script) can't properly deal with GIT_DIR being set, but then that's
> > a whole different bug.
>=20
> One thing that we did not have to worry about when git-sh-setup was
> invented is GIT_WORK_TREE and its cousin core.worktree.  When the use=
r
> uses GIT_DIR _but_ wants to work from a subdirectory of the checked o=
ut
> work tree, the user _must_ tell git where the top of the work tree is=
; in
> other words, setting and exporting only GIT_DIR is a misconfiguration=
=2E
>=20
> I have a suspicion that "the whole different bug" is what bit you --
> perhaps some places need to also set and export GIT_WORK_TREE as well=
 when
> the do GIT_DIR.

=46or completeness, here's an actual example of how it breaks:
doener@atjola:g $ git_fake_bare_checkout() {
>                 url=3D"$1"
>                 repo=3D"$2"
>                 worktree=3D"$3"
>                 git clone --no-checkout "$url" "$repo"
>                 cd "$repo"
>                 mkdir -p "$worktree"
>                 git read-tree HEAD
>                 git checkout-index -a --prefix=3D"$worktree" || true
>                 git config core.worktree "$worktree"
>                 mv .git/* .
>                 rmdir .git
>         }
doener@atjola:g $ git_fake_bare_checkout
git://git.madduck.net/etc/git.git git.git ../
Initialized empty Git repository in /home/doener/g/git.git/.git/
Receiving objects: 100% (6/6), done.
remote: Counting objects: 6, done.
remote: Compressing objects: 100% (4/4), done.
remote: Total 6 (delta 0), reused 0 (delta 0)
doener@atjola:git.git (master) $ git fetch
doener@atjola:git.git (master) $ git pull
fatal: Not a git repository
fatal: Not a git repository
fatal: Not a git repository

So the git directory is not called .git but git.git, with core.worktree
set to "../". When "git fetch" is called directly, it correctly finds
that the git dir is "." Same for "git pull", but as GIT_DIR is neither
set in the environment, nor exported by git-pull, the commands that get
executed by git-pull do not find the git dir, because git-pull does
cd_to_toplevel first, and obviously the other commands won't look for
git.git, but just .git.

It kind of feels like a bug that git-pull does not export GIT_DIR there=
,
but you could probably also argue that it is wrong not to have GIT_DIR
set in the environment when using a non-standard name for the git dir.
Hm?

Bj=F6rn
