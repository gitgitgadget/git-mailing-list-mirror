From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/3] diffcore-pickaxe: remove fill_one()
Date: Thu, 4 Apr 2013 20:08:47 -0400
Message-ID: <20130405000847.GB27775@sigill.intra.peff.net>
References: <7vr4iqi2uw.fsf@alter.siamese.dyndns.org>
 <004969e2ef9bb8017ce66e36b60a447ab35068d0.1365105971.git.simon@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: Simon Ruderich <simon@ruderich.org>
X-From: git-owner@vger.kernel.org Fri Apr 05 02:09:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNuDc-00022Y-GK
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 02:09:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765632Ab3DEAIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 20:08:55 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56559 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765469Ab3DEAIy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 20:08:54 -0400
Received: (qmail 8604 invoked by uid 107); 5 Apr 2013 00:10:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Apr 2013 20:10:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Apr 2013 20:08:47 -0400
Content-Disposition: inline
In-Reply-To: <004969e2ef9bb8017ce66e36b60a447ab35068d0.1365105971.git.simon@ruderich.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220128>

On Thu, Apr 04, 2013 at 10:21:08PM +0200, Simon Ruderich wrote:

> From: Jeff King <peff@peff.net>
> 
> fill_one is _almost_ identical to just calling fill_textconv; the
> exception is that for the !DIFF_FILE_VALID case, fill_textconv gives us
> an empty buffer rather than a NULL one.
> 
> Signed-off-by: Simon Ruderich <simon@ruderich.org>
> ---
> On Thu, Apr 04, 2013 at 01:49:42PM -0400, Jeff King wrote:
> > [snip]
> >
> > What do you think of something like this on top (this is on top of your
> > patches, but again, I would suggest re-ordering your two, so it would
> > come as patch 2/3):
> 
> Hello Jeff,
> 
> That's a good idea. I've added your patch, thanks. Signed-off?

Thanks. The whole series looks good to me. I think Junio's proposed
cleanup is a good direction, too, but I don't mind if that comes on top.

Here's an updated version of the patch with my signoff; I also expanded
on the commit message a little bit. The patch text is the same (I'm just
including the whole patch for Junio's convenience in applying).

-Peff

-- >8 --
Subject: [PATCH] diffcore-pickaxe: remove fill_one()

fill_one is _almost_ identical to just calling fill_textconv; the
exception is that for the !DIFF_FILE_VALID case, fill_textconv gives us
an empty buffer rather than a NULL one. Since we currently use the NULL
pointer as a signal that the file is not present on one side of the
diff, we must now switch to using DIFF_FILE_VALID to make the same
check.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Simon Ruderich <simon@ruderich.org>
---
 diffcore-pickaxe.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 8f955f8..3124f49 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -74,16 +74,6 @@ static void diffgrep_consume(void *priv, char *line, unsigned long len)
 	line[len] = hold;
 }
 
-static void fill_one(struct diff_filespec *one,
-		     mmfile_t *mf, struct userdiff_driver *textconv)
-{
-	if (DIFF_FILE_VALID(one)) {
-		mf->size = fill_textconv(textconv, one, &mf->ptr);
-	} else {
-		memset(mf, 0, sizeof(*mf));
-	}
-}
-
 static int diff_grep(struct diff_filepair *p, struct diff_options *o,
 		     regex_t *regexp, kwset_t kws)
 {
@@ -99,15 +89,15 @@ static int diff_grep(struct diff_filepair *p, struct diff_options *o,
 	textconv_one = get_textconv(p->one);
 	textconv_two = get_textconv(p->two);
 
-	fill_one(p->one, &mf1, textconv_one);
-	fill_one(p->two, &mf2, textconv_two);
+	mf1.size = fill_textconv(textconv_one, p->one, &mf1.ptr);
+	mf2.size = fill_textconv(textconv_two, p->two, &mf2.ptr);
 
-	if (!mf1.ptr) {
-		if (!mf2.ptr)
+	if (!DIFF_FILE_VALID(p->one)) {
+		if (!DIFF_FILE_VALID(p->two))
 			return 0; /* ignore unmerged */
 		/* created "two" -- does it have what we are looking for? */
 		hit = !regexec(regexp, mf2.ptr, 1, &regmatch, 0);
-	} else if (!mf2.ptr) {
+	} else if (!DIFF_FILE_VALID(p->two)) {
 		/* removed "one" -- did it have what we are looking for? */
 		hit = !regexec(regexp, mf1.ptr, 1, &regmatch, 0);
 	} else {
@@ -224,16 +214,16 @@ static int has_changes(struct diff_filepair *p, struct diff_options *o,
 	if (textconv_one == textconv_two && diff_unmodified_pair(p))
 		return 0;
 
-	fill_one(p->one, &mf1, textconv_one);
-	fill_one(p->two, &mf2, textconv_two);
+	mf1.size = fill_textconv(textconv_one, p->one, &mf1.ptr);
+	mf2.size = fill_textconv(textconv_two, p->two, &mf2.ptr);
 
-	if (!mf1.ptr) {
-		if (!mf2.ptr)
+	if (!DIFF_FILE_VALID(p->one)) {
+		if (!DIFF_FILE_VALID(p->two))
 			ret = 0; /* ignore unmerged */
 		/* created */
 		ret = contains(&mf2, o, regexp, kws) != 0;
 	}
-	else if (!mf2.ptr) /* removed */
+	else if (!DIFF_FILE_VALID(p->two)) /* removed */
 		ret = contains(&mf1, o, regexp, kws) != 0;
 	else
 		ret = contains(&mf1, o, regexp, kws) !=
-- 
1.8.2.rc0.33.gd915649
