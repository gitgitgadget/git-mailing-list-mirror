From: Jeff King <peff@peff.net>
Subject: Re: RFC: Resumable clone based on hybrid "smart" and "dumb" HTTP
Date: Thu, 11 Feb 2016 16:46:53 -0500
Message-ID: <20160211214653.GA835@sigill.intra.peff.net>
References: <CAJo=hJtHgE_vye_1sPTDsvJ0X=Cs72HKLgRH8btpW-pMrDdk9g@mail.gmail.com>
 <CAJo=hJuRxoe6tXe65ci-A35c_PWJEP7KEPFu5Ocn147HwVuo3A@mail.gmail.com>
 <20160210214945.GA5853@sigill.intra.peff.net>
 <xmqq4mdfvspl.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 22:47:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTz4n-0008EN-3P
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 22:47:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865AbcBKVq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 16:46:57 -0500
Received: from cloud.peff.net ([50.56.180.127]:40735 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751690AbcBKVq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 16:46:56 -0500
Received: (qmail 22903 invoked by uid 102); 11 Feb 2016 21:46:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Feb 2016 16:46:56 -0500
Received: (qmail 11465 invoked by uid 107); 11 Feb 2016 21:46:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Feb 2016 16:46:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Feb 2016 16:46:53 -0500
Content-Disposition: inline
In-Reply-To: <xmqq4mdfvspl.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286005>

On Thu, Feb 11, 2016 at 01:32:22PM -0800, Junio C Hamano wrote:

> > ... One
> > alternative would be to amend the bundle format so that rather than a
> > single file, you get a bundle header whose end says "...and my matching
> > packfile is 1234-abcd". And then the client knows that they can fetch
> > that separately from the same source.
> 
> I would imagine that we would introduce bundle v3 format for this.

Yeah, I think so. And in fact, the "here are my packfiles..." bit should
probably be in the v3 header.

> It may want to say "my matching packfiles are these" to accomodate a
> set of packs split at max-pack-size, but I am perfectly fine to say
> you must create a single pack when you use a bundle with separate
> header to keep things simpler.

Interesting. My initial thought is that one could replace "git bundle
create foo.bundle --all && split foo.bundle" with this (for storing or
transferring a bundle somewhere that cannot handle the whole thing in
one go).  It has the advantage that you do not need to recreate the full
bundle to extract the data.

But I think the negatives of splitting across packs would outweigh that.
You cannot have cross-pack deltas, so your total size would be much
larger (in general, I have yet to see a case where max-pack-size is
beneficial, beyond the obvious "your filesystem cannot store files
larger than N bytes").

So I don't think it would be helpful for normal bundle use.

It _could_ be helpful in the context we're talking about here, though.
If I create the split-bundle so that people can resumable-clone from me,
they can only clone up to that bundle's creation point (and
incrementally fetch the rest). But with a single pack, I can't update
the split-bundle without doing a full repack. With multiple packs, I
could regenerate the split-bundle header and just mention the new pack.

It wouldn't be as _efficient_ as a full repack of course, but it may be
a good, cheap interim solution between repacks.

> >   2. Client goes to <url>. They see that they are fetching a bundle,
> >      and know not to do the usual smart-http or dumb-http protocols.
> >      They can fetch the bundle header resumably (though it's tiny, so it
> >      doesn't really matter).
> 
> Might be in megabytes range, though, with many refs.  It still is
> tiny, though ;-).

Yes, but it's the same amount we already spew for a ref advertisement,
which isn't resumable, either. :)

I think I'd probably make this a straight fetch in the first iteration,
and we can worry about making it resumable later on if people actually
care.

> > And you'll notice, too, that all of the bundle-http magic kicks in
> > during step 2 because the client sees they're grabbing a bundle. Which
> > means that the <url> in step 1 doesn't _have_ to be a bundle. It can be
> > "go fetch from kernel.org, then come back to me".
> 
> Or it could be a packfile (and the client discovers roots), as you
> mentioned in a separate message.  I personally do not think it buys
> us much, as long as we do a bundle represented as a header and a
> separate pack.

Yeah, I think I agree, and if it were just me, I'd implement the bundle
part and call it done. But the important thing to me is that we haven't
eliminated the possibility of doing the pure-pack thing on top, if we
choose to.

-Peff
