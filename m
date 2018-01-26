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
	by dcvr.yhbt.net (Postfix) with ESMTP id 010621F404
	for <e@80x24.org>; Fri, 26 Jan 2018 19:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbeAZToe (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 14:44:34 -0500
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:38306
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752076AbeAZTnl (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 26 Jan 2018 14:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1516995820;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=aErs30Lm2arE7v1S1kioKZedbi/GHSbyVqXScx4+hYU=;
        b=BVp39iuOFQbZ9M3by7LvF2bEtbso98WKlcRZGwYTccZ/dEAUuYEVCnQIZzu/HOxN
        bQGdixKzThx2Pr3r/S8m7xeQ5E+Guz1EXUBPpkmJSzLydOZ6m+GKSn6fYSG3/LGsLoF
        FzERnHMIZM/lvska88NMBWdGC7hRJ+8Mv4AWkPTM=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016133ff3afa-721294ba-c691-4b45-b3a8-622525285902-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
References: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC 05/24] ref-filter: make valid_atom as function parameter
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 26 Jan 2018 19:43:40 +0000
X-SES-Outgoing: 2018.01.26-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make valid_atom as a function parameter,
there could be another variable further.
Need that for further reusing of formatting logic in cat-file.c.

We do not need to allow users to pass their own valid_atom variable in
global functions like verify_ref_format because in the end we want to
have same set of valid atoms for all commands. But, as a first step
of migrating, I create further another version of valid_atom
for cat-file.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 ref-filter.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 7030d35c84a81..ee2aa7d6d072b 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -325,7 +325,7 @@ static void head_atom_parser(const struct ref_format *format, struct used_atom *
 	atom->u.head = resolve_refdup("HEAD", RESOLVE_REF_READING, NULL, NULL);
 }
 
-static struct {
+static struct valid_atom {
 	const char *name;
 	cmp_type cmp_type;
 	void (*parser)(const struct ref_format *format, struct used_atom *atom, const char *arg);
@@ -396,6 +396,7 @@ struct atom_value {
  * Used to parse format string and sort specifiers
  */
 static int parse_ref_filter_atom(const struct ref_format *format,
+				 const struct valid_atom *valid_atom, int n_atoms,
 				 const char *atom, const char *ep)
 {
 	const char *sp;
@@ -425,13 +426,13 @@ static int parse_ref_filter_atom(const struct ref_format *format,
 	atom_len = (arg ? arg : ep) - sp;
 
 	/* Is the atom a valid one? */
-	for (i = 0; i < ARRAY_SIZE(valid_atom); i++) {
+	for (i = 0; i < n_atoms; i++) {
 		int len = strlen(valid_atom[i].name);
 		if (len == atom_len && !memcmp(valid_atom[i].name, sp, len))
 			break;
 	}
 
-	if (ARRAY_SIZE(valid_atom) <= i)
+	if (n_atoms <= i)
 		die(_("unknown field name: %.*s"), (int)(ep-atom), atom);
 
 	/* Add it in, including the deref prefix */
@@ -708,7 +709,8 @@ int verify_ref_format(struct ref_format *format)
 		if (!ep)
 			return error(_("malformed format string %s"), sp);
 		/* sp points at "%(" and ep points at the closing ")" */
-		at = parse_ref_filter_atom(format, sp + 2, ep);
+		at = parse_ref_filter_atom(format, valid_atom,
+					   ARRAY_SIZE(valid_atom), sp + 2, ep);
 		cp = ep + 1;
 
 		if (skip_prefix(used_atom[at].name, "color:", &color))
@@ -2143,7 +2145,9 @@ int format_ref_array_item(struct ref_array_item *info,
 		if (cp < sp)
 			append_literal(cp, sp, &state);
 		get_ref_atom_value(info,
-				   parse_ref_filter_atom(format, sp + 2, ep),
+				   parse_ref_filter_atom(format, valid_atom,
+							 ARRAY_SIZE(valid_atom),
+							 sp + 2, ep),
 				   &atomv);
 		atomv->handler(atomv, &state);
 	}
@@ -2194,7 +2198,8 @@ static int parse_sorting_atom(const char *atom)
 	 */
 	struct ref_format dummy = REF_FORMAT_INIT;
 	const char *end = atom + strlen(atom);
-	return parse_ref_filter_atom(&dummy, atom, end);
+	return parse_ref_filter_atom(&dummy, valid_atom,
+				     ARRAY_SIZE(valid_atom), atom, end);
 }
 
 /*  If no sorting option is given, use refname to sort as default */

--
https://github.com/git/git/pull/452
