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
	by dcvr.yhbt.net (Postfix) with ESMTP id A3B9F1F576
	for <e@80x24.org>; Mon,  5 Feb 2018 11:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753005AbeBEL23 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 06:28:29 -0500
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:42246
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752832AbeBEL1k (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Feb 2018 06:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1517830059;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=O2vDGEJpJOFAC7S7zRm+402hCi7kyqqCzXY0QXsOw/w=;
        b=XTMIfyHZiU0l3DwDo11jWDk8k0YIoA3vj+qw61V8WWeRJJfxsqTgAIW6JEDg8ZFL
        wf0hU1l0wEdGuGckvGrInJacDYMcaKQDLreMHhZJztxHhksyqzRVM8TJ5Mu6ipU3Y96
        Qu5K0JdkroGPP2VSebfozg+AdNXFIZVWrXugLAp0=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016165b8b44a-5508af8f-5539-4938-b41d-46137915de22-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016165b8b3c4-54efe4c4-6d19-435d-b5b9-6c727771353b-000000@eu-west-1.amazonses.com>
References: <0102016165b8b3c4-54efe4c4-6d19-435d-b5b9-6c727771353b-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC v2 12/25] cat-file: start reusing populate_value()
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 5 Feb 2018 11:27:39 +0000
X-SES-Outgoing: 2018.02.05-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move logic related to getting object info from cat-file to ref-filter.
It will help to reuse whole formatting logic from ref-filter further.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c | 17 ++++-------------
 ref-filter.c       | 20 ++++++++++++++++++++
 ref-filter.h       |  1 +
 3 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 367b1bd5802dc..179c955b86bd5 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -285,21 +285,12 @@ static void batch_object_write(const char *obj_name, struct batch_options *opt,
 	struct strbuf buf = STRBUF_INIT;
 	struct ref_array_item item = {0};
 
-	if (!data->skip_object_info &&
-	    sha1_object_info_extended(data->oid.hash, &data->info,
-				      OBJECT_INFO_LOOKUP_REPLACE) < 0) {
-		printf("%s missing\n",
-		       obj_name ? obj_name : oid_to_hex(&data->oid));
-		fflush(stdout);
-		return;
-	}
-
 	item.oid = data->oid;
-	item.type = data->type;
-	item.size = data->size;
-	item.disk_size = data->disk_size;
 	item.rest = data->rest;
-	item.delta_base_oid = &data->delta_base_oid;
+	item.objectname = obj_name;
+
+	if (populate_value(&item))
+		return;
 
 	strbuf_expand(&buf, opt->format.format, expand_format, &item);
 	strbuf_addch(&buf, '\n');
diff --git a/ref-filter.c b/ref-filter.c
index d09ec1bde6d54..3f92a27d98b6c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1403,6 +1403,23 @@ static const char *get_refname(struct used_atom *atom, struct ref_array_item *re
 	return show_ref(&atom->u.refname, ref->refname);
 }
 
+static int check_and_fill_for_cat(struct ref_array_item *ref)
+{
+	if (!cat_file_info->skip_object_info &&
+	    sha1_object_info_extended(ref->oid.hash, &cat_file_info->info,
+				      OBJECT_INFO_LOOKUP_REPLACE) < 0) {
+		const char *e = ref->objectname;
+		printf("%s missing\n", e ? e : oid_to_hex(&ref->oid));
+		fflush(stdout);
+		return -1;
+	}
+	ref->type = cat_file_info->type;
+	ref->size = cat_file_info->size;
+	ref->disk_size = cat_file_info->disk_size;
+	ref->delta_base_oid = &cat_file_info->delta_base_oid;
+	return 0;
+}
+
 /*
  * Parse the object referred by ref, and grab needed value.
  * Return 0 if everything was successful, -1 otherwise.
@@ -1424,6 +1441,9 @@ int populate_value(struct ref_array_item *ref)
 			ref->symref = "";
 	}
 
+	if (cat_file_info && check_and_fill_for_cat(ref))
+		return -1;
+
 	/* Fill in specials first */
 	for (i = 0; i < used_atom_cnt; i++) {
 		struct used_atom *atom = &used_atom[i];
diff --git a/ref-filter.h b/ref-filter.h
index 87b026b8b76d0..5c6e019998716 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -45,6 +45,7 @@ struct ref_array_item {
 	off_t disk_size;
 	const char *rest;
 	struct object_id *delta_base_oid;
+	const char *objectname;
 	char refname[FLEX_ARRAY];
 };
 

--
https://github.com/git/git/pull/452
