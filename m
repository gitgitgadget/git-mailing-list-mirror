Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1212120248
	for <e@80x24.org>; Wed, 20 Mar 2019 08:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbfCTIQj (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 04:16:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:57454 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726686AbfCTIQi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 04:16:38 -0400
Received: (qmail 19698 invoked by uid 109); 20 Mar 2019 08:16:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Mar 2019 08:16:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6400 invoked by uid 111); 20 Mar 2019 08:17:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 20 Mar 2019 04:17:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Mar 2019 04:16:36 -0400
Date:   Wed, 20 Mar 2019 04:16:36 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 11/13] pretty: drop unused "type" parameter in
 needs_rfc2047_encoding()
Message-ID: <20190320081636.GK10403@sigill.intra.peff.net>
References: <20190320081258.GA5621@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190320081258.GA5621@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "should we encode" check was split off from add_rfc2047() into its
own function in 41dd00bad3 (format-patch: fix rfc2047 address encoding
with respect to rfc822 specials, 2012-10-18). But only the "add" half
needs to know the rfc2047_type, since it only affects _how_ we encode,
not whether we do.

Signed-off-by: Jeff King <peff@peff.net>
---
 pretty.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/pretty.c b/pretty.c
index f496f0f128..f925a014f9 100644
--- a/pretty.c
+++ b/pretty.c
@@ -343,8 +343,7 @@ static int is_rfc2047_special(char ch, enum rfc2047_type type)
 	return !(isalnum(ch) || ch == '!' || ch == '*' || ch == '+' || ch == '-' || ch == '/');
 }
 
-static int needs_rfc2047_encoding(const char *line, int len,
-				  enum rfc2047_type type)
+static int needs_rfc2047_encoding(const char *line, int len)
 {
 	int i;
 
@@ -470,7 +469,7 @@ void pp_user_info(struct pretty_print_context *pp,
 		}
 
 		strbuf_addstr(sb, "From: ");
-		if (needs_rfc2047_encoding(namebuf, namelen, RFC2047_ADDRESS)) {
+		if (needs_rfc2047_encoding(namebuf, namelen)) {
 			add_rfc2047(sb, namebuf, namelen,
 				    encoding, RFC2047_ADDRESS);
 			max_length = 76; /* per rfc2047 */
@@ -1728,7 +1727,7 @@ void pp_title_line(struct pretty_print_context *pp,
 	if (pp->print_email_subject) {
 		if (pp->rev)
 			fmt_output_email_subject(sb, pp->rev);
-		if (needs_rfc2047_encoding(title.buf, title.len, RFC2047_SUBJECT))
+		if (needs_rfc2047_encoding(title.buf, title.len))
 			add_rfc2047(sb, title.buf, title.len,
 						encoding, RFC2047_SUBJECT);
 		else
-- 
2.21.0.701.g4401309e11

