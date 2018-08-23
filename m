Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2FB41F954
	for <e@80x24.org>; Thu, 23 Aug 2018 00:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbeHWEYH (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 00:24:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:52584 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725729AbeHWEYG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 00:24:06 -0400
Received: (qmail 12152 invoked by uid 109); 23 Aug 2018 00:50:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 23 Aug 2018 00:50:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6322 invoked by uid 111); 23 Aug 2018 00:50:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 22 Aug 2018 20:50:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Aug 2018 20:50:17 -0400
Date:   Wed, 22 Aug 2018 20:50:17 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Subject: [PATCH 6/9] pretty, ref-filter: format %(trailers) with no_divider
 option
Message-ID: <20180823005017.GF3126@sigill.intra.peff.net>
References: <20180823004300.GA1355@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180823004300.GA1355@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In both of these cases we know that we are feeding the
trailer-parsing code a pure commit message. We should tell
it so, which avoids false positives for a commit message
that contains a "---" line.

Signed-off-by: Jeff King <peff@peff.net>
---
 pretty.c                      |  3 +++
 ref-filter.c                  |  2 ++
 t/t4205-log-pretty-formats.sh | 23 +++++++++++++++++++++++
 t/t6300-for-each-ref.sh       | 23 +++++++++++++++++++++++
 4 files changed, 51 insertions(+)

diff --git a/pretty.c b/pretty.c
index 98cf5228f9..8ca29e9281 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1304,6 +1304,9 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 
 	if (skip_prefix(placeholder, "(trailers", &arg)) {
 		struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
+
+		opts.no_divider = 1;
+
 		if (*arg == ':') {
 			arg++;
 			for (;;) {
diff --git a/ref-filter.c b/ref-filter.c
index 0bccfceff2..3e8ee04d09 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -263,6 +263,8 @@ static int trailers_atom_parser(const struct ref_format *format, struct used_ato
 	struct string_list params = STRING_LIST_INIT_DUP;
 	int i;
 
+	atom->u.contents.trailer_opts.no_divider = 1;
+
 	if (arg) {
 		string_list_split(&params, arg, ',', -1);
 		for (i = 0; i < params.nr; i++) {
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 2052cadb11..978a8a66ff 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -598,4 +598,27 @@ test_expect_success ':only and :unfold work together' '
 	test_cmp expect actual
 '
 
+test_expect_success 'trailer parsing not fooled by --- line' '
+	git commit --allow-empty -F - <<-\EOF &&
+	this is the subject
+
+	This is the body. The message has a "---" line which would confuse a
+	message+patch parser. But here we know we have only a commit message,
+	so we get it right.
+
+	trailer: wrong
+	---
+	This is more body.
+
+	trailer: right
+	EOF
+
+	{
+		echo "trailer: right" &&
+		echo
+	} >expect &&
+	git log --no-walk --format="%(trailers)" >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 024f8c06f7..97bfbee6e8 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -715,6 +715,29 @@ test_expect_success 'basic atom: head contents:trailers' '
 	test_cmp expect actual.clean
 '
 
+test_expect_success 'trailer parsing not fooled by --- line' '
+	git commit --allow-empty -F - <<-\EOF &&
+	this is the subject
+
+	This is the body. The message has a "---" line which would confuse a
+	message+patch parser. But here we know we have only a commit message,
+	so we get it right.
+
+	trailer: wrong
+	---
+	This is more body.
+
+	trailer: right
+	EOF
+
+	{
+		echo "trailer: right" &&
+		echo
+	} >expect &&
+	git for-each-ref --format="%(trailers)" refs/heads/master >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'Add symbolic ref for the following tests' '
 	git symbolic-ref refs/heads/sym refs/heads/master
 '
-- 
2.19.0.rc0.412.g7005db4e88

