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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F98F1F404
	for <e@80x24.org>; Mon, 19 Mar 2018 13:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932889AbeCSNBO (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:01:14 -0400
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:34052
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755531AbeCSNBC (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Mar 2018 09:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1521464461;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=MOnaS5nYKNL0JB8Qv6tiHtOp+1xas7Ktvuw5hPNfxWU=;
        b=t84C5XhHg7Jj4H8yzWugAPGl6W2PUoaYLR2s7JtCAoU1KVS68MrGFsf1+CGBXDAn
        4UrM9fBlCat0jbqB0dgneOIc967jgtFjW7F9qDEKx7tsvZi8augtr4kVQ86RadKkqdh
        Ib2BvSbt/AYpwJ+A7YygRf4RpSnKAgtDOTdDoPXw=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <010201623e5944bd-e932aceb-2d30-4940-89e1-130b99f6ed81-000000@eu-west-1.amazonses.com>
In-Reply-To: <010201623e594401-906aa5ca-545b-405a-810a-607491fe09a7-000000@eu-west-1.amazonses.com>
References: <010201623e594401-906aa5ca-545b-405a-810a-607491fe09a7-000000@eu-west-1.amazonses.com>
Subject: [PATCH v3 4/5] ref-filter: add return value to parsers
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 19 Mar 2018 13:01:00 +0000
X-SES-Outgoing: 2018.03.19-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Continue removing any printing from ref-filter formatting logic,
so that it could be more general.

Change the signature of parsers by adding return value and
strbuf parameter for error message.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 ref-filter.c | 177 +++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 118 insertions(+), 59 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 2313a33f0baa4..b90cec1056954 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -101,22 +101,28 @@ static struct used_atom {
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
 
-static void color_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *color_value)
+static int color_atom_parser(const struct ref_format *format, struct used_atom *atom,
+			     const char *color_value, struct strbuf *err)
 {
-	if (!color_value)
-		die(_("expected format: %%(color:<color>)"));
-	if (color_parse(color_value, atom->u.color) < 0)
-		die(_("unrecognized color: %%(color:%s)"), color_value);
+	if (!color_value) {
+		strbuf_addstr(err, _("expected format: %(color:<color>)"));
+		return -1;
+	}
+	if (color_parse(color_value, atom->u.color) < 0) {
+		strbuf_addf(err, _("unrecognized color: %%(color:%s)"), color_value);
+		return -1;
+	}
 	/*
 	 * We check this after we've parsed the color, which lets us complain
 	 * about syntactically bogus color names even if they won't be used.
 	 */
 	if (!want_color(format->use_color))
 		color_parse("", atom->u.color);
+	return 0;
 }
 
-static void refname_atom_parser_internal(struct refname_atom *atom,
-					 const char *arg, const char *name)
+static int refname_atom_parser_internal(struct refname_atom *atom, const char *arg,
+					 const char *name, struct strbuf *err)
 {
 	if (!arg)
 		atom->option = R_NORMAL;
@@ -125,17 +131,25 @@ static void refname_atom_parser_internal(struct refname_atom *atom,
 	else if (skip_prefix(arg, "lstrip=", &arg) ||
 		 skip_prefix(arg, "strip=", &arg)) {
 		atom->option = R_LSTRIP;
-		if (strtol_i(arg, 10, &atom->lstrip))
-			die(_("Integer value expected refname:lstrip=%s"), arg);
+		if (strtol_i(arg, 10, &atom->lstrip)) {
+			strbuf_addf(err, _("Integer value expected refname:lstrip=%s"), arg);
+			return -1;
+		}
 	} else if (skip_prefix(arg, "rstrip=", &arg)) {
 		atom->option = R_RSTRIP;
-		if (strtol_i(arg, 10, &atom->rstrip))
-			die(_("Integer value expected refname:rstrip=%s"), arg);
-	} else
-		die(_("unrecognized %%(%s) argument: %s"), name, arg);
+		if (strtol_i(arg, 10, &atom->rstrip)) {
+			strbuf_addf(err, _("Integer value expected refname:rstrip=%s"), arg);
+			return -1;
+		}
+	} else {
+		strbuf_addf(err, _("unrecognized %%(%s) argument: %s"), name, arg);
+		return -1;
+	}
+	return 0;
 }
 
-static void remote_ref_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
+static int remote_ref_atom_parser(const struct ref_format *format, struct used_atom *atom,
+				  const char *arg, struct strbuf *err)
 {
 	struct string_list params = STRING_LIST_INIT_DUP;
 	int i;
@@ -145,9 +159,8 @@ static void remote_ref_atom_parser(const struct ref_format *format, struct used_
 
 	if (!arg) {
 		atom->u.remote_ref.option = RR_REF;
-		refname_atom_parser_internal(&atom->u.remote_ref.refname,
-					     arg, atom->name);
-		return;
+		return refname_atom_parser_internal(&atom->u.remote_ref.refname,
+						    arg, atom->name, err);
 	}
 
 	atom->u.remote_ref.nobracket = 0;
@@ -170,29 +183,40 @@ static void remote_ref_atom_parser(const struct ref_format *format, struct used_
 			atom->u.remote_ref.push_remote = 1;
 		} else {
 			atom->u.remote_ref.option = RR_REF;
-			refname_atom_parser_internal(&atom->u.remote_ref.refname,
-						     arg, atom->name);
+			if (refname_atom_parser_internal(&atom->u.remote_ref.refname,
+							 arg, atom->name, err))
+				return -1;
 		}
 	}
 
 	string_list_clear(&params, 0);
+	return 0;
 }
 
-static void body_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
+static int body_atom_parser(const struct ref_format *format, struct used_atom *atom,
+			    const char *arg, struct strbuf *err)
 {
-	if (arg)
-		die(_("%%(body) does not take arguments"));
+	if (arg) {
+		strbuf_addstr(err, _("%(body) does not take arguments"));
+		return -1;
+	}
 	atom->u.contents.option = C_BODY_DEP;
+	return 0;
 }
 
-static void subject_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
+static int subject_atom_parser(const struct ref_format *format, struct used_atom *atom,
+			       const char *arg, struct strbuf *err)
 {
-	if (arg)
-		die(_("%%(subject) does not take arguments"));
+	if (arg) {
+		strbuf_addstr(err, _("%(subject) does not take arguments"));
+		return -1;
+	}
 	atom->u.contents.option = C_SUB;
+	return 0;
 }
 
-static void trailers_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
+static int trailers_atom_parser(const struct ref_format *format, struct used_atom *atom,
+				const char *arg, struct strbuf *err)
 {
 	struct string_list params = STRING_LIST_INIT_DUP;
 	int i;
@@ -205,15 +229,19 @@ static void trailers_atom_parser(const struct ref_format *format, struct used_at
 				atom->u.contents.trailer_opts.unfold = 1;
 			else if (!strcmp(s, "only"))
 				atom->u.contents.trailer_opts.only_trailers = 1;
-			else
-				die(_("unknown %%(trailers) argument: %s"), s);
+			else {
+				strbuf_addf(err, _("unknown %%(trailers) argument: %s"), s);
+				return -1;
+			}
 		}
 	}
 	atom->u.contents.option = C_TRAILERS;
 	string_list_clear(&params, 0);
+	return 0;
 }
 
-static void contents_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
+static int contents_atom_parser(const struct ref_format *format, struct used_atom *atom,
+				const char *arg, struct strbuf *err)
 {
 	if (!arg)
 		atom->u.contents.option = C_BARE;
@@ -225,16 +253,23 @@ static void contents_atom_parser(const struct ref_format *format, struct used_at
 		atom->u.contents.option = C_SUB;
 	else if (skip_prefix(arg, "trailers", &arg)) {
 		skip_prefix(arg, ":", &arg);
-		trailers_atom_parser(format, atom, *arg ? arg : NULL);
+		if (trailers_atom_parser(format, atom, *arg ? arg : NULL, err))
+			return -1;
 	} else if (skip_prefix(arg, "lines=", &arg)) {
 		atom->u.contents.option = C_LINES;
-		if (strtoul_ui(arg, 10, &atom->u.contents.nlines))
-			die(_("positive value expected contents:lines=%s"), arg);
-	} else
-		die(_("unrecognized %%(contents) argument: %s"), arg);
+		if (strtoul_ui(arg, 10, &atom->u.contents.nlines)) {
+			strbuf_addf(err, _("positive value expected contents:lines=%s"), arg);
+			return -1;
+		}
+	} else {
+		strbuf_addf(err, _("unrecognized %%(contents) argument: %s"), arg);
+		return -1;
+	}
+	return 0;
 }
 
-static void objectname_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
+static int objectname_atom_parser(const struct ref_format *format, struct used_atom *atom,
+				  const char *arg, struct strbuf *err)
 {
 	if (!arg)
 		atom->u.objectname.option = O_FULL;
@@ -243,17 +278,23 @@ static void objectname_atom_parser(const struct ref_format *format, struct used_
 	else if (skip_prefix(arg, "short=", &arg)) {
 		atom->u.objectname.option = O_LENGTH;
 		if (strtoul_ui(arg, 10, &atom->u.objectname.length) ||
-		    atom->u.objectname.length == 0)
-			die(_("positive value expected objectname:short=%s"), arg);
+		    atom->u.objectname.length == 0) {
+			strbuf_addf(err, _("positive value expected objectname:short=%s"), arg);
+			return -1;
+		}
 		if (atom->u.objectname.length < MINIMUM_ABBREV)
 			atom->u.objectname.length = MINIMUM_ABBREV;
-	} else
-		die(_("unrecognized %%(objectname) argument: %s"), arg);
+	} else {
+		strbuf_addf(err, _("unrecognized %%(objectname) argument: %s"), arg);
+		return -1;
+	}
+	return 0;
 }
 
