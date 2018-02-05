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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C0741F576
	for <e@80x24.org>; Mon,  5 Feb 2018 11:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752936AbeBEL2A (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 06:28:00 -0500
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:42252
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752806AbeBEL1k (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Feb 2018 06:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1517830059;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=HfnSoBT2gOUrSXKHQT75Ab3H1HxAmZMfr5Crm+n7+pc=;
        b=LKykryyh61mt8/E3+ofVzuf+U/FN/PfqTGDGGkKxt7vM/Osq9qV/SH3H85bUvM+l
        4DKpYIUsgIZc6qUvhb8KDK30d8VTKhAjK4CZEMSak3Bu8WQ4HP0qGTKiuWWDKtSiOJX
        nljV9KeGdEvrMq5QFnwtSi1TqlQLb5b9J1pnxe2Y=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016165b8b42b-18bf5fff-cc40-471f-b633-26eeef71c989-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016165b8b3c4-54efe4c4-6d19-435d-b5b9-6c727771353b-000000@eu-west-1.amazonses.com>
References: <0102016165b8b3c4-54efe4c4-6d19-435d-b5b9-6c727771353b-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC v2 04/25] ref-filter: make valid_atom as function
 parameter
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 5 Feb 2018 11:27:39 +0000
X-SES-Outgoing: 2018.02.05-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make valid_atom as a function parameter,
there could be another variable further.
Need that for further reusing of formatting logic in cat-file.c.

We do not need to allow users to pass their own valid_atom variable in
global functions like verify_ref_format() because in the end we want to
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
index 9ed5e66066a7a..5e7ed0f338490 100644
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
@@ -2145,7 +2147,9 @@ int format_ref_array_item(struct ref_array_item *info,
 		if (cp < sp)
 			append_literal(cp, sp, &state);
 		if (get_ref_atom_value(info,
-				       parse_ref_filter_atom(format, sp + 2, ep),
+				       parse_ref_filter_atom(format, valid_atom,
+							     ARRAY_SIZE(valid_atom),
+							     sp + 2, ep),
 				       &atomv))
 			return -1;
 		atomv->handler(atomv, &state);
@@ -2198,7 +2202,8 @@ static int parse_sorting_atom(const char *atom)
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
