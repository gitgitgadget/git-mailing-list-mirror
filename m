From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 1/5] Allow alternate "low-level" emit function from xdl_diff
Date: Thu, 04 Sep 2008 00:29:19 +0200
Message-ID: <48BF0FBF.3010104@lsrfire.ath.cx>
References: <1219360921-28529-1-git-send-email-bdowning@lavos.net> <1219360921-28529-2-git-send-email-bdowning@lavos.net> <48AFC73F.2010100@lsrfire.ath.cx> <20080824081254.GI31114@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Thu Sep 04 00:30:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb0ry-0001zT-9Y
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 00:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033AbYICW31 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Sep 2008 18:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752026AbYICW31
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 18:29:27 -0400
Received: from india601.server4you.de ([85.25.151.105]:41281 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010AbYICW30 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 18:29:26 -0400
Received: from [10.0.1.200] (p57B7B77A.dip.t-dialin.net [87.183.183.122])
	by india601.server4you.de (Postfix) with ESMTPSA id B496C2F8045;
	Thu,  4 Sep 2008 00:29:24 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <20080824081254.GI31114@lavos.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94866>

Brian Downing schrieb:
> On Sat, Aug 23, 2008 at 10:15:59AM +0200, Ren=E9 Scharfe wrote:
>> Could we move more code into the library code to avoid that ugliness=
?
>>
>> AFAICS, compare_buffer() builds a struct patch with an array of
>> struct chunks, whose members are then fed one by one into either
>> blame_chunk() or handle_split().  Could we avoid the allocation
>> altogether by using a different interface?
>=20
> Thanks, I think this is a good idea.  I'll try to work up something l=
ike
> this, but it may be a few days before I have any appreciable hacking
> time to do so.

Here's a patch on top of the one I'm replying to, which in turn is
b3779280ca4881252069fa9d1c7d2069a69c4a52 in pu.  While it removes more
code than it adds and has a slightly nicer interface, it doesn't speed
up blame.  The following test case:

   $ git-blame -M -C -C -p --incremental master -- Makefile >/dev/null

loses a few calls to mmap, munmap and brk, as strace tells me, but any
speed up that might result from that is lost in the noise.

I haven't had time to think about how to combine it with the cache you
introduced in patches 2-5, though, and I won't get to it before the
weekend (if at all). :-/

Thanks,
Ren=E9


 builtin-blame.c   |  178 ++++++++++++++++-----------------------------=
-------
 xdiff-interface.c |   50 +++++++++++++++-
 xdiff-interface.h |    5 ++
 3 files changed, 109 insertions(+), 124 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 60f70bf..c9783dc 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -19,10 +19,6 @@
 #include "string-list.h"
 #include "mailmap.h"
 #include "parse-options.h"
-#include "xdiff/xtypes.h"
-#include "xdiff/xdiffi.h"
-#include "xdiff/xemit.h"
-#include "xdiff/xmacros.h"
=20
 static char blame_usage[] =3D "git blame [options] [rev-opts] [rev] [-=
-] file";
=20
@@ -448,99 +444,6 @@ static struct origin *find_rename(struct scoreboar=
d *sb,
 }
=20
 /*
- * Parsing of patch chunks...
- */
-struct chunk {
-	/* line number in postimage; up to but not including this
-	 * line is the same as preimage
-	 */
-	int same;
-
-	/* preimage line number after this chunk */
-	int p_next;
-
-	/* postimage line number after this chunk */
-	int t_next;
-};
-
-struct patch {
-	struct chunk *chunks;
-	int num;
-};
-
-static int process_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ec=
b,
-			xdemitconf_t const *xecfg)
-{
-	struct patch *patch =3D ecb->priv;
-	long s1, s2;
-	xdchange_t *xch, *xche;
-	struct chunk *chunk;
-
-	for (xch =3D xche =3D xscr; xch; xch =3D xche->next) {
-		xche =3D xdl_get_hunk(xch, xecfg);
-
-		s1 =3D XDL_MAX(xch->i1 - xecfg->ctxlen, 0);
-		s2 =3D XDL_MAX(xch->i2 - xecfg->ctxlen, 0);
-
-		++patch->num;
-		patch->chunks =3D xrealloc(patch->chunks,
-					 sizeof(struct chunk) * patch->num);
-		chunk =3D &patch->chunks[patch->num - 1];
-		chunk->same =3D s2 + XDL_MAX(xch->i1 - s1, 0);
-		chunk->p_next =3D xche->i1 + xche->chg1;
-		chunk->t_next =3D xche->i2 + xche->chg2;
-	}
-
-	return 0;
-}
-
-static struct patch *compare_buffer(mmfile_t *file_p, mmfile_t *file_o=
,
-				    int context)
-{
-	struct patch *patch;
-	xpparam_t xpp;
-	xdemitconf_t xecfg;
-	xdemitcb_t ecb;
-
-	xpp.flags =3D xdl_opts;
-	memset(&xecfg, 0, sizeof(xecfg));
-	xecfg.ctxlen =3D context;
-	patch =3D xmalloc(sizeof(struct patch));
-	patch->chunks =3D NULL;
-	patch->num =3D 0;
-	xecfg.emit_func =3D (void (*)())process_diff;
-	ecb.priv =3D patch;
-	xdi_diff(file_p, file_o, &xpp, &xecfg, &ecb);
-
-	return patch;
-}
-
-/*
- * Run diff between two origins and grab the patch output, so that
- * we can pass blame for lines origin is currently suspected for
- * to its parent.
- */
-static struct patch *get_patch(struct origin *parent, struct origin *o=
rigin)
-{
-	mmfile_t file_p, file_o;
-	struct patch *patch;
-
-	fill_origin_blob(parent, &file_p);
-	fill_origin_blob(origin, &file_o);
-	if (!file_p.ptr || !file_o.ptr)
-		return NULL;
-	patch =3D compare_buffer(&file_p, &file_o, 0);
-	num_get_patch++;
-	return patch;
-}
-
-static void free_patch(struct patch *p)
-{
-	free(p->chunks);
-	free(p);
-}
-
-/*
  * Link in a new blame entry to the scoreboard.  Entries that cover th=
e
  * same line range have been removed from the scoreboard previously.
  */
