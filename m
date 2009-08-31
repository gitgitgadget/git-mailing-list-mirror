From: Jeff King <peff@peff.net>
Subject: Re: Improve on 'approxidate'
Date: Sun, 30 Aug 2009 21:58:17 -0400
Message-ID: <20090831015817.GA30454@coredump.intra.peff.net>
References: <alpine.LFD.2.01.0908221438450.3158@localhost.localdomain>
 <20090830223558.GA29807@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Aug 31 04:02:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhwE9-0000WZ-1M
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 04:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561AbZHaB6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 21:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752690AbZHaB6T
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 21:58:19 -0400
Received: from peff.net ([208.65.91.99]:43406 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752392AbZHaB6S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 21:58:18 -0400
Received: (qmail 20191 invoked by uid 107); 31 Aug 2009 01:58:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 30 Aug 2009 21:58:31 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Aug 2009 21:58:17 -0400
Content-Disposition: inline
In-Reply-To: <20090830223558.GA29807@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127450>

On Sun, Aug 30, 2009 at 06:35:58PM -0400, Jeff King wrote:

> > +	tm.tm_year = -1;
> > +	tm.tm_mon = -1;
> > +	tm.tm_mday = -1;
> 
> This breaks relative dates like "3.months.ago", because
> approxidate_alpha needs to see the "current" date in tm (and now it sees
> -1, subtracts from it, and assumes we are just crossing a year boundary
> because of the negative).  3.years.ago is also broken, but I don't think
> 3.days.ago is.
> 
> Probably we just need to pass "now" to approxidate_alpha, and it needs
> to call update_tm under the case for "months" and "years" (and I haven't
> quite figured out why those are not part of the "tl" list).
> Unfortunately, I'm out of time to look at it more right now, but I'll
> take a look tonight or tomorrow if you don't beat me to it.

OK, I looked at it.

The fix is pretty straightforward. We _do_ already pass "now" to
approxidate_alpha, and it looks like you already fixed the "typelen"
array case (which handles seconds, minutes, hours, days, and weeks) by
calling update_tm. But all of those units are convertible to seconds,
and months and years are not, which explains why they are handled
separately.

So I think we can just "cheat" and call update_tm to fill in the fields
from "now" as we would for the other units, and then tweak the "struct
tm" as we did before. I.e.,:

diff --git a/date.c b/date.c
index 8e57e5e..e9ee4aa 100644
--- a/date.c
+++ b/date.c
@@ -857,7 +857,9 @@ static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm
 	}
 
 	if (match_string(date, "months") >= 5) {
-		int n = tm->tm_mon - *num;
+		int n;
+		update_tm(tm, now, 0); /* fill in date fields if needed */
+		n = tm->tm_mon - *num;
 		*num = 0;
 		while (n < 0) {
 			n += 12;
@@ -868,6 +870,7 @@ static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm
 	}
 
 	if (match_string(date, "years") >= 4) {
+		update_tm(tm, now, 0); /* fill in date fields if needed */
 		tm->tm_year -= *num;
 		*num = 0;
 		return end;

I'll wrap this fix up in a commit message with tests and add it to the
"test approxidate" series I'm brewing.

-Peff
