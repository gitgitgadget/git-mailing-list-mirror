Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F30C620986
	for <e@80x24.org>; Thu, 29 Sep 2016 08:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755380AbcI2Iij (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 04:38:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:49783 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755261AbcI2Ig6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 04:36:58 -0400
Received: (qmail 10363 invoked by uid 109); 29 Sep 2016 08:36:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 08:36:56 +0000
Received: (qmail 32108 invoked by uid 111); 29 Sep 2016 08:37:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 04:37:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Sep 2016 04:36:54 -0400
Date:   Thu, 29 Sep 2016 04:36:54 -0400
From:   Jeff King <peff@peff.net>
To:     "Kyle J. McKay" <mackyle@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] pretty: allow formatting names as initials
Message-ID: <20160929083654.nofgkn6kwb7bavzk@sigill.intra.peff.net>
References: <20160929083315.vwb3aurwbyjwlkjn@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160929083315.vwb3aurwbyjwlkjn@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Initials are shorter and often unique enough in a
per-project setting, so they can be used to give a more
informative version of --oneline.

The 'S' in the placeholder is for "short" (and 's' is
already taken by DATE_SHORT), but obviously that's pretty
arcane.

Possibly there should be more customization of initials,
asking for only 2-letter initials, etc.

Signed-off-by: Jeff King <peff@peff.net>
---
When I first tested it with "git log --format=%aS" I had to wonder "who
the heck is ntnd?". So using only the first-and-last would match the git
project's practice better, at least.

 pretty.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/pretty.c b/pretty.c
index c532c17..de62405 100644
--- a/pretty.c
+++ b/pretty.c
@@ -674,6 +674,23 @@ static int mailmap_name(const char **email, size_t *email_len,
 	return mail_map->nr && map_user(mail_map, email, email_len, name, name_len);
 }
 
+static void format_initials(struct strbuf *out, const char *name, size_t len)
+{
+	int initial = 1;
+	size_t i;
+
+	for (i = 0; i < len; i++) {
+		char c = name[i];
+		if (isspace(c)) {
+			initial = 1;
+			continue;
+		}
+		if (initial && isalpha(c))
+			strbuf_addch(out, tolower(c));
+		initial = 0;
+	}
+}
+
 static size_t format_person_part(struct strbuf *sb, char part,
 				 const char *msg, int len,
 				 const struct date_mode *dmode)
@@ -702,6 +719,10 @@ static size_t format_person_part(struct strbuf *sb, char part,
 		strbuf_add(sb, mail, maillen);
 		return placeholder_len;
 	}
+	if (part == 'S') {
+		format_initials(sb, name, namelen);
+		return placeholder_len;
+	}
 
 	if (!s.date_begin)
 		goto skip;
-- 
2.10.0.566.g5365f87