@@ -786,6 +689,22 @@ static void blame_chunk(struct scoreboard *sb,
 	}
 }
=20
+struct blame_chunk_cb_data {
+	struct scoreboard *sb;
+	struct origin *target;
+	struct origin *parent;
+	long plno;
+	long tlno;
+};
+
+static void blame_chunk_cb(void *data, long same, long p_next, long t_=
next)
+{
+	struct blame_chunk_cb_data *d =3D data;
+	blame_chunk(d->sb, d->tlno, d->plno, same, d->target, d->parent);
+	d->plno =3D p_next;
+	d->tlno =3D t_next;
+}
+
 /*
  * We are looking at the origin 'target' and aiming to pass blame
  * for the lines it is suspected to its parent.  Run diff to find
@@ -795,26 +714,28 @@ static int pass_blame_to_parent(struct scoreboard=
 *sb,
 				struct origin *target,
 				struct origin *parent)
 {
-	int i, last_in_target, plno, tlno;
-	struct patch *patch;
+	int last_in_target;
+	mmfile_t file_p, file_o;
+	struct blame_chunk_cb_data d =3D { sb, target, parent, 0, 0 };
+	xpparam_t xpp;
+	xdemitconf_t xecfg;
=20
 	last_in_target =3D find_last_in_target(sb, target);
 	if (last_in_target < 0)
 		return 1; /* nothing remains for this target */
=20
-	patch =3D get_patch(parent, target);
-	plno =3D tlno =3D 0;
-	for (i =3D 0; i < patch->num; i++) {
-		struct chunk *chunk =3D &patch->chunks[i];
+	fill_origin_blob(parent, &file_p);
+	fill_origin_blob(target, &file_o);
=20
-		blame_chunk(sb, tlno, plno, chunk->same, target, parent);
-		plno =3D chunk->p_next;
-		tlno =3D chunk->t_next;
-	}
+	num_get_patch++;
+
+	xpp.flags =3D xdl_opts;
+	memset(&xecfg, 0, sizeof(xecfg));
+	xecfg.ctxlen =3D 0;
+	xdi_diff_chunks(&file_p, &file_o, blame_chunk_cb, &d, &xpp, &xecfg);
 	/* The rest (i.e. anything after tlno) are the same as the parent */
-	blame_chunk(sb, tlno, plno, last_in_target, target, parent);
+	blame_chunk(sb, d.tlno, d.plno, last_in_target, target, parent);
=20
-	free_patch(patch);
 	return 0;
 }
=20
@@ -906,6 +827,23 @@ static void handle_split(struct scoreboard *sb,
 	}
 }
=20
+struct handle_split_cb_data {
+	struct scoreboard *sb;
+	struct blame_entry *ent;
+	struct origin *parent;
+	struct blame_entry *split;
+	long plno;
+	long tlno;
+};
+
+static void handle_split_cb(void *data, long same, long p_next, long t=
_next)
+{
+	struct handle_split_cb_data *d =3D data;
+	handle_split(d->sb, d->ent, d->tlno, d->plno, same, d->parent, d->spl=
it);
+	d->plno =3D p_next;
+	d->tlno =3D t_next;
+}
+
 /*
  * Find the lines from parent that are the same as ent so that
  * we can pass blames to it.  file_p has the blob contents for
@@ -920,8 +858,9 @@ static void find_copy_in_blob(struct scoreboard *sb=
,
 	const char *cp;
 	int cnt;
 	mmfile_t file_o;
-	struct patch *patch;
-	int i, plno, tlno;
+	struct handle_split_cb_data d =3D { sb, ent, parent, split, 0, 0 };
+	xpparam_t xpp;
+	xdemitconf_t xecfg;
=20
 	/*
 	 * Prepare mmfile that contains only the lines in ent.
@@ -936,24 +875,17 @@ static void find_copy_in_blob(struct scoreboard *=
sb,
 	}
 	file_o.size =3D cp - file_o.ptr;
=20
-	patch =3D compare_buffer(file_p, &file_o, 1);
-
 	/*
 	 * file_o is a part of final image we are annotating.
 	 * file_p partially may match that image.
 	 */
