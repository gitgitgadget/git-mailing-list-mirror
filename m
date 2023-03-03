Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EC9C64EC4
	for <git@archiver.kernel.org>; Fri,  3 Mar 2023 19:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjCCTWq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 14:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjCCTWo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 14:22:44 -0500
X-Greylist: delayed 327 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Mar 2023 11:22:43 PST
Received: from mx-out2.startmail.com (mx-out2.startmail.com [145.131.90.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B195ADD8
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 11:22:43 -0800 (PST)
From:   Toon Claes <toon@iotcl.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2020-07; t=1677871040;
        bh=hIDQw1H7lV/pXkcLa0u/UxjBowSecvoHiQDR3PK+YG4=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         Mime-Version:Content-Transfer-Encoding:From:Subject:To:Date:Sender:
         Content-Type:Content-Transfer-Encoding:Content-Disposition:
         Mime-Version:Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
        b=tMjkYTO3Rv+d7WOClXXLnP79EaFE4wzMI/jkoe9SnjuixGgl5Wyf/m62nQ5J0VzF1
         4fbF+AHTcCNFp0+kwpn3tEsv/quXDfnlDpRg3tvgqf8CLtmm2zX7muhGgKwlQbIMOV
         aSfsuB/zB6dpSZqs21v6EOP5WG2AUsm6dfpPNWbMeT5QkTuyNEPMvUPlsbML0sdF6Y
         cuBriw67xsFYs0XFjuE5Y3r6XZIgof569e2Kj/+eXAULTP8szZSQqkDvh4xc12NMq1
         ///gwQ9MmSFM4DrSB/SI2tV348KGtC5QHXKuxLzcNlnY41QIQNWAkVBHqEZP3MxFID
         0TVZl7QwhbrJA==
To:     toon@iotcl.com
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com
Subject: [PATCH v4 2/2] cat-file: quote-format name in error when using -z
Date:   Fri,  3 Mar 2023 20:17:08 +0100
Message-Id: <20230303191708.77894-3-toon@iotcl.com>
In-Reply-To: <20230303191708.77894-1-toon@iotcl.com>
References: <20230116190749.4141516-1-toon@iotcl.com>
 <20230303191708.77894-1-toon@iotcl.com>
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
 builtin/cat-file.c  | 10 ++++++++++
 t/t1006-cat-file.sh |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 0c47190f17..e0c7bfaa56 100644
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
@@ -433,6 +434,14 @@ static void batch_print_error(const char *obj_name,
 			      enum get_oid_result result,
 			      struct batch_options* opt)
 {
+		struct strbuf quoted = STRBUF_INIT;
+
+		if (opt->nul_terminated &&
+		    obj_name) {
+			quote_c_style(obj_name, &quoted, NULL, 0);
+			obj_name = quoted.buf;
+		}
+
 		switch (result) {
 		case MISSING_OBJECT:
 			printf("%s missing\n", obj_name);
@@ -458,6 +467,7 @@ static void batch_print_error(const char *obj_name,
 			break;
 		}
 		fflush(stdout);
+		strbuf_release(&quoted);
 }
 
 /*
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 2d875b17d8..6ac3881305 100755
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
2.39.2

