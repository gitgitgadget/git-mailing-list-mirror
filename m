From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] xdiff-interface: allow consume function to quit early by returning non-zero
Date: Mon, 15 Aug 2011 09:41:22 +0700
Message-ID: <1313376083-24713-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 15 04:42:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qsn8H-0004c8-Ri
	for gcvg-git-2@lo.gmane.org; Mon, 15 Aug 2011 04:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139Ab1HOClm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Aug 2011 22:41:42 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:52696 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735Ab1HOCll (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2011 22:41:41 -0400
Received: by iye16 with SMTP id 16so6548537iye.1
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 19:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=47dmsnUsPjVuRPFBSF/ZpgXQ0t6QzJwZJO8SvFBLlEs=;
        b=VN2ygrFXWFp5mS7Y+tu6YRpxgMSt3W3V/Uhj4nvxqSz7fsK5cReZoyY2m8Rzd2TpKv
         94++GrKxDE/3omN0FU0x4KPp9B6ULueW7KAWzVnjpn9vJx0KoLoW/bjR70Hy1QWlzq6Z
         E2svDtJZKu9gaaSe4PqfHzXDSgNOL93Ghhx88=
Received: by 10.43.53.129 with SMTP id vq1mr3259377icb.475.1313376101117;
        Sun, 14 Aug 2011 19:41:41 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.208.228])
        by mx.google.com with ESMTPS id m21sm433311ibf.59.2011.08.14.19.41.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Aug 2011 19:41:39 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Aug 2011 09:41:33 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179358>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 combine-diff.c     |    9 +++++----
 diff.c             |   32 +++++++++++++++++++-------------
 diffcore-pickaxe.c |    7 ++++---
 xdiff-interface.c  |   15 ++++++++++-----
 xdiff-interface.h  |    2 +-
 5 files changed, 39 insertions(+), 26 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index be67cfc..d99e1c6 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -163,14 +163,14 @@ struct combine_diff_state {
 	struct sline *lost_bucket;
 };
=20
-static void consume_line(void *state_, char *line, unsigned long len)
+static int consume_line(void *state_, char *line, unsigned long len)
 {
 	struct combine_diff_state *state =3D state_;
 	if (5 < len && !memcmp("@@ -", line, 4)) {
 		if (parse_hunk_header(line, len,
 				      &state->ob, &state->on,
 				      &state->nb, &state->nn))
-			return;
+			return 0;
 		state->lno =3D state->nb;
 		if (state->nn =3D=3D 0) {
 			/* @@ -X,Y +N,0 @@ removed Y lines
@@ -194,10 +194,10 @@ static void consume_line(void *state_, char *line=
, unsigned long len)
 					sizeof(unsigned long));
 		state->sline[state->nb-1].p_lno[state->n] =3D state->ob;
 		state->lost_bucket->next_lost =3D state->lost_bucket->lost_head;
-		return;
+		return 0;
 	}
 	if (!state->lost_bucket)
-		return; /* not in any hunk yet */
+		return 0; /* not in any hunk yet */
 	switch (line[0]) {
 	case '-':
 		append_lost(state->lost_bucket, state->n, line+1, len-1);
@@ -207,6 +207,7 @@ static void consume_line(void *state_, char *line, =
unsigned long len)
 		state->lno++;
 		break;
 	}
+	return 0;
 }
=20
 static void combine_diff(const unsigned char *parent, unsigned int mod=
e,
diff --git a/diff.c b/diff.c
index 93ef9a2..2801204 100644
--- a/diff.c
+++ b/diff.c
@@ -788,7 +788,7 @@ static int color_words_output_graph_prefix(struct d=
iff_words_data *diff_words)
 	}
 }
=20
-static void fn_out_diff_words_aux(void *priv, char *line, unsigned lon=
g len)
+static int fn_out_diff_words_aux(void *priv, char *line, unsigned long=
 len)
 {
 	struct diff_words_data *diff_words =3D priv;
 	struct diff_words_style *style =3D diff_words->style;
@@ -800,7 +800,7 @@ static void fn_out_diff_words_aux(void *priv, char =
*line, unsigned long len)
=20
 	if (line[0] !=3D '@' || parse_hunk_header(line, len,
 			&minus_first, &minus_len, &plus_first, &plus_len))
-		return;
+		return 0;
=20
 	assert(opt);
 	if (opt->output_prefix) {
@@ -849,6 +849,7 @@ static void fn_out_diff_words_aux(void *priv, char =
*line, unsigned long len)
=20
 	diff_words->current_plus =3D plus_end;
 	diff_words->last_minus =3D minus_first;
+	return 0;
 }
=20
 /* This function starts looking at *begin, and returns 0 iff a word wa=
s found. */
@@ -1042,7 +1043,7 @@ static void find_lno(const char *line, struct emi=
t_callback *ecbdata)
 	ecbdata->lno_in_postimage =3D strtol(p + 1, NULL, 10);
 }
=20
-static void fn_out_consume(void *priv, char *line, unsigned long len)
+static int fn_out_consume(void *priv, char *line, unsigned long len)
 {
 	struct emit_callback *ecbdata =3D priv;
 	const char *meta =3D diff_get_color(ecbdata->color_diff, DIFF_METAINF=
O);
@@ -1091,7 +1092,7 @@ static void fn_out_consume(void *priv, char *line=
, unsigned long len)
 		emit_hunk_header(ecbdata, line, len);
 		if (line[len-1] !=3D '\n')
 			putc('\n', ecbdata->opt->file);
-		return;
+		return 0;
 	}
=20
 	if (len < 1) {
@@ -1099,18 +1100,18 @@ static void fn_out_consume(void *priv, char *li=
ne, unsigned long len)
 		if (ecbdata->diff_words
 		    && ecbdata->diff_words->type =3D=3D DIFF_WORDS_PORCELAIN)
 			fputs("~\n", ecbdata->opt->file);
-		return;
+		return 0;
 	}
=20
 	if (ecbdata->diff_words) {
 		if (line[0] =3D=3D '-') {
 			diff_words_append(line, len,
 					  &ecbdata->diff_words->minus);
-			return;
+			return 0;
 		} else if (line[0] =3D=3D '+') {
 			diff_words_append(line, len,
 					  &ecbdata->diff_words->plus);
-			return;
+			return 0;
 		}
 		diff_words_flush(ecbdata);
 		if (ecbdata->diff_words->type =3D=3D DIFF_WORDS_PORCELAIN) {
@@ -1128,7 +1129,7 @@ static void fn_out_consume(void *priv, char *line=
, unsigned long len)
 			}
 			emit_line(ecbdata->opt, plain, reset, line, len);
 		}
-		return;
+		return 0;
 	}
