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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3137A1F576
	for <e@80x24.org>; Mon, 12 Feb 2018 08:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933031AbeBLIJm (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 03:09:42 -0500
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:51920
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932991AbeBLIIz (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Feb 2018 03:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1518422934;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=N1UX0JGU4JMUCW9wJmjjvUMsGJfJvE2WDaDgjfPeO9w=;
        b=YSeNXsjzAqeLAeV/LUpFSYt+wcY3GihZmHrWmrGVsTOpdIu0gWhrRloRYy3q+oqN
        VWAOJuMLpcqdJIEBjiLJhMCMPQt+eNcr3cj1/6qlN7ZMY0e4IEYdFXOJpKJ028FwWok
        Az1AgaCqeQDqc3cxVBI39HRPbirem7OETRyxIIYA=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020161890f435c-80fa0ef3-afaf-45b7-84a7-28e2bb66f320-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
Subject: [PATCH v3 15/23] cat-file: move skip_object_info into ref-filter
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 12 Feb 2018 08:08:54 +0000
X-SES-Outgoing: 2018.02.12-54.240.7.20
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
index 3a49b55a1cc2e..582679f3dca2c 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -393,14 +393,9 @@ static int batch_objects(struct batch_options *opt)
 	 */
 	memset(&data, 0, sizeof(data));
 	opt->format.cat_file_data = &data;
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
index 4adeea6aad0da..104cd6aef0102 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -775,6 +775,11 @@ int verify_ref_format(struct ref_format *format)
 	}
 	if (format->need_color_reset_at_eol && !want_color(format->use_color))
 		format->need_color_reset_at_eol = 0;
+	if (cat_file_info && format->all_objects) {
+		struct object_info empty = OBJECT_INFO_INIT;
+		if (!memcmp(&cat_file_info->info, &empty, sizeof(empty)))
+			cat_file_info->skip_object_info = 1;
+	}
 	return 0;
 }
 
diff --git a/ref-filter.h b/ref-filter.h
index fffc443726e28..b1c668c12428b 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -118,6 +118,7 @@ struct ref_format {
 	 * hopefully would be reduced later.
 	 */
 	struct expand_data *cat_file_data;
+	unsigned all_objects : 1;
 };
 
 #define REF_FORMAT_INIT { NULL, 0, -1 }

--
https://github.com/git/git/pull/452
