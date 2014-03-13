From: Jeff King <peff@peff.net>
Subject: Re: No progress from push when using bitmaps
Date: Thu, 13 Mar 2014 18:07:54 -0400
Message-ID: <20140313220754.GA20173@sigill.intra.peff.net>
References: <CAJo=hJth1YB+u2Y9S0X3xk7s2-HcPP4_k03qprHBU4A9721i8g@mail.gmail.com>
 <20140313212626.GA23618@sigill.intra.peff.net>
 <CAJo=hJu1WscibwectWzrUcoOV4-9xk4hBm1JA+RjONmgvZTXwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 13 23:08:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WODnF-0006CU-DR
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 23:08:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522AbaCMWH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 18:07:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:39060 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752682AbaCMWH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 18:07:56 -0400
Received: (qmail 15119 invoked by uid 102); 13 Mar 2014 22:07:56 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 13 Mar 2014 17:07:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Mar 2014 18:07:54 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJu1WscibwectWzrUcoOV4-9xk4hBm1JA+RjONmgvZTXwQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244054>

On Thu, Mar 13, 2014 at 03:01:09PM -0700, Shawn Pearce wrote:

> > It would definitely be good to have throughput measurements while
> > writing out the pack. However, I'm not sure we have anything useful to
> > count. We know the total number of objects we're reusing, but we're not
> > actually parsing the data; we're just blitting it out as a stream. I
> > think the progress code will need some refactoring to handle a
> > throughput-only case.
> 
> Yes. I think JGit suffers from this same bug, and again we never
> noticed it because usually only the servers are bitmapped, not the
> clients.
> 
> pack-objects writes a throughput meter when its writing objects.
> Really just the bytes out/second would be enough to let the user know
> the client is working. Unfortunately I think that is still tied to the
> overall progress system having some other counter?

Yes, I'm looking at it right now. The throughput meter is actually
connected to the sha1fd output. So really we just need to call
display_progress periodically as we loop through the data. It's a
one-liner fix.

_But_ it still looks ugly, because, as you mention, it's tied to the
progress meter, which is counting up to N objects. So we basically sit
there at "0", pumping data, and then after the pack is done, we can say
we sent N. :)

There are a few ways around this:

  1. Add a new phase "Writing packs" which counts from 0 to 1. Even
     though it's more accurate, moving from 0 to 1 really isn't that
     useful (the throughput is, but the 0/1 just looks like noise).

  2. Add a new phase "Writing reused objects" that counts from 0 bytes
     up to N bytes. This looks stupid, though, because we are repeating
     the current byte count both here and in the throughput.

  3. Use the regular "Writing objects" progress, but fake the object
     count. We know we are writing M bytes with N objects. Bump the
     counter by 1 for every M/N bytes we write.

The first two require some non-trivial surgery to the progress code. I
am leaning towards the third. Not just because it's easy, but because I
think it actually shows the most intuitive display. Yes, it's fudging
the object numbers, but those are largely meaningless anyway (in fact,
it makes them _better_ because now they're even, instead of getting 95%
done and then hitting some blob that is as big as the rest of the repo
combined).

-Peff
