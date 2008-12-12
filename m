From: Jeff King <peff@peff.net>
Subject: Re: git log --numstat disagrees with git apply --numstat
Date: Thu, 11 Dec 2008 21:21:56 -0500
Message-ID: <20081212022156.GC23128@sigill.intra.peff.net>
References: <20081211235337.GK32487@spearce.org> <20081212015254.GA23128@sigill.intra.peff.net> <20081212020857.GB23128@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Dec 12 03:23:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAxga-0008C8-25
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 03:23:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757120AbYLLCWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 21:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757104AbYLLCWF
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 21:22:05 -0500
Received: from peff.net ([208.65.91.99]:3851 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757089AbYLLCWE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 21:22:04 -0500
Received: (qmail 31474 invoked by uid 111); 12 Dec 2008 02:22:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 11 Dec 2008 21:22:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Dec 2008 21:21:56 -0500
Content-Disposition: inline
In-Reply-To: <20081212020857.GB23128@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102861>

On Thu, Dec 11, 2008 at 09:08:58PM -0500, Jeff King wrote:

> > which is probably just due to different xdi settings being used between
> > the two codepaths. I haven't looked closely to see which different
> > options we are feeding to xdiff.
> 
> Ah. Doing this gives me the 68/12 answer for "git log --numstat":

BTW, I got a little confused looking at the parameters to xdi_diff_outf,
since ecb gets passed in full of random garbage. I don't know if this
cleanup is worth applying:

-- >8 --
remove xecb parameter to xdi_diff_outf

It is pointless to pass this parameter in instead of just
declaring it locally inside the function because:

  1. We overwrite every member of the struct inside the
     function anyway, so we ignore anything passed in.

  2. The contents after we return point to a local variable
     that has gone out of scope, so it is wrong to look at
     them.

So it is just making the interface more complex to have it
there, and it looks like a potential error in the callers to
be passing a completely uninitialized variable.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c            |   15 +++++----------
 xdiff-interface.c |    9 +++++----
 xdiff-interface.h |    2 +-
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/diff.c b/diff.c
index af822c1..1801aef 100644
--- a/diff.c
+++ b/diff.c
@@ -403,7 +403,6 @@ static void diff_words_show(struct diff_words_data *diff_words)
 {
 	xpparam_t xpp;
 	xdemitconf_t xecfg;
-	xdemitcb_t ecb;
 	mmfile_t minus, plus;
 	int i;
 
@@ -428,7 +427,7 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	xpp.flags = XDF_NEED_MINIMAL;
 	xecfg.ctxlen = diff_words->minus.alloc + diff_words->plus.alloc;
 	xdi_diff_outf(&minus, &plus, fn_out_diff_words_aux, diff_words,
-		      &xpp, &xecfg, &ecb);
+		      &xpp, &xecfg);
 	free(minus.ptr);
 	free(plus.ptr);
 	diff_words->minus.text.size = diff_words->plus.text.size = 0;
@@ -1436,7 +1435,6 @@ static void builtin_diff(const char *name_a,
 		const char *diffopts = getenv("GIT_DIFF_OPTS");
 		xpparam_t xpp;
 		xdemitconf_t xecfg;
-		xdemitcb_t ecb;
 		struct emit_callback ecbdata;
 		const struct userdiff_funcname *pe;
 
@@ -1484,7 +1482,7 @@ static void builtin_diff(const char *name_a,
 			ecbdata.diff_words->file = o->file;
 		}
 		xdi_diff_outf(&mf1, &mf2, fn_out_consume, &ecbdata,
-			      &xpp, &xecfg, &ecb);
+			      &xpp, &xecfg);
 		if (DIFF_OPT_TST(o, COLOR_DIFF_WORDS))
 			free_diff_words_data(&ecbdata);
 		if (textconv_one)
@@ -1535,13 +1533,12 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 		/* Crazy xdl interfaces.. */
 		xpparam_t xpp;
 		xdemitconf_t xecfg;
-		xdemitcb_t ecb;
 
 		memset(&xpp, 0, sizeof(xpp));
 		memset(&xecfg, 0, sizeof(xecfg));
 		xpp.flags = XDF_NEED_MINIMAL | o->xdl_opts;
 		xdi_diff_outf(&mf1, &mf2, diffstat_consume, diffstat,
-			      &xpp, &xecfg, &ecb);
+			      &xpp, &xecfg);
 	}
 
  free_and_return:
@@ -1582,14 +1579,13 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 		/* Crazy xdl interfaces.. */
 		xpparam_t xpp;
 		xdemitconf_t xecfg;
-		xdemitcb_t ecb;
 
 		memset(&xpp, 0, sizeof(xpp));
 		memset(&xecfg, 0, sizeof(xecfg));
 		xecfg.ctxlen = 1; /* at least one context line */
 		xpp.flags = XDF_NEED_MINIMAL;
 		xdi_diff_outf(&mf1, &mf2, checkdiff_consume, &data,
-			      &xpp, &xecfg, &ecb);
+			      &xpp, &xecfg);
 
 		if ((data.ws_rule & WS_TRAILING_SPACE) &&
 		    data.trailing_blanks_start) {
@@ -3009,7 +3005,6 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 	for (i = 0; i < q->nr; i++) {
 		xpparam_t xpp;
 		xdemitconf_t xecfg;
-		xdemitcb_t ecb;
 		mmfile_t mf1, mf2;
 		struct diff_filepair *p = q->queue[i];
 		int len1, len2;
@@ -3071,7 +3066,7 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 		xecfg.ctxlen = 3;
 		xecfg.flags = XDL_EMIT_FUNCNAMES;
 		xdi_diff_outf(&mf1, &mf2, patch_id_consume, &data,
-			      &xpp, &xecfg, &ecb);
+			      &xpp, &xecfg);
 	}
 
 	git_SHA1_Final(sha1, &ctx);
diff --git a/xdiff-interface.c b/xdiff-interface.c
index d782f06..d0d60fa 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -140,18 +140,19 @@ int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemitconf_t co
 int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
 		  xdiff_emit_consume_fn fn, void *consume_callback_data,
 		  xpparam_t const *xpp,
-		  xdemitconf_t const *xecfg, xdemitcb_t *xecb)
+		  xdemitconf_t const *xecfg)
 {
 	int ret;
 	struct xdiff_emit_state state;
+	xdemitcb_t xecb;
 
 	memset(&state, 0, sizeof(state));
 	state.consume = fn;
 	state.consume_callback_data = consume_callback_data;
-	xecb->outf = xdiff_outf;
-	xecb->priv = &state;
+	xecb.outf = xdiff_outf;
+	xecb.priv = &state;
 	strbuf_init(&state.remainder, 0);
-	ret = xdi_diff(mf1, mf2, xpp, xecfg, xecb);
+	ret = xdi_diff(mf1, mf2, xpp, xecfg, &xecb);
 	strbuf_release(&state.remainder);
 	return ret;
 }
diff --git a/xdiff-interface.h b/xdiff-interface.h
index 7352b9a..491037d 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -10,7 +10,7 @@ int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemitconf_t co
 int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
 		  xdiff_emit_consume_fn fn, void *consume_callback_data,
 		  xpparam_t const *xpp,
-		  xdemitconf_t const *xecfg, xdemitcb_t *xecb);
+		  xdemitconf_t const *xecfg);
 int xdi_diff_hunks(mmfile_t *mf1, mmfile_t *mf2,
 		   xdiff_emit_hunk_consume_fn fn, void *consume_callback_data,
 		   xpparam_t const *xpp, xdemitconf_t *xecfg);
-- 
1.6.1.rc2.307.gb39e0.dirty
