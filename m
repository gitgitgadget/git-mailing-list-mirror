Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF42C46467
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 19:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjAPTIF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 14:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjAPTID (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 14:08:03 -0500
Received: from mx-out1.startmail.com (mx-out1.startmail.com [145.131.90.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A65D274BF
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 11:08:02 -0800 (PST)
From:   Toon Claes <toon@iotcl.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2020-07; t=1673896081;
        bh=2g/f1OsUPrxZRqWVup/kGvShit7MvugavLOu8TBOmfw=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         Mime-Version:Content-Transfer-Encoding:From:Subject:To:Date:Sender:
         Content-Type:Content-Transfer-Encoding:Content-Disposition:
         Mime-Version:Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
        b=C4SULXHguvkXCMyi0OkZG+1iQI+0PgIbFU5E612Zme3LhHG7Y4G47bbq7XHEOhNT2
         72tKLJKQL+uRzddo8278ATGh14O4Ac9tYU5gNcMOCRfc0IW+4nCC0SwBE+P1fXmY3R
         egUkmw29lar6UHENxWQzchMaptUDv39Rc8fTqfXBKDakRaJYiaLgcV5hAQEPsAiOtZ
         CKiaebJiKAZgeHccUkCSgrDLpfpvLFlh2t74OB1AumLIXb0GCF0GgJcWB2nh1KNWgz
         B9mx/YTkun84CAEZ8O/EcYXKgwKzo3FmUmm9FU5BvFrwvQ34ACsMj68Po6PXTontmz
         a1rJBqFRmEl3g==
To:     git@vger.kernel.org
Cc:     Toon Claes <toon@iotcl.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 1/1] cat-file: quote-format name in error when using -z
Date:   Mon, 16 Jan 2023 20:07:49 +0100
Message-Id: <20230116190749.4141516-2-toon@iotcl.com>
In-Reply-To: <20230116190749.4141516-1-toon@iotcl.com>
References: <20230105062447.2943709-1-toon@iotcl.com>
 <20230116190749.4141516-1-toon@iotcl.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since it's supported to have NUL-delimited input, introduced in
db9d67f2e9 (builtin/cat-file.c: support NUL-delimited input with `-z`,
2022-07-22), it's possible to pass paths that contain newlines. This
works great when the object is found, but when it's not, the input path
is returned in the error message. Because this can contain newlines, the
error message might get spread over multiple lines, making it harder to
machine-parse this error message.

With this change, the input is quote-formatted in the error message, if
needed. This ensures the error message is always on a single line and
makes parsing the error more straightforward.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 builtin/cat-file.c  | 19 +++++++++++++++++++
 t/t1006-cat-file.sh |  8 ++++++++
 2 files changed, 27 insertions(+)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index cc17635e76..b678f69773 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -14,6 +14,7 @@
 #include "tree-walk.h"
 #include "oid-array.h"
 #include "packfile.h"
+#include "quote.h"
 #include "object-store.h"
 #include "promisor-remote.h"
 #include "mailmap.h"
@@ -455,8 +456,17 @@ static void batch_object_write(const char *obj_name,
 						       &data->oid, &data->info,
 						       OBJECT_INFO_LOOKUP_REPLACE);
 		if (ret < 0) {
+			struct strbuf quoted = STRBUF_INIT;
+
+			if (opt->nul_terminated &&
+			    obj_name) {
+				quote_c_style(obj_name, &quoted, NULL, 0);
+				obj_name = quoted.buf;
+			}
+
 			printf("%s missing\n",
 			       obj_name ? obj_name : oid_to_hex(&data->oid));
+			strbuf_release(&quoted);
 			fflush(stdout);
 			return;
 		}
@@ -503,6 +513,13 @@ static void batch_one_object(const char *obj_name,
 	result = get_oid_with_context(the_repository, obj_name,
 				      flags, &data->oid, &ctx);
 	if (result != FOUND) {
+		struct strbuf quoted = STRBUF_INIT;
+
+		if (opt->nul_terminated) {
+			quote_c_style(obj_name, &quoted, NULL, 0);
+			obj_name = quoted.buf;
+		}
+
 		switch (result) {
 		case MISSING_OBJECT:
 			printf("%s missing\n", obj_name);
@@ -527,6 +544,8 @@ static void batch_one_object(const char *obj_name,
 			       result);
 			break;
 		}
+
+		strbuf_release(&quoted);
 		fflush(stdout);
 		return;
 	}
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 23b8942edb..e8ce20e739 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -447,6 +447,14 @@ test_expect_success FUNNYNAMES '--batch-check, -z with newline in input' '
 	test_cmp expect actual
 '

+test_expect_success '--batch-check, -z with newline in non-existent named object' '
+	printf "HEAD:newline${LF}missing" >in &&
+	git cat-file --batch-check -z <in >actual &&
+
+	printf "\"HEAD:newline\\\\nmissing\" missing\n" >expect &&
+	test_cmp expect actual
+'
+
 batch_command_multiple_info="info $hello_sha1
 info $tree_sha1
 info $commit_sha1
--
2.39.0.rc0.57.g2e71cbbddd.dirty
