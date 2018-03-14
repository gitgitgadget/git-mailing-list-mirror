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
	by dcvr.yhbt.net (Postfix) with ESMTP id 06BCA1F404
	for <e@80x24.org>; Wed, 14 Mar 2018 19:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbeCNTEY (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 15:04:24 -0400
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:58592
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751551AbeCNTEV (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Mar 2018 15:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1521054260;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=6hyZzCSdI8J8R+6EQl6wWtFKq6g/VMoSJcHX1bdSA2E=;
        b=G2c/EkgTJTau5bzIxr8S+SLWGBS2AU0y3uaiUeO1638M4UYoNmKjiHj7qdCeKsGv
        /I+S+/+5N9WVLsTSea90STHMsUceAAqhDDouSO4/jVRImugslLeEASDNTmUWZ+Bj4Hl
        FSI+PmTFBArfdmaCKaAoGew9EkFMzDvwYbcWRUlg=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016225e61cb4-b59773de-d22e-42cd-909a-d7ce71646898-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016225e61c34-50ab78f0-6fb6-4ece-acfe-da253bdce616-000000@eu-west-1.amazonses.com>
References: <0102016225e61c34-50ab78f0-6fb6-4ece-acfe-da253bdce616-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2 3/5] ref-filter: change parsing function error handling
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Wed, 14 Mar 2018 19:04:20 +0000
X-SES-Outgoing: 2018.03.14-54.240.7.18
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Continue removing any printing from ref-filter formatting logic,
so that it could be more general.

Change the signature of parse_ref_filter_atom() by changing return value,
adding previous return value to function parameter and also adding
strbuf parameter for error message.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 ref-filter.c | 43 ++++++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index d120360104806..dd83ef326511d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -397,7 +397,8 @@ struct atom_value {
  * Used to parse format string and sort specifiers
  */
 static int parse_ref_filter_atom(const struct ref_format *format,
-				 const char *atom, const char *ep)
+				 const char *atom, const char *ep, int *res,
+				 struct strbuf *err)
 {
 	const char *sp;
 	const char *arg;
@@ -406,14 +407,18 @@ static int parse_ref_filter_atom(const struct ref_format *format,
 	sp = atom;
 	if (*sp == '*' && sp < ep)
 		sp++; /* deref */
-	if (ep <= sp)
-		die(_("malformed field name: %.*s"), (int)(ep-atom), atom);
+	if (ep <= sp) {
+		strbuf_addf(err, _("malformed field name: %.*s"), (int)(ep-atom), atom);
+		return -1;
+	}
 
 	/* Do we have the atom already used elsewhere? */
 	for (i = 0; i < used_atom_cnt; i++) {
 		int len = strlen(used_atom[i].name);
-		if (len == ep - atom && !memcmp(used_atom[i].name, atom, len))
-			return i;
+		if (len == ep - atom && !memcmp(used_atom[i].name, atom, len)) {
+			*res = i;
+			return 0;
+		}
 	}
 
 	/*
@@ -432,8 +437,10 @@ static int parse_ref_filter_atom(const struct ref_format *format,
 			break;
 	}
 
-	if (ARRAY_SIZE(valid_atom) <= i)
-		die(_("unknown field name: %.*s"), (int)(ep-atom), atom);
+	if (ARRAY_SIZE(valid_atom) <= i) {
+		strbuf_addf(err, _("unknown field name: %.*s"), (int)(ep-atom), atom);
+		return -1;
+	}
 
 	/* Add it in, including the deref prefix */
 	at = used_atom_cnt;
@@ -458,7 +465,8 @@ static int parse_ref_filter_atom(const struct ref_format *format,
 		need_tagged = 1;
 	if (!strcmp(valid_atom[i].name, "symref"))
 		need_symref = 1;
-	return at;
+	*res = at;
+	return 0;
 }
 
 static void quote_formatting(struct strbuf *s, const char *str, int quote_style)
@@ -725,17 +733,20 @@ int verify_ref_format(struct ref_format *format)
 
 	format->need_color_reset_at_eol = 0;
 	for (cp = format->format; *cp && (sp = find_next(cp)); ) {
+		struct strbuf err = STRBUF_INIT;
 		const char *color, *ep = strchr(sp, ')');
 		int at;
 
 		if (!ep)
 			return error(_("malformed format string %s"), sp);
 		/* sp points at "%(" and ep points at the closing ")" */
-		at = parse_ref_filter_atom(format, sp + 2, ep);
+		if (parse_ref_filter_atom(format, sp + 2, ep, &at, &err))
+			die("%s", err.buf);
 		cp = ep + 1;
 
 		if (skip_prefix(used_atom[at].name, "color:", &color))
 			format->need_color_reset_at_eol = !!strcmp(color, "reset");
+		strbuf_release(&err);
 	}
 	if (format->need_color_reset_at_eol && !want_color(format->use_color))
 		format->need_color_reset_at_eol = 0;
@@ -2154,13 +2165,14 @@ int format_ref_array_item(struct ref_array_item *info,
 
 	for (cp = format->format; *cp && (sp = find_next(cp)); cp = ep + 1) {
 		struct atom_value *atomv;
+		int pos;
 
 		ep = strchr(sp, ')');
 		if (cp < sp)
 			append_literal(cp, sp, &state);
-		get_ref_atom_value(info,
-				   parse_ref_filter_atom(format, sp + 2, ep),
-				   &atomv);
+		if (parse_ref_filter_atom(format, sp + 2, ep, &pos, error_buf))
+			return -1;
+		get_ref_atom_value(info, pos, &atomv);
 		if (atomv->handler(atomv, &state, error_buf))
 			return -1;
 	}
@@ -2215,7 +2227,12 @@ static int parse_sorting_atom(const char *atom)
 	 */
 	struct ref_format dummy = REF_FORMAT_INIT;
 	const char *end = atom + strlen(atom);
-	return parse_ref_filter_atom(&dummy, atom, end);
+	struct strbuf err = STRBUF_INIT;
+	int res;
+	if (parse_ref_filter_atom(&dummy, atom, end, &res, &err))
+		die("%s", err.buf);
+	strbuf_release(&err);
+	return res;
 }
 
 /*  If no sorting option is given, use refname to sort as default */

--
https://github.com/git/git/pull/466
