Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09EE9202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 15:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752429AbdGMPGs (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 11:06:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:39144 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751280AbdGMPGr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 11:06:47 -0400
Received: (qmail 24344 invoked by uid 109); 13 Jul 2017 15:06:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 15:06:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32237 invoked by uid 111); 13 Jul 2017 15:06:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 11:06:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jul 2017 11:06:40 -0400
Date:   Thu, 13 Jul 2017 11:06:40 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 10/15] ref-filter: pass ref_format struct to atom parsers
Message-ID: <20170713150640.qnefucyb4buggo6q@sigill.intra.peff.net>
References: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The callback for parsing each formatting atom gets to see
only the atom struct (which it's filling in) and the text to
be parsed. This doesn't leave any room for it to behave
differently based on context known only to the ref_format.

We can solve this by passing in the surrounding ref_format
to each parser. Note that this makes things slightly awkward
for sort strings, which parse atoms without having a
ref_format. We'll solve that by using a dummy ref_format
with default parameters.

Signed-off-by: Jeff King <peff@peff.net>
---
If we eventually do move used_atoms into the format, we'd probably need
to either have a separate ref_format for the sorting atoms, or have them
share with the struct used for actual formatting. At this point I don't
think it matters at all. You can do nonsense like:

  git for-each-ref --sort='%(color:red)'

and after this series it will not respect your color.ui setting. But
since in either case it's a ridiculous sort key (whether it shows the
color or not, it's the same for all refs and so can't affect the
sorting), it's not worth caring about.

If we do eventually refactor ref_format more such that the dummy struct
doesn't cut it, I think we can deal with the issue then.

 ref-filter.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 080f5aceb..129a63677 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -98,7 +98,7 @@ static struct used_atom {
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
 
-static void color_atom_parser(struct used_atom *atom, const char *color_value)
+static void color_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *color_value)
 {
 	if (!color_value)
 		die(_("expected format: %%(color:<color>)"));
@@ -126,7 +126,7 @@ static void refname_atom_parser_internal(struct refname_atom *atom,
 		die(_("unrecognized %%(%s) argument: %s"), name, arg);
 }
 
-static void remote_ref_atom_parser(struct used_atom *atom, const char *arg)
+static void remote_ref_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
 {
 	struct string_list params = STRING_LIST_INIT_DUP;
 	int i;
@@ -160,28 +160,28 @@ static void remote_ref_atom_parser(struct used_atom *atom, const char *arg)
 	string_list_clear(&params, 0);
 }
 
-static void body_atom_parser(struct used_atom *atom, const char *arg)
+static void body_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
 {
 	if (arg)
 		die(_("%%(body) does not take arguments"));
 	atom->u.contents.option = C_BODY_DEP;
 }
 
-static void subject_atom_parser(struct used_atom *atom, const char *arg)
+static void subject_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
 {
 	if (arg)
 		die(_("%%(subject) does not take arguments"));
 	atom->u.contents.option = C_SUB;
 }
 
-static void trailers_atom_parser(struct used_atom *atom, const char *arg)
+static void trailers_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
 {
 	if (arg)
 		die(_("%%(trailers) does not take arguments"));
 	atom->u.contents.option = C_TRAILERS;
 }
 
-static void contents_atom_parser(struct used_atom *atom, const char *arg)
+static void contents_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
 {
 	if (!arg)
 		atom->u.contents.option = C_BARE;
@@ -201,7 +201,7 @@ static void contents_atom_parser(struct used_atom *atom, const char *arg)
 		die(_("unrecognized %%(contents) argument: %s"), arg);
 }
 
-static void objectname_atom_parser(struct used_atom *atom, const char *arg)
+static void objectname_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
 {
 	if (!arg)
 		atom->u.objectname.option = O_FULL;
@@ -218,7 +218,7 @@ static void objectname_atom_parser(struct used_atom *atom, const char *arg)
 		die(_("unrecognized %%(objectname) argument: %s"), arg);
 }
 
-static void refname_atom_parser(struct used_atom *atom, const char *arg)
+static void refname_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
 {
 	refname_atom_parser_internal(&atom->u.refname, arg, atom->name);
 }
@@ -234,7 +234,7 @@ static align_type parse_align_position(const char *s)
 	return -1;
 }
 
