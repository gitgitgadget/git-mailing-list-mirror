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
	by dcvr.yhbt.net (Postfix) with ESMTP id F1FA81F406
	for <e@80x24.org>; Tue,  9 Jan 2018 13:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757145AbeAINFu (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 08:05:50 -0500
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:45796
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757020AbeAINFZ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Jan 2018 08:05:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1515503123;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=YWmSRqPuKq1S28yQWenYGPOYfMvgto2iWnANgzZIcrs=;
        b=MjyYZPMkvz+Rfbi5RqYRVeV7RgRjkKPnl/nxQT+YZ7ANVTRBxs6q8p6+95BL6IiP
        7b1urYsVOrcZvVz+3tnUQVTLXoBkWh8tctl1Yg51tMQg3boUBrLdKrQwJpbuKXXZE9Z
        iT0BbXEUCWdZQk9dgWXnmlbdkLQ9Vwc4BQm1R+PQ=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020160db067ca1-d14d3b76-31fe-44cc-a655-7a548a0fe17d-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020160db0679c9-799a0bc4-b6d1-43e2-ad3b-80be4e4c55e9-000000@eu-west-1.amazonses.com>
References: <01020160db0679c9-799a0bc4-b6d1-43e2-ad3b-80be4e4c55e9-000000@eu-west-1.amazonses.com>
Subject: [PATCH 20/20] cat-file: make cat_file_info variable independent
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 9 Jan 2018 13:05:23 +0000
X-SES-Outgoing: 2018.01.09-54.240.7.18
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove connection between expand_data variable
in cat-file and in ref-filter.
It will help further to get rid of using expand_data in cat-file.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c |  2 +-
 ref-filter.c       | 28 ++++++++++++++--------------
 ref-filter.h       |  1 -
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 19cee0d22fabe..ffa8e61213e36 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -289,6 +289,7 @@ static void batch_object_write(const char *obj_name, struct batch_options *opt,
 	item.start_of_request = obj_name;
 
 	if (populate_value(&item)) return;
+	data->type = item.type;
 
 	strbuf_expand(&buf, opt->format->format, expand_format, &item);
 	strbuf_addch(&buf, '\n');
@@ -392,7 +393,6 @@ static int batch_objects(struct batch_options *opt)
 	 * object.
 	 */
 	memset(&data, 0, sizeof(data));
-	opt->format->cat_file_data = &data;
 	opt->format->is_cat = 1;
 	opt->format->split_on_whitespace = &data.split_on_whitespace;
 	opt->format->all_objects = opt->all_objects;
diff --git a/ref-filter.c b/ref-filter.c
index dbca6856432c0..a8a93b488db37 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -100,7 +100,7 @@ static struct used_atom {
 	} u;
 } *used_atoms;
 static int used_atom_cnt, need_tagged, need_symref;
-struct expand_data *cat_file_info;
+struct expand_data cat_file_info;
 static int is_cat = 0;
 
 static void color_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *color_value)
@@ -256,9 +256,9 @@ static void objectname_atom_parser(const struct ref_format *format, struct used_
 static void objectsize_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
 {
 	if (!arg)
-		cat_file_info->info.sizep = &cat_file_info->size;
+		cat_file_info.info.sizep = &cat_file_info.size;
 	else if (!strcmp(arg, "disk"))
-		cat_file_info->info.disk_sizep = &cat_file_info->disk_size;
+		cat_file_info.info.disk_sizep = &cat_file_info.disk_size;
 	else
 		die(_("urecognized %%(objectsize) argument: %s"), arg);
 }
@@ -266,7 +266,7 @@ static void objectsize_atom_parser(const struct ref_format *format, struct used_
 static void objecttype_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
 {
 	if (!arg)
-		cat_file_info->info.typep = &cat_file_info->type;
+		cat_file_info.info.typep = &cat_file_info.type;
 	else
 		die(_("urecognized %%(objecttype) argument: %s"), arg);
 }
@@ -274,7 +274,7 @@ static void objecttype_atom_parser(const struct ref_format *format, struct used_
 static void deltabase_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
 {
 	if (!arg)
-		cat_file_info->info.delta_base_sha1 = cat_file_info->delta_base_oid.hash;
+		cat_file_info.info.delta_base_sha1 = cat_file_info.delta_base_oid.hash;
 	else
 		die(_("urecognized %%(deltabase) argument: %s"), arg);
 }
@@ -739,7 +739,6 @@ int verify_ref_format(struct ref_format *format)
 {
 	const char *cp, *sp;
 
-	cat_file_info = format->cat_file_data;
 	is_cat = format->is_cat;
 	format->need_color_reset_at_eol = 0;
 	for (cp = format->format; *cp && (sp = find_next(cp)); ) {
@@ -768,8 +767,8 @@ int verify_ref_format(struct ref_format *format)
 		format->need_color_reset_at_eol = 0;
 	if (is_cat && format->all_objects) {
 		struct object_info empty = OBJECT_INFO_INIT;
-		if (!memcmp(&cat_file_info->info, &empty, sizeof(empty)))
-			cat_file_info->skip_object_info = 1;
+		if (!memcmp(&cat_file_info.info, &empty, sizeof(empty)))
+			cat_file_info.skip_object_info = 1;
 	}
 	return 0;
 }
@@ -1474,18 +1473,19 @@ int populate_value(struct ref_array_item *ref)
 	}
 
 	if (is_cat) {
-		if (!cat_file_info->skip_object_info &&
-		    sha1_object_info_extended(ref->objectname.hash, &cat_file_info->info,
+		if (!cat_file_info.info.typep) cat_file_info.info.typep = &cat_file_info.type;
+		if (!cat_file_info.skip_object_info &&
+		    sha1_object_info_extended(ref->objectname.hash, &cat_file_info.info,
 					      OBJECT_INFO_LOOKUP_REPLACE) < 0) {
 			const char *e = ref->start_of_request;
 			printf("%s missing\n", e ? e : oid_to_hex(&ref->objectname));
 			fflush(stdout);
 			return -1;
 		}
-		ref->type = cat_file_info->type;
-		ref->size = cat_file_info->size;
-		ref->disk_size = cat_file_info->disk_size;
-		ref->delta_base_oid = cat_file_info->delta_base_oid;
+		ref->type = cat_file_info.type;
+		ref->size = cat_file_info.size;
+		ref->disk_size = cat_file_info.disk_size;
+		ref->delta_base_oid = cat_file_info.delta_base_oid;
 	}
 
 	/* Fill in specials first */
diff --git a/ref-filter.h b/ref-filter.h
index 7f7b17e659241..ebaed0412fac2 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -125,7 +125,6 @@ struct ref_format {
 	 * Helps to move all formatting logic from cat-file to ref-filter,
 	 * hopefully would be reduced later.
 	 */
-	struct expand_data *cat_file_data;
 	int is_cat;
 	int *split_on_whitespace;
 	int all_objects;

--
https://github.com/git/git/pull/450
