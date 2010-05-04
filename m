From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git diff too slow for a file
Date: Tue, 04 May 2010 22:16:47 +0200
Message-ID: <4BE080AF.2030604@lsrfire.ath.cx>
References: <4BB00573.6040005@gmail.com> <4BC9D928.50909@lsrfire.ath.cx> <7vpr1y2eev.fsf@alter.siamese.dyndns.org> <4BCB48E5.9090303@lsrfire.ath.cx> <7vd3xuinbe.fsf@alter.siamese.dyndns.org> <4BDD7869.10701@lsrfire.ath.cx> <7v1vduwd8j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SungHyun Nam <goweol@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 04 22:17:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9OYR-0001wX-8R
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 22:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753827Ab0EDURL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 May 2010 16:17:11 -0400
Received: from india601.server4you.de ([85.25.151.105]:45423 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371Ab0EDURJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 16:17:09 -0400
Received: from [10.0.1.100] (p57B7C751.dip.t-dialin.net [87.183.199.81])
	by india601.server4you.de (Postfix) with ESMTPSA id 714072F8059;
	Tue,  4 May 2010 22:17:04 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <7v1vduwd8j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146340>

Am 02.05.2010 17:10, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>> diff --git a/merge-file.c b/merge-file.c
>> index c336c93..db4d0d5 100644
>> --- a/merge-file.c
>> +++ b/merge-file.c
>> @@ -66,7 +66,7 @@ static int generate_common_file(mmfile_t *res, mmf=
ile_t *f1, mmfile_t *f2)
>>  	xdemitcb_t ecb;
>> =20
>>  	memset(&xpp, 0, sizeof(xpp));
>> -	xpp.flags =3D XDF_NEED_MINIMAL;
>> +	xpp.flags =3D 0;
>>  	memset(&xecfg, 0, sizeof(xecfg));
>>  	xecfg.ctxlen =3D 3;
>>  	xecfg.flags =3D XDL_EMIT_COMMON;
>=20
> When I wrote the message you are responding to, I tried to decide whi=
ch is
> better, to replace the assigned value like your patch does, or to rem=
ove
> the assignment altogether as we have memset(&xpp, 0, sizeof(xpp)).  A=
nd I
> was somewhat torn.
>=20
> While it expresses what the patch wants to do a lot clearer (and it a=
lso
> marks the places the "later patch" needs to touch), the resulting cod=
e
> becomes slightly harder to read, because future readers of the code a=
re
> left with an obvious "why do we assign 0 after clearing the whole thi=
ng?
> is there anything subtle going on?" unanswered.

Well, I didn't do that because of a mix of laziness and caution.  A
mechanical replacement is much less likely to introduce bugs..

But when I take a closer look at the surrounding code, I can't help but
ask if the flags really have be passed in such a complicated way.

How about the following, which makes xdi_diff*() take a simple flag
parameter instead, moving the code to handle xpparam_t into
xdiff-interface.c, which seems to be the proper place for it?

Ren=C3=A9


---
 builtin/blame.c      |   10 ++--------
 builtin/merge-tree.c |    4 +---
 builtin/rerere.c     |    5 +----
 combine-diff.c       |    5 +----
 diff.c               |   25 +++++--------------------
 merge-file.c         |    5 +----
 xdiff-interface.c    |   18 +++++++++++-------
 xdiff-interface.h    |    8 ++++----
 8 files changed, 26 insertions(+), 54 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 8deeee1..1c1c9e4 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -734,7 +734,6 @@ static int pass_blame_to_parent(struct scoreboard *=
sb,
 	int last_in_target;
 	mmfile_t file_p, file_o;
 	struct blame_chunk_cb_data d =3D { sb, target, parent, 0, 0 };
-	xpparam_t xpp;
 	xdemitconf_t xecfg;
=20
 	last_in_target =3D find_last_in_target(sb, target);
@@ -745,11 +744,9 @@ static int pass_blame_to_parent(struct scoreboard =
*sb,
 	fill_origin_blob(target, &file_o);
 	num_get_patch++;
=20
-	memset(&xpp, 0, sizeof(xpp));
-	xpp.flags =3D xdl_opts;
 	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen =3D 0;
-	xdi_diff_hunks(&file_p, &file_o, blame_chunk_cb, &d, &xpp, &xecfg);
+	xdi_diff_hunks(&file_p, &file_o, blame_chunk_cb, &d, &xecfg, xdl_opts=
);
 	/* The rest (i.e. anything after tlno) are the same as the parent */
 	blame_chunk(sb, d.tlno, d.plno, last_in_target, target, parent);
=20
@@ -876,7 +873,6 @@ static void find_copy_in_blob(struct scoreboard *sb=
,
 	int cnt;
 	mmfile_t file_o;
 	struct handle_split_cb_data d =3D { sb, ent, parent, split, 0, 0 };
-	xpparam_t xpp;
 	xdemitconf_t xecfg;
=20
 	/*
@@ -896,12 +892,10 @@ static void find_copy_in_blob(struct scoreboard *=
sb,
 	 * file_o is a part of final image we are annotating.
 	 * file_p partially may match that image.
 	 */
-	memset(&xpp, 0, sizeof(xpp));
-	xpp.flags =3D xdl_opts;
 	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen =3D 1;
 	memset(split, 0, sizeof(struct blame_entry [3]));
-	xdi_diff_hunks(file_p, &file_o, handle_split_cb, &d, &xpp, &xecfg);
+	xdi_diff_hunks(file_p, &file_o, handle_split_cb, &d, &xecfg, xdl_opts=
);
 	/* remainder, if any, all match the preimage */
 	handle_split(sb, ent, d.tlno, d.plno, ent->num_lines, parent, split);
 }
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index fc00d79..d95cd1c 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -102,11 +102,9 @@ static void show_diff(struct merge_list *entry)
 {
 	unsigned long size;
 	mmfile_t src, dst;
-	xpparam_t xpp;
 	xdemitconf_t xecfg;
 	xdemitcb_t ecb;
=20
-	xpp.flags =3D 0;
 	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen =3D 3;
 	ecb.outf =3D show_outf;
@@ -120,7 +118,7 @@ static void show_diff(struct merge_list *entry)
 	if (!dst.ptr)
 		size =3D 0;
 	dst.size =3D size;
-	xdi_diff(&src, &dst, &xpp, &xecfg, &ecb);
+	xdi_diff(&src, &dst, &xecfg, &ecb, 0);
 	free(src.ptr);
 	free(dst.ptr);
 }
diff --git a/builtin/rerere.c b/builtin/rerere.c
index 0048f9e..43b75fa 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -78,7 +78,6 @@ static int outf(void *dummy, mmbuffer_t *ptr, int nbu=
f)
 static int diff_two(const char *file1, const char *label1,
 		const char *file2, const char *label2)
 {
-	xpparam_t xpp;
 	xdemitconf_t xecfg;
 	xdemitcb_t ecb;
 	mmfile_t minus, plus;
@@ -88,12 +87,10 @@ static int diff_two(const char *file1, const char *=
label1,
=20
 	printf("--- a/%s\n+++ b/%s\n", label1, label2);
 	fflush(stdout);
-	memset(&xpp, 0, sizeof(xpp));
-	xpp.flags =3D 0;
 	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen =3D 3;
 	ecb.outf =3D outf;
-	xdi_diff(&minus, &plus, &xpp, &xecfg, &ecb);
+	xdi_diff(&minus, &plus, &xecfg, &ecb, 0);
=20
 	free(minus.ptr);
 	free(plus.ptr);
diff --git a/combine-diff.c b/combine-diff.c
index 29779be..5b29226 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -208,7 +208,6 @@ static void combine_diff(const unsigned char *paren=
t, unsigned int mode,
 {
 	unsigned int p_lno, lno;
 	unsigned long nmask =3D (1UL << n);
-	xpparam_t xpp;
 	xdemitconf_t xecfg;
 	mmfile_t parent_file;
 	xdemitcb_t ecb;
@@ -220,8 +219,6 @@ static void combine_diff(const unsigned char *paren=
t, unsigned int mode,
=20
 	parent_file.ptr =3D grab_blob(parent, mode, &sz);
 	parent_file.size =3D sz;
-	memset(&xpp, 0, sizeof(xpp));
-	xpp.flags =3D 0;
 	memset(&xecfg, 0, sizeof(xecfg));
 	memset(&state, 0, sizeof(state));
 	state.nmask =3D nmask;
@@ -231,7 +228,7 @@ static void combine_diff(const unsigned char *paren=
t, unsigned int mode,
 	state.n =3D n;
=20
 	xdi_diff_outf(&parent_file, result_file, consume_line, &state,
-		      &xpp, &xecfg, &ecb);
+		      &xecfg, &ecb, 0);
 	free(parent_file.ptr);
=20
 	/* Assign line numbers for this parent.
diff --git a/diff.c b/diff.c
index 29e608b..d95a928 100644
--- a/diff.c
+++ b/diff.c
@@ -698,7 +698,6 @@ static void diff_words_fill(struct diff_words_buffe=
r *buffer, mmfile_t *out,
 /* this executes the word diff on the accumulated buffers */
 static void diff_words_show(struct diff_words_data *diff_words)
 {
-	xpparam_t xpp;
 	xdemitconf_t xecfg;
 	xdemitcb_t ecb;
 	mmfile_t minus, plus;
@@ -714,15 +713,13 @@ static void diff_words_show(struct diff_words_dat=
a *diff_words)
=20
 	diff_words->current_plus =3D diff_words->plus.text.ptr;
=20
-	memset(&xpp, 0, sizeof(xpp));
 	memset(&xecfg, 0, sizeof(xecfg));
 	diff_words_fill(&diff_words->minus, &minus, diff_words->word_regex);
 	diff_words_fill(&diff_words->plus, &plus, diff_words->word_regex);
-	xpp.flags =3D 0;
 	/* as only the hunk header will be parsed, we need a 0-context */
 	xecfg.ctxlen =3D 0;
 	xdi_diff_outf(&minus, &plus, fn_out_diff_words_aux, diff_words,
-		      &xpp, &xecfg, &ecb);
+		      &xecfg, &ecb, 0);
 	free(minus.ptr);
 	free(plus.ptr);
 	if (diff_words->current_plus !=3D diff_words->plus.text.ptr +
@@ -1703,7 +1700,6 @@ static void builtin_diff(const char *name_a,
 	else {
 		/* Crazy xdl interfaces.. */
 		const char *diffopts =3D getenv("GIT_DIFF_OPTS");
-		xpparam_t xpp;
 		xdemitconf_t xecfg;
 		xdemitcb_t ecb;
 		struct emit_callback ecbdata;
@@ -1733,7 +1729,6 @@ static void builtin_diff(const char *name_a,
 		if (!pe)
 			pe =3D diff_funcname_pattern(two);
=20
-		memset(&xpp, 0, sizeof(xpp));
 		memset(&xecfg, 0, sizeof(xecfg));
 		memset(&ecbdata, 0, sizeof(ecbdata));
 		ecbdata.label_path =3D lbl;
@@ -1744,7 +1739,6 @@ static void builtin_diff(const char *name_a,
 			check_blank_at_eof(&mf1, &mf2, &ecbdata);
 		ecbdata.file =3D o->file;
 		ecbdata.header =3D header.len ? &header : NULL;
-		xpp.flags =3D o->xdl_opts;
 		xecfg.ctxlen =3D o->context;
 		xecfg.interhunkctxlen =3D o->interhunkcontext;
 		xecfg.flags =3D XDL_EMIT_FUNCNAMES;
@@ -1777,7 +1771,7 @@ static void builtin_diff(const char *name_a,
 			}
 		}
 		xdi_diff_outf(&mf1, &mf2, fn_out_consume, &ecbdata,
-			      &xpp, &xecfg, &ecb);
+			      &xecfg, &ecb, o->xdl_opts);
 		if (DIFF_OPT_TST(o, COLOR_DIFF_WORDS))
 			free_diff_words_data(&ecbdata);
 		if (textconv_one)
@@ -1828,15 +1822,12 @@ static void builtin_diffstat(const char *name_a=
, const char *name_b,
 		data->deleted =3D mf1.size;
 	} else {
 		/* Crazy xdl interfaces.. */
-		xpparam_t xpp;
 		xdemitconf_t xecfg;
 		xdemitcb_t ecb;
=20
-		memset(&xpp, 0, sizeof(xpp));
 		memset(&xecfg, 0, sizeof(xecfg));
-		xpp.flags =3D o->xdl_opts;
 		xdi_diff_outf(&mf1, &mf2, diffstat_consume, diffstat,
-			      &xpp, &xecfg, &ecb);
+			      &xecfg, &ecb, o->xdl_opts);
 	}
=20
  free_and_return:
@@ -1876,16 +1867,13 @@ static void builtin_checkdiff(const char *name_=
a, const char *name_b,
 		goto free_and_return;
 	else {
 		/* Crazy xdl interfaces.. */
-		xpparam_t xpp;
 		xdemitconf_t xecfg;
 		xdemitcb_t ecb;
=20
-		memset(&xpp, 0, sizeof(xpp));
 		memset(&xecfg, 0, sizeof(xecfg));
 		xecfg.ctxlen =3D 1; /* at least one context line */
-		xpp.flags =3D 0;
 		xdi_diff_outf(&mf1, &mf2, checkdiff_consume, &data,
-			      &xpp, &xecfg, &ecb);
+			      &xecfg, &ecb, 0);
=20
 		if (data.ws_rule & WS_BLANK_AT_EOF) {
 			struct emit_callback ecbdata;
@@ -3378,14 +3366,12 @@ static int diff_get_patch_id(struct diff_option=
s *options, unsigned char *sha1)
 	data.ctx =3D &ctx;
=20
 	for (i =3D 0; i < q->nr; i++) {
-		xpparam_t xpp;
 		xdemitconf_t xecfg;
 		xdemitcb_t ecb;
 		mmfile_t mf1, mf2;
 		struct diff_filepair *p =3D q->queue[i];
 		int len1, len2;
=20
-		memset(&xpp, 0, sizeof(xpp));
 		memset(&xecfg, 0, sizeof(xecfg));
 		if (p->status =3D=3D 0)
 			return error("internal diff status error");
@@ -3438,11 +3424,10 @@ static int diff_get_patch_id(struct diff_option=
s *options, unsigned char *sha1)
 					len2, p->two->path);
 		git_SHA1_Update(&ctx, buffer, len1);
=20
-		xpp.flags =3D 0;
 		xecfg.ctxlen =3D 3;
 		xecfg.flags =3D XDL_EMIT_FUNCNAMES;
 		xdi_diff_outf(&mf1, &mf2, patch_id_consume, &data,
-			      &xpp, &xecfg, &ecb);
+			      &xecfg, &ecb, 0);
 	}
=20
 	git_SHA1_Final(sha1, &ctx);
diff --git a/merge-file.c b/merge-file.c
index db4d0d5..6521561 100644
--- a/merge-file.c
+++ b/merge-file.c
@@ -61,12 +61,9 @@ static int generate_common_file(mmfile_t *res, mmfil=
e_t *f1, mmfile_t *f2)
 {
 	unsigned long size =3D f1->size < f2->size ? f1->size : f2->size;
 	void *ptr =3D xmalloc(size);
-	xpparam_t xpp;
 	xdemitconf_t xecfg;
 	xdemitcb_t ecb;
=20
-	memset(&xpp, 0, sizeof(xpp));
-	xpp.flags =3D 0;
 	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen =3D 3;
 	xecfg.flags =3D XDL_EMIT_COMMON;
@@ -76,7 +73,7 @@ static int generate_common_file(mmfile_t *res, mmfile=
_t *f1, mmfile_t *f2)
 	res->size =3D 0;
=20
 	ecb.priv =3D res;
-	return xdi_diff(f1, f2, &xpp, &xecfg, &ecb);
+	return xdi_diff(f1, f2, &xecfg, &ecb, 0);
 }
=20
 void *merge_file(const char *path, struct blob *base, struct blob *our=
, struct blob *their, unsigned long *size)
diff --git a/xdiff-interface.c b/xdiff-interface.c
index ca5e3fb..6457a5b 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -126,20 +126,24 @@ static void trim_common_tail(mmfile_t *a, mmfile_=
t *b, long ctx)
 	b->size -=3D trimmed - recovered;
 }
=20
-int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemi=
tconf_t const *xecfg, xdemitcb_t *xecb)
+int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xdemitconf_t const *xecfg,
+	     xdemitcb_t *xecb, int xpp_flags)
 {
+	xpparam_t xpp;
 	mmfile_t a =3D *mf1;
 	mmfile_t b =3D *mf2;
=20
+	memset(&xpp, 0, sizeof(xpp));
+	xpp.flags =3D xpp_flags;
+
 	trim_common_tail(&a, &b, xecfg->ctxlen);
=20
-	return xdl_diff(&a, &b, xpp, xecfg, xecb);
+	return xdl_diff(&a, &b, &xpp, xecfg, xecb);
 }
=20
 int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
 		  xdiff_emit_consume_fn fn, void *consume_callback_data,
-		  xpparam_t const *xpp,
-		  xdemitconf_t const *xecfg, xdemitcb_t *xecb)
+		  xdemitconf_t const *xecfg, xdemitcb_t *xecb, int xpp_flags)
 {
 	int ret;
 	struct xdiff_emit_state state;
@@ -150,7 +154,7 @@ int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
 	xecb->outf =3D xdiff_outf;
 	xecb->priv =3D &state;
 	strbuf_init(&state.remainder, 0);
-	ret =3D xdi_diff(mf1, mf2, xpp, xecfg, xecb);
+	ret =3D xdi_diff(mf1, mf2, xecfg, xecb, xpp_flags);
 	strbuf_release(&state.remainder);
 	return ret;
 }
@@ -185,7 +189,7 @@ static int process_diff(xdfenv_t *xe, xdchange_t *x=
scr, xdemitcb_t *ecb,
=20
 int xdi_diff_hunks(mmfile_t *mf1, mmfile_t *mf2,
 		   xdiff_emit_hunk_consume_fn fn, void *consume_callback_data,
-		   xpparam_t const *xpp, xdemitconf_t *xecfg)
+		   xdemitconf_t *xecfg, int xpp_flags)
 {
 	struct xdiff_emit_hunk_state state;
 	xdemitcb_t ecb;
@@ -196,7 +200,7 @@ int xdi_diff_hunks(mmfile_t *mf1, mmfile_t *mf2,
 	state.consume_callback_data =3D consume_callback_data;
 	xecfg->emit_func =3D (void (*)())process_diff;
 	ecb.priv =3D &state;
-	return xdi_diff(mf1, mf2, xpp, xecfg, &ecb);
+	return xdi_diff(mf1, mf2, xecfg, &ecb, xpp_flags);
 }
=20
 int read_mmfile(mmfile_t *ptr, const char *filename)
diff --git a/xdiff-interface.h b/xdiff-interface.h
index abba70c..05adeb3 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -6,14 +6,14 @@
 typedef void (*xdiff_emit_consume_fn)(void *, char *, unsigned long);
 typedef void (*xdiff_emit_hunk_consume_fn)(void *, long, long, long);
=20
-int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemi=
tconf_t const *xecfg, xdemitcb_t *ecb);
+int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xdemitconf_t const *xecfg,
+	     xdemitcb_t *ecb, int xpp_flags);
 int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
 		  xdiff_emit_consume_fn fn, void *consume_callback_data,
-		  xpparam_t const *xpp,
-		  xdemitconf_t const *xecfg, xdemitcb_t *xecb);
+		  xdemitconf_t const *xecfg, xdemitcb_t *xecb, int xpp_flags);
 int xdi_diff_hunks(mmfile_t *mf1, mmfile_t *mf2,
 		   xdiff_emit_hunk_consume_fn fn, void *consume_callback_data,
-		   xpparam_t const *xpp, xdemitconf_t *xecfg);
+		   xdemitconf_t *xecfg, int xpp_flags);
 int parse_hunk_header(char *line, int len,
 		      int *ob, int *on,
 		      int *nb, int *nn);
--=20
1.7.1
