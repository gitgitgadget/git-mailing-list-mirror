From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] use skip_prefix() to avoid more magic numbers
Date: Sun, 5 Oct 2014 15:49:19 -0700
Message-ID: <20141005224919.GA19998@google.com>
References: <5430427A.5080800@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Oct 06 00:49:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XaucP-0006J1-3n
	for gcvg-git-2@plane.gmane.org; Mon, 06 Oct 2014 00:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbaJEWt3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Oct 2014 18:49:29 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:50994 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596AbaJEWt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2014 18:49:28 -0400
Received: by mail-pd0-f172.google.com with SMTP id ft15so2341507pdb.3
        for <git@vger.kernel.org>; Sun, 05 Oct 2014 15:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=92jPHMniKe9sMzhwAiFv86d59dwuSjOORXLY5O4XtAo=;
        b=E+KLhQSUCO42avbnVavrj10rAPtlha4PUU734qcnkKSvxgeomeoGykEM3reC5/eUgl
         XKZH79SB0Ofs8ZgIbXAhPViBCu9gHbj2e+RtyUfU5sIB/4LDhonWMBElKevGWrtHAz5B
         8UChx6KdQ183tGKZ9+kAQMxHfmRXSA+FraroN9hEx093qpigAdut7FXCC8aeWk2GseSl
         jXZqpHn39BzqZoe0R5WmaOzrSoG+tSOiXLU5Rw3xiDsaDiWVqnTkoUd8cOqQkkRz7dGj
         xMZ30+F7ANRI38uCfzE/1rZkvyaFHH3KOeCvrgfNWPgdWaTV3V+gUytsqU0I0HX7UoIj
         SRhg==
X-Received: by 10.66.66.40 with SMTP id c8mr21220902pat.83.1412549367453;
        Sun, 05 Oct 2014 15:49:27 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id iu10sm11598315pbd.57.2014.10.05.15.49.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 05 Oct 2014 15:49:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5430427A.5080800@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257904>

Ren=E9 Scharfe wrote:

> Continue where ae021d87 (use skip_prefix to avoid magic numbers) left=
 off
> and use skip_prefix() in more places for determining the lengths of p=
refix
> strings to avoid using dependent constants and other indirect methods=
=2E

Sounds promising.

