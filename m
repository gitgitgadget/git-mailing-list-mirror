From: Jeff King <peff@peff.net>
Subject: Re: Improve on 'approxidate'
Date: Sun, 30 Aug 2009 18:35:58 -0400
Message-ID: <20090830223558.GA29807@coredump.intra.peff.net>
References: <alpine.LFD.2.01.0908221438450.3158@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Aug 31 00:36:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mht0M-0007Cx-4d
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 00:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194AbZH3WgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 18:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754192AbZH3WgA
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 18:36:00 -0400
Received: from peff.net ([208.65.91.99]:47533 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754179AbZH3Wf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 18:35:59 -0400
Received: (qmail 19658 invoked by uid 107); 30 Aug 2009 22:36:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 30 Aug 2009 18:36:12 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Aug 2009 18:35:58 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0908221438450.3158@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127443>

On Sat, Aug 22, 2009 at 03:10:07PM -0700, Linus Torvalds wrote:

>  unsigned long approxidate(const char *date)
>  {
>  	int number = 0;
> @@ -881,21 +911,24 @@ unsigned long approxidate(const char *date)
>  	time_sec = tv.tv_sec;
>  	localtime_r(&time_sec, &tm);
>  	now = tm;
> +
> +	tm.tm_year = -1;
> +	tm.tm_mon = -1;
> +	tm.tm_mday = -1;

This breaks relative dates like "3.months.ago", because
approxidate_alpha needs to see the "current" date in tm (and now it sees
-1, subtracts from it, and assumes we are just crossing a year boundary
because of the negative).  3.years.ago is also broken, but I don't think
3.days.ago is.

Probably we just need to pass "now" to approxidate_alpha, and it needs
to call update_tm under the case for "months" and "years" (and I haven't
quite figured out why those are not part of the "tl" list).
Unfortunately, I'm out of time to look at it more right now, but I'll
take a look tonight or tomorrow if you don't beat me to it.

-Peff
