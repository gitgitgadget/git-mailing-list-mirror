Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4C4EB64D9
	for <git@archiver.kernel.org>; Sat, 17 Jun 2023 20:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjFQUnX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jun 2023 16:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjFQUnW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jun 2023 16:43:22 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64876100
        for <git@vger.kernel.org>; Sat, 17 Jun 2023 13:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687034597; x=1687639397; i=l.s.r@web.de;
 bh=tgptdcUzXi99wTKXokTVpV9uxwmfPepeNmVGK+wJiOI=;
 h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
 b=jMbM7VNbQcRvIUyOLWSXSzMv07bHiR/7ASivW9pYM8Eabog8IcpVhyk7e0fbBU0MQVrLoz7
 ZUeEXZuXbQPp7Vut3KRAeVFE7HidWUHhRWSMEGz5ayDcOLdQnVSRHY22cUWXOKYQxO9g8wJ17
 K/CYoTs1Xi7j2BA8D3we7VyjvDq5uANx5mNs5dUoTOuRgMgyKjNv1NpNClAa4AZXX88lGCT19
 8UY5bcstlwtAOv7GL7juz/t9ov9RcEqRWdbgvFLIyh5WyXRMcT6uwBf/7vsjoRtIlC4Q1pKMF
 ipaOxi0XDbYpOgv1oH0qdxh082XYNvjrPE1W/Z+RF2PN1Osl1ClA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.157.195]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgAJ8-1pc5dL2qOE-00hsen for
 <git@vger.kernel.org>; Sat, 17 Jun 2023 22:43:17 +0200
Message-ID: <150df0b0-0548-f291-2b68-960841dd1c97@web.de>
Date:   Sat, 17 Jun 2023 22:43:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: [PATCH 4/5] replace strbuf_expand() with strbuf_expand_step()
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
References: <767baa64-20a6-daf2-d34b-d81f72363749@web.de>
In-Reply-To: <767baa64-20a6-daf2-d34b-d81f72363749@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4HVFmAZpigKGmVZtEWZCb80paqi2ezhmdHk8O+76RLfLLLjYo7V
 ZEiU9uPe2asERBxuK275i7rtFLmU7zEnpzgoZmrXyMWoxAA6Ua4YTLSBEis84iqfobX1D8o
 r8j3jOau3AfCpTxU6AOnUw0uaUhXiXUpO+OnJsAGDGWoMEK8ParaMzutVLeDgF817FAYSW9
 v7wcri6WOVnj7o2PgKxcw==
UI-OutboundReport: notjunk:1;M01:P0:PXIe1365S08=;deTiHhC4Mhn0kAWqBoFuEocSxKE
 HygCjmDnKkB/PZefeu02ntUSdKzcjCiTu5WiaIS/t229RE5WS5kLg7qv7XaOduYt2+jA78vFu
 iNeuqiTEaliVrzqH07VlA/TxB5aJOmrPHX3buUQpcrWqHyLDj/bVRmbVJPnX2/l3xJzO4tWxW
 6lE0eeG+smIP3KnnRMVrdGFSTufK/GTdWbDDjhRY7YB4ElEkn53lnTA6G9/aS33V5SM95IHN7
 zV4j0SwX4wGF1NJmCXWETOYq6Y5gu0kbQPNcdYCDaS6el/Q4p/fFcpztTX2thB9IJUHlllack
 /euKW0IGtYCxbuxKGVWG9TQDHZnkO1s3nD0io5I/5OZsUBdFN/iVmqNt6d9tgZK4q8AUwXzIO
 DET5IUbUJJWDCFkaWy/yz8/LbcxS73zktPnxQycH5nfIuiwMluBbjtWV+O3xTYs2GNW62fP7z
 BydEx/B/H7JRU5fo6fVLNQuu/f6Gpk2B0HifqHoWhiTbn07U0JF1IsMZkfJdtOLE3br3AJzSa
 AHE9pzeand3nYxbQterSQjAIPFjO3QSrXF6EyKtYNUc5qP97tEn9X7qDXFW6dx9V5gAJFzWoM
 9ItXTHHEkGdl4fwolLytSdNF35xEBDm1b3B621Ex/J/zm5PMJX7CtPIpYzit+BFDY/64RFO08
 h3byflxuWrBdMh1/X4tje96QubO0W1/u/4C7NGSDkNpoiUeEq6xPT4vKYeER8Ec37lmyobzUk
 EtfiHHMY9vTY/WqxMmOencO2kbC4afNGd5ZxoNRSujJOe4QZEIMnFXyHsPC+Nys4NZwWu6Io8
 r8RIfPDFm6kF59XjnaUf2zc95U6sLV7UqGS5+OIGO/utSQUCCBPkCI8NGh+LRI5+o5jV0oMQK
 RFYyABaObX1zmWJFAtkqMilVYkSNo4Fa1RCkxSb1ONOtmUd1rekQ9lQKO2pqSRIT6H3ElEhZd
 MYC42w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid the overhead of passing context to a callback function of
