Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78F751FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 17:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835AbcFWRis (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 13:38:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:59211 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751628AbcFWRir (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 13:38:47 -0400
Received: (qmail 30182 invoked by uid 102); 23 Jun 2016 17:38:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 13:38:46 -0400
Received: (qmail 12909 invoked by uid 107); 23 Jun 2016 17:39:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 13:39:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jun 2016 13:38:44 -0400
Date:	Thu, 23 Jun 2016 13:38:44 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Simon Courtois <scourtois@cubyx.fr>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/7] color: allow "no-" for negating attributes
Message-ID: <20160623173844.GE15774@sigill.intra.peff.net>
References: <20160623173048.GA19923@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160623173048.GA19923@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Using "no-bold" rather than "nobold" is easier to read and
more natural to type (to me, anyway, even though I was the
person who introduced "nobold" in the first place). It's
easy to allow both.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt | 2 +-
 color.c                  | 4 +++-
 t/t4026-color.sh         | 4 ++++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f8460d4..4b13c90 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -166,7 +166,7 @@ hex, like `#ff0ab3`.
 The accepted attributes are `bold`, `dim`, `ul`, `blink`, and `reverse`.
 The position of any attributes with respect to the colors (before, after,
 or in between), doesn't matter. Specific attributes may be turned off
-by prefixing them with `no` (e.g., `noreverse`, `noul`, etc).
+by prefixing them with `no` or `no-` (e.g., `noreverse`, `no-ul`, etc).
 +
 For git's pre-defined color slots, the attributes are meant to be reset
 at the beginning of each item in the colored output. So setting
diff --git a/color.c b/color.c
index d787dec..a02a935 100644
--- a/color.c
+++ b/color.c
@@ -141,8 +141,10 @@ static int parse_attr(const char *name, size_t len)
 	int negate = 0;
 	int i;
 
-	if (skip_prefix_mem(name, len, "no", &name, &len))
+	if (skip_prefix_mem(name, len, "no", &name, &len)) {
+		skip_prefix_mem(name, len, "-", &name, &len);
 		negate = 1;
+	}
 
 	for (i = 0; i < ARRAY_SIZE(attrs); i++) {
 		if (attrs[i].len == len && !memcmp(attrs[i].name, name, len))
diff --git a/t/t4026-color.sh b/t/t4026-color.sh
index 2b32c4f..2065752 100755
--- a/t/t4026-color.sh
+++ b/t/t4026-color.sh
@@ -50,6 +50,10 @@ test_expect_success 'attr negation' '
 	color "nobold nodim noul noblink noreverse" "[22;24;25;27m"
 '
 
+test_expect_success '"no-" variant of negation' '
+	color "no-bold no-blink" "[22;25m"
+'
+
 test_expect_success 'long color specification' '
 	color "254 255 bold dim ul blink reverse" "[1;2;4;5;7;38;5;254;48;5;255m"
 '
-- 
2.9.0.209.g845fbc1

