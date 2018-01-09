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
	by dcvr.yhbt.net (Postfix) with ESMTP id EB4541F406
	for <e@80x24.org>; Tue,  9 Jan 2018 13:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757227AbeAINGL (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 08:06:11 -0500
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:38572
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756995AbeAINFZ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Jan 2018 08:05:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1515503123;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=LbrSGucQkMz2SO5TbH6Fqj9Qi23cXZNVtLDBIVD6ExU=;
        b=SG4eIogeg3Ldc1R4dQFcxSDlN45jQgBXw5wLCKGYjoUMGOuLyPi9JFI2CAe++P+e
        pTgQizLt5ScXtAg03XR0yM6nm/GSCtMghY9U0zub/3Vr5e8o8XQyv1kfpKyv8WjOO+u
        NaMPj/ZChN+Dcu4S1LBxPXzK8hCkAZ++tqnz/ZnU=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020160db067c88-f01ed048-da02-43a7-8b61-db62027911bf-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020160db0679c9-799a0bc4-b6d1-43e2-ad3b-80be4e4c55e9-000000@eu-west-1.amazonses.com>
References: <01020160db0679c9-799a0bc4-b6d1-43e2-ad3b-80be4e4c55e9-000000@eu-west-1.amazonses.com>
Subject: [PATCH 18/20] cat-file: add split_on_whitespace flag
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 9 Jan 2018 13:05:23 +0000
X-SES-Outgoing: 2018.01.09-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add flag to ref_format struct so that we could pass needed info
to cat-file.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c | 1 +
 ref-filter.c       | 4 ++--
 ref-filter.h       | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 289912ab1f858..5aac10b9808ff 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -394,6 +394,7 @@ static int batch_objects(struct batch_options *opt)
 	memset(&data, 0, sizeof(data));
 	opt->format->cat_file_data = &data;
 	opt->format->is_cat = 1;
+	opt->format->split_on_whitespace = &data.split_on_whitespace;
 	verify_ref_format(opt->format);
 	if (opt->cmdmode)
 		data.split_on_whitespace = 1;
diff --git a/ref-filter.c b/ref-filter.c
index 4259c9b9cd767..ee27edb2dad56 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -494,8 +494,8 @@ static int parse_ref_filter_atom(const struct ref_format *format,
 		need_tagged = 1;
 	if (!strcmp(valid_atoms[i].name, "symref"))
 		need_symref = 1;
-	if (is_cat && !strcmp(valid_atoms[i].name, "rest"))
-		cat_file_info->split_on_whitespace = 1;
+	if (!strcmp(valid_atoms[i].name, "rest"))
+		*format->split_on_whitespace = 1;
 	return at;
 }
 
diff --git a/ref-filter.h b/ref-filter.h
index 5ba4724a472f6..3228661414623 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -127,6 +127,7 @@ struct ref_format {
 	 */
 	struct expand_data *cat_file_data;
 	int is_cat;
+	int *split_on_whitespace;
 };
 
 #define REF_FORMAT_INIT { NULL, 0, -1 }

--
https://github.com/git/git/pull/450