+	xpp.flags =3D xdl_opts;
+	memset(&xecfg, 0, sizeof(xecfg));
+	xecfg.ctxlen =3D 1;
 	memset(split, 0, sizeof(struct blame_entry [3]));
-	plno =3D tlno =3D 0;
-	for (i =3D 0; i < patch->num; i++) {
-		struct chunk *chunk =3D &patch->chunks[i];
-
-		handle_split(sb, ent, tlno, plno, chunk->same, parent, split);
-		plno =3D chunk->p_next;
-		tlno =3D chunk->t_next;
-	}
+	xdi_diff_chunks(file_p, &file_o, handle_split_cb, &d, &xpp, &xecfg);
 	/* remainder, if any, all match the preimage */
-	handle_split(sb, ent, tlno, plno, ent->num_lines, parent, split);
-	free_patch(patch);
+	handle_split(sb, ent, d.tlno, d.plno, ent->num_lines, parent, split);
 }
=20
 /*
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 944ad98..a7cfdab 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -1,6 +1,9 @@
 #include "cache.h"
 #include "xdiff-interface.h"
-#include "strbuf.h"
+#include "xdiff/xtypes.h"
+#include "xdiff/xdiffi.h"
+#include "xdiff/xemit.h"
+#include "xdiff/xmacros.h"
=20
 struct xdiff_emit_state {
 	xdiff_emit_consume_fn consume;
@@ -153,6 +156,51 @@ int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
 	return ret;
 }
=20
+struct xdiff_emit_chunk_state {
+	xdiff_emit_chunk_consume_fn consume;
+	void *consume_callback_data;
+};
+
+static int process_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ec=
b,
+			xdemitconf_t const *xecfg)
+{
+	long s1, s2, same, p_next, t_next;
+	xdchange_t *xch, *xche;
+	struct xdiff_emit_chunk_state *state =3D ecb->priv;
+	xdiff_emit_chunk_consume_fn fn =3D state->consume;
+	void *consume_callback_data =3D state->consume_callback_data;
+
+
+	for (xch =3D xche =3D xscr; xch; xch =3D xche->next) {
+		xche =3D xdl_get_hunk(xch, xecfg);
+
+		s1 =3D XDL_MAX(xch->i1 - xecfg->ctxlen, 0);
+		s2 =3D XDL_MAX(xch->i2 - xecfg->ctxlen, 0);
+		same =3D s2 + XDL_MAX(xch->i1 - s1, 0);
+		p_next =3D xche->i1 + xche->chg1;
+		t_next =3D xche->i2 + xche->chg2;
+
+		fn(consume_callback_data, same, p_next, t_next);
+	}
+	return 0;
+}
+
+int xdi_diff_chunks(mmfile_t *mf1, mmfile_t *mf2,
+		    xdiff_emit_chunk_consume_fn fn, void *consume_callback_data,
+		    xpparam_t const *xpp, xdemitconf_t *xecfg)
+{
+	struct xdiff_emit_chunk_state state;
+	xdemitcb_t ecb;
+
+	memset(&state, 0, sizeof(state));
+	memset(&ecb, 0, sizeof(ecb));
+	state.consume =3D fn;
+	state.consume_callback_data =3D consume_callback_data;
+	xecfg->emit_func =3D (void (*)())process_diff;
+	ecb.priv =3D &state;
+	return xdi_diff(mf1, mf2, xpp, xecfg, &ecb);
+}
+
 int read_mmfile(mmfile_t *ptr, const char *filename)
 {
 	struct stat st;
diff --git a/xdiff-interface.h b/xdiff-interface.h
index 558492b..1f7d985 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -4,12 +4,17 @@
 #include "xdiff/xdiff.h"
=20
 typedef void (*xdiff_emit_consume_fn)(void *, char *, unsigned long);
+typedef void (*xdiff_emit_chunk_consume_fn)(void *, long, long, long);
=20
 int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemi=
tconf_t const *xecfg, xdemitcb_t *ecb);
 int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
 		  xdiff_emit_consume_fn fn, void *consume_callback_data,
 		  xpparam_t const *xpp,
 		  xdemitconf_t const *xecfg, xdemitcb_t *xecb);
+int xdi_diff_chunks(mmfile_t *mf1, mmfile_t *mf2,
+		    xdiff_emit_chunk_consume_fn fn, void *consume_callback_data,
+		    xpparam_t const *xpp, xdemitconf_t *xecfg);
+
 int parse_hunk_header(char *line, int len,
 		      int *ob, int *on,
 		      int *nb, int *nn);
