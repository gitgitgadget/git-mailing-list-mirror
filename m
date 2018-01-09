Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A4051F406
	for <e@80x24.org>; Tue,  9 Jan 2018 13:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757150AbeAINFv (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 08:05:51 -0500
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:49110
        "EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757021AbeAINFZ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Jan 2018 08:05:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1515503124;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=lWlBsE7mOlv6/YV1eS1ASIGK8wVfLFzke4bmLfoflMg=;
        b=OVpnGv4bLc0drIpdXrqVEXpIr1KxCst2hSNBhEYIwvCqzngU8kZs8w8yAQPih9Vm
        avsID6BIrI2llrEvdBwD98+CNQbrZ7bijki5jfPDXRUSFg/yHctgVWd1WDHIGMGBPUV
        GXTig/h6tG6kz0nARIiNhi/UrvpSdkpLpgSEC5U4=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020160db067c8a-c3ce9582-bc4d-40fd-ac96-b530f93b2752-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020160db0679c9-799a0bc4-b6d1-43e2-ad3b-80be4e4c55e9-000000@eu-west-1.amazonses.com>
References: <01020160db0679c9-799a0bc4-b6d1-43e2-ad3b-80be4e4c55e9-000000@eu-west-1.amazonses.com>
Subject: [PATCH 19/20] cat-file: move skip_object_info into ref-filter
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 9 Jan 2018 13:05:23 +0000
X-SES-Outgoing: 2018.01.09-54.240.7.12
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
index 5aac10b9808ff..19cee0d22fabe 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -395,16 +395,11 @@ static int batch_objects(struct batch_options *opt)
 	opt->format->cat_file_data = &data;
 	opt->format->is_cat = 1;
 	opt->format->split_on_whitespace = &data.split_on_whitespace;
+	opt->format->all_objects = opt->all_objects;
 	verify_ref_format(opt->format);
 	if (opt->cmdmode)
 		data.split_on_whitespace = 1;
 
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
index ee27edb2dad56..dbca6856432c0 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -766,6 +766,11 @@ int verify_ref_format(struct ref_format *format)
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
index 3228661414623..7f7b17e659241 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -128,6 +128,7 @@ struct ref_format {
 	struct expand_data *cat_file_data;
 	int is_cat;
 	int *split_on_whitespace;
+	int all_objects;
 };
 
 #define REF_FORMAT_INIT { NULL, 0, -1 }

--
https://github.com/git/git/pull/450
