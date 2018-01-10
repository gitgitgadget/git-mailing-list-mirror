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
	by dcvr.yhbt.net (Postfix) with ESMTP id C535A1FADF
	for <e@80x24.org>; Wed, 10 Jan 2018 09:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756130AbeAJJgt (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 04:36:49 -0500
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:37932
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754461AbeAJJgm (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 10 Jan 2018 04:36:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1515577001;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=U/oLh9TgaDbV17VIr6tI3Yc5fZfY8iZt7sCLSF1C15I=;
        b=OfTSoVpuIHcKKuGSZE/F72OKow5tzUGc8BdqJ6y8NhCiQ7T6SG2e6VRHshiViI3M
        YN8kR5WiVRBifq0LFsqY0fzHTSDUTWvLNa51eMw2+Gl+HHUmXV4+4LVzrNZoJoTAUY8
        9l5KH9+zoFIKdtTBW0LgaowEyai2NCDKRZFCGPGE=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020160df6dc59c-62462c0b-9d87-4fba-bfe7-2399dfb4eebb-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
References: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2 14/18] ref-filter: get rid of expand_atom_into_fields
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Wed, 10 Jan 2018 09:36:41 +0000
X-SES-Outgoing: 2018.01.10-54.240.7.18
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove expand_atom_into_fields function and create same logic
in terms of ref-filter style.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 ref-filter.c | 45 +++++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 35e16cec6d862..93248ce18152f 100644
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
-static void expand_atom_into_fields(const char *atom, int len,
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
-		expand_atom_into_fields(atom, atom_len, cat_file_info);
+	if (cat_file_info && !strcmp(valid_atoms[i].name, "rest"))
+		cat_file_info->split_on_whitespace = 1;
 	return at;
 }
 

--
https://github.com/git/git/pull/450
