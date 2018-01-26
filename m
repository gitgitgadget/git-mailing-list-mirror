Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFF151F404
	for <e@80x24.org>; Fri, 26 Jan 2018 19:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751885AbeAZToc (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 14:44:32 -0500
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:38310
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752089AbeAZTnl (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 26 Jan 2018 14:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1516995820;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=/Y5+p1nQYjpV3SMNXVYXDWAl3F2CIXC7Z3AzOckLDlk=;
        b=CuP73XC9LatGV1Xxj3XN8cyLDvJiIHewEtx0XXTyesmxsFHb8EF/5QWeDAEFnqqr
        9VIKXfjJmetGi8LOWfPSTzNh3ffzsMehWKyK0UwBR5UfhJWY8Nmhey0cR5TDzL/42CM
        Pqr8zp8+4FDOCYav5pgcgpuFNp3A4JeSTxjzvnVc=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016133ff3b41-c77d5053-8546-4b12-831e-135f3025a2ea-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
References: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC 15/24] cat-file: move skip_object_info into ref-filter
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 26 Jan 2018 19:43:40 +0000
X-SES-Outgoing: 2018.01.26-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move logic related to skip_object_info into ref-filter,
so that cat-file does not use that field at all.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c | 7 +------
 ref-filter.c       | 5 +++++
 ref-filter.h       | 1 +
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 601a87d9b5f7c..3a52c551f366a 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -394,14 +394,9 @@ static int batch_objects(struct batch_options *opt)
 	memset(&data, 0, sizeof(data));
 	opt->format.cat_file_data = &data;
 	opt->format.is_cat = 1;
+	opt->format.all_objects = opt->all_objects;
 	verify_ref_format(&opt->format);
 
-	if (opt->all_objects) {
-		struct object_info empty = OBJECT_INFO_INIT;
-		if (!memcmp(&data.info, &empty, sizeof(empty)))
-			data.skip_object_info = 1;
-	}
-
 	/*
 	 * If we are printing out the object, then always fill in the type,
 	 * since we will want to decide whether or not to stream.
diff --git a/ref-filter.c b/ref-filter.c
index 51da76dc21136..29a1b75c93181 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -777,6 +777,11 @@ int verify_ref_format(struct ref_format *format)
 	}
 	if (format->need_color_reset_at_eol && !want_color(format->use_color))
 		format->need_color_reset_at_eol = 0;
+	if (is_cat && format->all_objects) {
+		struct object_info empty = OBJECT_INFO_INIT;
+		if (!memcmp(&cat_file_info->info, &empty, sizeof(empty)))
+			cat_file_info->skip_object_info = 1;
+	}
 	return 0;
 }
 
diff --git a/ref-filter.h b/ref-filter.h
index 276de387f3bd0..4af89c4c86bee 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -120,6 +120,7 @@ struct ref_format {
 	 */
 	struct expand_data *cat_file_data;
 	int is_cat;
+	int all_objects;
 };
 
 #define REF_FORMAT_INIT { NULL, 0, -1 }

--
https://github.com/git/git/pull/452
