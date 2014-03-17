From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] mv: prevent mismatched data when ignoring errors.
Date: Mon, 17 Mar 2014 18:04:27 -0400
Message-ID: <20140317220427.GA19300@sigill.intra.peff.net>
References: <20140308183501.GH18371@serenity.lan>
 <1394306499-50871-1-git-send-email-sandals@crustytoothpaste.net>
 <8738ijzbue.fsf@thomasrast.ch>
 <20140316020018.GA20019@sigill.intra.peff.net>
 <7v1ty14z8x.fsf@alter.siamese.dyndns.org>
 <7vtxax2v1q.fsf@alter.siamese.dyndns.org>
 <53270FC2.2030701@alum.mit.edu>
 <CAPig+cTs23=j_1OsB4FUUb1PZWubhad+XBCa1iEx4jChZE2x4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <tr@thomasrast.ch>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Git List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Guillaume Gelin <contact@ramnes.eu>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 23:04:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPfe6-0000wt-MW
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 23:04:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634AbaCQWEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 18:04:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:41403 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752173AbaCQWE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 18:04:29 -0400
Received: (qmail 354 invoked by uid 102); 17 Mar 2014 22:04:29 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 17 Mar 2014 17:04:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Mar 2014 18:04:27 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cTs23=j_1OsB4FUUb1PZWubhad+XBCa1iEx4jChZE2x4w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244297>

On Mon, Mar 17, 2014 at 03:06:02PM -0400, Eric Sunshine wrote:

> On Mon, Mar 17, 2014 at 11:07 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> > On 03/17/2014 07:33 AM, Junio C Hamano wrote:
> >> Junio C Hamano <gitster@pobox.com> writes:
> >>
> >>> Would it make sense to go one step further to introduce two macros
> >>> to make this kind of screw-up less likely?
> > potential callers that I noticed, ALLOC_GROW() was used immediately
> > before making space in the array for a new element.  So I suggest
> > something more like
> >
> > +#define MOVE_DOWN(array, nr, at, count)        \
> > +       memmove((array) + (at) + (count),               \
> > +               (array) + (at),                         \
> > +               sizeof((array)[0]) * ((nr) - (at)))
> 
> Each time I read these, my brain (for whatever reason) interprets the
> names UP and DOWN opposite of the intended meaning, which makes them
> confusing. Perhaps INSERT_GAP and CLOSE_GAP would avoid such problems,
> and be more consistent with Michael's proposed ALLOC_INSERT_GAP.

Yeah, the UP/DOWN are very confusing to me. Something like SHRINK/EXPAND
(with the latter handling the ALLOC_GROW for us) makes more sense to me.
Those terms do not explicitly specify that we are doing it in the middle
(whereas GAP does), but I think it is fairly obvious from the parameters
what each is used for.

Side note: I had _almost_ added something to my original email
suggesting more use of macros to embody common idioms. For example, in
the vast majority of malloc cases, you could using something like:

  #define ALLOC_OBJS(x,n) do { x = xmalloc(sizeof(*x) * (n)); } while(0)
  #define ALLOC_OBJ(x) ALLOC_OBJS(x,1)

That eliminates a whole possible class of errors. But it's also
un-idiomatic as hell, and the resulting confusion can cause its own
problems. So I refrained from suggesting it.

I think as long as a macro is expressing a more high-level intent,
though, paying that cost can be worth it. By itself, wrapping memmove
to use sizeof(*array) does not seem all that exciting. But wrapping a
few specific cases like shrink/expand probably does make the code more
readable.

-Peff
