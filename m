Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D8B823BC
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 09:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717493629; cv=none; b=HcTkhVaic/arsw4+4i4e/8rlQdXRxqDKos5mD/mspbOGraYmrLeMM/tTV5i7fBnK1jzLx1oWOKgq1+xO+gZScyTKANp57zIMc8MOF9zhFzkjzo2ZQ8KIo8ocVOTUNKO9HaioGBPcK3JCXJilo1iziAF3KNi2FevpD642MODkuLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717493629; c=relaxed/simple;
	bh=hUm0YguTlDJhwVth3z5zySxUm2/WbB5vyJGmsXYtXAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0W+yZbA61wpZtoFA359E2cYlZ6IUbFEwjUM3t91L6EmMWcfOXUM9lAFKV54qpsZ5f9VuAk9tm8iX3KM6hj7QGkWdIWFaNv3i9WHbqVldZDhi0cYZvO1Bnvpenl1s4XUR+79bVXzyO7kgw5Imq2mxRHrtyOpEOh1XVdwi5/EY8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 20935 invoked by uid 109); 4 Jun 2024 09:33:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Jun 2024 09:33:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18062 invoked by uid 111); 4 Jun 2024 09:33:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Jun 2024 05:33:43 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Jun 2024 05:33:45 -0400
From: Jeff King <peff@peff.net>
To: darcy <acednes@gmail.com>
Cc: phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
	darcy via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] date: detect underflow when parsing dates with
 positive timezone offset
Message-ID: <20240604093345.GA1279521@coredump.intra.peff.net>
References: <pull.1726.git.git.1716801427015.gitgitgadget@gmail.com>
 <pull.1726.v2.git.git.1717369608923.gitgitgadget@gmail.com>
 <xmqqwmn66zzc.fsf@gitster.g>
 <2d771a72-3021-46db-ac32-e008a7ace34c@gmail.com>
 <67c23773-21a4-4ad5-9b98-5e44578166dd@gmail.com>
 <4574e410-ca1a-495f-9835-14ee3fa454a1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4574e410-ca1a-495f-9835-14ee3fa454a1@gmail.com>

On Tue, Jun 04, 2024 at 06:48:59PM +1000, darcy wrote:

> Though I am reading the `tm_to_time_t` code now and it only allows years
> up to 2099.
> 
> > 	if (year < 0 || year > 129) /* algo only works for 1970-2099 */
> > 		return -1;
> 
> I can of course add a check here for dates close to the end of 2099, but
> it seems that the bigger issue is that some day people will want to use
> Git after 2099... Should I see if I can extend this range? I'm not sure
> where that specific year comes from, it doesn't seem to be based on a
> limit of the size of `time_t`, and the comment or git logs don't seem to
> provide a reason.

I think the 2099 limitation is there because 2100 is not a leap year,
and the code has over-simplified computation there (it counts every 4th
year as a leap year, which is not generally true for century boundaries,
except for 2000 because it is divisible by 400).

From the log message of ecee9d9e79 ([PATCH] Do date parsing by hand...,
2005-04-30), I think the 1970 limitation may be about avoiding
non-60-minute DST (though it is not clear to me how the function cares
about dst either way, as it operates on UTC). You can't represent times
before 1970 in our code base anyway, because our epoch timestamp is
unsigned.

So yes, we could do better than that function. I worked on a series to
handle negative timestamps a while ago, and as part of that, I had to
replace this function. You can see the full series at the
"jk/time-negative-wip" branch of https://github.com/peff/git, but I'll
reproduce the commit in question below for the list archive.

The resulting series worked fine for me, but IIRC there was some issue
on Windows. I think its gmtime() did not understand negative timestamps,
maybe? And we'd need the reverse equivalent of the patch below (which we
could take from the same source).

There are some overflow checks already in date.c (grep for "overflow")
that might cover us, but I won't be surprised if there's a case that's
missing (although we store the timestamps as uintmax_t, so you're
unlikely to overflow that in practice). Underflow is more likely, though
if we finally support negative timestamps, then it becomes a non-issue
(and we'd actually want to revert the patch you're working on).

If you're interested in picking up the negative timestamp work, I'd be
happy to discuss it. It's been on my todo list for a long time, but I
never quite get around to it.

Anyway, here's the tm_to_time_t() cleanup.

-- >8 --
date: make tm_to_time_t() less restricted

