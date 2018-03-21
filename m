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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DED61F404
	for <e@80x24.org>; Wed, 21 Mar 2018 18:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752707AbeCUS25 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 14:28:57 -0400
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:36394
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752136AbeCUS2u (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 21 Mar 2018 14:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1521656929;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=DJsq8vgbgOPNdXilZ4uvqhoHC/5tlg+K8K3QEDcJt9g=;
        b=JkgDfWA158igtVyIxNrMztUXfgF3SV1zeBojkq6l+K24/4KpxLINeN5La1zc5fMQ
        b1Q4IN9bEJoaSOWe7p3BcxyUwTGALCpbUvTTI8SxjU6/BV4RSRlrrwmRTha8uKLNLAx
        x4vhj5Kvam+TtBHLUvFumualZje6CnDMp1E6YHOA=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016249d21c9b-260decf6-b3ce-45ed-ba68-5107cf482832-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016249d21c40-0edf6647-4d26-46fc-8cfd-5a446b93a5e2-000000@eu-west-1.amazonses.com>
References: <0102016249d21c40-0edf6647-4d26-46fc-8cfd-5a446b93a5e2-000000@eu-west-1.amazonses.com>
Subject: [PATCH v5 5/6] ref-filter: add return value to parsers
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

Change the signature of parsers by adding return value and
strbuf parameter for error message.
Return value equals 0 upon success and -1 upon failure.
Upon failure, error message is appended to the strbuf.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 ref-filter.c | 112 ++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 68 insertions(+), 44 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index ca38728b4c998..0ef7386b5fd20 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -101,22 +101,25 @@ static struct used_atom {
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
 
-static void color_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *color_value)
+static int color_atom_parser(const struct ref_format *format, struct used_atom *atom,
+			     const char *color_value, struct strbuf *err)
 {
 	if (!color_value)
-		die(_("expected format: %%(color:<color>)"));
+		return strbuf_error(err, -1, _("expected format: %%(color:<color>)"));
 	if (color_parse(color_value, atom->u.color) < 0)
-		die(_("unrecognized color: %%(color:%s)"), color_value);
+		return strbuf_error(err, -1, _("unrecognized color: %%(color:%s)"),
+				    color_value);
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
@@ -126,16 +129,18 @@ static void refname_atom_parser_internal(struct refname_atom *atom,
 		 skip_prefix(arg, "strip=", &arg)) {
 		atom->option = R_LSTRIP;
 		if (strtol_i(arg, 10, &atom->lstrip))
-			die(_("Integer value expected refname:lstrip=%s"), arg);
+			return strbuf_error(err, -1, _("Integer value expected refname:lstrip=%s"), arg);
 	} else if (skip_prefix(arg, "rstrip=", &arg)) {
 		atom->option = R_RSTRIP;
 		if (strtol_i(arg, 10, &atom->rstrip))
-			die(_("Integer value expected refname:rstrip=%s"), arg);
+			return strbuf_error(err, -1, _("Integer value expected refname:rstrip=%s"), arg);
 	} else
-		die(_("unrecognized %%(%s) argument: %s"), name, arg);
+		return strbuf_error(err, -1, _("unrecognized %%(%s) argument: %s"), name, arg);
+	return 0;
 }
 
-static void remote_ref_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
+static int remote_ref_atom_parser(const struct ref_format *format, struct used_atom *atom,
+				  const char *arg, struct strbuf *err)
 {
 	struct string_list params = STRING_LIST_INIT_DUP;
 	int i;
@@ -145,9 +150,8 @@ static void remote_ref_atom_parser(const struct ref_format *format, struct used_
 
 	if (!arg) {
 		atom->u.remote_ref.option = RR_REF;
-		refname_atom_parser_internal(&atom->u.remote_ref.refname,
-					     arg, atom->name);
-		return;
+		return refname_atom_parser_internal(&atom->u.remote_ref.refname,
+						    arg, atom->name, err);
 	}
 
 	atom->u.remote_ref.nobracket = 0;
@@ -170,29 +174,36 @@ static void remote_ref_atom_parser(const struct ref_format *format, struct used_
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
 	if (arg)
-		die(_("%%(body) does not take arguments"));
+		return strbuf_error(err, -1, _("%%(body) does not take arguments"));
 	atom->u.contents.option = C_BODY_DEP;
+	return 0;
 }
 
-static void subject_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
+static int subject_atom_parser(const struct ref_format *format, struct used_atom *atom,
+			       const char *arg, struct strbuf *err)
 {
 	if (arg)
-		die(_("%%(subject) does not take arguments"));
+		return strbuf_error(err, -1, _("%%(subject) does not take arguments"));
 	atom->u.contents.option = C_SUB;
+	return 0;
 }
 
-static void trailers_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
+static int trailers_atom_parser(const struct ref_format *format, struct used_atom *atom,
+				const char *arg, struct strbuf *err)
 {
 	struct string_list params = STRING_LIST_INIT_DUP;
 	int i;
@@ -206,14 +217,16 @@ static void trailers_atom_parser(const struct ref_format *format, struct used_at
 			else if (!strcmp(s, "only"))
 				atom->u.contents.trailer_opts.only_trailers = 1;
 			else
-				die(_("unknown %%(trailers) argument: %s"), s);
+				return strbuf_error(err, -1, _("unknown %%(trailers) argument: %s"), s);
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
@@ -225,16 +238,19 @@ static void contents_atom_parser(const struct ref_format *format, struct used_at
 		atom->u.contents.option = C_SUB;
 	else if (skip_prefix(arg, "trailers", &arg)) {
 		skip_prefix(arg, ":", &arg);
-		trailers_atom_parser(format, atom, *arg ? arg : NULL);
+		if (trailers_atom_parser(format, atom, *arg ? arg : NULL, err))
+			return -1;
 	} else if (skip_prefix(arg, "lines=", &arg)) {
 		atom->u.contents.option = C_LINES;
 		if (strtoul_ui(arg, 10, &atom->u.contents.nlines))
-			die(_("positive value expected contents:lines=%s"), arg);
+			return strbuf_error(err, -1, _("positive value expected contents:lines=%s"), arg);
 	} else
-		die(_("unrecognized %%(contents) argument: %s"), arg);
+		return strbuf_error(err, -1, _("unrecognized %%(contents) argument: %s"), arg);
+	return 0;
 }
 
-static void objectname_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
+static int objectname_atom_parser(const struct ref_format *format, struct used_atom *atom,
+				  const char *arg, struct strbuf *err)
 {
 	if (!arg)
 		atom->u.objectname.option = O_FULL;
@@ -244,16 +260,18 @@ static void objectname_atom_parser(const struct ref_format *format, struct used_
 		atom->u.objectname.option = O_LENGTH;
 		if (strtoul_ui(arg, 10, &atom->u.objectname.length) ||
 		    atom->u.objectname.length == 0)
-			die(_("positive value expected objectname:short=%s"), arg);
+			return strbuf_error(err, -1, _("positive value expected objectname:short=%s"), arg);
 		if (atom->u.objectname.length < MINIMUM_ABBREV)
 			atom->u.objectname.length = MINIMUM_ABBREV;
 	} else
-		die(_("unrecognized %%(objectname) argument: %s"), arg);
+		return strbuf_error(err, -1, _("unrecognized %%(objectname) argument: %s"), arg);
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
@@ -267,7 +285,8 @@ static align_type parse_align_position(const char *s)
 	return -1;
 }
 
-static void align_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
+static int align_atom_parser(const struct ref_format *format, struct used_atom *atom,
+			     const char *arg, struct strbuf *err)
 {
 	struct align *align = &atom->u.align;
 	struct string_list params = STRING_LIST_INIT_DUP;
@@ -275,7 +294,7 @@ static void align_atom_parser(const struct ref_format *format, struct used_atom
 	unsigned int width = ~0U;
 
 	if (!arg)
-		die(_("expected format: %%(align:<width>,<position>)"));
+		return strbuf_error(err, -1, _("expected format: %%(align:<width>,<position>)"));
 
 	align->position = ALIGN_LEFT;
 
@@ -287,48 +306,53 @@ static void align_atom_parser(const struct ref_format *format, struct used_atom
 		if (skip_prefix(s, "position=", &s)) {
 			position = parse_align_position(s);
 			if (position < 0)
-				die(_("unrecognized position:%s"), s);
+				return strbuf_error(err, -1, _("unrecognized position:%s"), s);
 			align->position = position;
 		} else if (skip_prefix(s, "width=", &s)) {
 			if (strtoul_ui(s, 10, &width))
-				die(_("unrecognized width:%s"), s);
+				return strbuf_error(err, -1, _("unrecognized width:%s"), s);
 		} else if (!strtoul_ui(s, 10, &width))
 			;
 		else if ((position = parse_align_position(s)) >= 0)
 			align->position = position;
 		else
-			die(_("unrecognized %%(align) argument: %s"), s);
+			return strbuf_error(err, -1, _("unrecognized %%(align) argument: %s"), s);
 	}
 
 	if (width == ~0U)
-		die(_("positive width expected with the %%(align) atom"));
+		return strbuf_error(err, -1, _("positive width expected with the %%(align) atom"));
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
-	} else {
-		die(_("unrecognized %%(if) argument: %s"), arg);
-	}
+	} else
+		return strbuf_error(err, -1, _("unrecognized %%(if) argument: %s"), arg);
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
@@ -455,8 +479,8 @@ static int parse_ref_filter_atom(const struct ref_format *format,
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
