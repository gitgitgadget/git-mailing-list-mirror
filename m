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
	by dcvr.yhbt.net (Postfix) with ESMTP id DF51A1FADF
	for <e@80x24.org>; Wed, 10 Jan 2018 09:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965464AbeAJJij (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 04:38:39 -0500
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:48798
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755620AbeAJJgm (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 10 Jan 2018 04:36:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1515577001;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=5Mlt6DoSjD02nCbiINluCtypKvOiFw1fsONScwotLv0=;
        b=AjIjr/iouQc572DCryC1LJTWaNcu/JYCY76NfHawU2on6edDw6kKd0+GVN8kjyAb
        J04muFlwEY87azZNoY6i/L5YeHIo5LlQi60iJ6gsw86nkPpQMfnDLA69xn+pJ11xbYA
        RaztuDk/CDqIZSvUtCj+n5eODsqryevnIyucOFFs=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020160df6dc548-3213651c-f87e-40f6-80b3-4fe2ee9131be-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
References: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2 06/18] ref-filter: reuse parse_ref_filter_atom
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Wed, 10 Jan 2018 09:36:41 +0000
X-SES-Outgoing: 2018.01.10-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Continue migrating formatting logic from cat-file to ref-filter.
Reuse parse_ref_filter_atom for unifying all processes in ref-filter
and further reducing of expand_atom_into_fields function.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 ref-filter.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 6ca4a671086ee..bb09875e2dbf4 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -100,6 +100,7 @@ static struct used_atom {
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
+struct expand_data *cat_file_info;
 
 static void color_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *color_value)
 {
@@ -251,6 +252,16 @@ static void objectname_atom_parser(const struct ref_format *format, struct used_
 		die(_("unrecognized %%(objectname) argument: %s"), arg);
 }
 
+static void objectsize_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
+{
+	if (!arg)
+		; /* default to normal object size */
+	else if (!strcmp(arg, "disk"))
+		cat_file_info->info.disk_sizep = &cat_file_info->disk_size;
+	else
+		die(_("urecognized %%(objectsize) argument: %s"), arg);
+}
+
 static void refname_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
 {
 	refname_atom_parser_internal(&atom->u.refname, arg, atom->name);
@@ -371,6 +382,14 @@ static struct valid_atom {
 	{ "else" },
 };
 
+static struct valid_atom valid_cat_file_atom[] = {
+	{ "objectname" },
+	{ "objecttype" },
+	{ "objectsize", FIELD_ULONG, objectsize_atom_parser },
+	{ "rest" },
+	{ "deltabase" },
+};
+
 #define REF_FORMATTING_STATE_INIT  { 0, NULL }
 
 struct ref_formatting_stack {
@@ -401,20 +420,14 @@ static int is_atom(const char *atom, const char *s, int slen)
 static void expand_atom_into_fields(const char *atom, int len,
 				    struct expand_data *data)
 {
-	if (is_atom("objectname", atom, len))
-		; /* do nothing */
-	else if (is_atom("objecttype", atom, len))
+	if (is_atom("objecttype", atom, len))
 		data->info.typep = &data->type;
 	else if (is_atom("objectsize", atom, len))
 		data->info.sizep = &data->size;
-	else if (is_atom("objectsize:disk", atom, len))
-		data->info.disk_sizep = &data->disk_size;
 	else if (is_atom("rest", atom, len))
 		data->split_on_whitespace = 1;
 	else if (is_atom("deltabase", atom, len))
 		data->info.delta_base_sha1 = data->delta_base_oid.hash;
-	else
-		die("unknown format element: %.*s", len, atom);
 }
 
 /*
@@ -483,6 +496,8 @@ static int parse_ref_filter_atom(const struct ref_format *format,
 		need_tagged = 1;
 	if (!strcmp(valid_atom[i].name, "symref"))
 		need_symref = 1;
+	if (cat_file_info)
+		expand_atom_into_fields(atom, atom_len, cat_file_info);
 	return at;
 }
 
@@ -726,6 +741,7 @@ int verify_ref_format(struct ref_format *format)
 {
 	const char *cp, *sp;
 
+	cat_file_info = format->cat_file_data;
 	format->need_color_reset_at_eol = 0;
 	for (cp = format->format; *cp && (sp = find_next(cp)); ) {
 		const char *color, *ep = strchr(sp, ')');
@@ -735,10 +751,10 @@ int verify_ref_format(struct ref_format *format)
 			return error(_("malformed format string %s"), sp);
 		/* sp points at "%(" and ep points at the closing ")" */
 
-		if (format->cat_file_data)
-			expand_atom_into_fields(sp + 2, ep - sp - 2,
-						format->cat_file_data);
-		else {
+		if (format->cat_file_data) {
+			at = parse_ref_filter_atom(format, valid_cat_file_atom,
+						   ARRAY_SIZE(valid_cat_file_atom), sp + 2, ep);
+		} else {
 			at = parse_ref_filter_atom(format, valid_atom,
 						   ARRAY_SIZE(valid_atom), sp + 2, ep);
 			if (skip_prefix(used_atom[at].name, "color:", &color))

--
https://github.com/git/git/pull/450
