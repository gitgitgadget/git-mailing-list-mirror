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
	by dcvr.yhbt.net (Postfix) with ESMTP id 60D811F404
	for <e@80x24.org>; Thu, 29 Mar 2018 12:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752679AbeC2Mts (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 08:49:48 -0400
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:50506
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751927AbeC2Mtr (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 29 Mar 2018 08:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1522327785;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=bfaRO/ntghaKsNHQv8HwzVHh3/2I14K0Nq1f4gK8hXA=;
        b=EYFmrZeWllmOLKIPbKW7+GR8OWOKKQA+VzZWpTVkYzHjOgjC9tWZoK3Ppr03jXYm
        crsl82mVV8tgdE8mbvEX2Fk+XUf7gtyz2MBI8+62jjaRvuQXRj1jvmrAoU+tuLtD1ts
        NCHHHxu+k6rJycCI3MzwBiDY2n2AAzKvlcChng1Q=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016271ce919c-7976644e-d024-4f15-a634-2df2a1c633db-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016271ce90fc-1bd75012-add6-49ee-bb32-66eeeb1cc3df-000000@eu-west-1.amazonses.com>
References: <0102016271ce90fc-1bd75012-add6-49ee-bb32-66eeeb1cc3df-000000@eu-west-1.amazonses.com>
Subject: [PATCH v6 4/6] ref-filter: change parsing function error handling
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Thu, 29 Mar 2018 12:49:45 +0000
X-SES-Outgoing: 2018.03.29-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Continue removing die() calls from ref-filter formatting logic,
so that it could be used by other commands.

Change the signature of parse_ref_filter_atom() by adding
strbuf parameter for error message.
The function returns the position in the used_atom[] array
(as before) for the given atom, or -1 to signal an error.
Upon failure, error message is appended to the strbuf.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 ref-filter.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index a18c86961f08c..93fa6b4e5e63d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -410,7 +410,8 @@ struct atom_value {
  * Used to parse format string and sort specifiers
  */
 static int parse_ref_filter_atom(const struct ref_format *format,
-				 const char *atom, const char *ep)
+				 const char *atom, const char *ep,
+				 struct strbuf *err)
 {
 	const char *sp;
 	const char *arg;
@@ -420,7 +421,8 @@ static int parse_ref_filter_atom(const struct ref_format *format,
 	if (*sp == '*' && sp < ep)
 		sp++; /* deref */
 	if (ep <= sp)
-		die(_("malformed field name: %.*s"), (int)(ep-atom), atom);
+		return strbuf_addf_ret(err, -1, _("malformed field name: %.*s"),
+				       (int)(ep-atom), atom);
 
 	/* Do we have the atom already used elsewhere? */
 	for (i = 0; i < used_atom_cnt; i++) {
@@ -446,7 +448,8 @@ static int parse_ref_filter_atom(const struct ref_format *format,
 	}
 
 	if (ARRAY_SIZE(valid_atom) <= i)
-		die(_("unknown field name: %.*s"), (int)(ep-atom), atom);
+		return strbuf_addf_ret(err, -1, _("unknown field name: %.*s"),
+				       (int)(ep-atom), atom);
 
 	/* Add it in, including the deref prefix */
 	at = used_atom_cnt;
@@ -728,17 +731,21 @@ int verify_ref_format(struct ref_format *format)
 
 	format->need_color_reset_at_eol = 0;
 	for (cp = format->format; *cp && (sp = find_next(cp)); ) {
+		struct strbuf err = STRBUF_INIT;
 		const char *color, *ep = strchr(sp, ')');
 		int at;
 
 		if (!ep)
 			return error(_("malformed format string %s"), sp);
 		/* sp points at "%(" and ep points at the closing ")" */
-		at = parse_ref_filter_atom(format, sp + 2, ep);
+		at = parse_ref_filter_atom(format, sp + 2, ep, &err);
+		if (at < 0)
+			die("%s", err.buf);
 		cp = ep + 1;
 
 		if (skip_prefix(used_atom[at].name, "color:", &color))
 			format->need_color_reset_at_eol = !!strcmp(color, "reset");
+		strbuf_release(&err);
 	}
 	if (format->need_color_reset_at_eol && !want_color(format->use_color))
 		format->need_color_reset_at_eol = 0;
@@ -2157,13 +2164,17 @@ int format_ref_array_item(struct ref_array_item *info,
 
 	for (cp = format->format; *cp && (sp = find_next(cp)); cp = ep + 1) {
 		struct atom_value *atomv;
+		int pos;
 
 		ep = strchr(sp, ')');
 		if (cp < sp)
 			append_literal(cp, sp, &state);
-		get_ref_atom_value(info,
-				   parse_ref_filter_atom(format, sp + 2, ep),
-				   &atomv);
+		pos = parse_ref_filter_atom(format, sp + 2, ep, error_buf);
+		if (pos < 0) {
+			pop_stack_element(&state.stack);
+			return -1;
+		}
+		get_ref_atom_value(info, pos, &atomv);
 		if (atomv->handler(atomv, &state, error_buf)) {
 			pop_stack_element(&state.stack);
 			return -1;
@@ -2222,7 +2233,12 @@ static int parse_sorting_atom(const char *atom)
 	 */
 	struct ref_format dummy = REF_FORMAT_INIT;
 	const char *end = atom + strlen(atom);
-	return parse_ref_filter_atom(&dummy, atom, end);
+	struct strbuf err = STRBUF_INIT;
+	int res = parse_ref_filter_atom(&dummy, atom, end, &err);
+	if (res < 0)
+		die("%s", err.buf);
+	strbuf_release(&err);
+	return res;
 }
 
 /*  If no sorting option is given, use refname to sort as default */

--
https://github.com/git/git/pull/466