We've been using a hand-rolled tm_to_time_t() conversion since
ecee9d9e79 ([PATCH] Do date parsing by hand..., 2005-04-30). It works
fine for recent dates, but it doesn't work before 1970 nor after 2099.

Let's lift those restrictions by using a more robust algorithm. The
days_from_civil() code here is lifted from Howard Hinnant's date
library, which can be found at:

  https://github.com/HowardHinnant/date

The code is in the year_month_day::to_days() function, but I also relied
on his excellent explanation in:

  http://howardhinnant.github.io/date_algorithms.html

The library is under the MIT license, which is GPL compatible. I've also
left a comment in the source file marking the licensing (the code is
substantially similar to the original; I only expanded the variable
names to make it easier to follow).

Ideally we could just rely on a system function to do this, but there
isn't one. POSIX specifies mktime(), but it uses the local timezone.
There's a timegm() function available in glibc and some BSD systems, as
well as a similar function on Windows (with a different name). However,
it's likely that there are still going to be some platforms without it,
so we'd need a fallback anyway. We may as well just use that fallback
everywhere to make sure that Git behaves consistently (and get more
complete test coverage).

Note that some callers, like parse_date_basic(), rely on tm_to_time_t()
complaining when we have negative values in any field. So we'll continue
to detect and complain about this case (the alternative would be to turn
"month -1" into "month 11" of the previous year, and so on).

Signed-off-by: Jeff King <peff@peff.net>
---
 date.c | 58 ++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 16 deletions(-)

diff --git a/date.c b/date.c
index 4337e18abd..df6c414c78 100644
--- a/date.c
+++ b/date.c
@@ -10,29 +10,55 @@
 #include "pager.h"
 #include "strbuf.h"
 
+/*
+ * Convert a year-month-day time into a number of days since 1970 (possibly
+ * negative). Note that "year" is the full year (not offset from 1900), and
+ * "month" is in the range 1-12 (unlike a "struct tm" 0-11).
+ *
+ * Working in time_t is overkill (since it usually represents seconds), but
+ * this makes sure we don't hit any integer range issues.
+ *
+ * This function is taken from https://github.com/HowardHinnant/date,
+ * which is released under an MIT license.
+ */
+static time_t days_from_civil(int year, int month, int day)
+{
+	time_t era;
+	unsigned year_of_era, day_of_year, day_of_era;
+
+	year -= month <= 2;
+	era = (year >= 0 ? year : year - 399) / 400;
+	year_of_era = year - era * 400;
+	day_of_year = (153 * (month + (month > 2 ? -3 : 9)) + 2) / 5 + day - 1;
+	day_of_era = year_of_era * 365 + year_of_era / 4 - year_of_era / 100
+			+ day_of_year;
+	return era * 146097 + (time_t)day_of_era - 719468;
+}
+
 /*
  * This is like mktime, but without normalization of tm_wday and tm_yday.
  * It also always operates in UTC, not the local timezone.
  */
 time_t tm_to_time_t(const struct tm *tm)
 {
-	static const int mdays[] = {
-	    0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334
-	};
-	int year = tm->tm_year - 70;
-	int month = tm->tm_mon;
-	int day = tm->tm_mday;
-
-	if (year < 0 || year > 129) /* algo only works for 1970-2099 */
-		return -1;
-	if (month < 0 || month > 11) /* array bounds */
-		return -1;
-	if (month < 2 || (year + 2) % 4)
-		day--;
-	if (tm->tm_hour < 0 || tm->tm_min < 0 || tm->tm_sec < 0)
+	time_t days, hours, minutes, seconds;
+
+	if (tm->tm_year < 0 ||
+	    tm->tm_mon < 0 ||
+	    tm->tm_mday < 0 ||
+	    tm->tm_hour < 0 ||
+	    tm->tm_min < 0 ||
+	    tm->tm_sec < 0)
 		return -1;
-	return (year * 365 + (year + 1) / 4 + mdays[month] + day) * 24*60*60UL +
-		tm->tm_hour * 60*60 + tm->tm_min * 60 + tm->tm_sec;
+
+	days = days_from_civil(tm->tm_year + 1900,
+			       tm->tm_mon + 1,
+			       tm->tm_mday);
+	hours = 24 * days + tm->tm_hour;
+	minutes = 60 * hours + tm->tm_min;
+	seconds = 60 * minutes + tm->tm_sec;
+
+	return seconds;
 }
 
 static const char *month_names[] = {

