From: =?windows-1252?Q?J=F6rn_Hees?= <dev@joernhees.de>
Subject: Re: [PATCH] remote-hg: Fix cloning and sharing bug
Date: Sun, 4 Aug 2013 14:17:20 +0200
Message-ID: <478CA849-148C-4F73-A64F-9A5829523CC3@joernhees.de>
References: <1A5ABD76-D3D9-400E-AC8F-26C0DEF43723@joernhees.de> <1375612683-9104-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 04 14:18:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5xFv-0005wF-2r
	for gcvg-git-2@plane.gmane.org; Sun, 04 Aug 2013 14:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787Ab3HDMR3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Aug 2013 08:17:29 -0400
Received: from srv1.joernhees.de ([81.20.133.80]:45521 "EHLO mail.joernhees.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751564Ab3HDMR3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Aug 2013 08:17:29 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.joernhees.de (Postfix) with ESMTP id B52F0E810EC;
	Sun,  4 Aug 2013 14:17:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at joernhees.de
Received: from mail.joernhees.de ([127.0.0.1])
	by localhost (srv1.joernhees.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4POzvBoFWf9u; Sun,  4 Aug 2013 14:17:21 +0200 (CEST)
Received: from [192.168.2.12] (xdsl-78-35-59-56.netcologne.de [78.35.59.56])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.joernhees.de (Postfix) with ESMTPSA id A0314E810EA;
	Sun,  4 Aug 2013 14:17:20 +0200 (CEST)
In-Reply-To: <1375612683-9104-1-git-send-email-apelisse@gmail.com>
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231624>

Hi,

On 4 Aug 2013, at 12:38, Antoine Pelisse <apelisse@gmail.com> wrote:
> [=85]
> I also decided to always clone local repositories because what J=F6rn=
 Hees
> said makes sense:
> If you have a local clone of a big repository, and then want to add a=
 slow
> remote, you would have to reclone everything.
> I think the trade-off is good, because clone from local should not be=
 that
> time expensive (maybe it can be on disk-space though).

I was working on a similar patch in the meantime, this point was the on=
ly thing that
kept me from submitting=85 Can someone of you think of an easy way to d=
o this lazily
on the first non-local remote being added?=20
In case we don't have a non-local clone (a mercurial dir with a clone s=
ubdir) yet, we
would try to go though the local mercurial remotes and then clone them=85=
 Just would
need a way to get their URLs. I thought about going through all "git re=
mote -v"=20
This way we wouldn't need to copy by default (bad for big repos), but c=
ould still do this
in a cheap way if a slow remote is added later on.

Btw, is there any reason why we don't just use the local mercurial remo=
tes as shared
repo? Cause it's not under our git dir and might be deleted?


> [=85]
> contrib/remote-helpers/git-remote-hg |   47 ++++++++++++++++++++-----=
---------
> 1 file changed, 28 insertions(+), 19 deletions(-)
>=20
> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-he=
lpers/git-remote-hg
> index 0194c67..487c13d 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -385,33 +385,42 @@ def get_repo(url, alias):
>=20
>     extensions.loadall(myui)
>=20
> -    if hg.islocal(url) and not os.environ.get('GIT_REMOTE_HG_TEST_RE=
MOTE'):
> -        repo =3D hg.repository(myui, url)
> -        if not os.path.exists(dirname):
> -            os.makedirs(dirname)
> -    else:
> -        shared_path =3D os.path.join(gitdir, 'hg')
> -        if not os.path.exists(shared_path):
> +    hgdir =3D os.path.join(gitdir, 'hg')
> +    try:
> +        os.mkdir(hgdir)
> +    except OSError:
> +        pass
> +
> +    shared_path =3D os.path.join(hgdir, '.shared')

I thought we had agreed to use .git/hg as the shared directory before? =
(so that
a clone into that dir would end up in .git/hg/.hg instead of .git/hg/.s=
hared/.hg)


> +    if not os.path.exists(shared_path):
> +        for remote in os.listdir(hgdir):
> +            try:
> +                hg.clone(myui, {}, os.path.join(hgdir, remote, 'clon=
e'),
> +                         shared_path, update=3DFalse, pull=3DTrue)
> +                break
> +            except error.RepoError:
> +                pass
> +        else:

Elegant use of the for-else clause, but to my experience confuses many =
people.

This would also be the place to check for local remotes after not findi=
ng already
cloned non-local remotes (the lazy approach mentioned above). As this w=
ould
cause nested "for-else" loops, i'd rather repeatedly check for existenc=
e of .git/hg/.hg
and list the several fallback in order, the last one being this one:

>             try:
>                 hg.clone(myui, {}, url, shared_path, update=3DFalse, =
pull=3DTrue)
>             except:
>                 die('Repository error')

If you want i'll send around my patch as RFC.
In the end i don't care which one is accepted and how, most important t=
hat one is
accepted to fix the bug.

Cheers,
J=F6rn