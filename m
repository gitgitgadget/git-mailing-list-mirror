From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] diffcore-pickaxe: unify setup and teardown code
 between log -S/-G
Date: Fri, 5 Apr 2013 01:28:10 -0400
Message-ID: <20130405052810.GA29815@sigill.intra.peff.net>
References: <7v1uapfuyp.fsf@alter.siamese.dyndns.org>
 <1365137126-21659-1-git-send-email-gitster@pobox.com>
 <1365137126-21659-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 05 07:28:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNzCi-00007B-PA
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 07:28:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161462Ab3DEF2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 01:28:18 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56819 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161033Ab3DEF2S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 01:28:18 -0400
Received: (qmail 10916 invoked by uid 107); 5 Apr 2013 05:30:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 05 Apr 2013 01:30:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Apr 2013 01:28:10 -0400
Content-Disposition: inline
In-Reply-To: <1365137126-21659-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220144>

On Thu, Apr 04, 2013 at 09:45:26PM -0700, Junio C Hamano wrote:

> The logic to decide early to do nothing and prepare the data to be
> inspected are the same between has_changes() and diff_grep().
> Introduce pickaxe_setup() helper to share the same code.
> 
> Similarly, introduce pickaxe_finish_filepair() to clean up after
> these two functions are done with a filepair.

All three patches look fine to me.

I notice that you are stuck factoring out not just the setup, but also
the cleanup, and I wondered if things could be made even simpler by just
encapsulating the checking logic in a callback; then the setup and
cleanup flow more naturally, as they are in a single function wrapper.

Like this, which ends up saving 20 lines rather than adding 7:

---
 diffcore-pickaxe.c | 118 +++++++++++++++--------------------
 1 file changed, 49 insertions(+), 69 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index cadb071..63722f8 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -8,7 +8,12 @@
 #include "xdiff-interface.h"
 #include "kwset.h"
 
-typedef int (*pickaxe_fn)(struct diff_filepair *p, struct diff_options *o, regex_t *regexp, kwset_t kws);
+typedef int (*pickaxe_fn)(mmfile_t *one, mmfile_t *two,
+			  struct diff_options *o,
+			  regex_t *regexp, kwset_t kws);
+
+static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
+			 regex_t *regexp, kwset_t kws, pickaxe_fn fn);
 
 static void pickaxe(struct diff_queue_struct *q, struct diff_options *o,
 		    regex_t *regexp, kwset_t kws, pickaxe_fn fn)
@@ -22,7 +27,7 @@ static void pickaxe(struct diff_queue_struct *q, struct diff_options *o,
 		/* Showing the whole changeset if needle exists */
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
-			if (fn(p, o, regexp, kws))
+			if (pickaxe_match(p, o, regexp, kws, fn))
 				return; /* do not munge the queue */
 		}
 
