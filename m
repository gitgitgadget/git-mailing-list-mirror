From: Jeff King <peff@peff.net>
Subject: Re: git should not use a default user.email config value
Date: Tue, 13 Aug 2013 11:53:46 -0400
Message-ID: <20130813155345.GA23391@sigill.intra.peff.net>
References: <20130810064717.GB30185@sigill.intra.peff.net>
 <52060EF9.2040504@alum.mit.edu>
 <7vvc3d1o01.fsf@alter.siamese.dyndns.org>
 <CAH5451nHfOaBzFzkrGvw+TyRj==cVpKF_QdXsTxnn5tTr1c0dw@mail.gmail.com>
 <20130812123921.GA16088@sigill.intra.peff.net>
 <CAH5451=PK15n4U-3Mb_TLevF3-r+vrpk1PXD15Oo1A2KFc5i_w@mail.gmail.com>
 <20130812154520.GA18215@sigill.intra.peff.net>
 <CAH5451=WKXUNzovXquFii=EdkeQXJEQ96_CRRebgQW6ow_19VA@mail.gmail.com>
 <20130813114635.GA16506@sigill.intra.peff.net>
 <CAH5451nxgpa4Q-BpwhD7yD6V6_LWBP=+oEDR3u0eGErSWNEBbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thorsten Glaser <tg@mirbsd.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 13 17:53:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9Guw-0003eT-2X
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 17:53:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758471Ab3HMPxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 11:53:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:57545 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758572Ab3HMPxs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 11:53:48 -0400
Received: (qmail 24926 invoked by uid 102); 13 Aug 2013 15:53:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Aug 2013 10:53:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Aug 2013 11:53:46 -0400
Content-Disposition: inline
In-Reply-To: <CAH5451nxgpa4Q-BpwhD7yD6V6_LWBP=+oEDR3u0eGErSWNEBbQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232228>

On Tue, Aug 13, 2013 at 10:52:34PM +1000, Andrew Ardill wrote:

> > The only downside I can think of is that we might want to use the
> > subsection in "include.SUBSECTION.*" for some other limiting conditions
> > (e.g., "only include this config when running version >= X.Y", or even
> > "include only when environment variable FOO is true").
> 
> It seems as though gitconfig doesn't have a standard way of dealing
> with 'sub-subsections', which is essentially what this is trying to
> implement.

Right. Syntactically, the config keys are:

  SECTION.SUBSECTION.KEY

where SUBSECTION is optional. SECTION and KEY cannot contain spaces or
dots and are case insensitive, but SUBSECTION is handled literally. It
can contain whatever data is useful to the config parser (for example,
remote names, branch names, or even URLs), including spaces or dots.

We could introduce the notion of sub-subsections, but that would not
play well with existing uses of subsection, which assume that they can
put arbitrary data into it.

> It makes sense that there could be different 'modes' of includes.
> These could be the ones you mentioned already, such as repo and env,
> but could also be things like branch where the config changes
> depending on which branch you are on. Ideally, multiple entries per
> mode would be allowed.
>
> Implementing all that initially would be overkill however if this sort
> of functionality is desirable the ability to easily add new modes
> would be a great boon down the track.

Right. We don't have to decide on all of it now; we just have to leave
the door open syntactically for future growth.

> The four pieces of information we need to include are that this is an
> include, the path to the include, the mode, and the mode specific
> parameter. Your proposal is to allow the sub-subsection by
> concatenating with a ":" like this
> 
> [include "<mode>:<mode-param>]
>   path = <path>

Right. The config parser does not care about the sub-subsection; it is
up to the interpreter of the key to split the subsection if it chooses.
I arbitrarily chose ":" as the internal delimiter because I thought it
looked nice. You could make it dot or space, too.

> Alternatively, we could allow chaining of subsections (couldn't find
> any previous discussion on this) by adding whitespace between each
> subsection. Seems like lots of potentially unnecessary work, but maybe
> this has already been discussed or is the most appropriate way of
> doing it.
> 
> $ git config --global include.repo./magic/.path ~/.gitconfig-magic
> 
> [include repo "/magic/"]
>    path = .gitconfig-magic

I don't think it has been discussed before. But as I mentioned above,
you would not want to apply this everywhere. For existing config
callbacks, they want to take the section literally. So it is going to be
up to the callback to parse the section into subsections anyway, at
which point it does not really matter what syntax you use.

We could teach the config parser to normalize:

  [section with many spaces]
    key

as "section.with.many.spaces.key" or "section.with many spaces.key" (I
do not think it is even valid in today's code, but I didn't check). But
personally I do not find that any easier to read or understand than the
colon syntax.

> This seems like the easiest and most flexible method, and doesn't
> require any 'special' considerations for the subsection. It would be
> harder for a user to configure, and the concept of a mode seems less
> intuitive.
> 
> $ git config --global include.magicrepos.mode repo
> $ git config --global include.magicrepos.param /magic/
> $ git config --global include.magicrepos.path ~/.gitconfig-magic
> 
> [include "magicrepos"]
>   mode = repo
>   param = "/magic/"
>   path = ~/.gitconfig-magic

Yeah, that is the most flexible. You could introduce multiple conditions
or other options, as well (e.g., instead of mode and param, have
include.magic.repo, include.magic.env, etc). But it seems like
over-engineering. I do not mind making the code a little harder to
write, but it seems unnecessarily complicated for the user, too.

> Of the three I probably think the subsection chaining is the nicest
> overall, though your original "repo:" proposal seems to be the easiest
> to implement.

I think I favor the colon proposal because of its simplicity. And
because the sub-section chaining cannot be applied consistently across
config keys, I don't think there is much value in trying to introduce a
new general config syntax.

-Peff
