From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/3] grep: generalize header grep code to accept arbitrary headers
Date: Fri, 28 Sep 2012 14:01:20 +0700
Message-ID: <1348815682-18696-1-git-send-email-pclouds@gmail.com>
References: <1348745786-27197-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 09:02:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THUaP-00061u-AL
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 09:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777Ab2I1HB7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Sep 2012 03:01:59 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64678 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877Ab2I1HB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 03:01:58 -0400
Received: by pbbrr4 with SMTP id rr4so4721305pbb.19
        for <git@vger.kernel.org>; Fri, 28 Sep 2012 00:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=cqPwmZwpoIbi5FX/MMEMHDE1ES5dTgkcbvNU9z+EBBY=;
        b=jyU0DIXicEV4ZDBgNnC24syCHX55XiiCLg0X/icP20mwZk3Z5I1WLvsh5JY+r/Oqog
         jXhgFjENjFaamWZP0qcoh1aYMM3TTu2m/Ck5S7oPdKa6m0Kc2PQAJgdshxZyDnoPHZY2
         Uo1H2j++mv0Sz5JqEjXNBKmzj/Sxzh6x9/0/a9Z6l55oIyVcNytYAXD1oHmjBxPg6QVR
         bla92Pw9mUR2aAfFjy+oMiVEwYxXQprTQHNSSi24k8GLca+fnj30feeeuK+Ke3zlhXof
         Z8tsgTSdi/peWWeGGGZZEWzEQDAkfREdt23s04jeS8gnDIE7Y4inwa3UtEQ8gV43h3q+
         gJ5Q==
Received: by 10.68.224.138 with SMTP id rc10mr17925688pbc.34.1348815718163;
        Fri, 28 Sep 2012 00:01:58 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id j9sm5048512pav.15.2012.09.28.00.01.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 28 Sep 2012 00:01:56 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 28 Sep 2012 14:01:49 +0700
X-Mailer: git-send-email 1.7.12.1.405.gb727dc9
In-Reply-To: <1348745786-27197-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206539>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Fri, Sep 28, 2012 at 12:09 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
 >>  enum grep_header_field {
 >>       GREP_HEADER_AUTHOR =3D 0,
 >> -     GREP_HEADER_COMMITTER
 >> +     GREP_HEADER_COMMITTER,
 >> +     GREP_HEADER_REFLOG,
 >> +     GREP_HEADER_FIELD_MAX
 >>  };
 >> -#define GREP_HEADER_FIELD_MAX (GREP_HEADER_COMMITTER + 1)
 >
 > Please add comment to ensure that FIELD_MAX stays at the end; if you
 > ensure that, the result is much better than the original "we know
 > committer is at the end so add one".

 It's probably even better to remove the enum. Say one day I got drunk
 and decided to add --grep-encoding. This patch makes sure that I could
 submit such a patch even in drunk state.

 grep.c     | 76 +++++++++++++++++++++++++++++++++---------------------=
--------
 grep.h     | 11 +++------
 revision.c |  8 +++----
 3 files changed, 47 insertions(+), 48 deletions(-)

diff --git a/grep.c b/grep.c
index 898be6e..0c72262 100644
--- a/grep.c
+++ b/grep.c
@@ -10,7 +10,7 @@ static int grep_source_is_binary(struct grep_source *=
gs);
 static struct grep_pat *create_grep_pat(const char *pat, size_t patlen=
,
 					const char *origin, int no,
 					enum grep_pat_token t,
-					enum grep_header_field field)
+					const char *header, size_t header_len)
 {
 	struct grep_pat *p =3D xcalloc(1, sizeof(*p));
 	p->pattern =3D xmemdupz(pat, patlen);
@@ -18,7 +18,8 @@ static struct grep_pat *create_grep_pat(const char *p=
at, size_t patlen,
 	p->origin =3D origin;
 	p->no =3D no;
 	p->token =3D t;
-	p->field =3D field;
+	p->header =3D header;
+	p->header_len =3D header_len;
 	return p;
 }
=20
@@ -45,7 +46,8 @@ static void do_append_grep_pat(struct grep_pat ***tai=
l, struct grep_pat *p)
 			if (!nl)
 				break;
 			new_pat =3D create_grep_pat(nl + 1, len - 1, p->origin,
-						  p->no, p->token, p->field);
+						  p->no, p->token,
+						  p->header, p->header_len);
 			new_pat->next =3D p->next;
 			if (!p->next)
 				*tail =3D &new_pat->next;
@@ -59,11 +61,13 @@ static void do_append_grep_pat(struct grep_pat ***t=
ail, struct grep_pat *p)
 	}
 }
