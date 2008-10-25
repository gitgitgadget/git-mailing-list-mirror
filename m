From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 5/5] blame: use xdi_diff_hunks(), get rid of struct patch
Date: Sat, 25 Oct 2008 15:31:36 +0200
Message-ID: <49031FB8.8060003@lsrfire.ath.cx>
References: <1219360921-28529-1-git-send-email-bdowning@lavos.net> <1219360921-28529-2-git-send-email-bdowning@lavos.net> <48AFC73F.2010100@lsrfire.ath.cx> <20080824081254.GI31114@lavos.net> <48BF0FBF.3010104@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Sat Oct 25 15:32:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtjG8-0000Wi-Lj
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 15:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbYJYNbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 09:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbYJYNbj
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 09:31:39 -0400
Received: from india601.server4you.de ([85.25.151.105]:56973 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbYJYNbj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 09:31:39 -0400
Received: from [10.0.1.100] (p57B7B97B.dip.t-dialin.net [87.183.185.123])
	by india601.server4you.de (Postfix) with ESMTPSA id 3F9F82F8045;
	Sat, 25 Oct 2008 15:31:37 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <48BF0FBF.3010104@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99112>

Based on a patch by Brian Downing, this replaces the struct patch based
code for blame passing with calls to xdi_diff_hunks().  This way we
avoid generating and then parsing patches; we only let the interesting
infos be passed to our callbacks instead.  This makes blame a bit faster:

   $ blame="./git blame -M -C -C -p --incremental v1.6.0"

   # master
   $ /usr/bin/time $blame Makefile >/dev/null
   1.38user 0.14system 0:01.52elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
   0inputs+0outputs (0major+12226minor)pagefaults 0swaps
   $ /usr/bin/time $blame cache.h >/dev/null
   1.66user 0.13system 0:01.80elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
   0inputs+0outputs (0major+12262minor)pagefaults 0swaps

   # this patch series
   $ /usr/bin/time $blame Makefile >/dev/null
   1.27user 0.12system 0:01.40elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
   0inputs+0outputs (0major+11836minor)pagefaults 0swaps
   $ /usr/bin/time $blame cache.h >/dev/null
   1.52user 0.12system 0:01.70elapsed 97%CPU (0avgtext+0avgdata 0maxresident)k
   0inputs+0outputs (0major+12052minor)pagefaults 0swaps

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
Brian, your numbers looked much more impressive.  Could you please clock
this code with your repository and the file server.c?  I wonder if this
callback mechanism is just too complicated or if your case simply benefits
lots more than the two files from git mentioned above.

The patch series ends here without adding xdiff caching, for two reasons.
It's quite easy to add it; patch 4 from your series applies unchanged and
patch 5 is just needs a few small changes to account for the absence of
compare_buffer().  More importantly, speed actually went down with caching
for the test case.  The common tail optimization (xdi_diff() vs. xdl_diff())
seems to beat caching for cache.h and Makefile..

 builtin-blame.c |  191 +++++++++++++++----------------------------------------
 1 files changed, 52 insertions(+), 139 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 5ca7065..b6bc5cf 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -443,113 +443,6 @@ static struct origin *find_rename(struct scoreboard *sb,
 }
 
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
-struct blame_diff_state {
-	struct patch *ret;
-	unsigned hunk_post_context;
-	unsigned hunk_in_pre_context : 1;
-};
-
-static void process_u_diff(void *state_, char *line, unsigned long len)
-{
-	struct blame_diff_state *state = state_;
-	struct chunk *chunk;
-	int off1, off2, len1, len2, num;
-
-	num = state->ret->num;
-	if (len < 4 || line[0] != '@' || line[1] != '@') {
-		if (state->hunk_in_pre_context && line[0] == ' ')
-			state->ret->chunks[num - 1].same++;
-		else {
-			state->hunk_in_pre_context = 0;
-			if (line[0] == ' ')
-				state->hunk_post_context++;
-			else
-				state->hunk_post_context = 0;
-		}
-		return;
-	}
-
-	if (num && state->hunk_post_context) {
-		chunk = &state->ret->chunks[num - 1];
-		chunk->p_next -= state->hunk_post_context;
-		chunk->t_next -= state->hunk_post_context;
-	}
-	state->ret->num = ++num;
-	state->ret->chunks = xrealloc(state->ret->chunks,
-				      sizeof(struct chunk) * num);
-	chunk = &state->ret->chunks[num - 1];
-	if (parse_hunk_header(line, len, &off1, &len1, &off2, &len2)) {
-		state->ret->num--;
-		return;
-	}
-
-	/* Line numbers in patch output are one based. */
-	off1--;
-	off2--;
-
-	chunk->same = len2 ? off2 : (off2 + 1);
-
-	chunk->p_next = off1 + (len1 ? len1 : 1);
-	chunk->t_next = chunk->same + len2;
-	state->hunk_in_pre_context = 1;
-	state->hunk_post_context = 0;
-}
-
-static struct patch *compare_buffer(mmfile_t *file_p, mmfile_t *file_o,
-				    int context)
-{
-	struct blame_diff_state state;
-	xpparam_t xpp;
-	xdemitconf_t xecfg;
-	xdemitcb_t ecb;
-
-	memset(&xpp, 0, sizeof(xpp));
-	xpp.flags = xdl_opts;
-	memset(&xecfg, 0, sizeof(xecfg));
-	xecfg.ctxlen = context;
-	memset(&state, 0, sizeof(state));
-	state.ret = xmalloc(sizeof(struct patch));
-	state.ret->chunks = NULL;
-	state.ret->num = 0;
-
-	xdi_diff_outf(file_p, file_o, process_u_diff, &state, &xpp, &xecfg, &ecb);
-
-	if (state.ret->num) {
-		struct chunk *chunk;
-		chunk = &state.ret->chunks[state.ret->num - 1];
-		chunk->p_next -= state.hunk_post_context;
-		chunk->t_next -= state.hunk_post_context;
-	}
-	return state.ret;
-}
-
-static void free_patch(struct patch *p)
-{
-	free(p->chunks);
-	free(p);
-}
-
-/*
  * Link in a new blame entry to the scoreboard.  Entries that cover the
  * same line range have been removed from the scoreboard previously.
  */
@@ -795,6 +688,22 @@ static void blame_chunk(struct scoreboard *sb,
 	}
 }
 
