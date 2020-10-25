Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2644C4363A
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 964ED222EC
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420273AbgJYWlz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Oct 2020 18:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1420265AbgJYWly (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Oct 2020 18:41:54 -0400
Received: from 0x63.nu (0x63.nu [IPv6:2a02:750:9::199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A78AC061755
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 15:41:54 -0700 (PDT)
Received: from ip6-localhost ([::1] helo=localhost.localdomain)
        by 0x63.nu with esmtp (Exim 4.90_1)
        (envelope-from <anders@0x63.nu>)
        id 1kWnXp-0007u5-27; Sun, 25 Oct 2020 22:27:17 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Anders Waldenborg <anders@0x63.nu>, christian.couder@gmail.com,
        peff@peff.net, jonathantanmy@google.com
Subject: [PATCH 04/21] pretty: allow using aliases in %(trailer:key=xyz)
Date:   Sun, 25 Oct 2020 22:26:35 +0100
Message-Id: <20201025212652.3003036-5-anders@0x63.nu>
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
        id 1kWnXp-0007u5-27; Sun, 25 Oct 2020 22:27:17 +0100
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

); SAEximRunCond expanded to false

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
---
 Documentation/pretty-formats.txt | 4 +++-
 pretty.c                         | 5 ++++-
 t/t4205-log-pretty-formats.sh    | 6 ++++++
 trailer.c                        | 7 +++++--
 trailer.h                        | 2 +-
 5 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 84bbc7439a..1714fa447d 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -256,7 +256,9 @@ endif::git-rev-list[]
 ** 'key=<K>': only show trailers with specified key. Matching is done
    case-insensitively and trailing colon is optional. If option is
    given multiple times trailer lines matching any of the keys are
-   shown. This option automatically enables the `only` option so that
+   shown. If `trailer.<token>.key` configuration option is set 'token'
+   can be used as an alias for showing trailers with the value in
+   key. This option automatically enables the `only` option so that
    non-trailer lines in the trailer block are hidden. If that is not
    desired it can be disabled with `only=false`.  E.g.,
    `%(trailers:key=Reviewed-by)` shows trailer lines with key
diff --git a/pretty.c b/pretty.c
index 7a7708a0ea..3c374abffe 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1135,7 +1135,7 @@ static int match_placeholder_bool_arg(const char *to_parse, const char *candidat
 	return 1;
 }
 
-static int format_trailer_match_cb(const struct strbuf *key, void *ud)
+static int format_trailer_match_cb(const struct strbuf *key, const char *alias, void *ud)
 {
 	const struct string_list *list = ud;
 	const struct string_list_item *item;
@@ -1144,6 +1144,9 @@ static int format_trailer_match_cb(const struct strbuf *key, void *ud)
 		if (key->len == (uintptr_t)item->util &&
 		    !strncasecmp(item->string, key->buf, key->len))
 			return 1;
+		if (alias && strlen(alias) == (uintptr_t)item->util &&
+		    !strncasecmp(item->string, alias, (uintptr_t)item->util))
+			return 1;
 	}
 	return 0;
 }
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 204c149d5a..757575d3f6 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -676,6 +676,12 @@ test_expect_success 'pretty format %(trailers:key=foo) multiple keys' '
 	test_cmp expect actual
 '
 
+test_expect_success 'pretty format %(trailers:key=foo) alias in config' '
+	git -c trailer.ab.key=Acked-by log --no-walk --pretty="format:%(trailers:key=ab)" >actual &&
+	echo "Acked-by: A U Thor <author@example.com>" >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success '%(trailers:key=nonexistent) becomes empty' '
 	git log --no-walk --pretty="x%(trailers:key=Nacked-by)x" >actual &&
 	echo "xx" >expect &&
diff --git a/trailer.c b/trailer.c
index ca7a823af6..8c0687a529 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1148,8 +1148,11 @@ static void format_trailer_info(struct strbuf *out,
 			struct strbuf tok = STRBUF_INIT;
 			struct strbuf val = STRBUF_INIT;
 
-			parse_trailer(&tok, &val, NULL, trailer, separator_pos);
-			if (!opts->filter || opts->filter(&tok, opts->filter_data)) {
+			const struct conf_info *conf;
+
+			parse_trailer(&tok, &val, &conf, trailer, separator_pos);
+			if (!opts->filter ||
+			    opts->filter(&tok, conf ? conf->name : NULL, opts->filter_data)) {
 				if (opts->unfold)
 					unfold_value(&val);
 
diff --git a/trailer.h b/trailer.h
index cd93e7ddea..b362b0d44d 100644
--- a/trailer.h
+++ b/trailer.h
@@ -73,7 +73,7 @@ struct process_trailer_options {
 	int no_divider;
 	int value_only;
 	const struct strbuf *separator;
-	int (*filter)(const struct strbuf *, void *);
+	int (*filter)(const struct strbuf *, const char *alias, void *);
 	void *filter_data;
 };
 
-- 
2.25.1

