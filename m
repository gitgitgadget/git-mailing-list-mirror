Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E120AC64EC4
	for <git@archiver.kernel.org>; Fri,  3 Mar 2023 19:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjCCTWr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 14:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjCCTWp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 14:22:45 -0500
Received: from mx-out2.startmail.com (mx-out2.startmail.com [145.131.90.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF405ADD9
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 11:22:44 -0800 (PST)
From:   Toon Claes <toon@iotcl.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2020-07; t=1677871038;
        bh=Cns2liA8MN5AiKMvdPTJo4uYorDw/enfpm5LnryDESc=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         Mime-Version:Content-Transfer-Encoding:From:Subject:To:Date:Sender:
         Content-Type:Content-Transfer-Encoding:Content-Disposition:
         Mime-Version:Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
        b=fHergXtK5IFG1gzCeKakjlb1T2t+nkWPIWxO1/HHR3PX6O8Nx79zhjVgJVvVUjG9z
         7UZk6Yhe6N0Qc/8czEd4qdsKKI9xZsuEa8b/Px9i4BwOCCtazLhcvIaQOn5b5AxA0f
         dsHRxlJm7iWlHMh78r7oRGEU+FQuFGUhYiy1uV2iP8aDDX54dEEwWJLKTIXSG3AdmS
         AT3U98cr/AdbLcyCvSWCF++iEFXFDC1ULvLd9W0IOfpit7goG4fkQ03QsLB65Z76dw
         ZU2dUXsRk4G52BEQfNNvSVEZakNxaYVOzu01DIBd8Y7FqW1a01KX1b9R8lnJW0FPhP
         96K4vKzRl+WTA==
To:     toon@iotcl.com
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com
Subject: [PATCH v4 1/2] cat-file: extract printing batch error message into function
Date:   Fri,  3 Mar 2023 20:17:07 +0100
Message-Id: <20230303191708.77894-2-toon@iotcl.com>
In-Reply-To: <20230303191708.77894-1-toon@iotcl.com>
References: <20230116190749.4141516-1-toon@iotcl.com>
 <20230303191708.77894-1-toon@iotcl.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are two callsites that were formatting an error message in batch
mode if an object could not be found. We're about to make changes to
that and to avoid doing that twice, we extract this into a separate
function.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 builtin/cat-file.c | 61 +++++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index cc17635e76..0c47190f17 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -429,6 +429,37 @@ static void print_default_format(struct strbuf *scratch, struct expand_data *dat
 		    (uintmax_t)data->size);
 }
 
+static void batch_print_error(const char *obj_name,
+			      enum get_oid_result result,
+			      struct batch_options* opt)
+{
+		switch (result) {
+		case MISSING_OBJECT:
+			printf("%s missing\n", obj_name);
+			break;
+		case SHORT_NAME_AMBIGUOUS:
+			printf("%s ambiguous\n", obj_name);
+			break;
+		case DANGLING_SYMLINK:
+			printf("dangling %"PRIuMAX"\n%s\n",
+			       (uintmax_t)strlen(obj_name), obj_name);
+			break;
+		case SYMLINK_LOOP:
+			printf("loop %"PRIuMAX"\n%s\n",
+			       (uintmax_t)strlen(obj_name), obj_name);
+			break;
+		case NOT_DIR:
+			printf("notdir %"PRIuMAX"\n%s\n",
+			       (uintmax_t)strlen(obj_name), obj_name);
+			break;
+		default:
+			BUG("unknown get_sha1_with_context result %d\n",
+			       result);
+			break;
+		}
+		fflush(stdout);
+}
+
 /*
  * If "pack" is non-NULL, then "offset" is the byte offset within the pack from
  * which the object may be accessed (though note that we may also rely on
@@ -455,9 +486,7 @@ static void batch_object_write(const char *obj_name,
 						       &data->oid, &data->info,
 						       OBJECT_INFO_LOOKUP_REPLACE);
 		if (ret < 0) {
-			printf("%s missing\n",
-			       obj_name ? obj_name : oid_to_hex(&data->oid));
-			fflush(stdout);
+			batch_print_error(obj_name, MISSING_OBJECT, opt);
 			return;
 		}
 
@@ -503,31 +532,7 @@ static void batch_one_object(const char *obj_name,
 	result = get_oid_with_context(the_repository, obj_name,
 				      flags, &data->oid, &ctx);
 	if (result != FOUND) {
-		switch (result) {
-		case MISSING_OBJECT:
-			printf("%s missing\n", obj_name);
-			break;
-		case SHORT_NAME_AMBIGUOUS:
-			printf("%s ambiguous\n", obj_name);
-			break;
-		case DANGLING_SYMLINK:
-			printf("dangling %"PRIuMAX"\n%s\n",
-			       (uintmax_t)strlen(obj_name), obj_name);
-			break;
-		case SYMLINK_LOOP:
-			printf("loop %"PRIuMAX"\n%s\n",
-			       (uintmax_t)strlen(obj_name), obj_name);
-			break;
-		case NOT_DIR:
-			printf("notdir %"PRIuMAX"\n%s\n",
-			       (uintmax_t)strlen(obj_name), obj_name);
-			break;
-		default:
-			BUG("unknown get_sha1_with_context result %d\n",
-			       result);
-			break;
-		}
-		fflush(stdout);
+		batch_print_error(obj_name, result, opt);
 		return;
 	}
 
-- 
2.39.2

