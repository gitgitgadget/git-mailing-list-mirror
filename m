Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DB8C4332F
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 15:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiLIPKf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Dec 2022 10:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiLIPJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2022 10:09:57 -0500
Received: from mx-out1.startmail.com (mx-out1.startmail.com [145.131.90.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5028CDF71
        for <git@vger.kernel.org>; Fri,  9 Dec 2022 07:09:48 -0800 (PST)
From:   Toon Claes <toon@iotcl.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2020-07; t=1670598055;
        bh=6IJ4HUeb9FmuNbWUnj3P6vEA53igOFHIiFohuhz22oo=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         Mime-Version:Content-Transfer-Encoding:From:Subject:To:Date:Sender:
         Content-Type:Content-Transfer-Encoding:Content-Disposition:
         Mime-Version:Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
        b=omvmQAh6hm0gNE5cuAV1WAN4CWNkiYi/CZ4gohp8yYPGrydthTwXZd9xolHYv9gse
         QlFHf1dXOv+6QwJOc20xa4OMRBDSr5RCp9Uohz4JMrvtj5z3f370qkQZS3yGY5LNXa
         lmPU1w8UFbkmCqiuOoQXNuLmxcSaRXQKOedUtHsSvegouYMs5u+w3WSbbYjLATpulP
         xpcLhUx/mujArpshJb3OD4Jj0oPAvIlxFEFqqNMx+9WkshJeVYRHHuG20dXJ6sqtps
         dl6HwqHVheRu9NgaP83WATkNs3nSYIag4i0TpYGC3rf+pc85w21zPg2PM3JKmUuheP
         tosl0abpOKYOQ==
To:     git@vger.kernel.org
Cc:     Toon Claes <toon@iotcl.com>
Subject: [PATCH 1/1] cat-file: quote-format name in error when using -z
Date:   Fri,  9 Dec 2022 16:00:48 +0100
Message-Id: <20221209150048.2400648-2-toon@iotcl.com>
In-Reply-To: <20221209150048.2400648-1-toon@iotcl.com>
References: <20221209150048.2400648-1-toon@iotcl.com>
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
index b3be58b1fb..67dd81238d 100644
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
@@ -475,6 +476,13 @@ static void batch_one_object(const char *obj_name,
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
@@ -499,6 +507,8 @@ static void batch_one_object(const char *obj_name,
 			       result);
 			break;
 		}
+
+		strbuf_release(&quoted);
 		fflush(stdout);
 		return;
 	}
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 23b8942edb..232bfd1723 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -447,6 +447,14 @@ test_expect_success FUNNYNAMES '--batch-check, -z with newline in input' '
 	test_cmp expect actual
 '

+test_expect_success FUNNYNAMES '--batch-check, -z with newline in non-existent named object' '
+	printf "HEAD:newline${LF}embedded" >in &&
+	git cat-file --batch-check -z <in >actual &&
+
+	printf "\"HEAD:newline\\\\nembedded\" missing\n" >expect &&
+	test_cmp expect actual
+'
+
 batch_command_multiple_info="info $hello_sha1
 info $tree_sha1
 info $commit_sha1
--
2.39.0.rc0.57