=20
 	if (line[0] !=3D '+') {
@@ -1143,6 +1144,8 @@ static void fn_out_consume(void *priv, char *line=
, unsigned long len)
 		ecbdata->lno_in_postimage++;
 		emit_add_line(reset, ecbdata, line + 1, len - 1);
 	}
+
+	return 0;
 }
=20
 static char *pprint_rename(const char *a, const char *b)
@@ -1250,7 +1253,7 @@ static struct diffstat_file *diffstat_add(struct =
diffstat_t *diffstat,
 	return x;
 }
=20
-static void diffstat_consume(void *priv, char *line, unsigned long len=
)
+static int diffstat_consume(void *priv, char *line, unsigned long len)
 {
 	struct diffstat_t *diffstat =3D priv;
 	struct diffstat_file *x =3D diffstat->files[diffstat->nr - 1];
@@ -1259,6 +1262,7 @@ static void diffstat_consume(void *priv, char *li=
ne, unsigned long len)
 		x->added++;
 	else if (line[0] =3D=3D '-')
 		x->deleted++;
+	return 0;
 }
=20
 const char mime_boundary_leader[] =3D "------------";
@@ -1805,7 +1809,7 @@ static int is_conflict_marker(const char *line, i=
nt marker_size, unsigned long l
 	return 1;
 }
=20
-static void checkdiff_consume(void *priv, char *line, unsigned long le=
n)
+static int checkdiff_consume(void *priv, char *line, unsigned long len=
)
 {
 	struct checkdiff_t *data =3D priv;
 	int color_diff =3D DIFF_OPT_TST(data->o, COLOR_DIFF);
@@ -1835,7 +1839,7 @@ static void checkdiff_consume(void *priv, char *l=
ine, unsigned long len)
 		}
 		bad =3D ws_check(line + 1, len - 1, data->ws_rule);
 		if (!bad)
-			return;
+			return 0;
 		data->status |=3D bad;
 		err =3D whitespace_error_string(bad);
 		fprintf(data->o->file, "%s%s:%d: %s.\n",
@@ -1853,6 +1857,7 @@ static void checkdiff_consume(void *priv, char *l=
ine, unsigned long len)
 		else
 			die("invalid diff");
 	}
