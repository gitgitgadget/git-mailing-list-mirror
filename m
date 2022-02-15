Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461ABC433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 22:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244543AbiBOWQl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 17:16:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244535AbiBOWQi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 17:16:38 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DB1D77
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 14:16:24 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a23so264224eju.3
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 14:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WueUOCJaofqvN+pAl2PEtPoNFK0PGZS/zFLU4HFCtz8=;
        b=KolMibdBsAxHpquXo7b5wv5nH/1w+DQfQV1mYDYXLnfjCnIuy6EWTEiFt/4PEcN8u9
         l/PkOmISBK3zP1evNDmrPCEI4/l8xexxec3Q2Aghn6n0tDWUA5C0yOR8AMskvYS23jqf
         tScKBG6BRyf57vPo7F0IjElv9hOu0q5V7ihaJms0VPMXd3Wy8Q/lvjHIcm2J1V6wQiEu
         JPZJzlrUdklFsJtMlhBvOx1rsK2GlAYZfGvb0iAi+r3TTkxWibatnSbrHUnWdk4p4IP+
         KVLxgNV2Uwzv+Ykxsh71khdYuyiETPoq1oAbYMCM22jqoT2losG+eaXVlyFtonJ2Z64X
         PQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WueUOCJaofqvN+pAl2PEtPoNFK0PGZS/zFLU4HFCtz8=;
        b=gXGzRVntUd0FQIcHTFA1Q/BktXBSxh1WbZA1cvNPLOu9nfmBlmP8pW+kISz/I6nH6v
         HVPouH3S8nHcA0YsI25QXR5rr6oucVwlVVwEfgfjafEcbnElBZXznfPsr5mdIiOAQt3l
         smdo1Pth6591eQaeLVi1i++EcJUtGjlxraiEsSVGLVU3ws+0MbPM8WlhLrr0tbrV3sMb
         F03yZYmWeufIMjT8j3HhZNJWna9mOiYqOcOKDYpHR/FCqp7iGCx2BXShx4ZjB5uHVjEG
         QisgP5JYsXt14COdYIgNytNZF7NkWjDxxFQikyHLPVO0W/MWfpsam0mE2IdJMEYD3xqs
         KqYQ==
X-Gm-Message-State: AOAM532wNluIQBnuyshAozwSVfE6lzenvUwym4Sd55kUpv3Z87KNpfpF
        GazBiySywuqiJAFPG/5z/KOXONNFbLw=
X-Google-Smtp-Source: ABdhPJzQhDopnESER8+fwiK4BCP9+nU93PEUgNc4Y7sRA1NFLjup/fxaFfz9q4h0Oq1QMeyHZkvG7g==
X-Received: by 2002:a17:906:7852:b0:6ce:88f5:4dc9 with SMTP id p18-20020a170906785200b006ce88f54dc9mr46501ejm.491.1644963382961;
        Tue, 15 Feb 2022 14:16:22 -0800 (PST)
Received: from matebook-pat.. ([213.55.247.223])
        by smtp.gmail.com with ESMTPSA id i5sm571341edc.94.2022.02.15.14.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 14:16:22 -0800 (PST)
From:   Patrick Marlier <patrick.marlier@gmail.com>
To:     git@vger.kernel.org, newren@gmail.com
Cc:     Patrick Marlier <patrick.marlier@gmail.com>
Subject: [PATCH 2/2] clean: avoid to differentiate untracked and ignored when appropriate
Date:   Tue, 15 Feb 2022 23:16:15 +0100
Message-Id: <20220215221615.20683-2-patrick.marlier@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220215221615.20683-1-patrick.marlier@gmail.com>
References: <20220215221615.20683-1-patrick.marlier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 builtin/clean.c  |  4 +++-
 t/t7300-clean.sh | 24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 18b37e3fd9..1b1454d052 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -978,7 +978,9 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		remove_directories = 1;
 	}
 
-	if (remove_directories && !ignored_only) {
+	if (remove_directories && ignored && !exclude_list.nr && force > 1)
+		; /* No need to recurse to look for ignored files */
+	else if (remove_directories && !ignored_only) {
 		/*
 		 * We need to know about ignored files too:
 		 *
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 0399701e62..684eba914b 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -788,4 +788,28 @@ test_expect_success 'traverse into directories that may have ignored entries' '
 	)
 '
 
+test_expect_success 'avoid traversing into untracked directories' '
+	test_when_finished rm -f output error trace.* &&
+	test_create_repo avoid-traversing-untracked-hierarchy &&
+	(
+		cd avoid-traversing-untracked-hierarchy &&
+
+		mkdir -p untracked/subdir/with/b &&
+		mkdir -p untracked/subdir/with/a &&
+		>untracked/subdir/with/a/random-file.txt &&
+
+		GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
+		git clean -ffdx
+	) &&
+
+	# Make sure we only visited into the top-level directory, and did
+	# not traverse into the "untracked" subdirectory since it was excluded
+	grep data.*read_directo.*directories-visited trace.output |
+		cut -d "|" -f 9 >trace.relevant &&
+	cat >trace.expect <<-EOF &&
+	 ..directories-visited:1
+	EOF
+	test_cmp trace.expect trace.relevant
+'
+
 test_done
-- 
2.35.1

