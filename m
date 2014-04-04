From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-objects: do not reuse packfiles without
 --delta-base-offset
Date: Fri, 4 Apr 2014 19:13:01 -0400
Message-ID: <20140404231301.GA2528@sigill.intra.peff.net>
References: <20140402063916.GA1437@sigill.intra.peff.net>
 <xmqqfvlvvdfi.fsf@gitster.dls.corp.google.com>
 <20140404214848.GA23666@sigill.intra.peff.net>
 <xmqqsipsohjz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 05 01:13:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWDIf-0007Yk-KH
	for gcvg-git-2@plane.gmane.org; Sat, 05 Apr 2014 01:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753180AbaDDXNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2014 19:13:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:54051 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753115AbaDDXND (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2014 19:13:03 -0400
Received: (qmail 13312 invoked by uid 102); 4 Apr 2014 23:13:03 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 04 Apr 2014 18:13:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Apr 2014 19:13:01 -0400
Content-Disposition: inline
In-Reply-To: <xmqqsipsohjz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245777>

On Fri, Apr 04, 2014 at 03:28:48PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > We could convert OFS_DELTA to REF_DELTA on the fly. That _may_ have a
> > performance impact. Right now, we are basically doing the equivalent of
> > sendfile(), and conversion would involve iterating through each object
> > and examining the header.  I think that's probably not too bad, though.
> > The most expensive part of that, stepping to the next object, requires
> > scanning through the zlib packets, but we should be able to use the
> > revidx to avoid that.
> >
> > I'm not sure it's even worth the code complexity, though. The non-reuse
> > codepath is not that much slower, and it should be extremely rare for a
> > client not to support OFS_DELTA these days.
> 
> OK, together with the fact that only ancient versions of fetcher
> would trigger this "do not reuse" codepath, I agree that we should
> go the simplest route this patch takes.

By the way, we may want to revisit this if we grow more features that do
not allow straight byte-for-byte reuse. I am thinking specifically if we
grow a packv4-like representation for an object, and we plan to convert
on-the-fly to existing packv2 clients. But I think the sensible steps
for that are:

  1. If we have v4 on disk and are outputting v2, add this case to the
     "can_reuse" function I just added. I.e., start out correct, and
     turn off the optimization.

  2. Experiment with on-the-fly conversion. It may be that the
     conversion is so expensive that the reuse optimization gets lost in
     the noise. Or maybe we can reclaim most of the advantage of the
     reuse code path, and it is worth going object-by-object and
     converting. But we won't know until we can measure.

-Peff
