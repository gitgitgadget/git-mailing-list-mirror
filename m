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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FD121F404
	for <e@80x24.org>; Fri, 26 Jan 2018 19:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752546AbeAZToE (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 14:44:04 -0500
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:37506
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752142AbeAZTnl (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 26 Jan 2018 14:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1516995820;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=M9TkKhM3A12hWE/iGlsslkKjT0EH3ZHGwSe/QiJiZs0=;
        b=dhEiYKcxrkPVAbvZgd2q7WcKQy8oym3AouyuS2rsY4jW8/y16XDs/SesXWQ7RsEZ
        J1y+soeOhVOPnTGlUwTUXlbuz+Niy0yp5HwfrnrL093VIATKiBTKb8UTex+AxONwdLl
        vaUMDcwErNBq7CRCfK8qdbaEDxqj2bddJeOWczcA=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016133ff3b3d-58cb3635-e54a-4473-a12c-78351f613c2c-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
References: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC 14/24] ref_filter: add is_rest_atom_used function
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 26 Jan 2018 19:43:40 +0000
X-SES-Outgoing: 2018.01.26-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Delete all items related to split_on_whitespace from ref-filter
and add new function for handling the logic.
Now cat-file could invoke that function to implementing its logic.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c |  8 +++-----
 ref-filter.c       | 17 +++++++++++++++--
 ref-filter.h       | 10 +++-------
 3 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 8f34d085962ed..601a87d9b5f7c 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -381,8 +381,7 @@ static int batch_objects(struct batch_options *opt)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct expand_data data;
-	int save_warning;
-	int retval = 0;
+	int save_warning, is_rest, retval = 0;
 
 	if (!opt->format.format)
 		opt->format.format = "%(objectname) %(objecttype) %(objectsize)";
@@ -396,8 +395,6 @@ static int batch_objects(struct batch_options *opt)
 	opt->format.cat_file_data = &data;
 	opt->format.is_cat = 1;
 	verify_ref_format(&opt->format);
-	if (opt->cmdmode)
-		data.split_on_whitespace = 1;
 
 	if (opt->all_objects) {
 		struct object_info empty = OBJECT_INFO_INIT;
@@ -436,9 +433,10 @@ static int batch_objects(struct batch_options *opt)
 	 */
 	save_warning = warn_on_object_refname_ambiguity;
 	warn_on_object_refname_ambiguity = 0;
+	is_rest = opt->cmdmode || is_rest_atom_used(&opt->format);
 
 	while (strbuf_getline(&buf, stdin) != EOF) {
-		if (data.split_on_whitespace) {
+		if (is_rest) {
 			/*
 			 * Split at first whitespace, tying off the beginning
 			 * of the string and saving the remainder (or NULL) in
diff --git a/ref-filter.c b/ref-filter.c
index 3b61e790e90d1..51da76dc21136 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -494,8 +494,6 @@ static int parse_ref_filter_atom(const struct ref_format *format,
 		need_tagged = 1;
 	if (!strcmp(valid_atom[i].name, "symref"))
 		need_symref = 1;
-	if (is_cat && !strcmp(valid_atom[i].name, "rest"))
-		cat_file_info->split_on_whitespace = 1;
 	return at;
 }
 
@@ -731,6 +729,21 @@ static const char *find_next(const char *cp)
 	return NULL;
 }
 
+/* Search for atom "rest" in given format. */
+int is_rest_atom_used(const struct ref_format *format)
+{
+	const char *cp, *sp;
+	for (cp = format->format; *cp && (sp = find_next(cp)); ) {
+		const char *ep = strchr(sp, ')');
+		int atom_len = ep - sp - 2;
+		sp += 2;
+		if (atom_len == 4 && !memcmp(sp, "rest", atom_len))
+			return 1;
+		cp = ep + 1;
+	}
+	return 0;
+}
+
 /*
  * Make sure the format string is well formed, and parse out
  * the used atoms.
diff --git a/ref-filter.h b/ref-filter.h
index c848370bed84a..276de387f3bd0 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -87,13 +87,6 @@ struct expand_data {
 	const char *rest;
 	struct object_id delta_base_oid;
 
-	/*
-	 * Whether to split the input on whitespace before feeding it to
-	 * get_sha1; this is decided during the mark_query phase based on
-	 * whether we have a %(rest) token in our format.
-	 */
-	int split_on_whitespace;
-
 	/*
 	 * After a mark_query run, this object_info is set up to be
 	 * passed to sha1_object_info_extended. It will point to the data
@@ -182,4 +175,7 @@ void pretty_print_ref(const char *name, const unsigned char *sha1,
 /* Fill the values of request and prepare all data for final string creation */
 int populate_value(struct ref_array_item *ref);
 
+/* Search for atom "rest" in given format. */
+int is_rest_atom_used(const struct ref_format *format);
+
 #endif /*  REF_FILTER_H  */

--
https://github.com/git/git/pull/452
