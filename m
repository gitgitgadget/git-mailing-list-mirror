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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B5D21F404
	for <e@80x24.org>; Mon, 19 Mar 2018 13:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755536AbeCSNBF (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:01:05 -0400
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:59970
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755530AbeCSNBC (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Mar 2018 09:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1521464460;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=WEG7a6nE6kb/7BKBnv8V4z+sMrZDNn0gQvzoSrqq9qo=;
        b=m6CNogW+r5nYvut7W8gfMDfdJgvPh5DzQ+ULXABiVqdKUQ2IFCKDyZHZnUpbpLAo
        7Lti5aA53VFh9+6Z0a2dOjs5LF5KPgn0nori0dSkZqcLjyVGJ8OjgI4yFKPFzdK03oM
        1vZ2HUZiEKWt3K3zAvIuvYqpSETr1H+L7ejzhxtQ=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <010201623e5944b9-8d44ad36-a6df-4bd3-97e7-de4ee54af3c0-000000@eu-west-1.amazonses.com>
In-Reply-To: <010201623e594401-906aa5ca-545b-405a-810a-607491fe09a7-000000@eu-west-1.amazonses.com>
References: <010201623e594401-906aa5ca-545b-405a-810a-607491fe09a7-000000@eu-west-1.amazonses.com>
Subject: [PATCH v3 3/5] ref-filter: change parsing function error handling
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 19 Mar 2018 13:01:00 +0000
X-SES-Outgoing: 2018.03.19-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Continue removing any printing from ref-filter formatting logic,
so that it could be more general.

Change the signature of parse_ref_filter_atom() by adding
strbuf parameter for error message.
Return value means the same except negative values: they indicate
errors (previous version could return only non-negative value).

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 ref-filter.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index d120360104806..2313a33f0baa4 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -397,7 +397,8 @@ struct atom_value {
  * Used to parse format string and sort specifiers
  */
 static int parse_ref_filter_atom(const struct ref_format *format,
-				 const char *atom, const char *ep)
+				 const char *atom, const char *ep,
+				 struct strbuf *err)
 {
 	const char *sp;
 	const char *arg;
@@ -406,8 +407,10 @@ static int parse_ref_filter_atom(const struct ref_format *format,
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
@@ -432,8 +435,10 @@ static int parse_ref_filter_atom(const struct ref_format *format,
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
@@ -725,17 +730,21 @@ int verify_ref_format(struct ref_format *format)
 
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
@@ -2154,13 +2163,15 @@ int format_ref_array_item(struct ref_array_item *info,
 
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
+		if (pos < 0)
+			return -1;
+		get_ref_atom_value(info, pos, &atomv);
 		if (atomv->handler(atomv, &state, error_buf))
 			return -1;
 	}
@@ -2215,7 +2226,12 @@ static int parse_sorting_atom(const char *atom)
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
