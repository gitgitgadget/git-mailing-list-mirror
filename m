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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E0CA1F404
	for <e@80x24.org>; Fri, 26 Jan 2018 19:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752561AbeAZToF (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 14:44:05 -0500
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:57616
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752047AbeAZTnl (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 26 Jan 2018 14:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1516995820;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=nOxaFWz5rCv+HSO8o10cABmlK7WO+19ikj3AvqAVXoM=;
        b=DS6iYCeppBxNiDUyjWBrLz6xrGiluJ4XSXf98RPt2qdPSGyNAHGUfI7SuYe77cK+
        gmaE4TsmAhRwp5t2QqsZKxS1OINFIIHYgcqNyVZl6QRwm8bRcjgR4AeHTT0yrmERify
        qhTr9CbIm66g6nGUHaJvkU30ZmmlL5XJymKx9Me8=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016133ff3b3d-001897ca-5d18-45e6-bd4c-118aa9a3d659-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
References: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC 16/24] ref-filter: make cat_file_info independent
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 26 Jan 2018 19:43:40 +0000
X-SES-Outgoing: 2018.01.26-54.240.7.19
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
 ref-filter.c       | 29 +++++++++++++++--------------
 ref-filter.h       |  1 -
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 3a52c551f366a..bd803856537b8 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -290,6 +290,7 @@ static void batch_object_write(const char *obj_name, struct batch_options *opt,
 	item.start_of_request = obj_name;
 
 	if (populate_value(&item)) return;
+	data->type = item.type;
 
 	strbuf_expand(&buf, opt->format.format, expand_format, &item);
 	strbuf_addch(&buf, '\n');
@@ -392,7 +393,6 @@ static int batch_objects(struct batch_options *opt)
 	 * object.
 	 */
 	memset(&data, 0, sizeof(data));
-	opt->format.cat_file_data = &data;
 	opt->format.is_cat = 1;
 	opt->format.all_objects = opt->all_objects;
 	verify_ref_format(&opt->format);
diff --git a/ref-filter.c b/ref-filter.c
index 29a1b75c93181..906a5344949f7 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -100,7 +100,7 @@ static struct used_atom {
 	} u;
 } *used_atom;
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
@@ -752,7 +752,6 @@ int verify_ref_format(struct ref_format *format)
 {
 	const char *cp, *sp;
 
-	cat_file_info = format->cat_file_data;
 	is_cat = format->is_cat;
 	format->need_color_reset_at_eol = 0;
 	for (cp = format->format; *cp && (sp = find_next(cp)); ) {
@@ -779,8 +778,8 @@ int verify_ref_format(struct ref_format *format)
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
@@ -1470,18 +1469,20 @@ static void need_object(struct ref_array_item *ref) {
 
 static int check_and_fill_for_cat(struct ref_array_item *ref)
 {
-	if (!cat_file_info->skip_object_info &&
-	    sha1_object_info_extended(ref->objectname.hash, &cat_file_info->info,
+	if (!cat_file_info.info.typep)
+		cat_file_info.info.typep = &cat_file_info.type;
+	if (!cat_file_info.skip_object_info &&
+	    sha1_object_info_extended(ref->objectname.hash, &cat_file_info.info,
 				      OBJECT_INFO_LOOKUP_REPLACE) < 0) {
 		const char *e = ref->start_of_request;
 		printf("%s missing\n", e ? e : oid_to_hex(&ref->objectname));
 		fflush(stdout);
 		return -1;
 	}
-	ref->type = cat_file_info->type;
-	ref->size = cat_file_info->size;
-	ref->disk_size = cat_file_info->disk_size;
-	ref->delta_base_oid = &cat_file_info->delta_base_oid;
+	ref->type = cat_file_info.type;
+	ref->size = cat_file_info.size;
+	ref->disk_size = cat_file_info.disk_size;
+	ref->delta_base_oid = &cat_file_info.delta_base_oid;
 	return 0;
 }
 
diff --git a/ref-filter.h b/ref-filter.h
index 4af89c4c86bee..d8064086f36a9 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -118,7 +118,6 @@ struct ref_format {
 	 * Helps to move all formatting logic from cat-file to ref-filter,
 	 * hopefully would be reduced later.
 	 */
-	struct expand_data *cat_file_data;
 	int is_cat;
 	int all_objects;
 };

--
https://github.com/git/git/pull/452
