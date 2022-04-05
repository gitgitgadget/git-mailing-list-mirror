Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5531DC35276
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 21:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383964AbiDEVqh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 17:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457460AbiDEQDP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 12:03:15 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44BEB6C
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 08:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649173596;
    s=strato-dkim-0002; d=pdev.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=vDboeccZovY6RHuosKMb2lg2jKkGuYoWjL6hCEAjzBc=;
    b=adWjwjNaeispVNxT2J49ASr2TIUuSEYGBmLvvT8YNftKqbeLYpPutaMNsP6XwZqIGh
    Fvhn6+oApuQ+S6MHZ8gJh1qGvm8aASvXWdVTzKnBQQIT8nHhvX61X2rP+4vpTcXlsgnG
    CGsjD/hXaMuWXQfJuiUJe0sxhOKmXnFuB298QmpNapwR9J/oxxWnFghU75eCD4X47Ysk
    Jl3UcMA3QKq1NT5Ou7fYmbLluSvowPjk+wkBN1Tx7Rgw8PAcAqxNOxCsvbdJ+RWsUGYG
    bQSOH5ZPenSVqqAJg+VJg4eY3/oIvxY03uD7tD2svr8XU1YhgVWxiBNuaz0PP09R+6kx
    9+gg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":Pm0UfUGtd9+G9p9stmxCE5ta4sApnuCD7TPTMbzWv5S/n05T6lsuXw4AMKWDFNaqqYSr1DzDfJaGHICUU2yIlESdigyw"
X-RZG-CLASS-ID: mo00
Received: from dragonbox..
    by smtp.strato.de (RZmta 47.42.2 AUTH)
    with ESMTPSA id I70750y35FkaR5D
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 5 Apr 2022 17:46:36 +0200 (CEST)
From:   Raphael Bauer <raphael@pdev.de>
To:     git@vger.kernel.org
Cc:     Raphael Bauer <raphael@pdev.de>
Subject: [PATCH] pretty format: fix colors on %+ placeholder newline
Date:   Tue,  5 Apr 2022 17:45:29 +0200
Message-Id: <20220405154529.966434-1-raphael@pdev.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <e8417ad5-f9f2-c1de-75f6-45be49f0011b@pdev.de>
References: <e8417ad5-f9f2-c1de-75f6-45be49f0011b@pdev.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, the color escape codes were not printed again when a %+
placeholder was expanded, which could lead to missing colors.

In particular, the following command on any commit history exercised the
problem:

git log --pretty=format:'%h%Cred%+d test' --graph

The string 'test' should always be in red, but is not when commits have
ref names associated and the %+d placeholder is expanded.
This is also not a problem of any pager since the --graph option adds a
colored pipe symbol at the beginning of the line, which makes re-setting
the color again afterwards necessary.
---
 pretty.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/pretty.c b/pretty.c
index ee6114e3f0..0aabba89ca 100644
--- a/pretty.c
+++ b/pretty.c
@@ -863,6 +863,7 @@ struct format_commit_context {
 	size_t width, indent1, indent2;
 	int auto_color;
 	int padding;
+	char curr_color_escape[COLOR_MAXLEN];
 
 	/* These offsets are relative to the start of the commit message. */
 	struct chunk author;
@@ -1050,6 +1051,7 @@ static size_t parse_color(struct strbuf *sb, /* in UTF-8 */
 		if (color_parse_mem(begin, end - begin, color) < 0)
 			die(_("unable to parse --pretty format"));
 		strbuf_addstr(sb, color);
+		strlcpy(c->curr_color_escape, color, COLOR_MAXLEN);
 		return end - placeholder + 1;
 	}
 
@@ -1067,8 +1069,10 @@ static size_t parse_color(struct strbuf *sb, /* in UTF-8 */
 	else if (skip_prefix(placeholder + 1, "reset", &rest))
 		basic_color = GIT_COLOR_RESET;
 
-	if (basic_color && want_color(c->pretty_ctx->color))
+	if (basic_color && want_color(c->pretty_ctx->color)) {
 		strbuf_addstr(sb, basic_color);
+		strlcpy(c->curr_color_escape, basic_color, COLOR_MAXLEN);
+	}
 
 	return rest - placeholder;
 }
@@ -1360,8 +1364,10 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 	case 'C':
 		if (starts_with(placeholder + 1, "(auto)")) {
 			c->auto_color = want_color(c->pretty_ctx->color);
-			if (c->auto_color && sb->len)
+			if (c->auto_color && sb->len) {
 				strbuf_addstr(sb, GIT_COLOR_RESET);
+				c->curr_color_escape[0] = 0;
+			}
 			return 7; /* consumed 7 bytes, "C(auto)" */
 		} else {
 			int ret = parse_color(sb, placeholder, c);
@@ -1813,9 +1819,11 @@ static size_t format_commit_item(struct strbuf *sb, /* in UTF-8 */
 		while (sb->len && sb->buf[sb->len - 1] == '\n')
 			strbuf_setlen(sb, sb->len - 1);
 	} else if (orig_len != sb->len) {
-		if (magic == ADD_LF_BEFORE_NON_EMPTY)
+		if (magic == ADD_LF_BEFORE_NON_EMPTY) {
 			strbuf_insertstr(sb, orig_len, "\n");
-		else if (magic == ADD_SP_BEFORE_NON_EMPTY)
+			strbuf_insertstr(sb, orig_len + 1,
+				((struct format_commit_context *)context)->curr_color_escape);
+		} else if (magic == ADD_SP_BEFORE_NON_EMPTY)
 			strbuf_insertstr(sb, orig_len, " ");
 	}
 	return consumed + 1;
-- 
2.35.1