strbuf_expand() by using strbuf_expand_step() in a loop instead.  It
requires explicit handling of %% and unrecognized placeholders, but is
simpler, more direct and avoids void pointers.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/cat-file.c |  35 +++++++--------
 builtin/ls-files.c | 109 +++++++++++++++++++--------------------------
 builtin/ls-tree.c  | 107 +++++++++++++++++---------------------------
 daemon.c           |  61 ++++++++-----------------
 pretty.c           |  72 ++++++++++++++++++------------
 strbuf.c           |  20 ---------
 strbuf.h           |  37 ++-------------
 7 files changed, 169 insertions(+), 272 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 0bafc14e6c..424f39675b 100644
=2D-- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -309,10 +309,8 @@ static int is_atom(const char *atom, const char *s, i=
nt slen)
 }

 static void expand_atom(struct strbuf *sb, const char *atom, int len,
-			void *vdata)
+			struct expand_data *data)
 {
-	struct expand_data *data =3D vdata;
-
 	if (is_atom("objectname", atom, len)) {
 		if (!data->mark_query)
 			strbuf_addstr(sb, oid_to_hex(&data->oid));
@@ -346,19 +344,21 @@ static void expand_atom(struct strbuf *sb, const cha=
r *atom, int len,
 		die("unknown format element: %.*s", len, atom);
 }

-static size_t expand_format(struct strbuf *sb, const char *start, void *d=
ata)
+static void expand_format(struct strbuf *sb, const char *start,
+			  struct expand_data *data)
 {
-	const char *end;
-
-	if (*start !=3D '(')
-		return 0;
-	end =3D strchr(start + 1, ')');
-	if (!end)
-		die("format element '%s' does not end in ')'", start);
-
-	expand_atom(sb, start + 1, end - start - 1, data);
-
-	return end - start + 1;
+	while (strbuf_expand_step(sb, &start)) {
+		const char *end;
+
+		if (skip_prefix(start, "%", &start) || *start !=3D '(')
+			strbuf_addch(sb, '%');
+		else if (!(end =3D strchr(start + 1, ')')))
+			die("format element '%s' does not end in ')'", start);
+		else {
+			expand_atom(sb, start + 1, end - start - 1, data);
+			start =3D end + 1;
+		}
+	}
 }

 static void batch_write(struct batch_options *opt, const void *data, int =
len)
@@ -494,7 +494,7 @@ static void batch_object_write(const char *obj_name,
 	if (!opt->format) {
 		print_default_format(scratch, data);
 	} else {
-		strbuf_expand(scratch, opt->format, expand_format, data);
+		expand_format(scratch, opt->format, data);
 		strbuf_addch(scratch, '\n');
 	}

@@ -777,9 +777,8 @@ static int batch_objects(struct batch_options *opt)
 	 */
 	memset(&data, 0, sizeof(data));
 	data.mark_query =3D 1;
-	strbuf_expand(&output,
+	expand_format(&output,
 		      opt->format ? opt->format : DEFAULT_FORMAT,
-		      expand_format,
 		      &data);
 	data.mark_query =3D 0;
 	strbuf_release(&output);
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 72012c0f0f..03bf5771b4 100644
=2D-- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -262,74 +262,57 @@ static void expand_objectsize(struct strbuf *line, c=
onst struct object_id *oid,
 		strbuf_addstr(line, "-");
 	}
 }
-struct show_index_data {
-	const char *pathname;
-	struct index_state *istate;
-	const struct cache_entry *ce;
-};
-
-static size_t expand_show_index(struct strbuf *sb, const char *start,
-				void *context)
-{
-	struct show_index_data *data =3D context;
-	const char *end;
-	const char *p;
-	size_t len =3D strbuf_expand_literal_cb(sb, start, NULL);
-	struct stat st;
-
-	if (len)
-		return len;
-	if (*start !=3D '(')
-		die(_("bad ls-files format: element '%s' "
-		      "does not start with '('"), start);
-
-	end =3D strchr(start + 1, ')');
-	if (!end)
-		die(_("bad ls-files format: element '%s' "
-		      "does not end in ')'"), start);
-
-	len =3D end - start + 1;
-	if (skip_prefix(start, "(objectmode)", &p))
-		strbuf_addf(sb, "%06o", data->ce->ce_mode);
-	else if (skip_prefix(start, "(objectname)", &p))
-		strbuf_add_unique_abbrev(sb, &data->ce->oid, abbrev);
-	else if (skip_prefix(start, "(objecttype)", &p))
-		strbuf_addstr(sb, type_name(object_type(data->ce->ce_mode)));
-	else if (skip_prefix(start, "(objectsize:padded)", &p))
-		expand_objectsize(sb, &data->ce->oid, object_type(data->ce->ce_mode), 1=
);
-	else if (skip_prefix(start, "(objectsize)", &p))
-		expand_objectsize(sb, &data->ce->oid, object_type(data->ce->ce_mode), 0=
);
-	else if (skip_prefix(start, "(stage)", &p))
-		strbuf_addf(sb, "%d", ce_stage(data->ce));
-	else if (skip_prefix(start, "(eolinfo:index)", &p))
-		strbuf_addstr(sb, S_ISREG(data->ce->ce_mode) ?
-			      get_cached_convert_stats_ascii(data->istate,
-			      data->ce->name) : "");
-	else if (skip_prefix(start, "(eolinfo:worktree)", &p))
-		strbuf_addstr(sb, !lstat(data->pathname, &st) &&
-			      S_ISREG(st.st_mode) ?
-			      get_wt_convert_stats_ascii(data->pathname) : "");
-	else if (skip_prefix(start, "(eolattr)", &p))
-		strbuf_addstr(sb, get_convert_attr_ascii(data->istate,
-			      data->pathname));
-	else if (skip_prefix(start, "(path)", &p))
-		write_name_to_buf(sb, data->pathname);
-	else
-		die(_("bad ls-files format: %%%.*s"), (int)len, start);
-
-	return len;
-}

 static void show_ce_fmt(struct repository *repo, const struct cache_entry=
 *ce,
 			const char *format, const char *fullname) {
-	struct show_index_data data =3D {
-		.pathname =3D fullname,
-		.istate =3D repo->index,
-		.ce =3D ce,
-	};
 	struct strbuf sb =3D STRBUF_INIT;

-	strbuf_expand(&sb, format, expand_show_index, &data);
+	while (strbuf_expand_step(&sb, &format)) {
+		const char *end;
+		size_t len;
+		struct stat st;
+
+		if (skip_prefix(format, "%", &format))
+			strbuf_addch(&sb, '%');
+		else if ((len =3D strbuf_expand_literal_cb(&sb, format, NULL)))
+			format +=3D len;
+		else if (*format !=3D '(')
+			die(_("bad ls-files format: element '%s' "
+			      "does not start with '('"), format);
+		else if (!(end =3D strchr(format + 1, ')')))
+			die(_("bad ls-files format: element '%s' "
+			      "does not end in ')'"), format);
+		else if (skip_prefix(format, "(objectmode)", &format))
+			strbuf_addf(&sb, "%06o", ce->ce_mode);
+		else if (skip_prefix(format, "(objectname)", &format))
+			strbuf_add_unique_abbrev(&sb, &ce->oid, abbrev);
+		else if (skip_prefix(format, "(objecttype)", &format))
+			strbuf_addstr(&sb, type_name(object_type(ce->ce_mode)));
+		else if (skip_prefix(format, "(objectsize:padded)", &format))
+			expand_objectsize(&sb, &ce->oid,
+					  object_type(ce->ce_mode), 1);
+		else if (skip_prefix(format, "(objectsize)", &format))
+			expand_objectsize(&sb, &ce->oid,
+					  object_type(ce->ce_mode), 0);
+		else if (skip_prefix(format, "(stage)", &format))
+			strbuf_addf(&sb, "%d", ce_stage(ce));
+		else if (skip_prefix(format, "(eolinfo:index)", &format))
+			strbuf_addstr(&sb, S_ISREG(ce->ce_mode) ?
+				      get_cached_convert_stats_ascii(repo->index,
+				      ce->name) : "");
+		else if (skip_prefix(format, "(eolinfo:worktree)", &format))
+			strbuf_addstr(&sb, !lstat(fullname, &st) &&
+				      S_ISREG(st.st_mode) ?
+				      get_wt_convert_stats_ascii(fullname) : "");
+		else if (skip_prefix(format, "(eolattr)", &format))
+			strbuf_addstr(&sb, get_convert_attr_ascii(repo->index,
+								 fullname));
+		else if (skip_prefix(format, "(path)", &format))
+			write_name_to_buf(&sb, fullname);
+		else
+			die(_("bad ls-files format: %%%.*s"),
+			    (int)(end - format + 1), format);
+	}
 	strbuf_addch(&sb, line_terminator);
 	fwrite(sb.buf, sb.len, 1, stdout);
 	strbuf_release(&sb);
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 077977a461..8460d20257 100644
=2D-- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -55,63 +55,6 @@ struct ls_tree_options {
 	const char *format;
 };

-struct show_tree_data {
-	struct ls_tree_options *options;
-	unsigned mode;
-	enum object_type type;
-	const struct object_id *oid;
-	const char *pathname;
-	struct strbuf *base;
-};
-
-static size_t expand_show_tree(struct strbuf *sb, const char *start,
-			       void *context)
-{
-	struct show_tree_data *data =3D context;
-	struct ls_tree_options *options =3D data->options;
-	const char *end;
-	const char *p;
-	unsigned int errlen;
-	size_t len =3D strbuf_expand_literal_cb(sb, start, NULL);
-
-	if (len)
-		return len;
-	if (*start !=3D '(')
-		die(_("bad ls-tree format: element '%s' does not start with '('"), star=
t);
-
-	end =3D strchr(start + 1, ')');
-	if (!end)
-		die(_("bad ls-tree format: element '%s' does not end in ')'"), start);
-
-	len =3D end - start + 1;
-	if (skip_prefix(start, "(objectmode)", &p)) {
-		strbuf_addf(sb, "%06o", data->mode);
-	} else if (skip_prefix(start, "(objecttype)", &p)) {
-		strbuf_addstr(sb, type_name(data->type));
-	} else if (skip_prefix(start, "(objectsize:padded)", &p)) {
-		expand_objectsize(sb, data->oid, data->type, 1);
-	} else if (skip_prefix(start, "(objectsize)", &p)) {
-		expand_objectsize(sb, data->oid, data->type, 0);
-	} else if (skip_prefix(start, "(objectname)", &p)) {
-		strbuf_add_unique_abbrev(sb, data->oid, options->abbrev);
-	} else if (skip_prefix(start, "(path)", &p)) {
-		const char *name =3D data->base->buf;
-		const char *prefix =3D options->chomp_prefix ? options->ls_tree_prefix =
: NULL;
-		struct strbuf sbuf =3D STRBUF_INIT;
-		size_t baselen =3D data->base->len;
-
-		strbuf_addstr(data->base, data->pathname);
-		name =3D relative_path(data->base->buf, prefix, &sbuf);
-		quote_c_style(name, sb, NULL, 0);
-		strbuf_setlen(data->base, baselen);
-		strbuf_release(&sbuf);
-	} else {
-		errlen =3D (unsigned long)len;
-		die(_("bad ls-tree format: %%%.*s"), errlen, start);
-	}
-	return len;
-}
-
 static int show_recursive(struct ls_tree_options *options, const char *ba=
se,
 			  size_t baselen, const char *pathname)
 {
@@ -150,14 +93,7 @@ static int show_tree_fmt(const struct object_id *oid, =
struct strbuf *base,
 	int recurse =3D 0;
 	struct strbuf sb =3D STRBUF_INIT;
 	enum object_type type =3D object_type(mode);
-	struct show_tree_data cb_data =3D {
-		.options =3D options,
-		.mode =3D mode,
-		.type =3D type,
-		.oid =3D oid,
-		.pathname =3D pathname,
-		.base =3D base,
-	};
+	const char *format =3D options->format;

 	if (type =3D=3D OBJ_TREE && show_recursive(options, base->buf, base->len=
, pathname))
 		recurse =3D READ_TREE_RECURSIVE;
@@ -166,7 +102,46 @@ static int show_tree_fmt(const struct object_id *oid,=
 struct strbuf *base,
 	if (type =3D=3D OBJ_BLOB && (options->ls_options & LS_TREE_ONLY))
 		return 0;

-	strbuf_expand(&sb, options->format, expand_show_tree, &cb_data);
+	while (strbuf_expand_step(&sb, &format)) {
+		const char *end;
+		size_t len;
+
+		if (skip_prefix(format, "%", &format))
+			strbuf_addch(&sb, '%');
+		else if ((len =3D strbuf_expand_literal_cb(&sb, format, NULL)))
+			format +=3D len;
+		else if (*format !=3D '(')
+			die(_("bad ls-tree format: element '%s' "
+			      "does not start with '('"), format);
+		else if (!(end =3D strchr(format + 1, ')')))
+			die(_("bad ls-tree format: element '%s' "
+			      "does not end in ')'"), format);
+		else if (skip_prefix(format, "(objectmode)", &format))
+			strbuf_addf(&sb, "%06o", mode);
+		else if (skip_prefix(format, "(objecttype)", &format))
+			strbuf_addstr(&sb, type_name(type));
+		else if (skip_prefix(format, "(objectsize:padded)", &format))
+			expand_objectsize(&sb, oid, type, 1);
+		else if (skip_prefix(format, "(objectsize)", &format))
+			expand_objectsize(&sb, oid, type, 0);
+		else if (skip_prefix(format, "(objectname)", &format))
+			strbuf_add_unique_abbrev(&sb, oid, options->abbrev);
+		else if (skip_prefix(format, "(path)", &format)) {
+			const char *name;
+			const char *prefix =3D options->chomp_prefix ?
+					     options->ls_tree_prefix : NULL;
+			struct strbuf sbuf =3D STRBUF_INIT;
+			size_t baselen =3D base->len;
+
+			strbuf_addstr(base, pathname);
+			name =3D relative_path(base->buf, prefix, &sbuf);
+			quote_c_style(name, &sb, NULL, 0);
+			strbuf_setlen(base, baselen);
+			strbuf_release(&sbuf);
+		} else
+			die(_("bad ls-tree format: %%%.*s"),
+			    (int)(end - format + 1), format);
+	}
 	strbuf_addch(&sb, options->null_termination ? '\0' : '\n');
 	fwrite(sb.buf, sb.len, 1, stdout);
 	strbuf_release(&sb);
diff --git a/daemon.c b/daemon.c
index 7139cc201d..3682bfdd08 100644
=2D-- a/daemon.c
+++ b/daemon.c
@@ -144,42 +144,6 @@ static void NORETURN daemon_die(const char *err, va_l=
ist params)
 	exit(1);
 }

-struct expand_path_context {
-	const char *directory;
-	struct hostinfo *hostinfo;
-};
-
-static size_t expand_path(struct strbuf *sb, const char *placeholder, voi=
d *ctx)
-{
-	struct expand_path_context *context =3D ctx;
-	struct hostinfo *hi =3D context->hostinfo;
-
-	switch (placeholder[0]) {
-	case 'H':
-		strbuf_addbuf(sb, &hi->hostname);
-		return 1;
-	case 'C':
-		if (placeholder[1] =3D=3D 'H') {
-			strbuf_addstr(sb, get_canon_hostname(hi));
-			return 2;
-		}
-		break;
-	case 'I':
-		if (placeholder[1] =3D=3D 'P') {
-			strbuf_addstr(sb, get_ip_address(hi));
-			return 2;
-		}
-		break;
-	case 'P':
-		strbuf_addbuf(sb, &hi->tcp_port);
-		return 1;
-	case 'D':
-		strbuf_addstr(sb, context->directory);
-		return 1;
-	}
-	return 0;
-}
-
 static const char *path_ok(const char *directory, struct hostinfo *hi)
 {
 	static char rpath[PATH_MAX];
@@ -223,10 +187,7 @@ static const char *path_ok(const char *directory, str=
uct hostinfo *hi)
 	}
 	else if (interpolated_path && hi->saw_extended_args) {
 		struct strbuf expanded_path =3D STRBUF_INIT;
-		struct expand_path_context context;
-
-		context.directory =3D directory;
-		context.hostinfo =3D hi;
+		const char *format =3D interpolated_path;

 		if (*dir !=3D '/') {
 			/* Allow only absolute */
@@ -234,8 +195,24 @@ static const char *path_ok(const char *directory, str=
uct hostinfo *hi)
 			return NULL;
 		}

-		strbuf_expand(&expanded_path, interpolated_path,
-			      expand_path, &context);
+		while (strbuf_expand_step(&expanded_path, &format)) {
+			if (skip_prefix(format, "%", &format))
+				strbuf_addch(&expanded_path, '%');
+			else if (skip_prefix(format, "H", &format))
+				strbuf_addbuf(&expanded_path, &hi->hostname);
+			else if (skip_prefix(format, "CH", &format))
+				strbuf_addstr(&expanded_path,
+					      get_canon_hostname(hi));
+			else if (skip_prefix(format, "IP", &format))
+				strbuf_addstr(&expanded_path,
+					      get_ip_address(hi));
+			else if (skip_prefix(format, "P", &format))
+				strbuf_addbuf(&expanded_path, &hi->tcp_port);
+			else if (skip_prefix(format, "D", &format))
+				strbuf_addstr(&expanded_path, directory);
+			else
+				strbuf_addch(&expanded_path, '%');
+		}

 		rlen =3D strlcpy(interp_path, expanded_path.buf,
 			       sizeof(interp_path));
diff --git a/pretty.c b/pretty.c
index d2df561a05..cffbf32987 100644
=2D-- a/pretty.c
+++ b/pretty.c
@@ -1254,9 +1254,19 @@ static struct strbuf *expand_separator(struct strbu=
f *sb,
 				       const char *argval, size_t arglen)
 {
 	char *fmt =3D xstrndup(argval, arglen);
+	const char *format =3D fmt;

 	strbuf_reset(sb);
-	strbuf_expand(sb, fmt, strbuf_expand_literal_cb, NULL);
+	while (strbuf_expand_step(sb, &format)) {
+		size_t len;
+
+		if (skip_prefix(format, "%", &format))
+			strbuf_addch(sb, '%');
+		else if ((len =3D strbuf_expand_literal_cb(sb, format, NULL)))
+			format +=3D len;
+		else
+			strbuf_addch(sb, '%');
+	}
 	free(fmt);
 	return sb;
 }
@@ -1803,7 +1813,7 @@ static size_t format_and_pad_commit(struct strbuf *s=
b, /* in UTF-8 */

 static size_t format_commit_item(struct strbuf *sb, /* in UTF-8 */
 				 const char *placeholder,
-				 void *context)
+				 struct format_commit_context *context)
 {
 	size_t consumed, orig_len;
 	enum {
@@ -1842,7 +1852,7 @@ static size_t format_commit_item(struct strbuf *sb, =
/* in UTF-8 */
 	}

 	orig_len =3D sb->len;
-	if (((struct format_commit_context *)context)->flush_type !=3D no_flush)
+	if ((context)->flush_type !=3D no_flush)
 		consumed =3D format_and_pad_commit(sb, placeholder, context);
 	else
 		consumed =3D format_commit_one(sb, placeholder, context);
@@ -1861,30 +1871,6 @@ static size_t format_commit_item(struct strbuf *sb,=
 /* in UTF-8 */
 	return consumed + 1;
 }

-static size_t userformat_want_item(struct strbuf *sb UNUSED,
-				   const char *placeholder,
-				   void *context)
-{
-	struct userformat_want *w =3D context;
-
-	if (*placeholder =3D=3D '+' || *placeholder =3D=3D '-' || *placeholder =
=3D=3D ' ')
-		placeholder++;
-
-	switch (*placeholder) {
-	case 'N':
-		w->notes =3D 1;
-		break;
-	case 'S':
-		w->source =3D 1;
-		break;
-	case 'd':
-	case 'D':
-		w->decorate =3D 1;
-		break;
-	}
-	return 0;
-}
-
 void userformat_find_requirements(const char *fmt, struct userformat_want=
 *w)
 {
 	struct strbuf dummy =3D STRBUF_INIT;
@@ -1894,7 +1880,26 @@ void userformat_find_requirements(const char *fmt, =
struct userformat_want *w)
 			return;
 		fmt =3D user_format;
 	}
-	strbuf_expand(&dummy, fmt, userformat_want_item, w);
+	while (strbuf_expand_step(&dummy, &fmt)) {
+		if (skip_prefix(fmt, "%", &fmt))
+			continue;
+
+		if (*fmt =3D=3D '+' || *fmt =3D=3D '-' || *fmt =3D=3D ' ')
+			fmt++;
+
+		switch (*fmt) {
+		case 'N':
+			w->notes =3D 1;
+			break;
+		case 'S':
+			w->source =3D 1;
+			break;
+		case 'd':
+		case 'D':
+			w->decorate =3D 1;
+			break;
+		}
+	}
 	strbuf_release(&dummy);
 }

@@ -1912,7 +1917,16 @@ void repo_format_commit_message(struct repository *=
r,
 	const char *output_enc =3D pretty_ctx->output_encoding;
 	const char *utf8 =3D "UTF-8";

-	strbuf_expand(sb, format, format_commit_item, &context);
+	while (strbuf_expand_step(sb, &format)) {
+		size_t len;
+
+		if (skip_prefix(format, "%", &format))
+			strbuf_addch(sb, '%');
+		else if ((len =3D format_commit_item(sb, format, &context)))
+			format +=3D len;
+		else
+			strbuf_addch(sb, '%');
+	}
 	rewrap_message_tail(sb, &context, 0, 0, 0);

 	/*
diff --git a/strbuf.c b/strbuf.c
index 972366b410..c3d1cee616 100644
=2D-- a/strbuf.c
+++ b/strbuf.c
@@ -427,26 +427,6 @@ int strbuf_expand_step(struct strbuf *sb, const char =
**formatp)
 	return 1;
 }

-void strbuf_expand(struct strbuf *sb, const char *format, expand_fn_t fn,
-		   void *context)
-{
-	while (strbuf_expand_step(sb, &format)) {
-		size_t consumed;
-
-		if (*format =3D=3D '%') {
-			strbuf_addch(sb, '%');
-			format++;
-			continue;
-		}
-
-		consumed =3D fn(sb, format, context);
-		if (consumed)
-			format +=3D consumed;
-		else
-			strbuf_addch(sb, '%');
-	}
-}
-
 size_t strbuf_expand_literal_cb(struct strbuf *sb,
 				const char *placeholder,
 				void *context UNUSED)
diff --git a/strbuf.h b/strbuf.h
index e293117f07..95e50e243e 100644
=2D-- a/strbuf.h
+++ b/strbuf.h
@@ -318,40 +318,9 @@ const char *strbuf_join_argv(struct strbuf *buf, int =
argc,
 			     const char **argv, char delim);

 /**
- * This function can be used to expand a format string containing
- * placeholders. To that end, it parses the string and calls the specifie=
d
- * function for every percent sign found.
- *
- * The callback function is given a pointer to the character after the `%=
`
- * and a pointer to the struct strbuf.  It is expected to add the expande=
d
- * version of the placeholder to the strbuf, e.g. to add a newline
- * character if the letter `n` appears after a `%`.  The function returns
- * the length of the placeholder recognized and `strbuf_expand()` skips
- * over it.
- *
- * The format `%%` is automatically expanded to a single `%` as a quoting
- * mechanism; callers do not need to handle the `%` placeholder themselve=
s,
- * and the callback function will not be invoked for this placeholder.
- *
- * All other characters (non-percent and not skipped ones) are copied
- * verbatim to the strbuf.  If the callback returned zero, meaning that t=
he
- * placeholder is unknown, then the percent sign is copied, too.
- *
- * In order to facilitate caching and to make it possible to give
- * parameters to the callback, `strbuf_expand()` passes a context
- * pointer with any kind of data.
- */
-typedef size_t (*expand_fn_t) (struct strbuf *sb,
-			       const char *placeholder,
-			       void *context);
-void strbuf_expand(struct strbuf *sb,
-		   const char *format,
-		   expand_fn_t fn,
-		   void *context);
-
-/**
- * Used as callback for `strbuf_expand` to only expand literals
- * (i.e. %n and %xNN). The context argument is ignored.
+ * Used with `strbuf_expand_step` to expand the literals %n and %x
+ * followed by two hexadecimal digits. Returns the number of recognized
+ * characters. The context argument is ignored.
  */
 size_t strbuf_expand_literal_cb(struct strbuf *sb,
 				const char *placeholder,
=2D-
2.41.0
