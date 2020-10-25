Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6168BC388F7
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35107222EC
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420296AbgJYWmD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Oct 2020 18:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1420281AbgJYWmB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Oct 2020 18:42:01 -0400
Received: from 0x63.nu (0x63.nu [IPv6:2a02:750:9::199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72062C0613CE
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 15:42:01 -0700 (PDT)
Received: from ip6-localhost ([::1] helo=localhost.localdomain)
        by 0x63.nu with esmtp (Exim 4.90_1)
        (envelope-from <anders@0x63.nu>)
        id 1kWnXr-0007u5-Oa; Sun, 25 Oct 2020 22:27:19 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Anders Waldenborg <anders@0x63.nu>, christian.couder@gmail.com,
        peff@peff.net, jonathantanmy@google.com
Subject: [PATCH 17/21] trailer: don't treat line with prefix of known trailer as known
Date:   Sun, 25 Oct 2020 22:26:48 +0100
Message-Id: <20201025212652.3003036-18-anders@0x63.nu>
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
        id 1kWnXr-0007u5-Oa; Sun, 25 Oct 2020 22:27:19 +0100
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

); SAEximRunCond expanded to false

E.g if "Closes" is a configured trailer a line starting with "c:"
shouldn't be treated as a recognized trailer when looking for trailer
block.

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
---
 t/t7513-interpret-trailers.sh |  7 +------
 trailer.c                     | 28 ++++++++++++++++++----------
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index b1e9a9e6d1..6ddc2f5573 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -239,12 +239,7 @@ test_expect_success 'with non-trailer lines mixed with a configured trailer' '
 	test_cmp expected actual
 '
 
-# This fails because "c:/windows/tmp/stuff/temp.txt" is classified as
-# a trailer line because "c" is a prefix of "Confirmed-By". Therefore
-# the new trailer is appended to that (non-trailer) block rather than
-# creating a new block. It also canonicalize the "trailer" to
-# "Confirmed-By: /windows/tmp/stuff/temp.txt"
-test_expect_failure 'with non-trailer lines mixed with prefix of configured trailer' '
+test_expect_success 'with non-trailer lines mixed with prefix of configured trailer' '
 	cat >patch <<-\EOF &&
 		some subject
 
diff --git a/trailer.c b/trailer.c
index 21877e4c06..d75d240e10 100644
--- a/trailer.c
+++ b/trailer.c
@@ -831,10 +831,20 @@ enum trailer_classification {
 	BLANK,
 };
 
+static int starts_with_separator(const char *buf)
+{
+	while (*buf == ' ' || *buf == '\t')
+		buf++;
+	if (!*buf)
+		return 0;
+	return !!strchr(separators, *buf);
+}
+
 static enum trailer_classification classify_trailer_line(const char *line)
 {
 	const char **p;
 	ssize_t separator_pos;
+	struct list_head *pos;
 
 	if (line[0] == comment_line_char)
 		return COMMENT;
@@ -849,19 +859,17 @@ static enum trailer_classification classify_trailer_line(const char *line)
 		if (starts_with(line, *p))
 			return GIT_GENERATED_PREFIX;
 
-
-	separator_pos = find_separator(line, separators);
-	if (separator_pos >= 1) {
-		struct list_head *pos;
-
-		list_for_each(pos, &conf_head) {
-			struct conf_info_item *item;
-			item = list_entry(pos, struct conf_info_item, list);
-			if (token_matches_conf(line, &item->conf,
-			                       separator_pos))
+	list_for_each(pos, &conf_head) {
+		struct conf_info_item *item = list_entry(pos, struct conf_info_item, list);
+		const char *conftrailer = item->conf.key ? item->conf.key : item->conf.name;
+		if (istarts_with(line, conftrailer)) {
+			if (starts_with_separator (line + strlen (conftrailer)))
 				return CONFIGURED_TRAILER;
 		}
+	}
 
+	separator_pos = find_separator(line, separators);
+	if (separator_pos >= 1) {
 		return TRAILER;
 	}
 
-- 
2.25.1

