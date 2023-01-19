Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E560BC004D4
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 23:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjASXAT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 18:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjASW7a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 17:59:30 -0500
X-Greylist: delayed 602 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 Jan 2023 14:49:10 PST
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B848747ED8
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 14:49:10 -0800 (PST)
Received: from hatter.bewilderbeest.net (97-113-250-99.tukw.qwest.net [97.113.250.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 1DAC6CB3;
        Thu, 19 Jan 2023 14:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1674167948;
        bh=IX5fRJOxCXBeLmJg9U1m2VchFoFY7jXtt1Y16rPjzmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q59uLoATWzoPwen2aSpQ6Dj7nEPd36aLGMj5J6Gm/eoJH0EbUBOzvFTolcAMg7PN8
         +26FqQLs+0YkJ0tbG0dLV4HZU9GXUHri38b3tigl2bwr8gfE0EFIZ85joct9rur+WZ
         fXe0Egw0/NvuPhlwQpusuFWzCxQ28YUWriTpHwFA=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     git@vger.kernel.org
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Patrick Hemmer <git@stormcloud9.net>
Subject: [PATCH 2/5] log: Refactor duplicated code to headerize recipient lists
Date:   Thu, 19 Jan 2023 14:38:55 -0800
Message-Id: <20230119223858.29262-3-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230119223858.29262-1-zev@bewilderbeest.net>
References: <20230119223858.29262-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The To and Cc headers are handled identically (the only difference is
the header name tag), so we might as well reuse the same code for both
instead of duplicating it.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 builtin/log.c | 23 ++---------------------
 log-tree.c    | 15 +++++++++++++++
 log-tree.h    |  2 ++
 3 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 057e299c245c..ad9d7ebc6d73 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2028,27 +2028,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		strbuf_addch(&buf, '\n');
 	}
 
-	if (extra_to.nr)
-		strbuf_addstr(&buf, "To: ");
-	for (i = 0; i < extra_to.nr; i++) {
-		if (i)
-			strbuf_addstr(&buf, "    ");
-		strbuf_addstr(&buf, extra_to.items[i].string);
-		if (i + 1 < extra_to.nr)
-			strbuf_addch(&buf, ',');
-		strbuf_addch(&buf, '\n');
-	}
-
-	if (extra_cc.nr)
-		strbuf_addstr(&buf, "Cc: ");
-	for (i = 0; i < extra_cc.nr; i++) {
-		if (i)
-			strbuf_addstr(&buf, "    ");
-		strbuf_addstr(&buf, extra_cc.items[i].string);
-		if (i + 1 < extra_cc.nr)
-			strbuf_addch(&buf, ',');
-		strbuf_addch(&buf, '\n');
-	}
+	recipients_to_header_buf("To", &buf, &extra_to);
+	recipients_to_header_buf("Cc", &buf, &extra_cc);
 
 	rev.extra_headers = to_free = strbuf_detach(&buf, NULL);
 
diff --git a/log-tree.c b/log-tree.c
index 1dd5fcbf7be4..0e8863fe545a 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -426,6 +426,21 @@ void fmt_output_email_subject(struct strbuf *sb, struct rev_info *opt)
 	}
 }
 
+void recipients_to_header_buf(const char *hdr, struct strbuf *buf,
+			      const struct string_list *recipients)
+{
+	for (int i = 0; i < recipients->nr; i++) {
+		if (!i)
+			strbuf_addf(buf, "%s: ", hdr);
+		else
+			strbuf_addstr(buf, "    ");
+		strbuf_addstr(buf, recipients->items[i].string);
+		if (i + 1 < recipients->nr)
+			strbuf_addch(buf, ',');
+		strbuf_addch(buf, '\n');
+	}
+}
+
 void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			     const char **extra_headers_p,
 			     int *need_8bit_cte_p,
diff --git a/log-tree.h b/log-tree.h
index e7e4641cf83c..227edc564121 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -25,6 +25,8 @@ void format_decorations_extended(struct strbuf *sb, const struct commit *commit,
 #define format_decorations(strbuf, commit, color) \
 			     format_decorations_extended((strbuf), (commit), (color), " (", ", ", ")")
 void show_decorations(struct rev_info *opt, struct commit *commit);
+void recipients_to_header_buf(const char *hdr, struct strbuf *buf,
+			      const struct string_list *recipients);
 void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			     const char **extra_headers_p,
 			     int *need_8bit_cte_p,
-- 
2.39.1.236.ga8a28b9eace8