@@ -37,7 +42,7 @@ static void pickaxe(struct diff_queue_struct *q, struct diff_options *o,
 		/* Showing only the filepairs that has the needle */
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
-			if (fn(p, o, regexp, kws))
+			if (pickaxe_match(p, o, regexp, kws, fn))
 				diff_q(&outq, p);
 			else
 				diff_free_filepair(p);
@@ -74,64 +79,33 @@ static int diff_grep(struct diff_filepair *p, struct diff_options *o,
 	line[len] = hold;
 }
 
-static int diff_grep(struct diff_filepair *p, struct diff_options *o,
+static int diff_grep(mmfile_t *one, mmfile_t *two,
+		     struct diff_options *o,
 		     regex_t *regexp, kwset_t kws)
 {
 	regmatch_t regmatch;
-	struct userdiff_driver *textconv_one = NULL;
-	struct userdiff_driver *textconv_two = NULL;
-	mmfile_t mf1, mf2;
-	int hit;
+	struct diffgrep_cb ecbdata;
+	xpparam_t xpp;
+	xdemitconf_t xecfg;
 
-	if (!o->pickaxe[0])
-		return 0;
+	if (!one)
+		return !regexec(regexp, two->ptr, 1, &regmatch, 0);
+	if (!two)
+		return !regexec(regexp, one->ptr, 1, &regmatch, 0);
 
-	if (DIFF_OPT_TST(o, ALLOW_TEXTCONV)) {
-		textconv_one = get_textconv(p->one);
-		textconv_two = get_textconv(p->two);
-	}
-
-	if (textconv_one == textconv_two && diff_unmodified_pair(p))
-		return 0;
-
-	mf1.size = fill_textconv(textconv_one, p->one, &mf1.ptr);
-	mf2.size = fill_textconv(textconv_two, p->two, &mf2.ptr);
-
-	if (!DIFF_FILE_VALID(p->one)) {
-		if (!DIFF_FILE_VALID(p->two))
-			hit = 0; /* ignore unmerged */
-		else
-			/* created "two" -- does it have what we are looking for? */
-			hit = !regexec(regexp, mf2.ptr, 1, &regmatch, 0);
-	} else if (!DIFF_FILE_VALID(p->two)) {
-		/* removed "one" -- did it have what we are looking for? */
-		hit = !regexec(regexp, mf1.ptr, 1, &regmatch, 0);
-	} else {
-		/*
-		 * We have both sides; need to run textual diff and see if
-		 * the pattern appears on added/deleted lines.
-		 */
-		struct diffgrep_cb ecbdata;
-		xpparam_t xpp;
-		xdemitconf_t xecfg;
-
-		memset(&xpp, 0, sizeof(xpp));
-		memset(&xecfg, 0, sizeof(xecfg));
-		ecbdata.regexp = regexp;
-		ecbdata.hit = 0;
-		xecfg.ctxlen = o->context;
-		xecfg.interhunkctxlen = o->interhunkcontext;
-		xdi_diff_outf(&mf1, &mf2, diffgrep_consume, &ecbdata,
-			      &xpp, &xecfg);
-		hit = ecbdata.hit;
-	}
-	if (textconv_one)
-		free(mf1.ptr);
-	if (textconv_two)
-		free(mf2.ptr);
-	diff_free_filespec_data(p->one);
-	diff_free_filespec_data(p->two);
-	return hit;
+	/*
+	 * We have both sides; need to run textual diff and see if
+	 * the pattern appears on added/deleted lines.
+	 */
+	memset(&xpp, 0, sizeof(xpp));
+	memset(&xecfg, 0, sizeof(xecfg));
+	ecbdata.regexp = regexp;
+	ecbdata.hit = 0;
+	xecfg.ctxlen = o->context;
+	xecfg.interhunkctxlen = o->interhunkcontext;
+	xdi_diff_outf(one, two, diffgrep_consume, &ecbdata,
+		      &xpp, &xecfg);
+	return ecbdata.hit;
 }
 
 static void diffcore_pickaxe_grep(struct diff_options *o)
@@ -198,9 +172,20 @@ static int has_changes(struct diff_filepair *p, struct diff_options *o,
 	return cnt;
 }
 
-static int has_changes(struct diff_filepair *p, struct diff_options *o,
+static int has_changes(mmfile_t *one, mmfile_t *two,
+		       struct diff_options *o,
 		       regex_t *regexp, kwset_t kws)
 {
+	if (!one)
+		return contains(two, o, regexp, kws) != 0;
+	if (!two)
+		return contains(one, o, regexp, kws) != 0;
+	return contains(one, o, regexp, kws) != contains(two, o, regexp, kws);
+}
+
+static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
+			 regex_t *regexp, kwset_t kws, pickaxe_fn fn)
+{
 	struct userdiff_driver *textconv_one = NULL;
 	struct userdiff_driver *textconv_two = NULL;
 	mmfile_t mf1, mf2;
@@ -209,6 +194,10 @@ static int has_changes(struct diff_filepair *p, struct diff_options *o,
 	if (!o->pickaxe[0])
 		return 0;
 
+	/* ignore unmerged */
+	if (!DIFF_FILE_VALID(p->one) && !DIFF_FILE_VALID(p->two))
+		return 0;
+
 	if (DIFF_OPT_TST(o, ALLOW_TEXTCONV)) {
 		textconv_one = get_textconv(p->one);
 		textconv_two = get_textconv(p->two);
@@ -227,18 +216,9 @@ static int has_changes(struct diff_filepair *p, struct diff_options *o,
 	mf1.size = fill_textconv(textconv_one, p->one, &mf1.ptr);
 	mf2.size = fill_textconv(textconv_two, p->two, &mf2.ptr);
 
-	if (!DIFF_FILE_VALID(p->one)) {
-		if (!DIFF_FILE_VALID(p->two))
-			ret = 0; /* ignore unmerged */
-		else
-			/* created */
-			ret = contains(&mf2, o, regexp, kws) != 0;
-	}
-	else if (!DIFF_FILE_VALID(p->two)) /* removed */
-		ret = contains(&mf1, o, regexp, kws) != 0;
-	else
-		ret = contains(&mf1, o, regexp, kws) !=
-		      contains(&mf2, o, regexp, kws);
+	ret = fn(DIFF_FILE_VALID(p->one) ? &mf1 : NULL,
+		 DIFF_FILE_VALID(p->two) ? &mf2 : NULL,
+		 o, regexp, kws);
 
 	if (textconv_one)
 		free(mf1.ptr);
