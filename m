From: Carlos Martin Nieto <cmn@elego.de>
Subject: Re: [PATCH] send-pack: don't send a thin pack when the server doesn't support it
Date: Tue, 08 Oct 2013 12:58:33 +0200
Message-ID: <87li242fmu.fsf@flaca.cmartin.tk>
References: <1381221884-27048-1-git-send-email-cmn@elego.de>
	<CACsJy8AQ-719sbUfJW98q_HYit7ePfB6oN3v7XTX6fvC7HnixA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 08 13:06:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTV7u-0005z5-IR
	for gcvg-git-2@plane.gmane.org; Tue, 08 Oct 2013 13:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694Ab3JHLGl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Oct 2013 07:06:41 -0400
Received: from hessy.cmartin.tk ([78.47.67.53]:58628 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751958Ab3JHLGk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Oct 2013 07:06:40 -0400
X-Greylist: delayed 482 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Oct 2013 07:06:40 EDT
Received: from cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by hessy.dwim.me (Postfix) with ESMTPA id 6F1D4805FA;
	Tue,  8 Oct 2013 12:58:34 +0200 (CEST)
Received: (nullmailer pid 8637 invoked by uid 1000);
	Tue, 08 Oct 2013 10:58:33 -0000
In-Reply-To: <CACsJy8AQ-719sbUfJW98q_HYit7ePfB6oN3v7XTX6fvC7HnixA@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 8 Oct 2013 16:44:49 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235769>

Duy Nguyen <pclouds@gmail.com> writes:

On Tue, 2013-10-08 at 16:44 +0700, Duy Nguyen wrote:
>On Tue, Oct 8, 2013 at 3:44 PM, Carlos Mart=C3=ADn Nieto <cmn@elego.de=
> wrote:
> > diff --git a/send-pack.c b/send-pack.c
> > index 7d172ef..7b88ac8 100644
> > --- a/send-pack.c
> > +++ b/send-pack.c
> > @@ -205,6 +205,8 @@ int send_pack(struct send_pack_args *args,
> >                 quiet_supported =3D 1;
> >         if (server_supports("agent"))
> >                 agent_supported =3D 1;
> > +       if (!server_supports("thin-pack"))
> > +               args->use_thin_pack =3D 0;
>=20
> Hmm.. I think this introduces a regression in C Git because
> receive-pack never advertises "thin-pack" and so "git push" from now
> on will never send thin packs. It's too late now to add thin-pack to
>=20
Oh, I'd never noticed that when looking though the network traffic. Thi=
s seems like something that breaks the compatibility that git otherwise=
 tries so hard to maintain. How did it happen that it's fine for the cl=
ient to assume that the server supports thin packs?

receive-pack, perhaps a new extension "no-thin-pack" for those
> servers? Alternatively, just run git push --no-thin (you'll need
> f7c815c (push: respect --no-thin - 2013-08-12) though).
>=20
Yeah, I had an older version in my PATH and was bitten by that when
testing. Having --no-thin and the server's index-pack fail with missing
bases is quite worrying when you're the one who wrote most of the
server-side code.

Having to remember to run 'git push --no-thin' when pushing to one
particular project is pretty bad experience as a user and I was hoping
to avoid this with newer gits. We could advertise a "no-thin-pack"
extension if a patch to support that would be accepted into mainline
git.

Cheers,
   cmn
