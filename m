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
	by dcvr.yhbt.net (Postfix) with ESMTP id 303E420248
	for <e@80x24.org>; Fri, 22 Feb 2019 16:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfBVQGB (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 11:06:01 -0500
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:44900
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727239AbfBVQFr (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 22 Feb 2019 11:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1550851545;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=pMcW7SFS23BWx6axMWftypabC6i7tWu2UIxEbCjF9O4=;
        b=AWox4o5unD5SFHcDAS47R80VX3RE/yiTf31xHYYiAVMYAXWFOQPXhYsa2Zc46XcZ
        OBfjb2qfgw4Bu6bzadkGGN4XwutW23VOH76xXAKntCGRrPgKhTDYaKiQfw4l7XM/Qy/
        Z277nIPQMzGyO9hOUg2eQoe8lP2fb8OUT+IP0GYM=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016915f49a58-dc12f07d-00e6-42be-812b-3072d33910d3-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
References: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC 09/20] ref-filter: make expand_data global
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 22 Feb 2019 16:05:45 +0000
X-SES-Outgoing: 2019.02.22-54.240.7.18
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Put struct expand_data into global scope to reuse it
in cat-file.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 builtin/cat-file.c | 15 ---------------
 ref-filter.c       | 11 +----------
 ref-filter.h       | 12 ++++++++++++
 3 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index e52646c0e6b5b..edf45f078b919 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -193,21 +193,6 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	return 0;
 }
 
-struct expand_data {
-	struct object_id oid;
-	enum object_type type;
-	unsigned long size;
-	off_t disk_size;
-	struct object_id delta_base_oid;
-
-	/*
-	 * After a mark_query run, this object_info is set up to be
-	 * passed to oid_object_info_extended. It will point to the data
-	 * elements above, so you can retrieve the response from there.
-	 */
-	struct object_info info;
-};
-
 static int is_atom(const char *atom, const char *s, int slen)
 {
 	int alen = strlen(atom);
diff --git a/ref-filter.c b/ref-filter.c
index 46bf89b3330de..65b94ea21e54f 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -64,16 +64,7 @@ struct refname_atom {
 	int lstrip, rstrip;
 };
 
-static struct expand_data {
-	struct object_id oid;
-	enum object_type type;
-	unsigned long size;
-	off_t disk_size;
-	struct object_id delta_base_oid;
-	void *content;
-
-	struct object_info info;
-} oi, oi_deref;
+static struct expand_data oi, oi_deref;
 
 /*
  * An atom is a valid field atom listed below, possibly prefixed with
diff --git a/ref-filter.h b/ref-filter.h
index aaeda9f324f5c..fc61457d4d660 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -5,6 +5,7 @@
 #include "refs.h"
 #include "commit.h"
 #include "parse-options.h"
+#include "object-store.h"
 
 /* Quoting styles */
 #define QUOTE_NONE 0
@@ -73,6 +74,17 @@ struct ref_filter {
 		verbose;
 };
 
+struct expand_data {
+	struct object_id oid;
+	enum object_type type;
+	unsigned long size;
+	off_t disk_size;
+	struct object_id delta_base_oid;
+	void *content;
+
+	struct object_info info;
+};
+
 struct ref_format {
 	/*
 	 * Set these to define the format; make sure you call

--
https://github.com/git/git/pull/568
