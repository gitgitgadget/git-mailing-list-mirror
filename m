Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E03FF1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 22:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbeHKBGu (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 21:06:50 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:44508 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbeHKBGt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 21:06:49 -0400
Received: by mail-it0-f74.google.com with SMTP id b124-v6so3265868itb.9
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 15:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=o+hhhlLpkR376WNbVmZePXK2RnV9McRASWjFWpPe1pY=;
        b=orogHEuS5p8FUXUCCqvo900UN5OjiBMdFot0fTjUe74HxnnGu+ZPoU5N0RtctFWOA9
         WpPA0Hg4eI6FWGMvw3AFHu3sHTKjWJKJ0MKRtNfsL4AgQZzjfZ6q3h/ACXtOD7Dp0iPt
         TpaJj7ZVzvEmdFq29M6xHinGkTkxf8XhS2vkghShe2/ubMzPJx7HljcHNx1UMxCXWAb2
         y4jEr5KEGkU4jV5JV8ooCKKDWmnjtvTqz5sjLkF+fDUIQB7EuBszN8WhJzVMS7pEDwuo
         h3BycbemC3yv9wpiCPzG0V5rgGDA6XoAMkFfisBhQvOdtG6uPZmNSQ9l8psK426Aitx4
         1xig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=o+hhhlLpkR376WNbVmZePXK2RnV9McRASWjFWpPe1pY=;
        b=qQVIsnWp2d+YwmDWIHCwuqaIk+ayk3CrlEgl5rsrrcy9oD05Q1jdNKv+/i9fnR7NDQ
         VSV/biK9yvgACQrI/uEylfTJxXquo1RoGiUc8BVq+0WQ4OLtZrXojmMWKT8+bE2bK9+5
         IpnUwWl8SotxjK7Y875s9n+wqQ/yJCun9gtDDjIadAJMfrJLfrVRbj+EaTJOehlPMkK6
         ycd0vNc1cKqHSZSpHEXdj7gbEp8gYR6Go/hFrTW2WUw6q2Jjg+CKuJH4j03tKs4zPeeZ
         WtWvunkL5XS+lKwlkFKTeC0QffaenemFz8fBnqYeO6T5zTpG5UrXdGNjNUp0JciICh7Z
         q4mw==
X-Gm-Message-State: AOUpUlFOPXAJmY8PJeL4MJ+73nvzFADR3EVjdYTQzwQdzHaPrreX0/56
        rrT2EPnVg6xqc2pCwZ1EEMsHfx7Eu2QK
X-Google-Smtp-Source: AA+uWPwCIWG0FpcnQf8WwfbdynzFOJIN0c93GwsUhGNIGFKnsBSTLL8w2hwcZq1t+kJ5LsFsxhP2l5Bra0AY
X-Received: by 2002:a6b:ca84:: with SMTP id a126-v6mr1373687iog.45.1533940499970;
 Fri, 10 Aug 2018 15:34:59 -0700 (PDT)
Date:   Fri, 10 Aug 2018 15:34:39 -0700
In-Reply-To: <20180810223441.30428-1-sbeller@google.com>
Message-Id: <20180810223441.30428-7-sbeller@google.com>
Mime-Version: 1.0
References: <20180810223441.30428-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 6/8] diff: use emit_line_0 once per line
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, Johannes.Schindelin@gmx.de
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All lines that use emit_line_0 multiple times per line, are combined
into a single call to emit_line_0, making use of the 'set' argument.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/diff.c b/diff.c
index 5eea5edca50..01095a59d3d 100644
--- a/diff.c
+++ b/diff.c
@@ -629,10 +629,7 @@ static void emit_line_0(struct diff_options *o,
 	int nofirst;
 	FILE *file = o->file;
 
-	if (first)
-		fputs(diff_line_prefix(o), file);
-	else if (!len)
-		return;
+	fputs(diff_line_prefix(o), file);
 
 	if (len == 0) {
 		has_trailing_newline = (first == '\n');
@@ -652,13 +649,17 @@ static void emit_line_0(struct diff_options *o,
 	if (len || !nofirst) {
 		if (reverse && want_color(o->use_color))
 			fputs(GIT_COLOR_REVERSE, file);
-		if (set_sign && set_sign[0])
-			fputs(set_sign, file);
+		if (set_sign || set)
+			fputs(set_sign ? set_sign : set, file);
 		if (first && !nofirst)
 			fputc(first, file);
-		if (set)
-			fputs(set, file);
-		fwrite(line, len, 1, file);
+		if (len) {
+			if (set_sign && set && set != set_sign)
+				fputs(reset, file);
+			if (set)
+				fputs(set, file);
+			fwrite(line, len, 1, file);
+		}
 		fputs(reset, file);
 	}
 	if (has_trailing_carriage_return)
@@ -1204,16 +1205,13 @@ static void emit_line_ws_markup(struct diff_options *o,
 	if (!ws && !set_sign)
 		emit_line_0(o, set, NULL, 0, reset, sign, line, len);
 	else if (!ws) {
-		/* Emit just the prefix, then the rest. */
-		emit_line_0(o, set_sign, NULL, !!set_sign, reset, sign, "", 0);
-		emit_line_0(o, set, NULL, 0, reset, 0, line, len);
+		emit_line_0(o, set_sign, set, !!set_sign, reset, sign, line, len);
 	} else if (blank_at_eof)
 		/* Blank line at EOF - paint '+' as well */
 		emit_line_0(o, ws, NULL, 0, reset, sign, line, len);
 	else {
 		/* Emit just the prefix, then the rest. */
-		emit_line_0(o, set_sign ? set_sign : set, NULL, !!set_sign, reset,
-			    sign, "", 0);
+		emit_line_0(o, set_sign, set, !!set_sign, reset, sign, "", 0);
 		ws_check_emit(line, len, ws_rule,
 			      o->file, set, reset, ws);
 	}
-- 
2.18.0.865.gffc8e1a3cd6-goog

