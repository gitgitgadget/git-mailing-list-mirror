From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: best way to fastforward all tracking branches after a fetch
Date: Sun, 11 Dec 2011 10:22:42 -0800 (PST)
Message-ID: <m3ehwbge8f.fsf@localhost.localdomain>
References: <jbvj5o$skt$1@dough.gmane.org>
	<20111211022218.GA22749@sita-lt.atc.tcs.com>
	<jc2l2a$som$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sitaram Chamarty <sitaramc@gmail.com>
To: Gelonida N <gelonida@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 11 19:22:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZo37-0001iR-Fm
	for gcvg-git-2@lo.gmane.org; Sun, 11 Dec 2011 19:22:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886Ab1LKSWp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Dec 2011 13:22:45 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46236 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492Ab1LKSWo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Dec 2011 13:22:44 -0500
Received: by eaaj10 with SMTP id j10so237294eaa.19
        for <git@vger.kernel.org>; Sun, 11 Dec 2011 10:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=kd3mDV5SrkA61G2uzdIl8oLVsBo+ds9EpaLHDpyFElQ=;
        b=HourHE10buhSLYrLnr+lNNSS78gBx+iMf3jCXxLPZvFZ9/Y8Go00MJ5kMS0/d0ji8a
         Hn5JT4ad7SOLLfth8GibJXwBVnCxRI1EeHiKkxPTTUaZFjKu+H3WrsvbT9x3/KwKUCRj
         WXjRAFRgLM6X+5WeYBXsa8flKON5nh5e7ESvA=
Received: by 10.213.98.78 with SMTP id p14mr1323149ebn.145.1323627762904;
        Sun, 11 Dec 2011 10:22:42 -0800 (PST)
Received: from localhost.localdomain (abvp14.neoplus.adsl.tpnet.pl. [83.8.213.14])
        by mx.google.com with ESMTPS id x12sm64285133eef.9.2011.12.11.10.22.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Dec 2011 10:22:42 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pBBIMfpZ021854;
	Sun, 11 Dec 2011 19:22:42 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pBBIMeJh021851;
	Sun, 11 Dec 2011 19:22:40 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <jc2l2a$som$1@dough.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186805>

Don't remove people from Cc, please.

Gelonida N <gelonida@gmail.com> writes:
> On 12/11/2011 03:22 AM, Sitaram Chamarty wrote:
> > On Sat, Dec 10, 2011 at 01:26:32PM +0100, Gelonida N wrote:

> > So what you want would boil down to this script (untested):
> >=20
> >     #!/bin/bash
> >     git status --porcelain -uno | grep . && {echo dirty tree, exiti=
ng...; exit 1; }
> >=20
> >     for b in `git for-each-ref '--format=3D%(refname:short)' refs/h=
eads`
> >     do
> >         git checkout $b
> >         git merge --ff-only @{u}
> >     done
>=20
> Is there no way to distinguish tracking branches from other branches?
> without checking them out?
>=20
> In order to save time I'd like to avoid checking out local branches.

You can use 'upstream' field name in git-for-each-ref invocation,
for example

  git for-each-ref '--format=3D%(refname:short) %(upstream:short)' refs=
/heads |
  	grep -e ' [^ ]' |
  	sed  -e 's/ .*$//
=20
This could probably be done using only sed -- grep is not necessary.

> Ideally I would even like to avoid checking out branches, which don't
> need to be forwarded.
=20
You can use git-update-ref plumbing, but you would have to do the
check if it does fast-forward yourself, and provide reflog message
yourself too.
=20
Something like

  git for-each-ref '--format=3D%(refname) %(upstream)' |
  while read refname upstream
  do
  	# there is upstream
  	test -n "$upstream" || break
  	# and if fast-forwards
  	test $(git merge-base $refname $upstream) =3D $(git rev-parse $refna=
me) || break
  	git update-ref -m "$message" $refname $upstream
  done

> I also had to remember on which branch I was in order to avoid, that =
I
> am at a random branch after running the script.
>=20
> I could imagine something like my snippet below , though I guess,
> there's something more elegant.
>=20
> git stash
> mybranch=3D`git branch | sed -n 's/\* *//p'`
> # do_script . . .
> git checkout $mybranch
> git stash apply

Don't use git-branch in scripting.  See __git_ps1 function in
contrib/completion/git-completion.bash how it can be done:

  b=3D"$(git symbolic-ref HEAD 2>/dev/null)" ||
  b=3D"$(git rev-parse --verify HEAD)"

Nb. the second part is here only if there is possibility that you are
on detached HEAD (unnamed branch).

HTH (hope that helps)
--=20
Jakub Nar=EAbski
