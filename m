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
	by dcvr.yhbt.net (Postfix) with ESMTP id DBD9C1F576
	for <e@80x24.org>; Mon, 12 Feb 2018 08:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933047AbeBLIKR (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 03:10:17 -0500
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:48922
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932982AbeBLIIz (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Feb 2018 03:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1518422934;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=hASNHaMdulQ4FLdsHLONDbIf2fBttkfj0ZZHpdjvI1A=;
        b=Rq1fr4L2ehDqiVuiEyHLpdZu2dpS5Z/Y+H0+tkbPZtZgglI0WTPwKwkVV5XO/wNB
        m4/a7KwikLvs6flUhxneVyGbd0rQ4Ua0/7bbvhF53k8abMHHyAdtaAlI2XwluD9se6P
        Y0DIaMPugXP3z3vFYr3aRVD77HErjzlvZ6/tc7TE=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020161890f4353-44cc5f60-0e42-492a-9d7f-0f6f1c7b3501-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
Subject: [PATCH v3 13/23] ref-filter: get rid of mark_atom_in_object_info()
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 12 Feb 2018 08:08:54 +0000
X-SES-Outgoing: 2018.02.12-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove mark_atom_in_object_info() and create same logic
in terms of ref-filter style.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 ref-filter.c | 45 +++++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 3f92a27d98b6c..34a54db168265 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -255,13 +255,29 @@ static void objectname_atom_parser(const struct ref_format *format, struct used_
 static void objectsize_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
 {
 	if (!arg)
-		; /* default to normal object size */
+		cat_file_info->info.sizep = &cat_file_info->size;
 	else if (!strcmp(arg, "disk"))
 		cat_file_info->info.disk_sizep = &cat_file_info->disk_size;
 	else
 		die(_("urecognized %%(objectsize) argument: %s"), arg);
 }
 
+static void objecttype_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
+{
+	if (!arg)
+		cat_file_info->info.typep = &cat_file_info->type;
+	else
+		die(_("urecognized %%(objecttype) argument: %s"), arg);
+}
+
+static void deltabase_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
+{
+	if (!arg)
+		cat_file_info->info.delta_base_sha1 = cat_file_info->delta_base_oid.hash;
+	else
+		die(_("urecognized %%(deltabase) argument: %s"), arg);
+}
+
 static void refname_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
 {
 	refname_atom_parser_internal(&atom->u.refname, arg, atom->name);
@@ -384,10 +400,10 @@ static struct valid_atom {
 
 static struct valid_atom valid_cat_file_atom[] = {
 	{ "objectname" },
-	{ "objecttype" },
+	{ "objecttype", FIELD_STR, objecttype_atom_parser },
 	{ "objectsize", FIELD_ULONG, objectsize_atom_parser },
 	{ "rest" },
-	{ "deltabase" },
+	{ "deltabase", FIELD_STR, deltabase_atom_parser },
 };
 
 #define REF_FORMATTING_STATE_INIT  { 0, NULL }
@@ -411,25 +427,6 @@ struct atom_value {
 	struct used_atom *atom;
 };
 
-static int is_atom(const char *atom, const char *s, int slen)
-{
-	int alen = strlen(atom);
-	return alen == slen && !memcmp(atom, s, alen);
-}
-
-static void mark_atom_in_object_info(const char *atom, int len,
-				    struct expand_data *data)
-{
-	if (is_atom("objecttype", atom, len))
-		data->info.typep = &data->type;
-	else if (is_atom("objectsize", atom, len))
-		data->info.sizep = &data->size;
-	else if (is_atom("rest", atom, len))
-		data->split_on_whitespace = 1;
-	else if (is_atom("deltabase", atom, len))
-		data->info.delta_base_sha1 = data->delta_base_oid.hash;
-}
-
 /*
  * Used to parse format string and sort specifiers
  */
@@ -496,8 +493,8 @@ static int parse_ref_filter_atom(const struct ref_format *format,
 		need_tagged = 1;
 	if (!strcmp(valid_atom[i].name, "symref"))
 		need_symref = 1;
-	if (cat_file_info)
-		mark_atom_in_object_info(atom, atom_len, cat_file_info);
+	if (cat_file_info && !strcmp(valid_atom[i].name, "rest"))
+		cat_file_info->split_on_whitespace = 1;
 	return at;
 }
 

--
https://github.com/git/git/pull/452
