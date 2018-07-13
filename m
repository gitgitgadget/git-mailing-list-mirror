Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C9291F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 12:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbeGMM62 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 08:58:28 -0400
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:38832
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729645AbeGMM61 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Jul 2018 08:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1531485836;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=ftUU4RrSQvIaVPalc+DDodOA2KIEoNDMFvRmzsWexdo=;
        b=hMi3qaR9LnOGl8vSJgPwWUj9S/BStkAqghy/3hy7FEChEOULBHR4ENOanDFirblX
        GauulRK9CobBZ+vfla06JhFAxKLjEoR8MbjwF9PajgW+KojKyHGD76sSX9jqEiHHCJ6
        wvU/cM3cglDHaAnFv1HC7Mqi8VqriV8KJyRLNUGs=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016493ab5347-c0429041-6e66-4550-894c-2d500cb2ed8e-000000@eu-west-1.amazonses.com>
In-Reply-To: <010201647e19c0f0-68cd728f-c86a-4be2-be6b-fd7e19e930fa-000000@eu-west-1.amazonses.com>
References: <010201647e19c0f0-68cd728f-c86a-4be2-be6b-fd7e19e930fa-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2 1/4] ref-filter: add info_source to valid_atom
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 13 Jul 2018 12:43:56 +0000
X-SES-Outgoing: 2018.07.13-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the source of object data to prevent parsing of unneeded data.
The goal is to improve performance by avoiding calling expensive
functions when we don't need the information they provide
or when we could get it by using a cheaper function.

It is stored in valid_atoms because it depends on the atoms we are
interested in.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 ref-filter.c | 82 +++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 43 insertions(+), 39 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index fa3685d91f046..8611c24fd57d1 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -41,6 +41,7 @@ void setup_ref_filter_porcelain_msg(void)
 
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 typedef enum { COMPARE_EQUAL, COMPARE_UNEQUAL, COMPARE_NONE } cmp_status;
+typedef enum { SOURCE_NONE = 0, SOURCE_OBJ, SOURCE_OTHER } info_source;
 
 struct align {
 	align_type position;
@@ -73,6 +74,7 @@ struct refname_atom {
 static struct used_atom {
 	const char *name;
 	cmp_type type;
+	info_source source;
 	union {
 		char color[COLOR_MAXLEN];
 		struct align align;
@@ -380,49 +382,50 @@ static int head_atom_parser(const struct ref_format *format, struct used_atom *a
 
 static struct {
 	const char *name;
+	info_source source;
 	cmp_type cmp_type;
 	int (*parser)(const struct ref_format *format, struct used_atom *atom,
 		      const char *arg, struct strbuf *err);
 } valid_atom[] = {
-	{ "refname" , FIELD_STR, refname_atom_parser },
-	{ "objecttype" },
-	{ "objectsize", FIELD_ULONG },
-	{ "objectname", FIELD_STR, objectname_atom_parser },
-	{ "tree" },
-	{ "parent" },
-	{ "numparent", FIELD_ULONG },
-	{ "object" },
-	{ "type" },
-	{ "tag" },
-	{ "author" },
-	{ "authorname" },
-	{ "authoremail" },
-	{ "authordate", FIELD_TIME },
-	{ "committer" },
-	{ "committername" },
-	{ "committeremail" },
-	{ "committerdate", FIELD_TIME },
-	{ "tagger" },
-	{ "taggername" },
-	{ "taggeremail" },
-	{ "taggerdate", FIELD_TIME },
-	{ "creator" },
-	{ "creatordate", FIELD_TIME },
-	{ "subject", FIELD_STR, subject_atom_parser },
-	{ "body", FIELD_STR, body_atom_parser },
-	{ "trailers", FIELD_STR, trailers_atom_parser },
-	{ "contents", FIELD_STR, contents_atom_parser },
-	{ "upstream", FIELD_STR, remote_ref_atom_parser },
-	{ "push", FIELD_STR, remote_ref_atom_parser },
-	{ "symref", FIELD_STR, refname_atom_parser },
-	{ "flag" },
-	{ "HEAD", FIELD_STR, head_atom_parser },
-	{ "color", FIELD_STR, color_atom_parser },
-	{ "align", FIELD_STR, align_atom_parser },
-	{ "end" },
-	{ "if", FIELD_STR, if_atom_parser },
-	{ "then" },
-	{ "else" },
+	{ "refname", SOURCE_NONE, FIELD_STR, refname_atom_parser },
+	{ "objecttype", SOURCE_OTHER },
+	{ "objectsize", SOURCE_OTHER, FIELD_ULONG },
+	{ "objectname", SOURCE_OTHER, FIELD_STR, objectname_atom_parser },
+	{ "tree", SOURCE_OBJ },
+	{ "parent", SOURCE_OBJ },
+	{ "numparent", SOURCE_OBJ, FIELD_ULONG },
+	{ "object", SOURCE_OBJ },
+	{ "type", SOURCE_OBJ },
+	{ "tag", SOURCE_OBJ },
+	{ "author", SOURCE_OBJ },
+	{ "authorname", SOURCE_OBJ },
+	{ "authoremail", SOURCE_OBJ },
+	{ "authordate", SOURCE_OBJ, FIELD_TIME },
+	{ "committer", SOURCE_OBJ },
+	{ "committername", SOURCE_OBJ },
+	{ "committeremail", SOURCE_OBJ },
+	{ "committerdate", SOURCE_OBJ, FIELD_TIME },
+	{ "tagger", SOURCE_OBJ },
+	{ "taggername", SOURCE_OBJ },
+	{ "taggeremail", SOURCE_OBJ },
+	{ "taggerdate", SOURCE_OBJ, FIELD_TIME },
+	{ "creator", SOURCE_OBJ },
+	{ "creatordate", SOURCE_OBJ, FIELD_TIME },
+	{ "subject", SOURCE_OBJ, FIELD_STR, subject_atom_parser },
+	{ "body", SOURCE_OBJ, FIELD_STR, body_atom_parser },
+	{ "trailers", SOURCE_OBJ, FIELD_STR, trailers_atom_parser },
+	{ "contents", SOURCE_OBJ, FIELD_STR, contents_atom_parser },
+	{ "upstream", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
+	{ "push", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
+	{ "symref", SOURCE_NONE, FIELD_STR, refname_atom_parser },
+	{ "flag", SOURCE_NONE },
+	{ "HEAD", SOURCE_NONE, FIELD_STR, head_atom_parser },
+	{ "color", SOURCE_NONE, FIELD_STR, color_atom_parser },
+	{ "align", SOURCE_NONE, FIELD_STR, align_atom_parser },
+	{ "end", SOURCE_NONE },
+	{ "if", SOURCE_NONE, FIELD_STR, if_atom_parser },
+	{ "then", SOURCE_NONE },
+	{ "else", SOURCE_NONE },
 };
 
 #define REF_FORMATTING_STATE_INIT  { 0, NULL }
@@ -498,6 +501,7 @@ static int parse_ref_filter_atom(const struct ref_format *format,
 	REALLOC_ARRAY(used_atom, used_atom_cnt);
 	used_atom[at].name = xmemdupz(atom, ep - atom);
 	used_atom[at].type = valid_atom[i].cmp_type;
+	used_atom[at].source = valid_atom[i].source;
 	if (arg) {
 		arg = used_atom[at].name + (arg - atom) + 1;
 		if (!*arg) {

--
https://github.com/git/git/pull/520
