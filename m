Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D10120248
	for <e@80x24.org>; Fri, 22 Feb 2019 16:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfBVQGM (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 11:06:12 -0500
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:35512
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727224AbfBVQFr (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 22 Feb 2019 11:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1550851545;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=89QMed43/Ml1C85s+0LQkxF2zqNx5ArbMGlaF6s1Uoo=;
        b=NSJ+MzB3SOnMvpbGjmwRYvTiA2p4bbxx2cx3fz2vMfU07RrAn+rCqj/tuAGnuYl4
        mwpZVH+PkEVyotRZ+GNw7NTAtg612dDUmhpRi1K1fD6H1Girl1M640jSQFFI3Q6LTsv
        hY/LbQk4OEaUu8zISloSpnOEv/ycNnGwSQm1aCaE=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016915f49a52-284c872e-17ab-4bfb-befd-2720b48fcbbe-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
References: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC 07/20] cat-file: remove skip_object_info
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 22 Feb 2019 16:05:45 +0000
X-SES-Outgoing: 2019.02.22-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Get rid of skip_object_info field in struct expand_data.
expand_data may be global further as we use it in ref-filter also,
so we need to remove cat-file specific fields from it.

All globals that I add through this patch will be deleted in the end,
so treat it just as the middle step.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 builtin/cat-file.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 9bcb02fad1f0d..f6470380f55b3 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -29,8 +29,9 @@ struct batch_options {
 };
 
 static const char *force_path;
-/* Will be deleted at the end of this patch */
+/* Next 2 vars will be deleted at the end of this patch */
 static int mark_query;
+static int skip_object_info;
 
 static int filter_object(const char *path, unsigned mode,
 			 const struct object_id *oid,
@@ -205,13 +206,6 @@ struct expand_data {
 	 * elements above, so you can retrieve the response from there.
 	 */
 	struct object_info info;
-
-	/*
-	 * This flag will be true if the requested batch format and options
-	 * don't require us to call oid_object_info, which can then be
-	 * optimized out.
-	 */
-	unsigned skip_object_info : 1;
 };
 
 static int is_atom(const char *atom, const char *s, int slen)
@@ -343,7 +337,7 @@ static void batch_object_write(const char *obj_name,
 			       struct batch_options *opt,
 			       struct expand_data *data)
 {
-	if (!data->skip_object_info &&
+	if (!skip_object_info &&
 	    oid_object_info_extended(the_repository, &data->oid, &data->info,
 				     OBJECT_INFO_LOOKUP_REPLACE) < 0) {
 		printf("%s missing\n",
@@ -494,7 +488,7 @@ static int batch_objects(struct batch_options *opt)
 	if (opt->all_objects) {
 		struct object_info empty = OBJECT_INFO_INIT;
 		if (!memcmp(&data.info, &empty, sizeof(empty)))
-			data.skip_object_info = 1;
+			skip_object_info = 1;
 	}
 
 	/*

--
https://github.com/git/git/pull/568
