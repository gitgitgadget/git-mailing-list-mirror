From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] fetch into shallow sends a large number of objects
Date: Thu, 10 Mar 2016 16:10:53 -0500
Message-ID: <20160310211052.GC30595@sigill.intra.peff.net>
References: <20160307221539.GA24034@sigill.intra.peff.net>
 <xmqqio0xn93q.fsf@gitster.mtv.corp.google.com>
 <20160308121444.GA18535@sigill.intra.peff.net>
 <CACsJy8Dk_g1O98UsDaeVS3VXmE2Mn5aR+w1OiFir+QwyJYLVZQ@mail.gmail.com>
 <20160308132524.GA22866@sigill.intra.peff.net>
 <20160310122020.GA24007@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 22:11:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae7rP-0004uP-Vi
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 22:11:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbcCJVLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 16:11:00 -0500
Received: from cloud.peff.net ([50.56.180.127]:58015 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932231AbcCJVK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 16:10:56 -0500
Received: (qmail 4033 invoked by uid 102); 10 Mar 2016 21:10:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Mar 2016 16:10:55 -0500
Received: (qmail 29307 invoked by uid 107); 10 Mar 2016 21:11:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Mar 2016 16:11:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Mar 2016 16:10:53 -0500
Content-Disposition: inline
In-Reply-To: <20160310122020.GA24007@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288640>

On Thu, Mar 10, 2016 at 07:20:20PM +0700, Duy Nguyen wrote:

> > +	else if (shallows.nr > 0) {
> > +		struct rev_info revs;
> > +		struct argv_array av = ARGV_ARRAY_INIT;
> > +		struct commit *c;
> > +		int i;
> > +
> > +		argv_array_push(&av, "rev-list");
> > +		argv_array_push(&av, "--boundary");
> 
> Nice. I didn't know about --boundary. But will it work correctly in
> this case?
> 
>        --- B ---- C ---- F
>           /      /
>      --- D ---- E ---- G
> 
> C and D will be current shallow cut points. People "want" F and G.
> "rev-list --boundary F G ^C ^D" would mark E as boundary/shallow too,
> correct? If so the history from G will be one depth short on a normal
> fetch.

IMHO, that is the right thing. They asked for "C" as a shallow cut-off
point, so anything that is a parent of "C" should be omitted as shallow,
too. It has nothing to do with the numeric depth, which was just the
starting point for generating the shallow cutoffs.

That's just my mental model, though. I admit I don't actually use
shallow clones myself, and maybe people would expect something else.

> > _But_, the client is not prepared to handle this. We send "shallow"
> > lines that it is not expecting, since it did not ask for any depth. So I
> > think this logic would have to kick in only when the client tells us to
> > do so.
> 
> Urgh.. not good. Perhaps a new extension to let the server know the
> client can handle spontaneous "deepen" commands and only activate new
> mode when the extension is present?

Yeah, we definitely need an extension. I'm not sure if the extension
should be "I know about spontaneous shallow/deepen responses; it's OK to
send them to me" or "I want you to include the shallow points I send as
boundary cutoffs for further shallow-ing of newly fetched history".

They amount to the same thing when implementing _this_ feature, but the
latter leaves us room in the future for a client to say "sure, I
understand your spontaneous responses, but I explicitly _don't_ want you
to do the boundary computation". I don't know if that is useful or not,
but it might not hurt to have later on (and by adding it now, it "just
works" later on with older servers/clients).

> > So what next? I think there's some protocol work here, and I think the
> > overall design of that needs to be considered alongside the other
> > "deepen" options your topic in pu adds (and of which I'm largely
> > ignorant). Does this sufficiently interest you to pick up and roll into
> > your other shallow work?
> 
> I can pick it up if you are busy with other stuff. But I'm also having
> a couple other topics at the moment, so it may not progress very fast.

Thanks. I don't think it is too urgent; it has been that way for a
while. I certainly have plenty of other things to work on, but mostly I
just feel a bit out of my depth on the shallow stuff. I haven't given it
any real thought, and you obviously have.

-Peff
