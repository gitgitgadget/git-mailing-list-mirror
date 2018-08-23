Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D1B61F954
	for <e@80x24.org>; Thu, 23 Aug 2018 00:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbeHWEYZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 00:24:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:52590 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725729AbeHWEYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 00:24:25 -0400
Received: (qmail 12202 invoked by uid 109); 23 Aug 2018 00:50:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 23 Aug 2018 00:50:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6327 invoked by uid 111); 23 Aug 2018 00:50:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 22 Aug 2018 20:50:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Aug 2018 20:50:37 -0400
Date:   Wed, 22 Aug 2018 20:50:37 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Subject: [PATCH 7/9] sequencer: ignore "---" divider when parsing trailers
Message-ID: <20180823005037.GG3126@sigill.intra.peff.net>
References: <20180823004300.GA1355@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180823004300.GA1355@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the sequencer code appends a signoff or cherry-pick
origin, it uses the default trailer-parsing options, which
treat "---" as the end of the commit message. As a result,
it may be fooled by a commit message that contains that
string and fail to find the existing trailer block. Even
more confusing, the actual append code does not know about
"---", and always appends to the end of the string. This can
lead to bizarre results. E.g., appending a signoff to a
commit message like this:

  subject

  body
  ---
  these dashes confuse the parser!

  Signed-off-by: A

results in output with a final block like:

  Signed-off-by: A

  Signed-off-by: A

The parser thinks the final line of the message is "body",
and ignores everything else, claiming there are no trailers.
So we output an extra newline separator (wrong) and add a
duplicate signoff (also wrong).

Since we know we are feeding a pure commit message, we can
simply tell the parser to ignore the "---" divider.

Signed-off-by: Jeff King <peff@peff.net>
---
 sequencer.c       |  2 ++
 t/t7501-commit.sh | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 3e15faa94e..25bdbfcce1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -232,6 +232,8 @@ static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
 	size_t i;
 	int found_sob = 0, found_sob_last = 0;
 
+	opts.no_divider = 1;
+
 	trailer_info_get(&info, sb->buf, &opts);
 
 	if (info.trailer_start == info.trailer_end)
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 51646d8019..1cabb8b8ed 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -517,6 +517,22 @@ Myfooter: x" &&
 	test_cmp expected actual
 '
 
+test_expect_success 'signoff not confused by ---' '
+	cat >expected <<-EOF &&
+		subject
+
+		body
+		---
+		these dashes confuse the parser!
+
+		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	EOF
+	# should be a noop, since we already signed
+	git commit --allow-empty --signoff -F expected &&
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'multiple -m' '
 
 	>negative &&
-- 
2.19.0.rc0.412.g7005db4e88

