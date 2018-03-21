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
	by dcvr.yhbt.net (Postfix) with ESMTP id 773531F404
	for <e@80x24.org>; Wed, 21 Mar 2018 18:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752684AbeCUS2w (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 14:28:52 -0400
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:36396
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752345AbeCUS2u (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 21 Mar 2018 14:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1521656929;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=zJKObfh6XivMzGq/fo+hlh7zeJubhrIu5p4m3wCzYCM=;
        b=FE8AcvquZ7TtwJC7u1HnzNyG8vbPwlGNk64inKxknJZSXa9pj1q17KtLaNWTn0kY
        uVXGbVGA1mQh8HdmrA7yPgKnD5MbUDi9+btCR1jyOpZ4D8/4FURpaKq5LZNw1muys+X
        q2447TIUT9Bqk2mQlVyf10B6C/xVls1s156vvYJo=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016249d21c96-29f058b0-a43d-45b7-9c1d-5ea2382858a2-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016249d21c40-0edf6647-4d26-46fc-8cfd-5a446b93a5e2-000000@eu-west-1.amazonses.com>
References: <0102016249d21c40-0edf6647-4d26-46fc-8cfd-5a446b93a5e2-000000@eu-west-1.amazonses.com>
Subject: [PATCH v5 4/6] ref-filter: change parsing function error handling
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Wed, 21 Mar 2018 18:28:49 +0000
X-SES-Outgoing: 2018.03.21-54.240.7.20
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
 ref-filter.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index f79c8c477f1dc..ca38728b4c998 100644
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
@@ -407,7 +408,8 @@ static int parse_ref_filter_atom(const struct ref_format *format,
 	if (*sp == '*' && sp < ep)
 		sp++; /* deref */
 	if (ep <= sp)
-		die(_("malformed field name: %.*s"), (int)(ep-atom), atom);
+		return strbuf_error(err, -1, _("malformed field name: %.*s"),
+				    (int)(ep-atom), atom);
 
 	/* Do we have the atom already used elsewhere? */
 	for (i = 0; i < used_atom_cnt; i++) {
@@ -433,7 +435,8 @@ static int parse_ref_filter_atom(const struct ref_format *format,
 	}
 
 	if (ARRAY_SIZE(valid_atom) <= i)
-		die(_("unknown field name: %.*s"), (int)(ep-atom), atom);
+		return strbuf_error(err, -1, _("unknown field name: %.*s"),
+				    (int)(ep-atom), atom);
 
 	/* Add it in, including the deref prefix */
 	at = used_atom_cnt;
@@ -715,17 +718,21 @@ int verify_ref_format(struct ref_format *format)
 
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
@@ -2144,13 +2151,15 @@ int format_ref_array_item(struct ref_array_item *info,
 
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
@@ -2203,7 +2212,12 @@ static int parse_sorting_atom(const char *atom)
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
