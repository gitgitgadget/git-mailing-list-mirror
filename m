Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5019DC4332F
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 11:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239735AbiKQLbI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 06:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239722AbiKQLax (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 06:30:53 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864514875A
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 03:30:44 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id s196so1724565pgs.3
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 03:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXx3uJztlxTc5guOX6lQ/1R4HDmOgcHIbupMGnumBhE=;
        b=a8KKjw+vWDLrMyVeDGgjWazI3dBlM+pPQtnKHttafLRx97f1rH4X9cAhGlqgKeuJJ7
         SY5qrEf1S5+zQYJ43/aijeHurtj5Gn0VwMKlo+rZhmF7bGJjxcCWgdLEwt6cgm7+8Knu
         Coa6td7GrQF9Tj7QZ7WtbS2ddGap7FsmvmSbd7PHSFw/Lggvjkzmimp7YqHO7f89sS6e
         Y9du185+JS/lTqDN/3a2w161lD0FphR/nvow1NutsoSWKNeAWw+0a2NK3tN3yiRxnRS/
         19i0ktu7druAsoD85psbbvLaJicxh6wwP8r8nkYLUamjrGFIADaKP3Kbx1RpVe77WrSH
         CvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXx3uJztlxTc5guOX6lQ/1R4HDmOgcHIbupMGnumBhE=;
        b=hRrXjPzxct2dF5pr0/1Vd1UJGFyPPjBf0jyjOFBMeEGplxrMzBNUNKyLx/ixyS1U8L
         c8KdITrdE2q6rojcGd/EjIyNpdPyXolLd7tnDu+s59/Wp0CEUnlYZd5epEefb1sygDOk
         /RJwDPgz64vDfDkgfNQ6RpsqW1gFqwHVte5eYnD7huIENynU72MtIrTdzX9vmqOP2JuH
         43L991G6qbqQS/2VodZ58AcrWs3aiiGEnIQYR5KjALVbXbNUc8cZfH/UWubLODy075LB
         ipy80R44oWLLfgzfX6Fmejvd58ltAqY4cGJDiFkh4Juk3DqN0GEyp/YmfUwaULC+bU/M
         a7dA==
X-Gm-Message-State: ANoB5pn30skCiTSnin58IsCBrBJ4GM2U2CeskNuV/25ltxPMBUmt5F1Y
        U6wSQZBD84YMQmh1ix3JUC//qqCc/sfMtA==
X-Google-Smtp-Source: AA0mqf6rfe8praUsN7azbp/e51/0yXpX1RBKwHsuVdsTRdDk/fZUbbujWwvdg3psYCyPJCEnLXoirw==
X-Received: by 2002:a05:6a00:301b:b0:56e:1ce2:c919 with SMTP id ay27-20020a056a00301b00b0056e1ce2c919mr2486697pfb.78.1668684643820;
        Thu, 17 Nov 2022 03:30:43 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.60])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b00186c5e8b1d0sm1056117pln.149.2022.11.17.03.30.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Nov 2022 03:30:43 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, tenglong.tl@alibaba-inc.com, me@ttaylorr.com,
        Teng Long <dyroneteng@gmail.com>
Subject: [RFC PATCH 5/6] ls-tree: introduce 'match_pattern()' function
Date:   Thu, 17 Nov 2022 19:30:22 +0800
Message-Id: <20221117113023.65865-6-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.1.426.g770fc8806cb.dirty
In-Reply-To: <20221117113023.65865-1-tenglong.tl@alibaba-inc.com>
References: <20221117113023.65865-1-tenglong.tl@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

In preparation for actually implementing the '--pattern' option, we
add a new method called 'match_pattern' that uses regular expressions
to match 'ls-tree' entities.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/ls-tree.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 7661170f7ca..03dd3fbcb26 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -24,6 +24,7 @@ static struct pathspec pathspec;
 static int chomp_prefix;
 static const char *ls_tree_prefix;
 static const char *format;
+static const char *pattern;
 struct show_tree_data {
 	unsigned mode;
 	enum object_type type;
@@ -46,6 +47,32 @@ static enum ls_tree_cmdmode {
 	MODE_OBJECT_ONLY,
 } cmdmode;
 
+__attribute__((unused))
+static int match_pattern(const char *line)
+{
+	int ret = 0;
+	regex_t r;
+	regmatch_t m[1];
+	char errbuf[64];
+
+	ret = regcomp(&r, pattern, 0);
+	if (ret) {
+		regerror(ret, &r, errbuf, sizeof(errbuf));
+		die("failed regcomp() for pattern '%s' (%s)", pattern, errbuf);
+	}
+	ret = regexec(&r, line, 1, m, 0);
+	if (ret) {
+		if (ret == REG_NOMATCH)
+			goto cleanup;
+		regerror(ret, &r, errbuf, sizeof(errbuf));
+		die("failed regexec() for subject '%s' (%s)", line, errbuf);
+	}
+
+cleanup:
+	regfree(&r);
+	return ret;
+}
+
 static void expand_objectsize(struct strbuf *line, const struct object_id *oid,
 			      const enum object_type type, unsigned int padded)
 {
-- 
2.38.1.426.g770fc8806cb.dirty

