From: Jeff King <peff@peff.net>
Subject: [PATCH/RFH] date: avoid "X years, 12 months" in relative dates
Date: Wed, 20 Apr 2011 01:24:35 -0400
Message-ID: <20110420052435.GA28597@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 07:24:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCPuK-0000Tf-Rk
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 07:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630Ab1DTFYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 01:24:40 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38475
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543Ab1DTFYj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 01:24:39 -0400
Received: (qmail 16173 invoked by uid 107); 20 Apr 2011 05:25:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Apr 2011 01:25:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Apr 2011 01:24:35 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171839>

When relative dates are more than about a year ago, we start
writing them as "Y years, M months".  At the point where we
calculate Y and M, we have the time delta specified as a
number of days. We calculate these integers as:

  Y = days / 365
  M = (days % 365 + 15) / 30

This rounds days in the latter half of a month up to the
nearest month, so that day 16 is "1 month" (or day 381 is "1
year, 1 month").

We don't round the year at all, though, meaning we can end
up with "1 year, 12 months", which is silly; it should just
be "2 years".

The implementation is crude but effective: we check for this
silly case with a conditional and tweak the values:

  if (M == 12) {
	  Y++;
	  M = 0;
  }

It's tempting to look for a purely numerical solution, like
just rounding better. But it is made difficult by the fact
that our approximation of a month is "30 days", which means
that a year does not actually contain 12 of our approximate
months (there is a 5-day discrepancy).

So you could do:

  Y = (days + 15) / 365

which will round up the year if we are in the last 15 days.
And then you would make a matching tweak for months:

  M = (days + 15) % 365 / 30;

so that they both round at exactly the same day.

But that doesn't quite work. Day 715 will be properly
rounded to "2 years, 0 months", which is what we want. But
days 710 through 714 remain at "1 year, 12 months", due to
the 5-day discrepancy.

Another attempt would be to write it as the much more
readable:

  total_months = (days + 15) / 30;
  Y = total_months / 12;
  M = total_months % 12;

But our 5-day discrepancy hits us again, and this time much
worse, since the error compounds with each year. On day
3650, we should be exactly at "10 years", but the above puts
us at "10 years, 2 months".

Signed-off-by: Jeff King <peff@peff.net>
---
So I thought this patch would take me about 2 minutes to write, and (as
you can probably guess from the length of the commit message), it turned
out much more complex. I'd be curious to see if anybody has a numerical
solution using integers.

With floating point, it's pretty simple:

  double one_month = 365 / 12;
  unsigned long total_months = ((double)days + (one_month / 2)) / one_month;
  unsigned long years = total_months / 12;
  unsigned long months = total_months % 12;

but I'm beginning to think it's not possible to make a simple formula
with just integers. Which maybe means we should just use floating point
here. Or maybe somebody can prove me to be an idiot.

 date.c          |    5 +++++
 t/t0006-date.sh |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/date.c b/date.c
index 00f9eb5..3dfade2 100644
--- a/date.c
+++ b/date.c
@@ -132,6 +132,11 @@ const char *show_date_relative(unsigned long time, int tz,
 		unsigned long years = diff / 365;
 		unsigned long months = (diff % 365 + 15) / 30;
 		int n;
+
+		if (months == 12) {
+			years++;
+			months = 0;
+		}
 		n = snprintf(timebuf, timebuf_size, "%lu year%s",
 				years, (years > 1 ? "s" : ""));
 		if (months)
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 1d4d0a5..f87abb5 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -25,6 +25,7 @@ check_show 37500000 '1 year, 2 months ago'
 check_show 55188000 '1 year, 9 months ago'
 check_show 630000000 '20 years ago'
 check_show 31449600 '12 months ago'
+check_show 62985600 '2 years ago'
 
 check_parse() {
 	echo "$1 -> $2" >expect
-- 
1.7.5.rc2.4.gc3ad3
