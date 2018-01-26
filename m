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
	by dcvr.yhbt.net (Postfix) with ESMTP id BBFA51F404
	for <e@80x24.org>; Fri, 26 Jan 2018 19:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752221AbeAZToD (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 14:44:03 -0500
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:34826
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752181AbeAZTnl (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 26 Jan 2018 14:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1516995820;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=bjrm7+IVeqqBebxdue9me8tCb1IRxQ542ooKRag4fjg=;
        b=KUgxTPF6nJFPHyAKGrQh9EPN3ShzNVXqANTEBZ+j66Nny/CH03/NhlIE4Ptzd3ru
        cip2AwcCetNduCiao4UbDO1TphLrJ8lZcduk2MQ4ujNtcpwjF0g8a6NoevatxhVk630
        1ukc1QP3FUb6trI7isUan2L9Y2cTLTEzH5OpuJnM=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016133ff3b1b-dcaaf82b-b21b-49b9-b21c-85f55873bd09-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
References: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC 11/24] cat-file: start reusing populate_value
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 26 Jan 2018 19:43:40 +0000
X-SES-Outgoing: 2018.01.26-54.240.7.17
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
 builtin/cat-file.c | 16 +++-------------
 ref-filter.c       | 20 ++++++++++++++++++++
 ref-filter.h       |  2 ++
 3 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 61b7acc79155d..c2ca645662ae7 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -285,21 +285,11 @@ static void batch_object_write(const char *obj_name, struct batch_options *opt,
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
 	item.objectname = data->oid;
-	item.type = data->type;
-	item.size = data->size;
-	item.disk_size = data->disk_size;
 	item.rest = data->rest;
-	item.delta_base_oid = &data->delta_base_oid;
+	item.start_of_request = obj_name;
+
+	if (populate_value(&item)) return;
 
 	strbuf_expand(&buf, opt->format.format, expand_format, &item);
 	strbuf_addch(&buf, '\n');
diff --git a/ref-filter.c b/ref-filter.c
index e69dd1ff5091f..12ca236815411 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1451,6 +1451,23 @@ static void need_object(struct ref_array_item *ref) {
 		free(buf);
 }
 
+static int check_and_fill_for_cat(struct ref_array_item *ref)
+{
+	if (!cat_file_info->skip_object_info &&
+	    sha1_object_info_extended(ref->objectname.hash, &cat_file_info->info,
+				      OBJECT_INFO_LOOKUP_REPLACE) < 0) {
+		const char *e = ref->start_of_request;
+		printf("%s missing\n", e ? e : oid_to_hex(&ref->objectname));
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
  */
@@ -1467,6 +1484,9 @@ int populate_value(struct ref_array_item *ref)
 			ref->symref = "";
 	}
 
+	if (cat_file_info && check_and_fill_for_cat(ref))
+		return -1;
+
 	/* Fill in specials first */
 	for (i = 0; i < used_atom_cnt; i++) {
 		struct used_atom *atom = &used_atom[i];
diff --git a/ref-filter.h b/ref-filter.h
index 6373167aaacd7..e41d2913c0fff 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -45,6 +45,8 @@ struct ref_array_item {
 	off_t disk_size;
 	const char *rest;
 	struct object_id *delta_base_oid;
+	/* Need it for better explanation in error log. */
+	const char *start_of_request;
 	char refname[FLEX_ARRAY];
 };
 

--
https://github.com/git/git/pull/452