+struct blame_chunk_cb_data {
+	struct scoreboard *sb;
+	struct origin *target;
+	struct origin *parent;
+	long plno;
+	long tlno;
+};
+
+static void blame_chunk_cb(void *data, long same, long p_next, long t_next)
+{
+	struct blame_chunk_cb_data *d = data;
+	blame_chunk(d->sb, d->tlno, d->plno, same, d->target, d->parent);
+	d->plno = p_next;
+	d->tlno = t_next;
+}
+
 /*
  * We are looking at the origin 'target' and aiming to pass blame
  * for the lines it is suspected to its parent.  Run diff to find
@@ -804,36 +713,28 @@ static int pass_blame_to_parent(struct scoreboard *sb,
 				struct origin *target,
 				struct origin *parent)
 {
-	int i, last_in_target, plno, tlno;
-	struct patch *patch;
+	int last_in_target;
 	mmfile_t file_p, file_o;
+	struct blame_chunk_cb_data d = { sb, target, parent, 0, 0 };
+	xpparam_t xpp;
+	xdemitconf_t xecfg;
 
 	last_in_target = find_last_in_target(sb, target);
 	if (last_in_target < 0)
 		return 1; /* nothing remains for this target */
 
-	/*
-	 * Run diff between two origins and grab the patch output, so that
-	 * we can pass blame for lines origin is currently suspected for
-	 * to its parent.
-	 */
 	fill_origin_blob(parent, &file_p);
 	fill_origin_blob(target, &file_o);
-	patch = compare_buffer(&file_p, &file_o, 0);
 	num_get_patch++;
 
-	plno = tlno = 0;
-	for (i = 0; i < patch->num; i++) {
-		struct chunk *chunk = &patch->chunks[i];
-
-		blame_chunk(sb, tlno, plno, chunk->same, target, parent);
-		plno = chunk->p_next;
-		tlno = chunk->t_next;
-	}
+	memset(&xpp, 0, sizeof(xpp));
+	xpp.flags = xdl_opts;
+	memset(&xecfg, 0, sizeof(xecfg));
+	xecfg.ctxlen = 0;
+	xdi_diff_hunks(&file_p, &file_o, blame_chunk_cb, &d, &xpp, &xecfg);
 	/* The rest (i.e. anything after tlno) are the same as the parent */
-	blame_chunk(sb, tlno, plno, last_in_target, target, parent);
+	blame_chunk(sb, d.tlno, d.plno, last_in_target, target, parent);
 
-	free_patch(patch);
 	return 0;
 }
 
@@ -925,6 +826,23 @@ static void handle_split(struct scoreboard *sb,
 	}
 }
 
+struct handle_split_cb_data {
+	struct scoreboard *sb;
+	struct blame_entry *ent;
+	struct origin *parent;
+	struct blame_entry *split;
+	long plno;
+	long tlno;
+};
+
+static void handle_split_cb(void *data, long same, long p_next, long t_next)
+{
+	struct handle_split_cb_data *d = data;
+	handle_split(d->sb, d->ent, d->tlno, d->plno, same, d->parent, d->split);
+	d->plno = p_next;
+	d->tlno = t_next;
+}
+
 /*
  * Find the lines from parent that are the same as ent so that
  * we can pass blames to it.  file_p has the blob contents for
@@ -939,8 +857,9 @@ static void find_copy_in_blob(struct scoreboard *sb,
 	const char *cp;
 	int cnt;
 	mmfile_t file_o;
-	struct patch *patch;
-	int i, plno, tlno;
+	struct handle_split_cb_data d = { sb, ent, parent, split, 0, 0 };
+	xpparam_t xpp;
+	xdemitconf_t xecfg;
 
 	/*
 	 * Prepare mmfile that contains only the lines in ent.
@@ -955,24 +874,18 @@ static void find_copy_in_blob(struct scoreboard *sb,
 	}
 	file_o.size = cp - file_o.ptr;
 
-	patch = compare_buffer(file_p, &file_o, 1);
-
 	/*
 	 * file_o is a part of final image we are annotating.
 	 * file_p partially may match that image.
 	 */
+	memset(&xpp, 0, sizeof(xpp));
+	xpp.flags = xdl_opts;
+	memset(&xecfg, 0, sizeof(xecfg));
+	xecfg.ctxlen = 1;
 	memset(split, 0, sizeof(struct blame_entry [3]));
-	plno = tlno = 0;
-	for (i = 0; i < patch->num; i++) {
-		struct chunk *chunk = &patch->chunks[i];
-
-		handle_split(sb, ent, tlno, plno, chunk->same, parent, split);
-		plno = chunk->p_next;
-		tlno = chunk->t_next;
-	}
+	xdi_diff_hunks(file_p, &file_o, handle_split_cb, &d, &xpp, &xecfg);
 	/* remainder, if any, all match the preimage */
-	handle_split(sb, ent, tlno, plno, ent->num_lines, parent, split);
-	free_patch(patch);
+	handle_split(sb, ent, d.tlno, d.plno, ent->num_lines, parent, split);
 }
 
 /*
-- 
1.6.0.3.514.g2f91b
