Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6EAC4332F
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 13:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350640AbiBHNOz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 08:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350317AbiBHMPR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 07:15:17 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB23C03FEC0
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 04:15:17 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id h14-20020a17090a130e00b001b88991a305so1883873pja.3
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 04:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KWdTw3XgNxjSBuQwBII3Ji6fiHgnFV/CEDoNMYoeG+Y=;
        b=YHQA0MMA6e2nY5Dm70QWQbowwHm64D3F0/5RhKO7QM/9XQubk5pxz4Acnx3fyvYNzq
         UmfuGRI0wrfYyPnEBxyeXVOdRzRlJPpDXOJhZUaOesDdkLsgGgVQJOq/2gy0TeJpBUou
         t5rZMPoq/yBTO4s50ztRG7r1csTMM5VImTamBF5BjUr44KiuD5LR55ucPqDjukltKjOF
         aC6cCW1bANvMKtNoxyqRgSw+ECv3sYhh83Zjd33A57tGnCOuHX+/+E/Sk3yXktOVk8AA
         TN/jN1mTN5dNHvmFApJS4saS4xp6v5iX6VM5nGVMDEgkjVtXeUEkL3v6XtnrbVXO79Nb
         6oGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KWdTw3XgNxjSBuQwBII3Ji6fiHgnFV/CEDoNMYoeG+Y=;
        b=2LCnnVkfGV0VcyZeH2wEhoepcS2lVc32Xpr1WUmqVQJaYOVviVDcAUSXkiJY7mry9z
         m9LDfR2tvxhjdUoPbG8fXzInjOt/r/Jdd1bnvNjlLt/wjNSwOONvfw6gdup1VisSlPjU
         Tv8bevqLfJ/qGdgnisDUaBSp0aqwkb55uvBtX6AoThx23+xjxvQwQnoPtMcQi1exh9qi
         IZOg2F0YJJ0c83e5rhBIz8qhq4PFQIHNKTNGp3JDAKgMrMXNvlnJPnfyOGSh9AUMdqzG
         ZSmgSbJ3omZuqACPhm9Jnnj8ssz1RUWqh+T6dU5f3CwE8tadmu7SbV5Ae7wdw0LuxBRn
         jazg==
X-Gm-Message-State: AOAM533zY9Bm9cYQtkz7DnWlh53Tl6/fl5dsVn5QhQ4wSBeedbhf3W36
        cwkzpcOXGfpdiGXKU7WfTJA=
X-Google-Smtp-Source: ABdhPJy6QgugzAqI2iUCyyNYstUCLy2UI2rmoc2gsYwYyuwdjcAmBB56MVQoVsSZqceqV3vHqf1jkQ==
X-Received: by 2002:a17:902:f64e:: with SMTP id m14mr4223612plg.158.1644322516891;
        Tue, 08 Feb 2022 04:15:16 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.44])
        by smtp.gmail.com with ESMTPSA id t3sm16973344pfg.28.2022.02.08.04.15.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Feb 2022 04:15:16 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v11 12/13] ls-tree: introduce function "fast_path()"
Date:   Tue,  8 Feb 2022 20:14:37 +0800
Message-Id: <6d264977491b3645292bba5f91479ab1623e8b80.1644319434.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.403.gb35f2687cf.dirty
In-Reply-To: <cover.1644319434.git.dyroneteng@gmail.com>
References: <cover.1644319434.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The generic "show_tree_fmt()" is slower than "show_tree()", so
we want to take the fast path if possible.

when "--format=<format>" is passed, "fast_path()" will determine
whether to use "show_tree()" or insist on using "show_tree_fmt()"
by a try of finding out if the built-int format is hit.

This commit take out the related codes from "cmd_ls_tree()" and
package them into a new funtion "fast_path()".

Explain it a little bit further, whether fast_path is hit or not,
the final correctness should not break. Abstracting a separate method
helps improve the readability of "cmd_ls_tree()" and the cohesiveness
and extensibility of fast path logic.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/ls-tree.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 1c71e5d543..ba96bcf602 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -58,6 +58,19 @@ enum {
 
 static int cmdmode = MODE_UNSPECIFIED;
 
+static int fast_path(void){
+	if (!strcmp(format, default_format)) {
+		return 1;
+	} else if (!strcmp(format, long_format)) {
+		shown_fields = shown_fields | FIELD_SIZE;
+		return 1;
+	} else if (!strcmp(format, name_only_format)) {
+		shown_fields = FIELD_PATH_NAME;
+		return 1;
+	}
+	return 0;
+}
+
 static void expand_objectsize(struct strbuf *line, const struct object_id *oid,
 			      const enum object_type type, unsigned int padded)
 {
@@ -350,15 +363,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	 * The generic show_tree_fmt() is slower than show_tree(), so
 	 * take the fast path if possible.
 	 */
-	if (format && (!strcmp(format, default_format))) {
-		fn = show_tree;
-	} else if (format && (!strcmp(format, long_format))) {
-		shown_fields = shown_fields | FIELD_SIZE;
-		fn = show_tree;
-	} else if (format && (!strcmp(format, name_only_format))) {
-		shown_fields = FIELD_PATH_NAME;
-		fn = show_tree;
-	} else if (format)
+	if (format && !fast_path())
 		fn = show_tree_fmt;
 
 	return !!read_tree(the_repository, tree, &pathspec, fn, NULL);
-- 
2.34.1.403.gb35f2687cf.dirty

