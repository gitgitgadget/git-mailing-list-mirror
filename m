From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/6] strbuf: add an optimized 1-character strbuf_grow
Date: Mon, 6 Apr 2015 01:05:44 -0400
Message-ID: <20150406050544.GB1932@peff.net>
References: <20150405010611.GA15901@peff.net>
 <20150405011127.GD30127@peff.net>
 <CAPig+cTK5MJLfwETFfM1Zdw35M2geKKmA6Q9M0kHdMP9t8qLNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 07:06:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YezEy-000464-1A
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 07:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbbDFFFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2015 01:05:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:42792 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750791AbbDFFFr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 01:05:47 -0400
Received: (qmail 30380 invoked by uid 102); 6 Apr 2015 05:05:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Apr 2015 00:05:47 -0500
Received: (qmail 9520 invoked by uid 107); 6 Apr 2015 05:06:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Apr 2015 01:06:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Apr 2015 01:05:44 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cTK5MJLfwETFfM1Zdw35M2geKKmA6Q9M0kHdMP9t8qLNg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266836>

On Sun, Apr 05, 2015 at 10:13:21PM -0400, Eric Sunshine wrote:

> > -               strbuf_grow(sb, 1);
> > +               strbuf_grow_ch(sb);
> 
> strbuf_grow_ch() seems overly special-case. What about instead taking
> advantage of inline strbuf_avail() to do something like this?
> 
>     if (!strbuf_avail())
>         strbuf_grow(sb, 1);

Thanks, I somehow missed that function (despite it being a few line
above the one I added!).

I agree that strbuf_avail is a much better generic interface, and it
turns out to be just as fast (actually, a tiny bit faster in my tests).
I'll use that in the re-roll.

> (Minor tangent: The 1 is still slightly magical and potentially
> confusing for someone who doesn't know that the buffer is grown
> aggressively, so changing it to a larger number might make it more
> obvious to the casual reader that the buffer is in fact not being
> grown on every iteration.)

I agree this is slightly confusing (and I had to double-check how
strbuf_grow worked while writing this series). OTOH, this is not so much
about the "1" here as about how strbufs work. We care about the
amortized asymptotic cost. strbuf_add() has the same issue; we add more
bytes in each chunk, but we would still want to make sure that there is
a sub-linear relationship between the number of adds and the number of
allocations).

-Peff
