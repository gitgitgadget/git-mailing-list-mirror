Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08DAD1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 05:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfF0FZS (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 01:25:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:51980 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726370AbfF0FZR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 01:25:17 -0400
Received: (qmail 7559 invoked by uid 109); 27 Jun 2019 05:25:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 27 Jun 2019 05:25:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4438 invoked by uid 111); 27 Jun 2019 05:26:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 27 Jun 2019 01:26:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Jun 2019 01:25:15 -0400
Date:   Thu, 27 Jun 2019 01:25:15 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: fprintf_ln() is slow
Message-ID: <20190627052515.GA21207@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor and I noticed a slowdown in p1451 between v2.20.1 and v2.21.0. I
was surprised to find that it bisects to bbb15c5193 (fsck: reduce word
legos to help i18n, 2018-11-10).

The important part, as it turns out, is the switch to using fprintf_ln()
instead of a regular fprintf() with a "\n" in it. Doing this:

diff --git a/builtin/fsck.c b/builtin/fsck.c
index d26fb0a044..234b766843 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -128,12 +128,12 @@ static int fsck_error_func(struct fsck_options *o,
 	switch (type) {
 	case FSCK_WARN:
 		/* TRANSLATORS: e.g. warning in tree 01bfda: <more explanation> */
-		fprintf_ln(stderr, _("warning in %s %s: %s"),
+		fprintf(stderr, _("warning in %s %s: %s\n"),
 			   printable_type(obj), describe_object(obj), message);
 		return 0;
 	case FSCK_ERROR:
 		/* TRANSLATORS: e.g. error in tree 01bfda: <more explanation> */
-		fprintf_ln(stderr, _("error in %s %s: %s"),
+		fprintf(stderr, _("error in %s %s: %s\n"),
 			   printable_type(obj), describe_object(obj), message);
 		return 1;
 	default:

on top of the current tip of master yields this result:

  Test                                             HEAD^             HEAD                  
  -----------------------------------------------------------------------------------------
  1451.3: fsck with 0 skipped bad commits          9.78(7.46+2.32)   8.74(7.38+1.36) -10.6%
  1451.5: fsck with 1 skipped bad commits          9.78(7.66+2.11)   8.49(7.04+1.44) -13.2%
  1451.7: fsck with 10 skipped bad commits         9.83(7.45+2.37)   8.53(7.26+1.24) -13.2%
  1451.9: fsck with 100 skipped bad commits        9.87(7.47+2.40)   8.54(7.24+1.30) -13.5%
  1451.11: fsck with 1000 skipped bad commits      9.79(7.67+2.12)   8.48(7.25+1.23) -13.4%
  1451.13: fsck with 10000 skipped bad commits     9.86(7.58+2.26)   8.38(7.09+1.28) -15.0%
  1451.15: fsck with 100000 skipped bad commits    9.58(7.39+2.19)   8.41(7.21+1.19) -12.2%
  1451.17: fsck with 1000000 skipped bad commits   6.38(6.31+0.07)   6.35(6.26+0.07) -0.5% 

That test makes a repo with a million bad commits. Most of those (except
the last one, which doesn't see a huge change!) tests are outputting
900k+ error messages. So small changes in the speed of printing are
amplified.

This is a totally synthetic repo. So as a real-world case, these numbers
are probably not all that interesting. If you have a million-line fsck
output, the extra 1s of output time is probably not biggest thing on
your mind. But we do use fprintf_ln() elsewhere, and I wonder if there
are cases where it could add up.

I thought it might be due to stdio's locking overhead (we ran into that
with single-character getc's in other code). But there's no unlocked
variant of the formatting functions, so the best we can do is this:

diff --git a/strbuf.c b/strbuf.c
index 0e18b259ce..fac3b33f68 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -882,12 +882,18 @@ int fprintf_ln(FILE *fp, const char *fmt, ...)
 {
 	int ret;
 	va_list ap;
+
+	flockfile(fp);
+
 	va_start(ap, fmt);
 	ret = vfprintf(fp, fmt, ap);
 	va_end(ap);
-	if (ret < 0 || putc('\n', fp) == EOF)
-		return -1;
-	return ret + 1;
+
+	if (ret >= 0 && putc_unlocked('\n', fp) != EOF)
+		ret++;
+
+	funlockfile(fp);
+	return ret;
 }
 
 char *xstrdup_tolower(const char *string)

which doesn't seem to help. I don't know if this is even worth digging
into, or if we should declare that "yeah, fprintf_ln is not the fastest
way to print something; don't use it in a tight loop".

But maybe somebody else has a brilliant idea.

-Peff
