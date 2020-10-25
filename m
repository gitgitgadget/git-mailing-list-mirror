Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A850CC388F7
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 840AB222EC
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420315AbgJYWmO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Oct 2020 18:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1420309AbgJYWmL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Oct 2020 18:42:11 -0400
Received: from 0x63.nu (0x63.nu [IPv6:2a02:750:9::199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2343C0613D0
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 15:42:10 -0700 (PDT)
Received: from ip6-localhost ([::1] helo=localhost.localdomain)
        by 0x63.nu with esmtp (Exim 4.90_1)
        (envelope-from <anders@0x63.nu>)
        id 1kWnXr-0007u5-2A; Sun, 25 Oct 2020 22:27:19 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Anders Waldenborg <anders@0x63.nu>, christian.couder@gmail.com,
        peff@peff.net, jonathantanmy@google.com
Subject: [PATCH 15/21] trailer: factor out classify_trailer_line
Date:   Sun, 25 Oct 2020 22:26:46 +0100
Message-Id: <20201025212652.3003036-16-anders@0x63.nu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201025212652.3003036-1-anders@0x63.nu>
References: <20201025212652.3003036-1-anders@0x63.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: ::1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on st.localdomain)
        by 0x63.nu with esmtp (Exim 4.90_1)
        (envelope-from <anders@0x63.nu>)
        id 1kWnXr-0007u5-2A; Sun, 25 Oct 2020 22:27:19 +0100
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

); SAEximRunCond expanded to false

No functional change intended.

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
---
 trailer.c | 123 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 74 insertions(+), 49 deletions(-)

diff --git a/trailer.c b/trailer.c
index 937cf1edeb..21877e4c06 100644
--- a/trailer.c
+++ b/trailer.c
@@ -821,6 +821,53 @@ static size_t find_patch_start(const char *str)
 	return s - str;
 }
 
+enum trailer_classification {
+	GIT_GENERATED_PREFIX,
+	CONFIGURED_TRAILER,
+	TRAILER,
+	CONTINUATION,
+	NON_TRAILER,
+	COMMENT,
+	BLANK,
+};
+
+static enum trailer_classification classify_trailer_line(const char *line)
+{
+	const char **p;
+	ssize_t separator_pos;
+
+	if (line[0] == comment_line_char)
+		return COMMENT;
+
+	if (is_blank_line(line))
+		return BLANK;
+
+	if (isspace(line[0]))
+		return CONTINUATION;
+
+	for (p = git_generated_prefixes; *p; p++)
+		if (starts_with(line, *p))
+			return GIT_GENERATED_PREFIX;
+
+
+	separator_pos = find_separator(line, separators);
+	if (separator_pos >= 1) {
+		struct list_head *pos;
+
+		list_for_each(pos, &conf_head) {
+			struct conf_info_item *item;
+			item = list_entry(pos, struct conf_info_item, list);
+			if (token_matches_conf(line, &item->conf,
+			                       separator_pos))
+				return CONFIGURED_TRAILER;
+		}
+
+		return TRAILER;
+	}
+
+	return NON_TRAILER;
+}
+
 /*
  * Return the position of the first trailer line or len if there are no
  * trailers.
@@ -864,59 +911,37 @@ static size_t find_trailer_start(const char *buf, size_t len)
 	     l >= end_of_title;
 	     l = last_line(buf, l)) {
 		const char *bol = buf + l;
-		const char **p;
-		ssize_t separator_pos;
 
-		if (bol[0] == comment_line_char) {
-			non_trailer_lines += possible_continuation_lines;
-			possible_continuation_lines = 0;
-			continue;
-		}
-		if (is_blank_line(bol)) {
-			non_trailer_lines += possible_continuation_lines;
-			if (recognized_prefix &&
-			    trailer_lines * 3 >= non_trailer_lines)
-				return next_line(bol) - buf;
-			else if (trailer_lines && !non_trailer_lines)
-				return next_line(bol) - buf;
-			return len;
-		}
-
-		for (p = git_generated_prefixes; *p; p++) {
-			if (starts_with(bol, *p)) {
+		switch (classify_trailer_line(bol)) {
+			case GIT_GENERATED_PREFIX:
+			case CONFIGURED_TRAILER:
+				recognized_prefix = 1;
+				/* fallthrough */
+			case TRAILER:
 				trailer_lines++;
 				possible_continuation_lines = 0;
-				recognized_prefix = 1;
-				goto continue_outer_loop;
-			}
-		}
-
-		separator_pos = find_separator(bol, separators);
-		if (separator_pos >= 1 && !isspace(bol[0])) {
-			struct list_head *pos;
-
-			trailer_lines++;
-			possible_continuation_lines = 0;
-			if (recognized_prefix)
-				continue;
-			list_for_each(pos, &conf_head) {
-				struct conf_info_item *item;
-				item = list_entry(pos, struct conf_info_item, list);
-				if (token_matches_conf(bol, &item->conf,
-						       separator_pos)) {
-					recognized_prefix = 1;
-					break;
-				}
-			}
-		} else if (isspace(bol[0]))
-			possible_continuation_lines++;
-		else {
-			non_trailer_lines++;
-			non_trailer_lines += possible_continuation_lines;
-			possible_continuation_lines = 0;
+				break;
+			case CONTINUATION:
+				possible_continuation_lines++;
+				break;
+			case NON_TRAILER:
+				non_trailer_lines++;
+				non_trailer_lines += possible_continuation_lines;
+				possible_continuation_lines = 0;
+				break;
+			case COMMENT:
+				non_trailer_lines += possible_continuation_lines;
+				possible_continuation_lines = 0;
+				break;
+			case BLANK:
+				non_trailer_lines += possible_continuation_lines;
+				if (recognized_prefix &&
+					trailer_lines * 3 >= non_trailer_lines)
+					return next_line(bol) - buf;
+				else if (trailer_lines && !non_trailer_lines)
+					return next_line(bol) - buf;
+				return len;
 		}
-continue_outer_loop:
-		;
 	}
 
 	return len;
-- 
2.25.1

