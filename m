From: Jeff King <peff@peff.net>
Subject: Re: config-file includes
Date: Mon, 26 Sep 2011 08:36:20 -0400
Message-ID: <20110926123620.GA30336@sigill.intra.peff.net>
References: <20110923195829.GA27677@sigill.intra.peff.net>
 <CACsJy8BAVRAct=sxTpZ+b-ft1OjbY9oZG6uEXrcsTXw3CXnwSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 26 14:36:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8AQC-0003gs-6v
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 14:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753475Ab1IZMgZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Sep 2011 08:36:25 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44518
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753375Ab1IZMgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 08:36:25 -0400
Received: (qmail 11906 invoked by uid 107); 26 Sep 2011 12:41:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 26 Sep 2011 08:41:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Sep 2011 08:36:20 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8BAVRAct=sxTpZ+b-ft1OjbY9oZG6uEXrcsTXw3CXnwSg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182104>

On Mon, Sep 26, 2011 at 08:45:58PM +1000, Nguyen Thai Ngoc Duy wrote:

> > You could extend this to look in refs, with something like:
> >
> > =C2=A0[include]
> > =C2=A0ref =3D meta:config
> >
> > which would resolve meta:config to a blob and examine it (i.e., it =
would
> > look at refs/heads/meta).
>=20
> I had something similar [1], although I disregarded worktree content
> completely.

Thanks, I had totally missed that thread.

Maybe it wasn't clear from my proposal, but I intend to disregard the
worktree entirely, too. The include.path was about including stuff from
the local filesystem, not necessarily your worktree.

> One thing about this meta thing is fsck/prune must dig in
> config file in order not to accidentally remove something config file
> refers to.

It is only a connectivity problem if you put a raw sha1 in the config.
It seems much more sensible to me to use a real ref. That solves the
fsck issue, and it makes it easier to manipulate the contents using git=
=2E

> Another thing is, what if I want to exclude certain part of the inclu=
ded config?

  git show origin/meta:config ;# review upstream
  git checkout meta origin/meta
  $EDITOR config
  git commit -a -m 'tweak my config based on upstream'
  git config include.ref meta:config

  [weeks later]
  git fetch ;# oh, new config from upstream
  git log -p origin/meta@{1}...origin/meta ;# looks good to me
  git checkout meta
  git merge origin/meta

Junio raised a good point in the thread you referenced: why is this any
better than the project just shipping a "./setup-config" script that yo=
u
run (and re-run when there is an update). Two things I can think of:

  1. Carrying it in the project tree (as opposed to a separate ref) is
     annoying. It bloats your project tree, and any changes you make
     get tangled up in the changes you're making to the project itself.
     To me, they're logically separate entities.

     You can still keep a separate "meta" ref that has the setup-config
     script in it, though. That wouldn't need git support at all.
     But...

  2. Using a script to deploy the config makes it annoying to track
     changes. If I make local tweaks to what upstream suggests for the
     config, I would want those tracked by git. And when upstream makes
     a change, I want to do a 3-way merge. So either my script must be
     clever in deploying, or I must never touch the deployed .git/confi=
g
     file, and instead edit the setup-config script. Even then, how doe=
s
     it handle changes in .git/config that happen naturally (e.g.,
     branch config written by git).

If we had even a mechanism to include regular files, you could do
something like:

       # make our local tweaked version of config
       git checkout meta
       $EDITOR config
       git commit -a -m 'tweak config based on upstream'

       # now deploy it
       cp config .git/tracked-config

       # and reference it
       git config include.path tracked-config

       # Weeks later, update and redeploy. Don't touch tracked-config i=
n
       # the meantime, as your changes will be overwritten (or copy it
       # back after checkout, commit changes, then pull)
       git checkout meta
       git pull
       cp config .git/tracked-config

which is really quite similar to the "include.ref" I showed earlier,
except you can skip the annoying "deploy" step. Which is a minor
convenience if you are actually keeping your own local config branch,
and a slightly larger one if you want to do the dangerous "just look at
origin/meta for config" thing.

> > [1] I want conditional inclusion because sometimes the rules for co=
nfig
> > =C2=A0 =C2=A0entries changes from version to version. For example, =
I have
> > =C2=A0 =C2=A0pager.diff set to a script in my ~/.gitconfig. But old=
er versions of
> > =C2=A0 =C2=A0git don't understand non-boolean values and barf. I'd =
really like to
> > =C2=A0 =C2=A0do something like:
> >
> > =C2=A0 =C2=A0[include-ifdef "has-pager-scripts"]
> > =C2=A0 =C2=A0path =3D ~/.gitconfig-pager
> >
> > =C2=A0 =C2=A0where "has-pager-scripts" would be a magic flag compil=
ed into git
> > =C2=A0 =C2=A0versions that understand that config.
>=20
> But how far would you go with conditional expressions?

I agree it could become hairy in the general case. That's why I called
it "include-ifdef" and not "include-if". That would serve my use case. =
I
have no desire to support

  [include-if "2 + 2 >=3D 4"]

-Peff
