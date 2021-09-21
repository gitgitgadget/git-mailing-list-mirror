Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3316EC433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 01:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1638A60F6D
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 01:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbhIUBqB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 21:46:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:51346 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231855AbhIUBm6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 21:42:58 -0400
Received: (qmail 2912 invoked by uid 109); 21 Sep 2021 01:41:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Sep 2021 01:41:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26077 invoked by uid 111); 21 Sep 2021 01:41:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 20 Sep 2021 21:41:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 20 Sep 2021 21:41:27 -0400
From:   Jeff King <peff@peff.net>
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] grep: stop modifying buffer in strip_timestamp
Message-ID: <YUk4R040RBc0aBIF@coredump.intra.peff.net>
References: <YUk3zwuse56v76ze@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUk3zwuse56v76ze@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When grepping for headers in commit objects, we receive individual
lines (e.g., "author Name <email> 1234 -0000"), and then strip off the
timestamp to do our match. We do so by writing a NUL byte over the
whitespace separator, and then remembering to restore it later.

We had to do it this way when this was added back in a4d7d2c6db (log
--author/--committer: really match only with name part, 2008-09-04),
because we fed the result directly to regexec(), which expects a
NUL-terminated string. But since b7d36ffca0 (regex: use regexec_buf(),
2016-09-21), we have a function which can match on part of a buffer.

So instead of modifying the string, we can instead just move the "eol"
pointer, and the rest of the code will do the right thing. This will let
the next patch make more use of "const" in grep functions.

Signed-off-by: Jeff King <peff@peff.net>
---
I think this is fairly safe. It would fail subtly if somebody _did_ rely
on the NUL, but we just call into patmatch(), which calls functions
which handle the length-delimited buffer.

 grep.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/grep.c b/grep.c
index 35708ce973..3b372ec29d 100644
--- a/grep.c
+++ b/grep.c
@@ -922,20 +922,16 @@ static int patmatch(struct grep_pat *p, char *line, char *eol,
 	return hit;
 }
 
-static int strip_timestamp(char *bol, char **eol_p)
+static void strip_timestamp(char *bol, char **eol_p)
 {
 	char *eol = *eol_p;
-	int ch;
 
 	while (bol < --eol) {
 		if (*eol != '>')
 			continue;
 		*eol_p = ++eol;
-		ch = *eol;
-		*eol = '\0';
-		return ch;
+		break;
 	}
-	return 0;
 }
 
 static struct {
@@ -952,7 +948,6 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
 			     regmatch_t *pmatch, int eflags)
 {
 	int hit = 0;
-	int saved_ch = 0;
 	const char *start = bol;
 
 	if ((p->token != GREP_PATTERN) &&
@@ -968,7 +963,7 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
 		switch (p->field) {
 		case GREP_HEADER_AUTHOR:
 		case GREP_HEADER_COMMITTER:
-			saved_ch = strip_timestamp(bol, &eol);
+			strip_timestamp(bol, &eol);
 			if (eol == end)
 				goto again;
 			break;
@@ -981,7 +976,7 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
 		len = header_field[p->field].len;
 
 		if (strncmp(bol, field, len))
-			goto restore;
+			return 0;
 
 		bol += len;
 	}
@@ -1035,11 +1030,6 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
 		pmatch[0].rm_eo += bol - start;
 	}
 
-restore:
-	if (p->token == GREP_PATTERN_HEAD && saved_ch)
-		*eol = saved_ch;
-
-
 	return hit;
 }
 
-- 
2.33.0.1023.gc687d0d3c8

