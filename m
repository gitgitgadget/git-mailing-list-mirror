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
	by dcvr.yhbt.net (Postfix) with ESMTP id DF0DE1F576
	for <e@80x24.org>; Mon, 12 Feb 2018 08:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933036AbeBLIKC (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 03:10:02 -0500
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:58622
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932986AbeBLIIz (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Feb 2018 03:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1518422934;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=sEIPHWLCryPW51hU3IWlqFkZ3K2p4jr5WI/pFMLXZpE=;
        b=D8lBFkeWZE8LFiuoiLq4T8cnQ5VRqwWuR9omMKDj6y8zUMIeu38pHVVvk5eQ5HTm
        tu2EWx8MniLq6AgDrPR/JwfaEWtIMYVEDjonwo/Dhp6f8MWfR5g78agGTR8QzCpX6J8
        bCCSyyT8YSjSwBW2wdSDSCqHsgTV3f20s85FVvT0=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020161890f4374-60ceebf6-c8aa-4011-bac6-1350549235b1-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
Subject: [PATCH v3 17/23] ref-filter: make valid_atom general again
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 12 Feb 2018 08:08:54 +0000
X-SES-Outgoing: 2018.02.12-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stop using valid_cat_file_atom, making the code more general.
Further commits will contain some tests, docs and
support of new features.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 ref-filter.c | 34 +++++++++-------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index cc70bcf2bb8b1..ee311d51ff81c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -358,8 +358,8 @@ static struct valid_atom {
 	void (*parser)(const struct ref_format *format, struct used_atom *atom, const char *arg);
 } valid_atom[] = {
 	{ "refname" , FIELD_STR, refname_atom_parser },
-	{ "objecttype" },
-	{ "objectsize", FIELD_ULONG },
+	{ "objecttype", FIELD_STR, objecttype_atom_parser },
+	{ "objectsize", FIELD_ULONG, objectsize_atom_parser },
 	{ "objectname", FIELD_STR, objectname_atom_parser },
 	{ "tree" },
 	{ "parent" },
@@ -396,12 +396,6 @@ static struct valid_atom {
 	{ "if", FIELD_STR, if_atom_parser },
 	{ "then" },
 	{ "else" },
-};
-
-static struct valid_atom valid_cat_file_atom[] = {
-	{ "objectname" },
-	{ "objecttype", FIELD_STR, objecttype_atom_parser },
-	{ "objectsize", FIELD_ULONG, objectsize_atom_parser },
 	{ "rest" },
 	{ "deltabase", FIELD_STR, deltabase_atom_parser },
 };
@@ -431,7 +425,6 @@ struct atom_value {
  * Used to parse format string and sort specifiers
  */
 static int parse_ref_filter_atom(const struct ref_format *format,
-				 const struct valid_atom *valid_atom, int n_atoms,
 				 const char *atom, const char *ep)
 {
 	const char *sp;
@@ -461,13 +454,13 @@ static int parse_ref_filter_atom(const struct ref_format *format,
 	atom_len = (arg ? arg : ep) - sp;
 
 	/* Is the atom a valid one? */
-	for (i = 0; i < n_atoms; i++) {
+	for (i = 0; i < ARRAY_SIZE(valid_atom); i++) {
 		int len = strlen(valid_atom[i].name);
 		if (len == atom_len && !memcmp(valid_atom[i].name, sp, len))
 			break;
 	}
 
-	if (n_atoms <= i)
+	if (ARRAY_SIZE(valid_atom) <= i)
 		die(_("unknown field name: %.*s"), (int)(ep-atom), atom);
 
 	/* Add it in, including the deref prefix */
@@ -761,15 +754,9 @@ int verify_ref_format(struct ref_format *format)
 			return error(_("malformed format string %s"), sp);
 		/* sp points at "%(" and ep points at the closing ")" */
 
-		if (cat_file_info.is_cat_file)
-			at = parse_ref_filter_atom(format, valid_cat_file_atom,
-						   ARRAY_SIZE(valid_cat_file_atom), sp + 2, ep);
-		else {
-			at = parse_ref_filter_atom(format, valid_atom,
-						   ARRAY_SIZE(valid_atom), sp + 2, ep);
-			if (skip_prefix(used_atom[at].name, "color:", &color))
-				format->need_color_reset_at_eol = !!strcmp(color, "reset");
-		}
+		at = parse_ref_filter_atom(format, sp + 2, ep);
+		if (skip_prefix(used_atom[at].name, "color:", &color))
+			format->need_color_reset_at_eol = !!strcmp(color, "reset");
 
 		cp = ep + 1;
 	}
@@ -2231,9 +2218,7 @@ int format_ref_array_item(struct ref_array_item *info,
 		if (cp < sp)
 			append_literal(cp, sp, &state);
 		if (get_ref_atom_value(info,
-				       parse_ref_filter_atom(format, valid_atom,
-							     ARRAY_SIZE(valid_atom),
-							     sp + 2, ep),
+				       parse_ref_filter_atom(format, sp + 2, ep),
 				       &atomv))
 			return -1;
 		atomv->handler(atomv, &state);
@@ -2286,8 +2271,7 @@ static int parse_sorting_atom(const char *atom)
 	 */
 	struct ref_format dummy = REF_FORMAT_INIT;
 	const char *end = atom + strlen(atom);
-	return parse_ref_filter_atom(&dummy, valid_atom,
-				     ARRAY_SIZE(valid_atom), atom, end);
+	return parse_ref_filter_atom(&dummy, atom, end);
 }
 
 /*  If no sorting option is given, use refname to sort as default */

--
https://github.com/git/git/pull/452
