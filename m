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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D95C1F576
	for <e@80x24.org>; Mon, 12 Feb 2018 08:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933009AbeBLIJM (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 03:09:12 -0500
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:51932
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932998AbeBLII4 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Feb 2018 03:08:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1518422934;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=2B4af89AtuGn++s363lRhpaCHMle/iR+G3WC+zvBZIU=;
        b=DM+d67KEtaOhSzyWFbEAs1B6ZnIIFS2oiu0uqbfqRyJZoztFpS8dGyNc/8kM+Ygx
        XQmy3pKOK1vZ9IiA20uNBxrv0RWFgqi20mxSeNCvLvF4OJ9usEfcXWRj68AbjZsgtH+
        i6+hy621nESvbgyYC/H2hMXl6Wy2abSM9CcCRkcQ=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020161890f4376-0d1c5615-ae9c-4320-bc2d-fd3bda19bce0-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
Subject: [PATCH v3 16/23] ref-filter: make cat_file_info independent
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

Remove connection between expand_data variable
in cat-file and in ref-filter.
It will help further to get rid of using expand_data in cat-file.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c |  3 ++-
 ref-filter.c       | 36 +++++++++++++++++++-----------------
 ref-filter.h       |  7 ++-----
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 582679f3dca2c..273b4038e3893 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -292,6 +292,7 @@ static void batch_object_write(const char *obj_name, struct batch_options *opt,
 	if (populate_value(&item))
 		return;
 
+	data->type = item.type;
 	strbuf_expand(&buf, opt->format.format, expand_format, &item);
 	strbuf_addch(&buf, '\n');
 	batch_write(opt, buf.buf, buf.len);
@@ -392,7 +393,7 @@ static int batch_objects(struct batch_options *opt)
 	 * sha1_object_info_extended for each object.
 	 */
 	memset(&data, 0, sizeof(data));
-	opt->format.cat_file_data = &data;
+	opt->format.is_cat_file = 1;
 	opt->format.all_objects = opt->all_objects;
 	verify_ref_format(&opt->format);
 
diff --git a/ref-filter.c b/ref-filter.c
index 104cd6aef0102..cc70bcf2bb8b1 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -100,7 +100,7 @@ static struct used_atom {
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
-struct expand_data *cat_file_info;
+struct expand_data cat_file_info;
 
 static void color_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *color_value)
 {
@@ -255,9 +255,9 @@ static void objectname_atom_parser(const struct ref_format *format, struct used_
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
@@ -265,7 +265,7 @@ static void objectsize_atom_parser(const struct ref_format *format, struct used_
 static void objecttype_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
 {
 	if (!arg)
-		cat_file_info->info.typep = &cat_file_info->type;
+		cat_file_info.info.typep = &cat_file_info.type;
 	else
 		die(_("urecognized %%(objecttype) argument: %s"), arg);
 }
@@ -273,7 +273,7 @@ static void objecttype_atom_parser(const struct ref_format *format, struct used_
 static void deltabase_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
 {
 	if (!arg)
-		cat_file_info->info.delta_base_sha1 = cat_file_info->delta_base_oid.hash;
+		cat_file_info.info.delta_base_sha1 = cat_file_info.delta_base_oid.hash;
 	else
 		die(_("urecognized %%(deltabase) argument: %s"), arg);
 }
@@ -751,7 +751,7 @@ int verify_ref_format(struct ref_format *format)
 {
 	const char *cp, *sp;
 
-	cat_file_info = format->cat_file_data;
+	cat_file_info.is_cat_file = format->is_cat_file;
 	format->need_color_reset_at_eol = 0;
 	for (cp = format->format; *cp && (sp = find_next(cp)); ) {
 		const char *color, *ep = strchr(sp, ')');
@@ -761,7 +761,7 @@ int verify_ref_format(struct ref_format *format)
 			return error(_("malformed format string %s"), sp);
 		/* sp points at "%(" and ep points at the closing ")" */
 
-		if (format->cat_file_data)
+		if (cat_file_info.is_cat_file)
 			at = parse_ref_filter_atom(format, valid_cat_file_atom,
 						   ARRAY_SIZE(valid_cat_file_atom), sp + 2, ep);
 		else {
@@ -775,10 +775,10 @@ int verify_ref_format(struct ref_format *format)
 	}
 	if (format->need_color_reset_at_eol && !want_color(format->use_color))
 		format->need_color_reset_at_eol = 0;
-	if (cat_file_info && format->all_objects) {
+	if (cat_file_info.is_cat_file && format->all_objects) {
 		struct object_info empty = OBJECT_INFO_INIT;
-		if (!memcmp(&cat_file_info->info, &empty, sizeof(empty)))
-			cat_file_info->skip_object_info = 1;
+		if (!memcmp(&cat_file_info.info, &empty, sizeof(empty)))
+			cat_file_info.skip_object_info = 1;
 	}
 	return 0;
 }
@@ -1420,18 +1420,20 @@ static const char *get_refname(struct used_atom *atom, struct ref_array_item *re
 
 static int check_and_fill_for_cat(struct ref_array_item *ref)
 {
-	if (!cat_file_info->skip_object_info &&
-	    sha1_object_info_extended(ref->oid.hash, &cat_file_info->info,
+	if (!cat_file_info.info.typep)
+		cat_file_info.info.typep = &cat_file_info.type;
+	if (!cat_file_info.skip_object_info &&
+	    sha1_object_info_extended(ref->oid.hash, &cat_file_info.info,
 				      OBJECT_INFO_LOOKUP_REPLACE) < 0) {
 		const char *e = ref->objectname;
 		printf("%s missing\n", e ? e : oid_to_hex(&ref->oid));
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
 
@@ -1456,7 +1458,7 @@ int populate_value(struct ref_array_item *ref)
 			ref->symref = "";
 	}
 
-	if (cat_file_info && check_and_fill_for_cat(ref))
+	if (cat_file_info.is_cat_file && check_and_fill_for_cat(ref))
 		return -1;
 
 	/* Fill in specials first */
diff --git a/ref-filter.h b/ref-filter.h
index b1c668c12428b..4eaf6d0514502 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -99,6 +99,7 @@ struct expand_data {
 	 * optimized out.
 	 */
 	unsigned skip_object_info : 1;
+	unsigned is_cat_file : 1;
 };
 
 struct ref_format {
@@ -113,12 +114,8 @@ struct ref_format {
 	/* Internal state to ref-filter */
 	int need_color_reset_at_eol;
 
-	/*
-	 * Helps to move all formatting logic from cat-file to ref-filter,
-	 * hopefully would be reduced later.
-	 */
-	struct expand_data *cat_file_data;
 	unsigned all_objects : 1;
+	unsigned is_cat_file : 1;
 };
 
 #define REF_FORMAT_INIT { NULL, 0, -1 }

--
https://github.com/git/git/pull/452
