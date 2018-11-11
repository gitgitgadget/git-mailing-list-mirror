Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 854F81F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 06:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbeKKQLF (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 11:11:05 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37713 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbeKKQLF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 11:11:05 -0500
Received: by mail-oi1-f193.google.com with SMTP id w66-v6so4762579oiw.4
        for <git@vger.kernel.org>; Sat, 10 Nov 2018 22:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mms0aOjmTokxH/YVZ6NrGkicGMnzSg9TGErNjQ0QdY8=;
        b=eT90vv5fK9c7PFFrpuCXx4K6B6GZWhqBZ4cfYGw8Bxa9zaQXQ8zqTp5zcbk5zo1xZ7
         VCqyzkHMkSYO50+3QpzkAiSW8csLdskw6yXXKgX5WV9xLpcD7rA7aPRoAxebygaMSHd6
         1X8yAXOND4XOxJd6I8s8ju16+2NmTtkNUY3jmKGRgZXmS01kKllcushc7ueSY9jiRaIc
         DEZiarUEoxb/6xcSt0JZW9s1pHiAU9w03bvgi+xrqZLKJX3j5/mgSECyIZEBTvSoRkqg
         kjDWE39rZIt9NxbUaQP3iwOcNCFwbq2P0L1AX5FoMQCsMxoHzigMNRsQpidDeyi+IiYa
         e4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mms0aOjmTokxH/YVZ6NrGkicGMnzSg9TGErNjQ0QdY8=;
        b=eYHjvPtFbfrZufQ3hPphiTZ/oUZX1fmf9xmc1eA+C650lDgYGCep/liCkvAfWsS7Fx
         cqIfTEo434SWSTXKk5NNSO1JYYE8a0XKnpwmu4kiEaV3kcHVIX25Fwk1IigK+Y2sQW8u
         zQVTiXiFpr5gz0hMj+J9+naMj8EPufTlTcvq7EwlyRB+8GdUJ96XACS98D0XqUYoO1Mm
         LrdPmbytuc16sDTitRvhk13LHUH46TDaPlRtw37u7DtsGH7OjBI67ufF84BK0AD3hwVK
         KX6Kv7Tt7H1Nw5+E7GihvfXgXQJSoTBtJFUqzchi2wTQvAbZDQHp0iLLCmzUH8Jnrrdu
         wQGg==
X-Gm-Message-State: AGRZ1gJjSX/WrlPVXN5P/ufT2KEwSDGHsU/wNRSeH8NaqSZEci0ZZTAL
        k3W2W81IjqKp7xEl4ywYJYOzug44
X-Google-Smtp-Source: AJdET5cZMDIGua/GX0DCMb7DF++wamOzLStBt0qBKZ2Sx/BpI97IGSGFsdlX7WKYw+VS59eKdhlPJg==
X-Received: by 2002:aca:e607:: with SMTP id d7-v6mr8135977oih.68.1541917406487;
        Sat, 10 Nov 2018 22:23:26 -0800 (PST)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id f34sm1286855otb.25.2018.11.10.22.23.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 10 Nov 2018 22:23:26 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     larsxschneider@gmail.com, sandals@crustytoothpaste.net,
        peff@peff.net, me@ttaylorr.com, jrnieder@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 06/10] fast-export: when using paths, avoid corrupt stream with non-existent mark
Date:   Sat, 10 Nov 2018 22:23:08 -0800
Message-Id: <20181111062312.16342-7-newren@gmail.com>
X-Mailer: git-send-email 2.19.1.866.g82735bcbde
In-Reply-To: <20181111062312.16342-1-newren@gmail.com>
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If file paths are specified to fast-export and multiple refs point to a
commit that does not touch any of the relevant file paths, then
fast-export can hit problems.  fast-export has a list of additional refs
that it needs to explicitly set after exporting all blobs and commits,
and when it tries to get_object_mark() on the relevant commit, it can
get a mark of 0, i.e. "not found", because the commit in question did
not touch the relevant paths and thus was not exported.  Trying to
import a stream with a mark corresponding to an unexported object will
cause fast-import to crash.

Avoid this problem by taking the commit the ref points to and finding an
ancestor of it that was exported, and make the ref point to that commit
instead.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/fast-export.c  | 13 ++++++++++++-
 t/t9350-fast-export.sh | 24 ++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index a3c044b0af..5648a8ce9c 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -900,7 +900,18 @@ static void handle_tags_and_duplicates(void)
 			if (anonymize)
 				name = anonymize_refname(name);
 			/* create refs pointing to already seen commits */
-			commit = (struct commit *)object;
+			commit = rewrite_commit((struct commit *)object);
+			if (!commit) {
+				/*
+				 * Neither this object nor any of its
+				 * ancestors touch any relevant paths, so
+				 * it has been filtered to nothing.  Delete
+				 * it.
+				 */
+				printf("reset %s\nfrom %s\n\n",
+				       name, sha1_to_hex(null_sha1));
+				continue;
+			}
 			printf("reset %s\nfrom :%d\n\n", name,
 			       get_object_mark(&commit->object));
 			show_progress();
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 5bf21b4908..dbb560c110 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -386,6 +386,30 @@ test_expect_success 'path limiting with import-marks does not lose unmodified fi
 	grep file0 actual
 '
 
+test_expect_success 'avoid corrupt stream with non-existent mark' '
+	test_create_repo avoid_non_existent_mark &&
+	(
+		cd avoid_non_existent_mark &&
+
+		touch important-path &&
+		git add important-path &&
+		test_commit initial &&
+
+		touch ignored &&
+		git add ignored &&
+		test_commit whatever &&
+
+		git branch A &&
+		git branch B &&
+
+		echo foo >>important-path &&
+		git add important-path &&
+		test_commit more changes &&
+
+		git fast-export --all -- important-path | git fast-import --force
+	)
+'
+
 test_expect_success 'full-tree re-shows unmodified files'        '
 	git checkout -f simple &&
 	git fast-export --full-tree simple >actual &&
-- 
2.19.1.866.g82735bcbde

