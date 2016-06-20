Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 187921FEAA
	for <e@80x24.org>; Mon, 20 Jun 2016 21:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754990AbcFTVOZ (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 17:14:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:57487 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752601AbcFTVOW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 17:14:22 -0400
Received: (qmail 9575 invoked by uid 102); 20 Jun 2016 21:14:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Jun 2016 17:14:16 -0400
Received: (qmail 18130 invoked by uid 107); 20 Jun 2016 21:14:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Jun 2016 17:14:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Jun 2016 17:14:14 -0400
Date:	Mon, 20 Jun 2016 17:14:14 -0400
From:	Jeff King <peff@peff.net>
To:	Norbert Kiesel <nkiesel@gmail.com>
Cc:	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH 3/3] local_tzoffset: detect errors from tm_to_time_t
Message-ID: <20160620211413.GB15521@sigill.intra.peff.net>
References: <20160620210901.GE3631@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160620210901.GE3631@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When we want to know the local timezone offset at a given
timestamp, we compute it by asking for localtime() at the
given time, and comparing the offset to GMT at that time.
However, there's some juggling between time_t and "struct
tm" which happens, which involves calling our own
tm_to_time_t().

If that function returns an error (e.g., because it only
handles dates up to the year 2099), it returns "-1", which
we treat as a time_t, and is clearly bogus, leading to
bizarre timestamps (that seem to always adjust the time back
to (time_t)(uint32_t)-1, in the year 2106).

It's not a good idea for local_tzoffset() to simply die
here; it would make it hard to run "git log" on a repository
with funny timestamps. Instead, let's just treat such cases
as "zero offset".

Reported-by: Norbert Kiesel <nkiesel@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 date.c          | 2 ++
 t/t0006-date.sh | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/date.c b/date.c
index 7c9f769..4c7aa9b 100644
--- a/date.c
+++ b/date.c
@@ -74,6 +74,8 @@ static int local_tzoffset(unsigned long time)
 	localtime_r(&t, &tm);
 	t_local = tm_to_time_t(&tm);
 
+	if (t_local == -1)
+		return 0; /* error; just use +0000 */
 	if (t_local < t) {
 		eastwest = -1;
 		offset = t - t_local;
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 57033dd..04ce535 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -48,6 +48,11 @@ check_show default "$TIME" 'Wed Jun 15 16:13:20 2016 +0200'
 check_show raw "$TIME" '1466000000 +0200'
 check_show iso-local "$TIME" '2016-06-15 14:13:20 +0000'
 
+# arbitrary time absurdly far in the future
+FUTURE="5758122296 -0400"
+check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400"
+check_show iso-local "$FUTURE" "2152-06-19 22:24:56 +0000"
+
 check_parse() {
 	echo "$1 -> $2" >expect
 	test_expect_${4:-success} "parse date ($1${3:+ TZ=$3})" "
-- 
2.9.0.167.g9e4667c
