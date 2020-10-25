Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48947C4363A
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B0B1222C2
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420305AbgJYWmH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Oct 2020 18:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1420281AbgJYWmE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Oct 2020 18:42:04 -0400
Received: from 0x63.nu (0x63.nu [IPv6:2a02:750:9::199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CBCC061755
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 15:42:04 -0700 (PDT)
Received: from ip6-localhost ([::1] helo=localhost.localdomain)
        by 0x63.nu with esmtp (Exim 4.90_1)
        (envelope-from <anders@0x63.nu>)
        id 1kWnXq-0007u5-9d; Sun, 25 Oct 2020 22:27:18 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Anders Waldenborg <anders@0x63.nu>, christian.couder@gmail.com,
        peff@peff.net, jonathantanmy@google.com
Subject: [PATCH 12/21] trailer: handle configured nondefault separators explicitly
Date:   Sun, 25 Oct 2020 22:26:43 +0100
Message-Id: <20201025212652.3003036-13-anders@0x63.nu>
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
        id 1kWnXq-0007u5-9d; Sun, 25 Oct 2020 22:27:18 +0100
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

); SAEximRunCond expanded to false

Instead of parsing out separator from configuration when it is
printed, do this parsing when reading the configuration so it can be
stored separately and "conf->key" will contain the actual key only.

No functional change intended.

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
---
 trailer.c | 59 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 39 insertions(+), 20 deletions(-)

diff --git a/trailer.c b/trailer.c
index 1592e6c998..102eca0127 100644
--- a/trailer.c
+++ b/trailer.c
@@ -13,6 +13,7 @@
 struct conf_info {
 	char *name;
 	char *key;
+	char *nondefault_separator;
 	char *command;
 	enum trailer_where where;
 	enum trailer_if_exists if_exists;
@@ -140,32 +141,21 @@ static void free_arg_item(struct arg_item *item)
 	free(item);
 }
 
-static char last_non_space_char(const char *s)
-{
-	int i;
-	for (i = strlen(s) - 1; i >= 0; i--)
-		if (!isspace(s[i]))
-			return s[i];
-	return '\0';
-}
-
 static void print_item(FILE *outfile, const struct trailer_item *item)
 {
 	if (item->token) {
 		const char *tok = item->token;
+		const char *sep = (char []){separators[0], ' ', '\0'};
 		const struct conf_info *conf = item->conf;
-		char c;
 
-		if (conf && conf->key)
-			tok = conf->key;
+		if (conf) {
+			if (conf->key)
+				tok = conf->key;
+			if (conf->nondefault_separator)
+				sep = conf->nondefault_separator;
+		}
 
-		c = last_non_space_char(tok);
-		if (!c)
-			return;
-		if (strchr(separators, c))
-			fputs(tok, outfile);
-		else
-			fprintf(outfile, "%s%c ", tok, separators[0]);
+		fprintf(outfile, "%s%s", tok, sep);
 	}
 
 	fprintf(outfile, "%s\n", item->value);
@@ -502,6 +492,34 @@ static int git_trailer_default_config(const char *conf_key, const char *value, v
 	return 0;
 }
 
+static void git_trailer_config_key(const char *conf_key, const char *value, struct conf_info *conf)
+{
+	const char *end = value + strlen(value) - 1;
+
+	while (end > value && isspace(*end))
+		end--;
+
+	if (end == value) {
+		warning(_("Ignoring empty token for key '%s'"), conf_key);
+		return;
+	}
+
+	if (strchr(separators, *end)) {
+		const char *token_end = end - 1;
+		while (token_end > value && isspace(*token_end))
+			token_end--;
+		if (token_end == value) {
+			warning(_("Ignoring empty token for key '%s'"), conf_key);
+			return;
+		}
+
+		conf->key = xstrndup(value, token_end - value + 1);
+		conf->nondefault_separator = xstrdup(token_end + 1);
+	} else {
+		conf->key = xstrdup(value);
+	}
+}
+
 static int git_trailer_config(const char *conf_key, const char *value, void *cb)
 {
 	const char *trailer_item, *variable_name;
@@ -536,7 +554,8 @@ static int git_trailer_config(const char *conf_key, const char *value, void *cb)
 	case TRAILER_KEY:
 		if (conf->key)
 			warning(_("more than one %s"), conf_key);
-		conf->key = xstrdup(value);
+
+		git_trailer_config_key (conf_key, value, conf);
 		break;
 	case TRAILER_COMMAND:
 		if (conf->command)
-- 
2.25.1

