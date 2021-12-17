Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C163FC433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 13:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhLQNai (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 08:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbhLQNad (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 08:30:33 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45E5C06173E
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 05:30:32 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id j9so4163740wrc.0
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 05:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3LVDarJRlnU5+Qq4XJlcuBnxgogAY4EOPMBnptsgNU4=;
        b=MikYkODW29lIS3lC5X7Lf0gplQKOBhor7Ocjxqsf3pYKGAY7huyt0Hh6uxXQKTR/99
         nh3RWK9ScKzhhv/YU8s2wWT2XmXETAFq8F+uCeYkTAKugoQ4yA2Lrou2UZHTgkHvHgi2
         qmYjJCr78LIpmnwXYOXXdgeisxmpCgvIMtyQQyyqKk36JsqE9EwvUYCzK1k3BsuUbyND
         H8MQzmhIfsBarLjr6qYj5pBvyRDpYH1r7TByulsOpElIanLDnLmPigoJScCZ8F3RryHH
         RUSi6K5xcqJm4yisdBF3JBnWwC3Wy0DyEpB/naVghl6GuqgoEgc0TiiaLRD5KHbnuv9K
         Iz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3LVDarJRlnU5+Qq4XJlcuBnxgogAY4EOPMBnptsgNU4=;
        b=MoSkcx5+D5RCo5yer6S/veQd2Pk14kJvJwUfjDdJg/ijcnDetWwhyvgmQHxIuojf8f
         9prW0A9NF2bhUNmWb+nnSJTiTGhJ28i3KUJP+Mh29ZPrYsyldStpq+6339t5nzzmU220
         xsQ97SjYS0bZgNKFz4mwUyWd4emR2YjYsDZ5B6KSMwOIDp64XM1GYobZi4AfOAEbms4a
         GmHf6bxWcHiH0P2vHGMJaiXz96xw6ECgVldUhPrWeqfaOQHsD72xmdJw6G5iLg53Z0O5
         32CJmOX6CbQBYhGQE4zCXSXJcMz6FCIJ3YeUA8bPcu0tlvNRHgtunKbq9y+VyDFPcnft
         gA4A==
X-Gm-Message-State: AOAM532d5pirRTv51qhAlFvqfX4I6U4IJwM3dJSq3MF8StR2UmOxFSsi
        vQv6tph+sRbqed9q+ro4p5BZek5F9lFEZg==
X-Google-Smtp-Source: ABdhPJzqxtm/VXCgIS7RItAJxYULL4tN7AYNsriRtjV5qiSwDbFsoXiCghp8wJbO5OjOhQwowHiLpg==
X-Received: by 2002:a5d:4f0e:: with SMTP id c14mr2591202wru.716.1639747830983;
        Fri, 17 Dec 2021 05:30:30 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b19sm11953993wmb.38.2021.12.17.05.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 05:30:30 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 5/7] ls-tree: split up the "init" part of show_tree()
Date:   Fri, 17 Dec 2021 14:30:21 +0100
Message-Id: <RFC-patch-5.7-8c9d8a8221d-20211217T131635Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
In-Reply-To: <RFC-cover-0.7-00000000000-20211217T131635Z-avarab@gmail.com>
References: <cover.1639721750.git.dyroneteng@gmail.com> <RFC-cover-0.7-00000000000-20211217T131635Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split up the "init" part of the show_tree() function where we decide
what the "type" is, and whether we'll return early. This makes things
a bit less readable for now, but we'll soon re-use this in a sibling
function, and avoiding the duplication will be worth it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-tree.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index eecc7482d54..df8312408da 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -61,25 +61,33 @@ static int show_recursive(const char *base, size_t baselen, const char *pathname
 	return 0;
 }
 
-static int show_tree(const struct object_id *oid, struct strbuf *base,
-		const char *pathname, unsigned mode, void *context)
+static int show_tree_init(enum object_type *type, struct strbuf *base,
+			  const char *pathname, unsigned mode, int *retval)
 {
-	int retval = 0;
-	size_t baselen;
-	enum object_type type = OBJ_BLOB;
-
 	if (S_ISGITLINK(mode)) {
-		type = OBJ_COMMIT;
+		*type = OBJ_COMMIT;
 	} else if (S_ISDIR(mode)) {
 		if (show_recursive(base->buf, base->len, pathname)) {
-			retval = READ_TREE_RECURSIVE;
+			*retval = READ_TREE_RECURSIVE;
 			if (!(ls_options & LS_SHOW_TREES))
-				return retval;
+				return 1;
 		}
-		type = OBJ_TREE;
+		*type = OBJ_TREE;
 	}
 	else if (ls_options & LS_TREE_ONLY)
-		return 0;
+		return 1;
+	return 0;
+}
+
+static int show_tree(const struct object_id *oid, struct strbuf *base,
+		const char *pathname, unsigned mode, void *context)
+{
+	int retval = 0;
+	size_t baselen;
+	enum object_type type = OBJ_BLOB;
+
+	if (show_tree_init(&type, base, pathname, mode, &retval))
+		return retval;
 
 	if (!(ls_options & LS_NAME_ONLY)) {
 		if (ls_options & LS_SHOW_SIZE) {
-- 
2.34.1.1119.g7a3fc8778ee

