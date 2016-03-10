From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] fetch into shallow sends a large number of objects
Date: Thu, 10 Mar 2016 16:40:42 -0500
Message-ID: <20160310214042.GB32608@sigill.intra.peff.net>
References: <20160307221539.GA24034@sigill.intra.peff.net>
 <xmqqio0xn93q.fsf@gitster.mtv.corp.google.com>
 <20160308121444.GA18535@sigill.intra.peff.net>
 <CACsJy8Dk_g1O98UsDaeVS3VXmE2Mn5aR+w1OiFir+QwyJYLVZQ@mail.gmail.com>
 <20160308132524.GA22866@sigill.intra.peff.net>
 <20160310122020.GA24007@lanh>
 <20160310211052.GC30595@sigill.intra.peff.net>
 <xmqqbn6mdnyn.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 22:40:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae8K9-00046E-Mz
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 22:40:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbcCJVkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 16:40:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:58051 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932180AbcCJVkp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 16:40:45 -0500
Received: (qmail 5324 invoked by uid 102); 10 Mar 2016 21:40:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Mar 2016 16:40:45 -0500
Received: (qmail 29724 invoked by uid 107); 10 Mar 2016 21:41:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Mar 2016 16:41:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Mar 2016 16:40:42 -0500
Content-Disposition: inline
In-Reply-To: <xmqqbn6mdnyn.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288646>

On Thu, Mar 10, 2016 at 01:26:08PM -0800, Junio C Hamano wrote:

> > IMHO, that is the right thing. They asked for "C" as a shallow cut-off
> > point, so anything that is a parent of "C" should be omitted as shallow,
> > too. It has nothing to do with the numeric depth, which was just the
> > starting point for generating the shallow cutoffs.
> 
> I think that is the right mental model.  The statement that "C and D
> are current cut points" does not make much sense.  As you cannot
> rewrite parents of commits after the fact, you cannot construct a
> case like "when the shallow clone originally was made, two histories
> were forked long time before B and D, and the cloner ended up with C
> and D as the cutoff point, but now that we have the ancestry linkage
> between B and D (and C and E), we need to make E a new cutoff".  The
> original "shallow" implementation does not store "starting point +
> number of depth" and instead translates that to the cut-off point
> for this exact reason.

OK, good. Now there are at least two of us who view it that way. :)

> > Yeah, we definitely need an extension. I'm not sure if the extension
> > should be "I know about spontaneous shallow/deepen responses; it's OK to
> > send them to me" or "I want you to include the shallow points I send as
> > boundary cutoffs for further shallow-ing of newly fetched history".
> >
> > They amount to the same thing when implementing _this_ feature, but the
> > latter leaves us room in the future for a client to say "sure, I
> > understand your spontaneous responses, but I explicitly _don't_ want you
> > to do the boundary computation". I don't know if that is useful or not,
> > but it might not hurt to have later on (and by adding it now, it "just
> > works" later on with older servers/clients).
> 
> I am not sure what distinction you are worried about.  An updated
> client that is capable of saying "you may give shallow/deepen
> responses to me" can optionally be told not to say it to the server,
> and that is equivalent to saying "I don't want you to send them", no?

Mostly, I wondered if we would need to send spontaneous shallow lines
for any other cases, and the client would not be able to say "I
understand them and want them in case A, but not in case B".

I do not have any case A in mind; it was just a general sense of "let's
make feature flags as specific as possible to avoid painting ourselves
into a corner". I'm OK with implementing it either way.

-Peff
