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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3269F1F576
	for <e@80x24.org>; Mon, 12 Feb 2018 08:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933006AbeBLII7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 03:08:59 -0500
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:41336
        "EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932655AbeBLIIz (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Feb 2018 03:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1518422934;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=x56XF06v9MyKdgRa1gMlwuSDcDHuYT1a3cYUMGntqSE=;
        b=SN43P0q1k43BCbbMoNq97krVcuz7nhRCEhIrdRO2ojiUWudk2TnDDem+kNA8l7S0
        AcdQ7jLEGBJG+Jbh4LBHH/wGvGJBFYtKQc8n+GDw2WYXX9NhyfY07dkx0+hpnK5kLG/
        648bOH3IS91e1lk0fFzZpIZcOVRwFKzSvZbR8VoQ=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020161890f434b-3f93f5b7-0fad-4777-ab9b-79c48b2b41d2-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
Subject: [PATCH v3 08/23] ref-filter: reuse parse_ref_filter_atom()
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 12 Feb 2018 08:08:54 +0000
X-SES-Outgoing: 2018.02.12-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Continue migrating formatting logic from cat-file to ref-filter.
Reuse parse_ref_filter_atom() for unifying all processes in ref-filter
and further removing of mark_atom_in_object_info().

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 ref-filter.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index ff87e632f463c..5c75259b1ab8c 100644
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
 static void mark_atom_in_object_info(const char *atom, int len,
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
+		mark_atom_in_object_info(atom, atom_len, cat_file_info);
 	return at;
 }
 
@@ -726,6 +741,7 @@ int verify_ref_format(struct ref_format *format)
 {
 	const char *cp, *sp;
 
+	cat_file_info = format->cat_file_data;
 	format->need_color_reset_at_eol = 0;
 	for (cp = format->format; *cp && (sp = find_next(cp)); ) {
 		const char *color, *ep = strchr(sp, ')');
@@ -736,8 +752,8 @@ int verify_ref_format(struct ref_format *format)
 		/* sp points at "%(" and ep points at the closing ")" */
 
 		if (format->cat_file_data)
-			mark_atom_in_object_info(sp + 2, ep - sp - 2,
-						format->cat_file_data);
+			at = parse_ref_filter_atom(format, valid_cat_file_atom,
+						   ARRAY_SIZE(valid_cat_file_atom), sp + 2, ep);
 		else {
 			at = parse_ref_filter_atom(format, valid_atom,
 						   ARRAY_SIZE(valid_atom), sp + 2, ep);

--
https://github.com/git/git/pull/452