+	return 0;
 }
=20
 static unsigned char *deflate_it(char *data,
@@ -4008,19 +4013,20 @@ static int remove_space(char *line, int len)
 	return dst - line;
 }
=20
-static void patch_id_consume(void *priv, char *line, unsigned long len=
)
+static int patch_id_consume(void *priv, char *line, unsigned long len)
 {
 	struct patch_id_t *data =3D priv;
 	int new_len;
=20
 	/* Ignore line numbers when computing the SHA1 of the patch */
 	if (!prefixcmp(line, "@@ -"))
-		return;
+		return 0;
=20
 	new_len =3D remove_space(line, len);
=20
 	git_SHA1_Update(data->ctx, line, new_len);
 	data->patchlen +=3D new_len;
+	return 0;
 }
=20
 /* returns 0 upon success, and writes result into sha1 */
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index ea03b91..12811b9 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -12,25 +12,26 @@ struct diffgrep_cb {
 	int hit;
 };
=20
-static void diffgrep_consume(void *priv, char *line, unsigned long len=
)
+static int diffgrep_consume(void *priv, char *line, unsigned long len)
 {
 	struct diffgrep_cb *data =3D priv;
 	regmatch_t regmatch;
 	int hold;
=20
 	if (line[0] !=3D '+' && line[0] !=3D '-')
-		return;
+		return 0;
 	if (data->hit)
 		/*
 		 * NEEDSWORK: we should have a way to terminate the
 		 * caller early.
 		 */
-		return;
+		return 0;
 	/* Yuck -- line ought to be "const char *"! */
 	hold =3D line[len];
 	line[len] =3D '\0';
 	data->hit =3D !regexec(data->regexp, line + 1, 1, &regmatch, 0);
 	line[len] =3D hold;
+	return 0;
 }
=20
 static void fill_one(struct diff_filespec *one,
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 0e2c169..c5684b4 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -56,7 +56,7 @@ int parse_hunk_header(char *line, int len,
 	return -!!memcmp(cp, " @@", 3);
 }
=20
-static void consume_one(void *priv_, char *s, unsigned long size)
+static int consume_one(void *priv_, char *s, unsigned long size)
 {
 	struct xdiff_emit_state *priv =3D priv_;
 	char *ep;
@@ -64,10 +64,12 @@ static void consume_one(void *priv_, char *s, unsig=
ned long size)
 		unsigned long this_size;
 		ep =3D memchr(s, '\n', size);
 		this_size =3D (ep =3D=3D NULL) ? size : (ep - s + 1);
-		priv->consume(priv->consume_callback_data, s, this_size);
+		if (priv->consume(priv->consume_callback_data, s, this_size))
+			return -1;
 		size -=3D this_size;
 		s +=3D this_size;
 	}
+	return 0;
 }
=20
 static int xdiff_outf(void *priv_, mmbuffer_t *mb, int nbuf)
@@ -84,15 +86,18 @@ static int xdiff_outf(void *priv_, mmbuffer_t *mb, =
int nbuf)
=20
 		/* we have a complete line */
 		if (!priv->remainder.len) {
-			consume_one(priv, mb[i].ptr, mb[i].size);
+			if (consume_one(priv, mb[i].ptr, mb[i].size))
+				return -1;
 			continue;
 		}
 		strbuf_add(&priv->remainder, mb[i].ptr, mb[i].size);
-		consume_one(priv, priv->remainder.buf, priv->remainder.len);
+		if (consume_one(priv, priv->remainder.buf, priv->remainder.len))
+			return -1;
 		strbuf_reset(&priv->remainder);
 	}
 	if (priv->remainder.len) {
-		consume_one(priv, priv->remainder.buf, priv->remainder.len);
+		if (consume_one(priv, priv->remainder.buf, priv->remainder.len))
+			return -1;
 		strbuf_reset(&priv->remainder);
 	}
 	return 0;
diff --git a/xdiff-interface.h b/xdiff-interface.h
index 49d1116..b7aaa0e 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -3,7 +3,7 @@
=20
 #include "xdiff/xdiff.h"
=20
-typedef void (*xdiff_emit_consume_fn)(void *, char *, unsigned long);
+typedef int (*xdiff_emit_consume_fn)(void *, char *, unsigned long);
 typedef void (*xdiff_emit_hunk_consume_fn)(void *, long, long, long);
=20
 int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemi=
tconf_t const *xecfg, xdemitcb_t *ecb);
--=20
1.7.4.74.g639db
