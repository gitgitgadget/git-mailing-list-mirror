Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE4982018E
	for <e@80x24.org>; Mon, 11 Jul 2016 05:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbcGKFGV (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 01:06:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:42707 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750863AbcGKFGV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 01:06:21 -0400
Received: (qmail 13528 invoked by uid 102); 11 Jul 2016 05:06:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Jul 2016 01:06:22 -0400
Received: (qmail 29011 invoked by uid 107); 11 Jul 2016 05:06:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Jul 2016 01:06:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jul 2016 01:06:17 -0400
Date:	Mon, 11 Jul 2016 01:06:17 -0400
From:	Jeff King <peff@peff.net>
To:	Theodore Ts'o <tytso@mit.edu>
Cc:	Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 4/5] date: document and test "raw-local" mode
Message-ID: <20160711050617.GD32514@sigill.intra.peff.net>
References: <20160711050201.GA18031@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160711050201.GA18031@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The "raw" format shows a Unix epoch timestamp, but with a
timezone tacked on. The timestamp is not _in_ that zone, but
it is extra information about the time (by default, the zone
the author was in).

The documentation claims that "raw-local" does not work. It
does, but the end result is rather subtle. Let's describe it
in better detail, and test to make sure it works (namely,
the epoch time doesn't change, but the zone does).

While we are rewording the documentation in this area, let's
not use the phrase "does not work" for the remaining option,
"--relative". It's vague; do we accept it or not? We do
accept it, but it has no effect (which is a reasonable
outcome).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/rev-list-options.txt | 9 ++++++---
 t/t0006-date.sh                    | 1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 5267ee1..a6059d1 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -725,8 +725,8 @@ include::pretty-options.txt[]
 	`iso-local`), the user's local time zone is used instead.
 +
 `--date=relative` shows dates relative to the current time,
-e.g. ``2 hours ago''. The `-local` option cannot be used with
-`--raw` or `--relative`.
+e.g. ``2 hours ago''. The `-local` option has no effect for
+`--relative`.
 +
 `--date=local` is an alias for `--date=default-local`.
 +
@@ -746,7 +746,10 @@ format, often found in email messages.
 +
 `--date=short` shows only the date, but not the time, in `YYYY-MM-DD` format.
 +
-`--date=raw` shows the date in the internal raw Git format `%s %z` format.
+`--date=raw` shows the date in the internal raw Git format `%s %z`
+format. Note that the `-local` option does not affect the
+seconds-since-epoch value (which is always measured in UTC), but does
+switch the accompanying timezone value.
 +
 `--date=format:...` feeds the format `...` to your system `strftime`.
 Use `--date=format:%c` to show the date in your system locale's
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 04ce535..276366e 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -47,6 +47,7 @@ check_show short "$TIME" '2016-06-15'
 check_show default "$TIME" 'Wed Jun 15 16:13:20 2016 +0200'
 check_show raw "$TIME" '1466000000 +0200'
 check_show iso-local "$TIME" '2016-06-15 14:13:20 +0000'
+check_show raw-local "$TIME" '1466000000 +0000'
 
 # arbitrary time absurdly far in the future
 FUTURE="5758122296 -0400"
-- 
2.9.0.406.g77f030d

