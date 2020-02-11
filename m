Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99928C352A3
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 17:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCF220578
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 17:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbgBKRTy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 12:19:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:57574 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728925AbgBKRTy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 12:19:54 -0500
Received: (qmail 8649 invoked by uid 109); 11 Feb 2020 17:19:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Feb 2020 17:19:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32168 invoked by uid 111); 11 Feb 2020 17:28:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Feb 2020 12:28:45 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 Feb 2020 12:19:53 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 3/4] mailinfo: be more liberal with header whitespace
Message-ID: <20200211171953.GC2119034@coredump.intra.peff.net>
References: <20200211171649.GB2118476@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200211171649.GB2118476@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

RFC822 and friends allow arbitrary whitespace after the colon of a
header and before the values. I.e.:

  Subject:foo
  Subject: foo
  Subject:  foo

all have the subject "foo". But mailinfo requires exactly one space.
This doesn't seem to be bothering anybody, but it is pickier than the
standard specifies. And we can easily just soak up arbitrary whitespace
there in our parser, so let's do so.

Note that the test covers both too little and too much whitespace, but
the "too much" case already works fine (because we later eat leading and
trailing whitespace from the values).

Signed-off-by: Jeff King <peff@peff.net>
---
 mailinfo.c          |  5 +++--
 t/t5100-mailinfo.sh | 15 +++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index ee8d05e239..78f06da524 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -351,9 +351,10 @@ static inline int skip_header(const struct strbuf *line, const char *hdr,
 {
 	const char *val;
 	if (!skip_iprefix(line->buf, hdr, &val) ||
-	    *val++ != ':' ||
-	    !isspace(*val++))
+	    *val++ != ':')
 		return 0;
+	while (isspace(*val))
+		val++;
 	*outval = val;
 	return 1;
 }
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index 9690dcad4f..147e616533 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -213,4 +213,19 @@ test_expect_failure 'mailinfo -b separated double [PATCH]' '
 	test z"$subj" = z"Subject: [other] message"
 '
 
+test_expect_success 'mailinfo handles unusual header whitespace' '
+	git mailinfo /dev/null /dev/null >actual <<-\EOF &&
+	From:Real Name <user@example.com>
+	Subject:    extra spaces
+	EOF
+
+	cat >expect <<-\EOF &&
+	Author: Real Name
+	Email: user@example.com
+	Subject: extra spaces
+
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.25.0.708.g4c6f45973e

