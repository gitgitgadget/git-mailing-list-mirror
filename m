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
	by dcvr.yhbt.net (Postfix) with ESMTP id 14EC41F576
	for <e@80x24.org>; Mon, 12 Feb 2018 08:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933038AbeBLIKC (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 03:10:02 -0500
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:51922
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932990AbeBLIIz (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Feb 2018 03:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1518422934;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=ibSU5LGfBe3FGyznhbQ1x01RdYYxFvGZ99GQMpXWkrg=;
        b=CAvnMxvQUDTE0J55w+T6pbfySUVufDWsWOrsZ9o7MjKOltWW+x6fpja1N0D5kehP
        wWW7g70jS6oxrUxGvPXJiZu2SXm8kMMEV0DA5xA1SNxjmMjTIdHW0dgaTMeEzpqInWb
        S8eCF0t1WaCUWbmEmoH9NK+BvVIBHI9Nb/OwAPKg=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020161890f4357-05e636bc-8b44-425b-a252-ff2341f91cdd-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
Subject: [PATCH v3 14/23] ref_filter: add is_atom_used function
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
index 6db57e3533806..3a49b55a1cc2e 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -382,8 +382,7 @@ static int batch_objects(struct batch_options *opt)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct expand_data data;
-	int save_warning;
-	int retval = 0;
+	int save_warning, is_rest, retval = 0;
 
 	if (!opt->format.format)
 		opt->format.format = "%(objectname) %(objecttype) %(objectsize)";
@@ -395,8 +394,6 @@ static int batch_objects(struct batch_options *opt)
 	memset(&data, 0, sizeof(data));
 	opt->format.cat_file_data = &data;
 	verify_ref_format(&opt->format);
-	if (opt->cmdmode)
-		data.split_on_whitespace = 1;
 
 	if (opt->all_objects) {
 		struct object_info empty = OBJECT_INFO_INIT;
@@ -435,9 +432,10 @@ static int batch_objects(struct batch_options *opt)
 	 */
 	save_warning = warn_on_object_refname_ambiguity;
 	warn_on_object_refname_ambiguity = 0;
+	is_rest = opt->cmdmode || is_atom_used(&opt->format, "rest");
 
 	while (strbuf_getline(&buf, stdin) != EOF) {
-		if (data.split_on_whitespace) {
+		if (is_rest) {
 			/*
 			 * Split at first whitespace, tying off the beginning
 			 * of the string and saving the remainder (or NULL) in
diff --git a/ref-filter.c b/ref-filter.c
index 34a54db168265..4adeea6aad0da 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -493,8 +493,6 @@ static int parse_ref_filter_atom(const struct ref_format *format,
 		need_tagged = 1;
 	if (!strcmp(valid_atom[i].name, "symref"))
 		need_symref = 1;
-	if (cat_file_info && !strcmp(valid_atom[i].name, "rest"))
-		cat_file_info->split_on_whitespace = 1;
 	return at;
 }
 
@@ -730,6 +728,21 @@ static const char *find_next(const char *cp)
 	return NULL;
 }
 
+/* Search for atom in given format. */
+int is_atom_used(const struct ref_format *format, const char *atom)
+{
+	const char *cp, *sp;
+	for (cp = format->format; *cp && (sp = find_next(cp)); ) {
+		const char *ep = strchr(sp, ')');
+		int atom_len = ep - sp - 2;
+		sp += 2;
+		if (atom_len == strlen(atom) && !memcmp(sp, atom, atom_len))
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
index 5c6e019998716..fffc443726e28 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -86,13 +86,6 @@ struct expand_data {
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
@@ -186,4 +179,7 @@ void pretty_print_ref(const char *name, const unsigned char *sha1,
 /* Fill the values of request and prepare all data for final string creation */
 int populate_value(struct ref_array_item *ref);
 
+/* Search for atom in given format. */
+int is_atom_used(const struct ref_format *format, const char *atom);
+
 #endif /*  REF_FILTER_H  */

--
https://github.com/git/git/pull/452
