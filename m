From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t4212: handle systems with post-apocalyptic gmtime
Date: Fri, 28 Mar 2014 14:47:10 -0400
Message-ID: <20140328184710.GA29987@sigill.intra.peff.net>
References: <20140326182103.GB7087@sigill.intra.peff.net>
 <20140326185153.GA12912@sigill.intra.peff.net>
 <xmqqr45oixa6.fsf@gitster.dls.corp.google.com>
 <20140326192536.GA13989@sigill.intra.peff.net>
 <20140326193359.GA14105@sigill.intra.peff.net>
 <20140326212227.GC6991@hashpling.org>
 <20140326215741.GA17716@sigill.intra.peff.net>
 <20140326224616.GA9454@hashpling.org>
 <20140327224837.GB32434@sigill.intra.peff.net>
 <xmqqd2h6cm26.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Charles Bailey <cbailey32@bloomberg.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 19:47:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTboF-0003Hu-WE
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 19:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225AbaC1SrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 14:47:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:49470 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751735AbaC1SrM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 14:47:12 -0400
Received: (qmail 32334 invoked by uid 102); 28 Mar 2014 18:47:12 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 28 Mar 2014 13:47:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Mar 2014 14:47:10 -0400
Content-Disposition: inline
In-Reply-To: <xmqqd2h6cm26.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245411>

On Fri, Mar 28, 2014 at 09:41:53AM -0700, Junio C Hamano wrote:

> Offhand, the three possible failure modes this thread identified
> sounds to me like the only plausible ones, and I think the best way
> forward might be to
> 
>  - teach the "is the result sane, even though we may have got a
>    non-NULL from gmtime?  otherwise let's signal a failure by
>    replacing it with a known sentinel value" codepath the new
>    failure mode Charles's report suggests---if we feed a positive
>    timestamp and gmtime gave us back a tm_year+1900 < 0, that is
>    certainly an overflow; and

I don't think we can analyze the output from gmtime. If it wraps the
year at N, then won't N+2014 look like a valid value?

If we are going to do something trustworthy I think it has to be before
we hand off to gmtime. Like:

diff --git a/date.c b/date.c
index e1a2cee..e0c43c4 100644
--- a/date.c
+++ b/date.c
@@ -57,6 +57,8 @@ static time_t gm_time_t(unsigned long time, int tz)
 static struct tm *time_to_tm(unsigned long time, int tz)
 {
 	time_t t = gm_time_t(time, tz);
+	if (t > 9999999999999999)
+		return NULL;
 	return gmtime(&t);
 }

I suspect that would handle the FreeBSD case, as well.

By the way, I have a suspicion that the gm_time_t above can overflow if
you specially craft a value at the edge of what time_t can handle (we
check that our value will not overflow time_t earlier, but now we might
be adding up to 86400 seconds to it). <sigh>

-Peff
