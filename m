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
	by dcvr.yhbt.net (Postfix) with ESMTP id E6B8F1F406
	for <e@80x24.org>; Tue,  9 Jan 2018 13:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757142AbeAINFu (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 08:05:50 -0500
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:43900
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757023AbeAINFZ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Jan 2018 08:05:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1515503124;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=fd7XkD7LbkL3JQ4u7+cNR/jEnhzxbee5JWqOU98zsuc=;
        b=MhQQLTgPDVSMfkqlDkD4Rvd0uO+qoHm4rdwojq8NQ18Jgp2MQYudPPD7IxHXVs8c
        0bwwM5vNzDEjdjEFAR9iAj1moFH4q9M67/eHoO/2QNP7FNhmr2tY7IhbVLeuy0G8Sbn
        GFZ4r4r1yj7nk7/38JRKRQhJmBVrug47W6pCokbM=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020160db067ae8-81d31cf2-0f69-4f36-9de8-27e9716d2f4b-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020160db0679c9-799a0bc4-b6d1-43e2-ad3b-80be4e4c55e9-000000@eu-west-1.amazonses.com>
References: <01020160db0679c9-799a0bc4-b6d1-43e2-ad3b-80be4e4c55e9-000000@eu-west-1.amazonses.com>
Subject: [PATCH 04/20] cat-file: make valid_atoms as a function parameter
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 9 Jan 2018 13:05:23 +0000
X-SES-Outgoing: 2018.01.09-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make valid_atoms as a function parameter,
there could be another variable further.
Need that for further reusing of formatting logic in cat-file.c.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 ref-filter.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 1426f0c28bce7..2d6e81fe1ab00 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -396,6 +396,7 @@ struct atom_value {
  * Used to parse format string and sort specifiers
  */
 static int parse_ref_filter_atom(const struct ref_format *format,
+				 const struct valid_atom *valid_atoms, int n_atoms,
 				 const char *atom, const char *ep)
 {
 	const char *sp;
@@ -425,13 +426,13 @@ static int parse_ref_filter_atom(const struct ref_format *format,
 	atom_len = (arg ? arg : ep) - sp;
 
 	/* Is the atom a valid one? */
-	for (i = 0; i < ARRAY_SIZE(valid_atoms); i++) {
+	for (i = 0; i < n_atoms; i++) {
 		int len = strlen(valid_atoms[i].name);
 		if (len == atom_len && !memcmp(valid_atoms[i].name, sp, len))
 			break;
 	}
 
-	if (ARRAY_SIZE(valid_atoms) <= i)
+	if (n_atoms <= i)
 		die(_("unknown field name: %.*s"), (int)(ep-atom), atom);
 
 	/* Add it in, including the deref prefix */
@@ -708,7 +709,8 @@ int verify_ref_format(struct ref_format *format)
 		if (!ep)
 			return error(_("malformed format string %s"), sp);
 		/* sp points at "%(" and ep points at the closing ")" */
-		at = parse_ref_filter_atom(format, sp + 2, ep);
+		at = parse_ref_filter_atom(format, valid_atoms,
+					   ARRAY_SIZE(valid_atoms), sp + 2, ep);
 		cp = ep + 1;
 
 		if (skip_prefix(used_atoms[at].name, "color:", &color))
@@ -2139,7 +2141,9 @@ void format_ref_array_item(struct ref_array_item *info,
 		if (cp < sp)
 			append_literal(cp, sp, &state);
 		get_ref_atom_value(info,
-				   parse_ref_filter_atom(format, sp + 2, ep),
+				   parse_ref_filter_atom(format, valid_atoms,
+							 ARRAY_SIZE(valid_atoms),
+							 sp + 2, ep),
 				   &atomv);
 		atomv->handler(atomv, &state);
 	}
@@ -2187,7 +2191,8 @@ static int parse_sorting_atom(const char *atom)
 	 */
 	struct ref_format dummy = REF_FORMAT_INIT;
 	const char *end = atom + strlen(atom);
-	return parse_ref_filter_atom(&dummy, atom, end);
+	return parse_ref_filter_atom(&dummy, valid_atoms,
+				     ARRAY_SIZE(valid_atoms), atom, end);
 }
 
 /*  If no sorting option is given, use refname to sort as default */

--
https://github.com/git/git/pull/450
