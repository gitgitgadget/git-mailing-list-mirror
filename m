Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77247C77B7C
	for <git@archiver.kernel.org>; Wed, 10 May 2023 19:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbjEJTJB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 15:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEJTI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 15:08:59 -0400
X-Greylist: delayed 473 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 10 May 2023 12:08:56 PDT
Received: from mx-out1.startmail.com (mx-out1.startmail.com [145.131.90.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F6C30D6
        for <git@vger.kernel.org>; Wed, 10 May 2023 12:08:56 -0700 (PDT)
From:   Toon Claes <toon@iotcl.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2020-07; t=1683745263;
        bh=xP65Dk94iR3lHgfE+oZcucGTTiZD7WSYNPot6cWyOno=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         Mime-Version:Content-Transfer-Encoding:From:Subject:To:Date:Sender:
         Content-Type:Content-Transfer-Encoding:Content-Disposition:
         Mime-Version:Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
        b=BRMIMHlTKMH3sPQCQ2iA54RVll9PadCFO7lR/Ohm1nNOT0Br+ajYXAMRG/Jf1kduM
         glNZoXGg3CpzlJWt2wqMZBphFKNFlfaQmSFpzcpqcs7pHApkqlOLNWDmd8nQKmfRfJ
         fK4Q4fFjHX1OWqIYxFmoU3ZD4w6p6WxdSNrtq0Cb5HZiX3YB5jKcyTzI8kvbFxu/Kf
         NtejM1Q/UrjuSS4zGax2/6PgsLNchKXC1NbxohgmXlelniWc45mwLB6t9cCKSHMeIW
         J1S10ASHUu0D256yf9qtcbgrvFJwiXVdczKz8hh9c3hRyMmipWYRHVAlbjwrME+nEb
         J+DzpJfZNzdSA==
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Toon Claes <toon@iotcl.com>
Subject: [PATCH v5 1/1] cat-file: quote-format name in error when using -z
Date:   Wed, 10 May 2023 21:01:16 +0200
Message-Id: <20230510190116.795641-2-toon@iotcl.com>
In-Reply-To: <20230510190116.795641-1-toon@iotcl.com>
References: <xmqqilfhctrr.fsf@gitster.g>
 <20230510190116.795641-1-toon@iotcl.com>
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
 t/t1006-cat-file.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 0bafc14e6c..0ff31c4593 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -25,6 +25,7 @@
 #include "object-store.h"
 #include "replace-object.h"
 #include "promisor-remote.h"
+#include "quote.h"
 #include "mailmap.h"
 #include "write-or-die.h"
 
@@ -470,8 +471,17 @@ static void batch_object_write(const char *obj_name,
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
@@ -518,6 +528,13 @@ static void batch_one_object(const char *obj_name,
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
@@ -542,6 +559,8 @@ static void batch_one_object(const char *obj_name,
 			       result);
 			break;
 		}
+
+		strbuf_release(&quoted);
 		fflush(stdout);
 		return;
 	}
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 8eac74b59c..03c1bfb86b 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -447,6 +447,33 @@ test_expect_success FUNNYNAMES '--batch-check, -z with newline in input' '
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
+test_expect_success FUNNYNAMES '--batch-check, -z with missing object having newline in name' '
+	git init missing-object-newline &&
+	(
+		cd missing-object-newline &&
+		file="newline${LF}embedded" &&
+		echo_without_newline "hello" > $file &&
+		git add "$file" &&
+		git commit -m "file with newline embedded" &&
+		test_tick &&
+
+		sha1=$(git rev-parse HEAD:"$file") &&
+		rm .git/objects/$(test_oid_to_path $sha1) &&
+		printf "HEAD:$file" >in &&
+		git cat-file --batch-check -z <in >actual &&
+		printf "\"HEAD:newline\\\\nembedded\" missing\n" >expect &&
+		test_cmp expect actual
+	)
+'
+
 batch_command_multiple_info="info $hello_sha1
 info $tree_sha1
 info $commit_sha1
-- 
2.40.1

