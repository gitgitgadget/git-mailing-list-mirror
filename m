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
	by dcvr.yhbt.net (Postfix) with ESMTP id A50911F576
	for <e@80x24.org>; Mon,  5 Feb 2018 11:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752920AbeBEL1z (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 06:27:55 -0500
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:41056
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752710AbeBEL1k (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Feb 2018 06:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1517830059;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=aT5Sx9BLQa+8jl463FJjKh17SLq4XM8+jvaZUj+d+xc=;
        b=In7WMpGMjhqTw4Hb/QPtdc5k5QKnn2rHfac2AOvh5QUpGPUIvQX54n/XfkppeDN+
        TUMiou36bI/yV5hWDu8tmV6rL0KtAqLVJh/DDvifPeHeSEFvyvzakOGd/cTO8XI3A/b
        kPqp54j7TJUkLeMf29+ZHWIpNCgV6GwBdT+gHUO8=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016165b8b45f-26ed9dd1-3ab5-421e-b76d-cf9cf2c377b0-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016165b8b3c4-54efe4c4-6d19-435d-b5b9-6c727771353b-000000@eu-west-1.amazonses.com>
References: <0102016165b8b3c4-54efe4c4-6d19-435d-b5b9-6c727771353b-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC v2 16/25] cat-file: move skip_object_info into
 ref-filter
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 5 Feb 2018 11:27:39 +0000
X-SES-Outgoing: 2018.02.05-54.240.7.18
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
index a55138f1fd1d1..37adf626d0e55 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -395,14 +395,9 @@ static int batch_objects(struct batch_options *opt)
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
index bbcd507d179a9..7dcd36cd2cddc 100644
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
index f590e5d694df4..e882eb5126118 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -119,6 +119,7 @@ struct ref_format {
 	 */
 	struct expand_data *cat_file_data;
 	int is_cat;
+	int all_objects;
 };
 
 #define REF_FORMAT_INIT { NULL, 0, -1 }

--
https://github.com/git/git/pull/452