-static void align_atom_parser(struct used_atom *atom, const char *arg)
+static void align_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
 {
 	struct align *align = &atom->u.align;
 	struct string_list params = STRING_LIST_INIT_DUP;
@@ -273,7 +273,7 @@ static void align_atom_parser(struct used_atom *atom, const char *arg)
 	string_list_clear(&params, 0);
 }
 
-static void if_atom_parser(struct used_atom *atom, const char *arg)
+static void if_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
 {
 	if (!arg) {
 		atom->u.if_then_else.cmp_status = COMPARE_NONE;
@@ -287,7 +287,7 @@ static void if_atom_parser(struct used_atom *atom, const char *arg)
 	}
 }
 
-static void head_atom_parser(struct used_atom *atom, const char *arg)
+static void head_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
 {
 	struct object_id unused;
 
@@ -297,7 +297,7 @@ static void head_atom_parser(struct used_atom *atom, const char *arg)
 static struct {
 	const char *name;
 	cmp_type cmp_type;
-	void (*parser)(struct used_atom *atom, const char *arg);
+	void (*parser)(const struct ref_format *format, struct used_atom *atom, const char *arg);
 } valid_atom[] = {
 	{ "refname" , FIELD_STR, refname_atom_parser },
 	{ "objecttype" },
@@ -364,7 +364,8 @@ struct atom_value {
 /*
  * Used to parse format string and sort specifiers
  */
-static int parse_ref_filter_atom(const char *atom, const char *ep)
+static int parse_ref_filter_atom(const struct ref_format *format,
+				 const char *atom, const char *ep)
 {
 	const char *sp;
 	const char *arg;
@@ -412,7 +413,7 @@ static int parse_ref_filter_atom(const char *atom, const char *ep)
 		arg = used_atom[at].name + (arg - atom) + 1;
 	memset(&used_atom[at].u, 0, sizeof(used_atom[at].u));
 	if (valid_atom[i].parser)
-		valid_atom[i].parser(&used_atom[at], arg);
+		valid_atom[i].parser(format, &used_atom[at], arg);
 	if (*atom == '*')
 		need_tagged = 1;
 	if (!strcmp(valid_atom[i].name, "symref"))
@@ -668,7 +669,7 @@ int verify_ref_format(struct ref_format *format)
 		if (!ep)
 			return error(_("malformed format string %s"), sp);
 		/* sp points at "%(" and ep points at the closing ")" */
-		at = parse_ref_filter_atom(sp + 2, ep);
+		at = parse_ref_filter_atom(format, sp + 2, ep);
 		cp = ep + 1;
 
 		if (skip_prefix(used_atom[at].name, "color:", &color))
@@ -2075,7 +2076,9 @@ void format_ref_array_item(struct ref_array_item *info,
 		ep = strchr(sp, ')');
 		if (cp < sp)
 			append_literal(cp, sp, &state);
-		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
+		get_ref_atom_value(info,
+				   parse_ref_filter_atom(format, sp + 2, ep),
+				   &atomv);
 		atomv->handler(atomv, &state);
 	}
 	if (*cp) {
@@ -2116,8 +2119,13 @@ void pretty_print_ref(const char *name, const unsigned char *sha1,
 
 static int parse_sorting_atom(const char *atom)
 {
+	/*
+	 * This parses an atom using a dummy ref_format, since we don't
+	 * actually care about the formatting details.
+	 */
+	struct ref_format dummy = REF_FORMAT_INIT;
 	const char *end = atom + strlen(atom);
-	return parse_ref_filter_atom(atom, end);
+	return parse_ref_filter_atom(&dummy, atom, end);
 }
 
 /*  If no sorting option is given, use refname to sort as default */
-- 
2.13.2.1157.gc6daca446

