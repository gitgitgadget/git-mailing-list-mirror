From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] remote.c: avoid O(n^2) behavior in match_push_refs by
 using string_list
Date: Wed, 3 Jul 2013 15:00:47 -0400
Message-ID: <20130703190047.GA349@sigill.intra.peff.net>
References: <1372809228-2963-1-git-send-email-bcasey@nvidia.com>
 <20130703062332.GA16090@sigill.intra.peff.net>
 <CA+sFfMeDC=hc7QZhfSuQYsdBPzig5WANeTBhMxFZk=Pusq0QpA@mail.gmail.com>
 <7vhagbfpwz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Martin Fick <mfick@codeaurora.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 21:01:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuSIV-0001Gz-Ky
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 21:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965117Ab3GCTAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 15:00:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:40843 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964816Ab3GCTAv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 15:00:51 -0400
Received: (qmail 31897 invoked by uid 102); 3 Jul 2013 19:02:02 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 03 Jul 2013 14:02:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jul 2013 15:00:47 -0400
Content-Disposition: inline
In-Reply-To: <7vhagbfpwz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229511>

On Wed, Jul 03, 2013 at 11:40:12AM -0700, Junio C Hamano wrote:

> Brandon Casey <drafnel@gmail.com> writes:
> 
> > Right.  For repos with few refs on either side, I don't think there
> > will be any measurable difference.  When pushing a single ref to a
> > repo with a very large number of refs, we will see a very small net
> > loss for the time required to prepare the string list (which grows
> > linearly with the number of remote refs).  After 2 or 3 refs, we
> > should see a net gain.
> >
> > So we're really just improving our worst case performance here.
> 
> ... by penalizing the common case by how much?  If it is not too
> much, then this obviously would be a good change.

I don't think by much. If we have "m" local refs to push and "n" remote
refs, right now we do O(m*n) work ("m" linear searches of the remote
namespace). With Brandon's patch, we do O(n log n) to build the index,
plus O(m log n) for lookups.

So our break-even point is basically m = log n, and for m smaller than
that, we do more work building the index. Your absolute biggest
difference would be pushing a single ref to a repository with a very
large number of refs.

Here are the timings before and after Brandon's patch for pushing a
no-op single ref from a normal repo to one with 370K refs (the same
pathological repo from the upload-pack tests). Times are
best-of-five.

             before     after
     real    0m1.087s   0m1.156s
     user    0m1.344s   0m1.412s
     sys     0m0.288s   0m0.284s

So it's measurable, but even on a pathological worst-case, we're talking
about 6% slowdown.

You could try to guess about when to build the index based on the size
of "m" and "n", but I suspect you'd waste more time calculating whether
to build the index than you would simply building it in most cases.

-Peff
