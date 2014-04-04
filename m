From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-objects: do not reuse packfiles without
 --delta-base-offset
Date: Fri, 4 Apr 2014 17:48:49 -0400
Message-ID: <20140404214848.GA23666@sigill.intra.peff.net>
References: <20140402063916.GA1437@sigill.intra.peff.net>
 <xmqqfvlvvdfi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 04 23:49:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWBzE-0002nW-VW
	for gcvg-git-2@plane.gmane.org; Fri, 04 Apr 2014 23:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330AbaDDVsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2014 17:48:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:54006 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752194AbaDDVsu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2014 17:48:50 -0400
Received: (qmail 9077 invoked by uid 102); 4 Apr 2014 21:48:50 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 04 Apr 2014 16:48:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Apr 2014 17:48:49 -0400
Content-Disposition: inline
In-Reply-To: <xmqqfvlvvdfi.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245773>

On Wed, Apr 02, 2014 at 10:39:13AM -0700, Junio C Hamano wrote:

> > However, it's possible that the other side cannot read our
> > packfile verbatim. For example, we may have objects stored
> > as OFS_DELTA, but the client is an antique version of git
> > that only understands REF_DELTA. We negotiate this
> > capability over the fetch protocol. A normal pack-objects
> > run will convert OFS_DELTA into REF_DELTA on the fly, but
> > the "reuse pack" code path never even looks at the objects.
> 
> The above makes it sound like "reuse pack" codepath is broken.

It is broken (without this patch), though in practice only for ancient
(pre-1.4.x) clients.

> Is it too much hassle to peek at the initial bytes of each object to
> see how they are encoded? Would it be possible to convert OFS_DELTA to
> REF_DELTA on the fly on that codepath as well, instead of disabling
> the reuse altogether?

It's a mistake to peek ahead of time. Part of the point of the
pack-reuse optimization is to start sending out bytes as soon as
possible, since the network is quite often the bottleneck. So we would
not want to look through all of the to-be-sent data before sending out
the first byte.

We could convert OFS_DELTA to REF_DELTA on the fly. That _may_ have a
performance impact. Right now, we are basically doing the equivalent of
sendfile(), and conversion would involve iterating through each object
and examining the header.  I think that's probably not too bad, though.
The most expensive part of that, stepping to the next object, requires
scanning through the zlib packets, but we should be able to use the
revidx to avoid that.

I'm not sure it's even worth the code complexity, though. The non-reuse
codepath is not that much slower, and it should be extremely rare for a
client not to support OFS_DELTA these days.

-Peff
