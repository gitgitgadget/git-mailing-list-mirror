Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02AF11F453
	for <e@80x24.org>; Wed,  7 Nov 2018 01:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388611AbeKGKk6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 05:40:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:43118 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387697AbeKGKk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 05:40:58 -0500
Received: (qmail 25295 invoked by uid 109); 7 Nov 2018 01:12:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 07 Nov 2018 01:12:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7157 invoked by uid 111); 7 Nov 2018 01:12:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 06 Nov 2018 20:12:13 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Nov 2018 20:12:53 -0500
Date:   Tue, 6 Nov 2018 20:12:53 -0500
From:   Jeff King <peff@peff.net>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] approxidate: handle pending number for "specials"
Message-ID: <20181107011253.GA18276@sigill.intra.peff.net>
References: <20181102052239.GA19162@sigill.intra.peff.net>
 <20181102052309.GB19234@sigill.intra.peff.net>
 <CAPUEspi12TtKxKGr=tutfLPNPWhaZmGCh7q4D1LRJ9LFTWwKNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPUEspi12TtKxKGr=tutfLPNPWhaZmGCh7q4D1LRJ9LFTWwKNA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 06, 2018 at 04:48:28PM -0800, Carlo Arenas wrote:

> On Thu, Nov 1, 2018 at 10:24 PM Jeff King <peff@peff.net> wrote:
> >
> >  static void date_yesterday(struct tm *tm, struct tm *now, int *num)
> >  {
> > +       *num = 0;
> 
> the only caller (date_time) for this sends num = NULL, so this
> triggers a segfault.

Oof. Thanks for catching.

That's not the only caller. Usually this is called via a function
pointer from the "struct special" array. date_time() is just reusing the
other helper as a quick way to do a one-day subtraction.

> the only reference I could find to that apparently unused parameter comes from:
> 93cfa7c7a8 ("approxidate_careful() reports errorneous date string", 2010-01-26)
> and seems to indicate it is optional and therefore a check for NULL
> might make sense for all other cases

I think date_yesterday() is the only one of those special functions that
gets called like this. Here's what I think we should do to fix it (this
can go right on top of jk/misc-unused-fixes, which is already in next).

-- >8 --
Subject: [PATCH] approxidate: fix NULL dereference in date_time()

When we see a time like "noon", we pass "12" to our date_time() helper,
which sets the hour to 12pm. If the current time is before noon, then we
wrap around to yesterday using date_yesterday(). But unlike the normal
calls to date_yesterday() from approxidate_alpha(), we pass a NULL "num"
parameter. Since c27cc94fad (approxidate: handle pending number for
"specials", 2018-11-02), that causes a segfault.

One way to fix this is by checking for NULL. But arguably date_time() is
abusing our helper by passing NULL in the first place (and this is the
only case where one of these "special" parsers is used this way). So
instead, let's have it just do the 1-day subtraction itself. It's still
just a one-liner due to our update_tm() helper.

Note that the test added here is a little funny, as we say "10am noon",
which makes the "10am" seem pointless.  But this bug can only be
triggered when it the currently-parsed hour is before the special time.
The latest special time is "tea" at 1700, but t0006 uses a hard-coded
TEST_DATE_NOW of 1900. We could reset TEST_DATE_NOW, but that may lead
to confusion in other tests. Just saying "10am noon" makes this test
self-contained.

Reported-by: Carlo Arenas <carenas@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 date.c          | 2 +-
 t/t0006-date.sh | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/date.c b/date.c
index 7adce327a3..9bc15df6f9 100644
--- a/date.c
+++ b/date.c
@@ -929,7 +929,7 @@ static void date_yesterday(struct tm *tm, struct tm *now, int *num)
 static void date_time(struct tm *tm, struct tm *now, int hour)
 {
 	if (tm->tm_hour < hour)
-		date_yesterday(tm, now, NULL);
+		update_tm(tm, now, 24*60*60);
 	tm->tm_hour = hour;
 	tm->tm_min = 0;
 	tm->tm_sec = 0;
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index b7ea5fbc36..ffb2975e48 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -114,6 +114,7 @@ check_approxidate '15:00' '2009-08-30 15:00:00'
 check_approxidate 'noon today' '2009-08-30 12:00:00'
 check_approxidate 'noon yesterday' '2009-08-29 12:00:00'
 check_approxidate 'January 5th noon pm' '2009-01-05 12:00:00'
+check_approxidate '10am noon' '2009-08-29 12:00:00'
 
 check_approxidate 'last tuesday' '2009-08-25 19:20:00'
 check_approxidate 'July 5th' '2009-07-05 19:20:00'
-- 
2.19.1.1534.g3beb3b7d96