-static void refname_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
+static int refname_atom_parser(const struct ref_format *format, struct used_atom *atom,
+			       const char *arg, struct strbuf *err)
 {
-	refname_atom_parser_internal(&atom->u.refname, arg, atom->name);
+	return refname_atom_parser_internal(&atom->u.refname, arg, atom->name, err);
 }
 
 static align_type parse_align_position(const char *s)
@@ -267,15 +308,18 @@ static align_type parse_align_position(const char *s)
 	return -1;
 }
 
-static void align_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
+static int align_atom_parser(const struct ref_format *format, struct used_atom *atom,
+			     const char *arg, struct strbuf *err)
 {
 	struct align *align = &atom->u.align;
 	struct string_list params = STRING_LIST_INIT_DUP;
 	int i;
 	unsigned int width = ~0U;
 
-	if (!arg)
-		die(_("expected format: %%(align:<width>,<position>)"));
+	if (!arg) {
+		strbuf_addstr(err, _("expected format: %(align:<width>,<position>)"));
+		return -1;
+	}
 
 	align->position = ALIGN_LEFT;
 
@@ -286,49 +330,64 @@ static void align_atom_parser(const struct ref_format *format, struct used_atom
 
 		if (skip_prefix(s, "position=", &s)) {
 			position = parse_align_position(s);
-			if (position < 0)
-				die(_("unrecognized position:%s"), s);
+			if (position < 0) {
+				strbuf_addf(err, _("unrecognized position:%s"), s);
+				return -1;
+			}
 			align->position = position;
 		} else if (skip_prefix(s, "width=", &s)) {
-			if (strtoul_ui(s, 10, &width))
-				die(_("unrecognized width:%s"), s);
+			if (strtoul_ui(s, 10, &width)) {
+				strbuf_addf(err, _("unrecognized width:%s"), s);
+				return -1;
+			}
 		} else if (!strtoul_ui(s, 10, &width))
 			;
 		else if ((position = parse_align_position(s)) >= 0)
 			align->position = position;
-		else
-			die(_("unrecognized %%(align) argument: %s"), s);
+		else {
+			strbuf_addf(err, _("unrecognized %%(align) argument: %s"), s);
+			return -1;
+		}
 	}
 
-	if (width == ~0U)
-		die(_("positive width expected with the %%(align) atom"));
+	if (width == ~0U) {
+		strbuf_addstr(err, _("positive width expected with the %(align) atom"));
+		return -1;
+	}
 	align->width = width;
 	string_list_clear(&params, 0);
+	return 0;
 }
 
