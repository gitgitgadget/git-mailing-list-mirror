From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/5] log: do not segfault on gmtime errors
Date: Wed, 26 Mar 2014 17:09:29 -0400
Message-ID: <20140326210929.GA16581@sigill.intra.peff.net>
References: <20140224073348.GA20221@sigill.intra.peff.net>
 <20140224074905.GE9969@sigill.intra.peff.net>
 <20140326110559.GA32625@hashpling.org>
 <20140326182103.GB7087@sigill.intra.peff.net>
 <xmqqvbv0iy6u.fsf@gitster.dls.corp.google.com>
 <20140326190157.GB12912@sigill.intra.peff.net>
 <xmqqeh1oisim.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Charles Bailey <cbailey32@bloomberg.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 22:09:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSv4q-0002Km-Ff
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 22:09:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755422AbaCZVJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 17:09:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:47958 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753544AbaCZVJb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 17:09:31 -0400
Received: (qmail 24365 invoked by uid 102); 26 Mar 2014 21:09:31 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Mar 2014 16:09:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Mar 2014 17:09:29 -0400
Content-Disposition: inline
In-Reply-To: <xmqqeh1oisim.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245228>

On Wed, Mar 26, 2014 at 02:01:21PM -0700, Junio C Hamano wrote:

> > I don't know how important that is. This is such a minor feature that it
> > is not worth a lot of maintenance headache in the test. But I also do
> > not know if this is going to be the last report, or we will have a bunch
> > of other systems that need their own special values put into the test.
> 
> I didn't quite realize that your objective of the change was to
> signal the failure of gmtime for all implementations,

I didn't realize it at the time I wrote the test, either. It was my goal
to recognize such failures, but I didn't now at the time that there were
failures that would be signaled by anything besides a NULL return.

> the ones that signal an error by giving NULL back to us and (2) the
> ones that fail to signal an error but leave bogus result (FreeBSD,
> but it appears AIX might be also giving us another bogus value), by
> using a single sane sentinel value.  If we can do that consistently
> on every platform, that would indeed be great.

Agreed. I am not sure we can do so. For FreeBSD, I think it is not hard.
I am not sure what the pattern is for AIX. I am hoping Charles will
reveal some pattern, but there may not be one.

> But if that is the case, we should not have to maintain special case
> values in the test code, I would think.

Right. All of my suggestions to accommodate special values in the test
were assuming that the system gmtime was smarter than we are. That it
produced a good value for this crazy time and _didn't_ fail.

But after having done the basic math, I don't think that is what is
going on here.

> The test instead should expect the output to have that single sentinel
> value, and if the workaround code fails to detect a breakage in the
> platform gmtime(), the special case logic to catch these
> platform-specific breakages should go that "timestamp that cannot be
> grokked by gmtime---replace it with a sentinel" logic, no?

Yes, exactly. That is the preferable solution, if we can come up with
such logic. Personally I am not optimistic.

The fallback is to accept that we cannot cover all cases, and just
loosen the test (i.e., the second patch I posted today).

-Peff
