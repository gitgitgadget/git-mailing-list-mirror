From: Jeff King <peff@peff.net>
Subject: Re: [BUG REPORT] Git log pretty date
Date: Tue, 3 Jun 2014 02:45:26 -0400
Message-ID: <20140603064526.GB26150@sigill.intra.peff.net>
References: <CACJZPBtv-Cpb8_WZMz9Hsk9MrC86YGfbvREt6G=QKvMBjrqsEg@mail.gmail.com>
 <CACsJy8BREpVFKq3mW=Lwn+uNm1r40Xe8f4EyXLFN2yybZRT0oA@mail.gmail.com>
 <20140529161628.GB3763@sigill.intra.peff.net>
 <xmqq7g54begk.fsf@gitster.dls.corp.google.com>
 <20140529194932.GA16665@sigill.intra.peff.net>
 <CACJZPBs2_htD=zS1K3fOW+DZ323+2+iwupWuyNDArg2XF6Qx5g@mail.gmail.com>
 <CACJZPBtJZ+gDvtHnRwi8JOO7rFAg=pPBvEQ=-FwKnp9Gr+FStw@mail.gmail.com>
 <20140603034619.GA18176@sigill.intra.peff.net>
 <20140603062301.GA22149@spirit>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Rodrigo Fernandes <rtfrodrigo@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Tue Jun 03 08:45:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WriTU-0003T8-N5
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 08:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbaFCGp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 02:45:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:36419 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752351AbaFCGp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 02:45:28 -0400
Received: (qmail 6189 invoked by uid 102); 3 Jun 2014 06:45:28 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Jun 2014 01:45:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jun 2014 02:45:26 -0400
Content-Disposition: inline
In-Reply-To: <20140603062301.GA22149@spirit>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250615>

On Tue, Jun 03, 2014 at 08:23:02AM +0200, Dennis Kaarsemaker wrote:

> On Mon, Jun 02, 2014 at 11:46:19PM -0400, Jeff King wrote:
> > On Fri, May 30, 2014 at 09:08:57AM +0100, Rodrigo Fernandes wrote:
> > 
> > > Do you have any idea how does github understand that is a bug and
> > > fixes it automatically?
> > > (I'm saying this because on Github the date is correct).
> > 
> > I looked into this. The dates you see on GitHub's web UI are actually
> > parsed by Rugged/libgit2. The libgit2 parser is slightly more forgiving
> > in this instance; if it sees a broken timezone, it will leave the
> > timestamp intact, and only omit the timezone. Whereas git says "no, it's
> > broken, and the timestamp cannot be trusted".
> > 
> > I think both are equally valid strategies, and I do not even think it is
> > a problem that they diverge between the two implementations. I'd be OK
> > with a patch to make git handle errors in each independently, assuming
> > it is not too invasive.
> 
> I think what libgit2 does is more wrong than what git does. It displays
> the timestamp subtly wrong (off by 7 hours) instead of making it
> completely clear that the timestamp is bogus.

I'm not sure what you mean. The timestamp is in UTC seconds-since-epoch,
and does not depend on the timezone. The timezone only indicates the
author's local time when the commit was made.

Whether the latter is relevant depends on the date format you are
showing (i.e., if you are showing it in the author's timezone, it
matters; for --date=local or --date=relative, it would not).

So I do not think libgit2 is at fault for parsing them separately; it
does not know how the result will be presented. What GitHub shows is
wrong, as it tries to put the timestamp into the author's timezone
(which it doesn't know). But in practice it turns out be more useful,
because we show relative dates for recent things (so "8 hours ago" is
actually accurate and does not care about the timestamp). For distant
things, time zone effects become less important (we show "Oct 29, 2010";
it may have actually been Oct 30 or Oct 28 in the author's zone, but
it's really not that important anymore).

Those comments are just on the two strategies. As far as
implementations, it looks like libgit2 somehow parses this commit as
+0700, which is odd. I'd expect it to fall back to +0000. I didn't dig
further.

-Peff
