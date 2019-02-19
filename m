Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47C8C1F453
	for <e@80x24.org>; Tue, 19 Feb 2019 00:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732221AbfBSAF7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 19:05:59 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34666 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730731AbfBSAF5 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 19:05:57 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A8B2761095;
        Tue, 19 Feb 2019 00:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550534756;
        bh=lNVGjphXf1N6F7gp4i2Z6PY7qjptJoa2PRQAHWh8M88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Li0k1ULQ77O2KX0uIgXJsNLwQN5VbHsSYn/GpzAcnpYS9VMGuTSTKVcC7MioRslr1
         riGPwTbKx5mH+nmPUY2oG8Hldkvd+t5D31s6sqU9EiKhoLjMBdkYZpQ7k+omY/b9VI
         vfZ1HXd30e0w6qn6VuUc33QtV88AR+oepZV5TmCuF9agz6gJVyxH2gRYI6jdrPP7fv
         7eaAcVCKgzI9/UEEzsPsP4zwumPLIWk8RPxg9rASysGnhd9eGIozcJyTVFM43GFXdr
         D1t8Q7BpYowAlPoGJg3UxE+J6OidU3RUx1+hap4QOOg3xqCCTM7LMOC50h8tI6EKLQ
         6EX8J377dx2kJZ+KTY1d82AevZhywc2IMmHpcM8tb9T5d5Qxm6SYp+WTOnFiotZVj4
         TazVwedYWfGOEG/VPak/pCYOgudQMy52Eb9ktVOYotEQMtAL8LkLlDI6ZOKa7uXoeN
         nr3W8MiomhSQs+Yb0XNRtuc1jtpgqfBHyBjP9PfjCXBEaJIcVjJ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 17/35] builtin/pull: make hash-size independent
Date:   Tue, 19 Feb 2019 00:05:08 +0000
Message-Id: <20190219000526.476553-18-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e
In-Reply-To: <20190219000526.476553-1-sandals@crustytoothpaste.net>
References: <20190219000526.476553-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using get_oid_hex and GIT_SHA1_HEXSZ, use parse_oid_hex to
avoid the need for a constant and simplify the code.

Additionally, fix some comments to refer to object IDs instead of SHA-1
and update a constant used to provide an allocation hint.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/pull.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 701d1473dc..0f63207891 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -365,9 +365,10 @@ static void get_merge_heads(struct oid_array *merge_heads)
 
 	fp = xfopen(filename, "r");
 	while (strbuf_getline_lf(&sb, fp) != EOF) {
-		if (get_oid_hex(sb.buf, &oid))
-			continue;  /* invalid line: does not start with SHA1 */
-		if (starts_with(sb.buf + GIT_SHA1_HEXSZ, "\tnot-for-merge\t"))
+		const char *p;
+		if (parse_oid_hex(sb.buf, &oid, &p))
+			continue;  /* invalid line: does not start with object ID */
+		if (starts_with(p, "\tnot-for-merge\t"))
 			continue;  /* ref is not-for-merge */
 		oid_array_append(merge_heads, &oid);
 	}
@@ -756,7 +757,7 @@ static int get_rebase_fork_point(struct object_id *fork_point, const char *repo,
 	cp.no_stderr = 1;
 	cp.git_cmd = 1;
 
-	ret = capture_command(&cp, &sb, GIT_SHA1_HEXSZ);
+	ret = capture_command(&cp, &sb, GIT_MAX_HEXSZ);
 	if (ret)
 		goto cleanup;
 
@@ -801,7 +802,7 @@ static int get_octopus_merge_base(struct object_id *merge_base,
 }
 
 /**
- * Given the current HEAD SHA1, the merge head returned from git-fetch and the
+ * Given the current HEAD oid, the merge head returned from git-fetch and the
  * fork point calculated by get_rebase_fork_point(), runs git-rebase with the
  * appropriate arguments and returns its exit status.
  */
