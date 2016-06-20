Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FA511FEAA
	for <e@80x24.org>; Mon, 20 Jun 2016 21:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752824AbcFTVMd (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 17:12:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:57483 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751596AbcFTVMb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 17:12:31 -0400
Received: (qmail 9479 invoked by uid 102); 20 Jun 2016 21:12:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Jun 2016 17:12:01 -0400
Received: (qmail 18103 invoked by uid 107); 20 Jun 2016 21:12:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Jun 2016 17:12:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Jun 2016 17:11:59 -0400
Date:	Mon, 20 Jun 2016 17:11:59 -0400
From:	Jeff King <peff@peff.net>
To:	Norbert Kiesel <nkiesel@gmail.com>
Cc:	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH 2/3] t0006: test various date formats
Message-ID: <20160620211158.GA15521@sigill.intra.peff.net>
References: <20160620210901.GE3631@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160620210901.GE3631@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

We ended up testing some of these date formats throughout
the rest of the suite (e.g., via for-each-ref's
"$(authordate:...)" format), but we never did so
systematically. t0006 is the right place for unit-testing of
our date-handling code.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-date.c | 26 ++++++++++++++++++++++++++
 t/t0006-date.sh      | 21 +++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index 8ebcded..d9ab360 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -2,6 +2,7 @@
 
 static const char *usage_msg = "\n"
 "  test-date relative [time_t]...\n"
+"  test-date show:<format> [time_t]...\n"
 "  test-date parse [date]...\n"
 "  test-date approxidate [date]...\n";
 
@@ -17,6 +18,29 @@ static void show_relative_dates(char **argv, struct timeval *now)
 	strbuf_release(&buf);
 }
 
+static void show_dates(char **argv, const char *format)
+{
+	struct date_mode mode;
+
+	parse_date_format(format, &mode);
+	for (; *argv; argv++) {
+		char *arg = *argv;
+		time_t t;
+		int tz;
+
+		/*
+		 * Do not use our normal timestamp parsing here, as the point
+		 * is to test the formatting code in isolation.
+		 */
+		t = strtol(arg, &arg, 10);
+		while (*arg == ' ')
+			arg++;
+		tz = atoi(arg);
+
+		printf("%s -> %s\n", *argv, show_date(t, tz, &mode));
+	}
+}
+
 static void parse_dates(char **argv, struct timeval *now)
 {
 	struct strbuf result = STRBUF_INIT;
@@ -63,6 +87,8 @@ int main(int argc, char **argv)
 		usage(usage_msg);
 	if (!strcmp(*argv, "relative"))
 		show_relative_dates(argv+1, &now);
+	else if (skip_prefix(*argv, "show:", &x))
+		show_dates(argv+1, x);
 	else if (!strcmp(*argv, "parse"))
 		parse_dates(argv+1, &now);
 	else if (!strcmp(*argv, "approxidate"))
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index fa05269..57033dd 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -27,6 +27,27 @@ check_relative 630000000 '20 years ago'
 check_relative 31449600 '12 months ago'
 check_relative 62985600 '2 years ago'
 
+check_show () {
+	format=$1
+	time=$2
+	expect=$3
+	test_expect_${4:-success} "show date ($format:$time)" '
+		echo "$time -> $expect" >expect &&
+		test-date show:$format "$time" >actual &&
+		test_cmp expect actual
+	'
+}
+
+# arbitrary but sensible time for examples
+TIME='1466000000 +0200'
+check_show iso8601 "$TIME" '2016-06-15 16:13:20 +0200'
+check_show iso8601-strict "$TIME" '2016-06-15T16:13:20+02:00'
+check_show rfc2822 "$TIME" 'Wed, 15 Jun 2016 16:13:20 +0200'
+check_show short "$TIME" '2016-06-15'
+check_show default "$TIME" 'Wed Jun 15 16:13:20 2016 +0200'
+check_show raw "$TIME" '1466000000 +0200'
+check_show iso-local "$TIME" '2016-06-15 14:13:20 +0000'
+
 check_parse() {
 	echo "$1 -> $2" >expect
 	test_expect_${4:-success} "parse date ($1${3:+ TZ=$3})" "
-- 
2.9.0.167.g9e4667c