[...]
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -81,14 +81,16 @@ static int parse_branch_color_slot(const char *va=
r, int ofs)
> =20
>  static int git_branch_config(const char *var, const char *value, voi=
d *cb)
>  {
> +	const char *slot_name;
> +
>  	if (starts_with(var, "column."))
>  		return git_column_config(var, value, "branch", &colopts);
>  	if (!strcmp(var, "color.branch")) {
>  		branch_use_color =3D git_config_colorbool(var, value);
>  		return 0;
>  	}
> -	if (starts_with(var, "color.branch.")) {
> -		int slot =3D parse_branch_color_slot(var, 13);
> +	if (skip_prefix(var, "color.branch.", &slot_name)) {
> +		int slot =3D parse_branch_color_slot(var, slot_name - var);

I wonder why the separate var and offset parameters exist in the first
place.  Wouldn't taking a single const char * so the old code could use
'var + 13' instead of 'var, 13' have worked?

At first glance I thought this should be

		int slot =3D parse_branch_color_slot(slot_name, 0);

to be simpler.  At second glance, how about something like the followin=
g
on top?

[...]
> --- a/builtin/log.c
> +++ b/builtin/log.c
[...]
> @@ -388,8 +390,8 @@ static int git_log_config(const char *var, const =
char *value, void *cb)
>  		default_show_root =3D git_config_bool(var, value);
>  		return 0;
>  	}
> -	if (starts_with(var, "color.decorate."))
> -		return parse_decorate_color_config(var, 15, value);
> +	if (skip_prefix(var, "color.decorate.", &slot_name))
> +		return parse_decorate_color_config(var, slot_name - var, value);

Likewise: the offset-based API seems odd now here, too.

[...]
> --- a/pretty.c
> +++ b/pretty.c
[...]
> @@ -809,18 +808,19 @@ static void parse_commit_header(struct format_c=
ommit_context *context)
>  	int i;
> =20
>  	for (i =3D 0; msg[i]; i++) {
> +		const char *name;

ident instead of name, maybe? (since it's a 'name <email> timestamp'
field)

[...]
> @@ -1522,7 +1518,7 @@ static void pp_header(struct pretty_print_conte=
xt *pp,
>  	int parents_shown =3D 0;
> =20
>  	for (;;) {
> -		const char *line =3D *msg_p;
> +		const char *name, *line =3D *msg_p;

Likewise.

With or without the changes below,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

diff --git i/builtin/branch.c w/builtin/branch.c
index 6785097..022a88e 100644
--- i/builtin/branch.c
+++ w/builtin/branch.c
@@ -62,19 +62,19 @@ static unsigned char merge_filter_ref[20];
 static struct string_list output =3D STRING_LIST_INIT_DUP;
 static unsigned int colopts;
=20
-static int parse_branch_color_slot(const char *var, int ofs)
+static int parse_branch_color_slot(const char *slot)
 {
-	if (!strcasecmp(var+ofs, "plain"))
+	if (!strcasecmp(slot, "plain"))
 		return BRANCH_COLOR_PLAIN;
-	if (!strcasecmp(var+ofs, "reset"))
+	if (!strcasecmp(slot, "reset"))
 		return BRANCH_COLOR_RESET;
-	if (!strcasecmp(var+ofs, "remote"))
+	if (!strcasecmp(slot, "remote"))
 		return BRANCH_COLOR_REMOTE;
-	if (!strcasecmp(var+ofs, "local"))
+	if (!strcasecmp(slot, "local"))
 		return BRANCH_COLOR_LOCAL;
-	if (!strcasecmp(var+ofs, "current"))
+	if (!strcasecmp(slot, "current"))
 		return BRANCH_COLOR_CURRENT;
-	if (!strcasecmp(var+ofs, "upstream"))
+	if (!strcasecmp(slot, "upstream"))
 		return BRANCH_COLOR_UPSTREAM;
 	return -1;
 }
@@ -90,7 +90,7 @@ static int git_branch_config(const char *var, const c=
har *value, void *cb)
 		return 0;
 	}
 	if (skip_prefix(var, "color.branch.", &slot_name)) {
-		int slot =3D parse_branch_color_slot(var, slot_name - var);
+		int slot =3D parse_branch_color_slot(slot_name);
 		if (slot < 0)
 			return 0;
 		if (!value)
diff --git i/builtin/log.c w/builtin/log.c
index 1202eba..68d5d30 100644
--- i/builtin/log.c
+++ w/builtin/log.c
@@ -391,7 +391,7 @@ static int git_log_config(const char *var, const ch=
ar *value, void *cb)
 		return 0;
 	}
 	if (skip_prefix(var, "color.decorate.", &slot_name))
-		return parse_decorate_color_config(var, slot_name - var, value);
+		return parse_decorate_color_config(var, slot_name, value);
 	if (!strcmp(var, "log.mailmap")) {
 		use_mailmap_config =3D git_config_bool(var, value);
 		return 0;
diff --git i/log-tree.c w/log-tree.c
index cff7ac1..6402c19 100644
--- i/log-tree.c
+++ w/log-tree.c
@@ -56,9 +56,9 @@ static int parse_decorate_color_slot(const char *slot=
)
 	return -1;
 }
=20
-int parse_decorate_color_config(const char *var, const int ofs, const =
char *value)
+int parse_decorate_color_config(const char *var, const char *slot_name=
, const char *value)
 {
-	int slot =3D parse_decorate_color_slot(var + ofs);
+	int slot =3D parse_decorate_color_slot(slot_name);
 	if (slot < 0)
 		return 0;
 	if (!value)
diff --git i/log-tree.h w/log-tree.h
index b26160c..d637b04 100644
--- i/log-tree.h
+++ w/log-tree.h
@@ -7,7 +7,8 @@ struct log_info {
 	struct commit *commit, *parent;
 };
=20
-int parse_decorate_color_config(const char *var, const int ofs, const =
char *value);
+int parse_decorate_color_config(const char *var, const char *slot_name=
,
+				const char *value);
 void init_log_tree_opt(struct rev_info *);
 int log_tree_diff_flush(struct rev_info *);
 int log_tree_commit(struct rev_info *, struct commit *);
diff --git i/pretty.c w/pretty.c
index a181ac6..e2c59ef 100644
--- i/pretty.c
+++ w/pretty.c
@@ -808,19 +808,19 @@ static void parse_commit_header(struct format_com=
mit_context *context)
 	int i;
=20
 	for (i =3D 0; msg[i]; i++) {
-		const char *name;
+		const char *ident;
 		int eol;
 		for (eol =3D i; msg[eol] && msg[eol] !=3D '\n'; eol++)
 			; /* do nothing */
=20
 		if (i =3D=3D eol) {
 			break;
-		} else if (skip_prefix(msg + i, "author ", &name)) {
-			context->author.off =3D name - msg;
-			context->author.len =3D msg + eol - name;
-		} else if (skip_prefix(msg + i, "committer ", &name)) {
-			context->committer.off =3D name - msg;
-			context->committer.len =3D msg + eol - name;
+		} else if (skip_prefix(msg + i, "author ", &ident)) {
+			context->author.off =3D ident - msg;
+			context->author.len =3D msg + eol - ident;
+		} else if (skip_prefix(msg + i, "committer ", &ident)) {
+			context->committer.off =3D ident - msg;
+			context->committer.len =3D msg + eol - ident;
 		}
 		i =3D eol;
 	}
@@ -1518,7 +1518,7 @@ static void pp_header(struct pretty_print_context=
 *pp,
 	int parents_shown =3D 0;
=20
 	for (;;) {
-		const char *name, *line =3D *msg_p;
+		const char *ident, *line =3D *msg_p;
 		int linelen =3D get_one_line(*msg_p);
=20
 		if (!linelen)
@@ -1553,14 +1553,14 @@ static void pp_header(struct pretty_print_conte=
xt *pp,
 		 * FULL shows both authors but not dates.
 		 * FULLER shows both authors and dates.
 		 */
-		if (skip_prefix(line, "author ", &name)) {
+		if (skip_prefix(line, "author ", &ident)) {
 			strbuf_grow(sb, linelen + 80);
-			pp_user_info(pp, "Author", sb, name, encoding);
+			pp_user_info(pp, "Author", sb, ident, encoding);
 		}
-		if (skip_prefix(line, "committer ", &name) &&
+		if (skip_prefix(line, "committer ", &ident) &&
 		    (pp->fmt =3D=3D CMIT_FMT_FULL || pp->fmt =3D=3D CMIT_FMT_FULLER)=
) {
 			strbuf_grow(sb, linelen + 80);
-			pp_user_info(pp, "Commit", sb, name, encoding);
+			pp_user_info(pp, "Commit", sb, ident, encoding);
 		}
 	}
 }