=20
+/* header must not be freed while grep is running */
 void append_header_grep_pattern(struct grep_opt *opt,
-				enum grep_header_field field, const char *pat)
+				const char *header, const char *pat)
 {
 	struct grep_pat *p =3D create_grep_pat(pat, strlen(pat), "header", 0,
-					     GREP_PATTERN_HEAD, field);
+					     GREP_PATTERN_HEAD,
+					     header, strlen(header));
 	do_append_grep_pat(&opt->header_tail, p);
 }
=20
@@ -76,7 +80,7 @@ void append_grep_pattern(struct grep_opt *opt, const =
char *pat,
 void append_grep_pat(struct grep_opt *opt, const char *pat, size_t pat=
len,
 		     const char *origin, int no, enum grep_pat_token t)
 {
-	struct grep_pat *p =3D create_grep_pat(pat, patlen, origin, no, t, 0)=
;
+	struct grep_pat *p =3D create_grep_pat(pat, patlen, origin, no, t, NU=
LL, 0);
 	do_append_grep_pat(&opt->pattern_tail, p);
 }
=20
@@ -92,7 +96,7 @@ struct grep_opt *grep_opt_dup(const struct grep_opt *=
opt)
 	for(pat =3D opt->pattern_list; pat !=3D NULL; pat =3D pat->next)
 	{
 		if(pat->token =3D=3D GREP_PATTERN_HEAD)
-			append_header_grep_pattern(ret, pat->field,
+			append_header_grep_pattern(ret, pat->header,
 						   pat->pattern);
 		else
 			append_grep_pat(ret, pat->pattern, pat->patternlen,
@@ -359,7 +363,7 @@ static void dump_grep_pat(struct grep_pat *p)
 	switch (p->token) {
 	default: break;
 	case GREP_PATTERN_HEAD:
-		fprintf(stderr, "<head %d>", p->field); break;
+		fprintf(stderr, "<head %s>", p->header); break;
 	case GREP_PATTERN_BODY:
 		fprintf(stderr, "<body>"); break;
 	}
@@ -436,9 +440,10 @@ static struct grep_expr *grep_or_expr(struct grep_=
expr *left, struct grep_expr *
 static struct grep_expr *prep_header_patterns(struct grep_opt *opt)
 {
 	struct grep_pat *p;
-	struct grep_expr *header_expr;
-	struct grep_expr *(header_group[GREP_HEADER_FIELD_MAX]);
-	enum grep_header_field fld;
+	struct grep_expr *header_expr =3D NULL;
+	struct grep_expr **header_group;
+	struct string_list header =3D STRING_LIST_INIT_NODUP;
+	int fld;
=20
 	if (!opt->header_list)
 		return NULL;
@@ -446,37 +451,45 @@ static struct grep_expr *prep_header_patterns(str=
uct grep_opt *opt)
 	for (p =3D opt->header_list; p; p =3D p->next) {
 		if (p->token !=3D GREP_PATTERN_HEAD)
 			die("bug: a non-header pattern in grep header list.");
-		if (p->field < 0 || GREP_HEADER_FIELD_MAX <=3D p->field)
-			die("bug: unknown header field %d", p->field);
+		if (!p->header || !p->header_len)
+			die("bug: unknown header field");
 		compile_regexp(p, opt);
+		string_list_append(&header, p->header);
 	}
=20
-	for (fld =3D 0; fld < GREP_HEADER_FIELD_MAX; fld++)
-		header_group[fld] =3D NULL;
+	sort_string_list(&header);
+	string_list_remove_duplicates(&header, 0);
+	header_group =3D xmalloc(sizeof(*header_group) * header.nr);
+	memset(header_group, 0, sizeof(*header_group) * header.nr);
=20
 	for (p =3D opt->header_list; p; p =3D p->next) {
 		struct grep_expr *h;
 		struct grep_pat *pp =3D p;
+		struct string_list_item *item;
=20
 		h =3D compile_pattern_atom(&pp);
 		if (!h || pp !=3D p->next)
 			die("bug: malformed header expr");
-		if (!header_group[p->field]) {
-			header_group[p->field] =3D h;
+		item =3D string_list_lookup(&header, p->header);
+		if (!item)
+			die("bug: malformed header expr");
+		fld =3D item - header.items;
+		if (!header_group[fld]) {
+			header_group[fld] =3D h;
 			continue;
 		}
-		header_group[p->field] =3D grep_or_expr(h, header_group[p->field]);
+		header_group[fld] =3D grep_or_expr(h, header_group[fld]);
 	}
=20
-	header_expr =3D NULL;
-
-	for (fld =3D 0; fld < GREP_HEADER_FIELD_MAX; fld++) {
-		if (!header_group[fld])
-			continue;
+	for (fld =3D 0; fld < header.nr; fld++) {
 		if (!header_expr)
 			header_expr =3D grep_true_expr();
 		header_expr =3D grep_or_expr(header_group[fld], header_expr);
 	}
+
+	string_list_clear(&header, 0);
+	free(header_group);
+
 	return header_expr;
 }
=20
@@ -691,14 +704,6 @@ static int strip_timestamp(char *bol, char **eol_p=
)
 	return 0;
 }
=20
-static struct {
-	const char *field;
-	size_t len;
-} header_field[] =3D {
-	{ "author ", 7 },
-	{ "committer ", 10 },
-};
-
 static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
 			     enum grep_context ctx,
 			     regmatch_t *pmatch, int eflags)
@@ -714,12 +719,11 @@ static int match_one_pattern(struct grep_pat *p, =
char *bol, char *eol,
 	if (p->token =3D=3D GREP_PATTERN_HEAD) {
 		const char *field;
 		size_t len;
-		assert(p->field < ARRAY_SIZE(header_field));
-		field =3D header_field[p->field].field;
-		len =3D header_field[p->field].len;
-		if (strncmp(bol, field, len))
+		field =3D p->header;
+		len =3D p->header_len;
+		if (strncmp(bol, field, len) || bol[len] !=3D ' ')
 			return 0;
-		bol +=3D len;
+		bol +=3D len + 1;
 		saved_ch =3D strip_timestamp(bol, &eol);
 	}
=20
diff --git a/grep.h b/grep.h
index 8a28a67..bc00f2a 100644
--- a/grep.h
+++ b/grep.h
@@ -27,12 +27,6 @@ enum grep_context {
 	GREP_CONTEXT_BODY
 };
=20
-enum grep_header_field {
-	GREP_HEADER_AUTHOR =3D 0,
-	GREP_HEADER_COMMITTER
-};
-#define GREP_HEADER_FIELD_MAX (GREP_HEADER_COMMITTER + 1)
-
 struct grep_pat {
 	struct grep_pat *next;
 	const char *origin;
@@ -40,7 +34,8 @@ struct grep_pat {
 	enum grep_pat_token token;
 	char *pattern;
 	size_t patternlen;
-	enum grep_header_field field;
+	const char *header;
+	size_t header_len;
 	regex_t regexp;
 	pcre *pcre_regexp;
 	pcre_extra *pcre_extra_info;
@@ -136,7 +131,7 @@ struct grep_opt {
=20
 extern void append_grep_pat(struct grep_opt *opt, const char *pat, siz=
e_t patlen, const char *origin, int no, enum grep_pat_token t);
 extern void append_grep_pattern(struct grep_opt *opt, const char *pat,=
 const char *origin, int no, enum grep_pat_token t);
-extern void append_header_grep_pattern(struct grep_opt *, enum grep_he=
ader_field, const char *);
+extern void append_header_grep_pattern(struct grep_opt *, const char *=
, const char *);
 extern void compile_grep_patterns(struct grep_opt *opt);
 extern void free_grep_patterns(struct grep_opt *opt);
 extern int grep_buffer(struct grep_opt *opt, char *buf, unsigned long =
size);
diff --git a/revision.c b/revision.c
index ae12e11..f7cf385 100644
--- a/revision.c
+++ b/revision.c
@@ -1288,9 +1288,9 @@ static void add_grep(struct rev_info *revs, const=
 char *ptn, enum grep_pat_token
 	append_grep_pattern(&revs->grep_filter, ptn, "command line", 0, what)=
;
 }
=20
-static void add_header_grep(struct rev_info *revs, enum grep_header_fi=
eld field, const char *pattern)
+static void add_header_grep(struct rev_info *revs, const char *header,=
 const char *pattern)
 {
-	append_header_grep_pattern(&revs->grep_filter, field, pattern);
+	append_header_grep_pattern(&revs->grep_filter, header, pattern);
 }
=20
 static void add_message_grep(struct rev_info *revs, const char *patter=
n)
@@ -1590,10 +1590,10 @@ static int handle_revision_opt(struct rev_info =
*revs, int argc, const char **arg
 	 * Grepping the commit log
 	 */
 	else if ((argcount =3D parse_long_opt("author", argv, &optarg))) {
-		add_header_grep(revs, GREP_HEADER_AUTHOR, optarg);
+		add_header_grep(revs, "author", optarg);
 		return argcount;
 	} else if ((argcount =3D parse_long_opt("committer", argv, &optarg)))=
 {
-		add_header_grep(revs, GREP_HEADER_COMMITTER, optarg);
+		add_header_grep(revs, "committer", optarg);
 		return argcount;
 	} else if ((argcount =3D parse_long_opt("grep", argv, &optarg))) {
 		add_message_grep(revs, optarg);
--=20
1.7.12.1.405.gb727dc9