-static void if_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
+static int if_atom_parser(const struct ref_format *format, struct used_atom *atom,
+			  const char *arg, struct strbuf *err)
 {
 	if (!arg) {
 		atom->u.if_then_else.cmp_status = COMPARE_NONE;
-		return;
+		return 0;
 	} else if (skip_prefix(arg, "equals=", &atom->u.if_then_else.str)) {
 		atom->u.if_then_else.cmp_status = COMPARE_EQUAL;
 	} else if (skip_prefix(arg, "notequals=", &atom->u.if_then_else.str)) {
 		atom->u.if_then_else.cmp_status = COMPARE_UNEQUAL;
 	} else {
-		die(_("unrecognized %%(if) argument: %s"), arg);
+		strbuf_addf(err, _("unrecognized %%(if) argument: %s"), arg);
+		return -1;
 	}
+	return 0;
 }
 
-static void head_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
+static int head_atom_parser(const struct ref_format *format, struct used_atom *atom,
+			    const char *arg, struct strbuf *err)
 {
 	atom->u.head = resolve_refdup("HEAD", RESOLVE_REF_READING, NULL, NULL);
+	return 0;
 }
 
 static struct {
 	const char *name;
 	cmp_type cmp_type;
-	void (*parser)(const struct ref_format *format, struct used_atom *atom, const char *arg);
+	int (*parser)(const struct ref_format *format, struct used_atom *atom,
+		      const char *arg, struct strbuf *err);
 } valid_atom[] = {
 	{ "refname" , FIELD_STR, refname_atom_parser },
 	{ "objecttype" },
@@ -457,8 +516,8 @@ static int parse_ref_filter_atom(const struct ref_format *format,
 		}
 	}
 	memset(&used_atom[at].u, 0, sizeof(used_atom[at].u));
-	if (valid_atom[i].parser)
-		valid_atom[i].parser(format, &used_atom[at], arg);
+	if (valid_atom[i].parser && valid_atom[i].parser(format, &used_atom[at], arg, err))
+		return -1;
 	if (*atom == '*')
 		need_tagged = 1;
 	if (!strcmp(valid_atom[i].name, "symref"))

--
https://github.com/git/git/pull/466
