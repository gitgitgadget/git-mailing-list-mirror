From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] diffcore-pickaxe: fill_one() doesn't modify textconv
Date: Thu, 4 Apr 2013 13:49:42 -0400
Message-ID: <20130404174942.GB13005@sigill.intra.peff.net>
References: <472ae7e08eedfef5886d0ace935654876091447d.1365090893.git.simon@ruderich.org>
 <20130404160557.GB25232@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Simon Ruderich <simon@ruderich.org>
X-From: git-owner@vger.kernel.org Thu Apr 04 19:50:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNoIk-0005tM-9c
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 19:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764116Ab3DDRtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 13:49:49 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56112 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764017Ab3DDRtt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 13:49:49 -0400
Received: (qmail 3357 invoked by uid 107); 4 Apr 2013 17:51:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Apr 2013 13:51:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Apr 2013 13:49:42 -0400
Content-Disposition: inline
In-Reply-To: <20130404160557.GB25232@ruderich.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220041>

On Thu, Apr 04, 2013 at 06:05:58PM +0200, Simon Ruderich wrote:

> Signed-off-by: Simon Ruderich <simon@ruderich.org>
> ---
>  diffcore-pickaxe.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
> index f814a52..c378ea0 100644
> --- a/diffcore-pickaxe.c
> +++ b/diffcore-pickaxe.c
> @@ -75,10 +75,10 @@ static void diffgrep_consume(void *priv, char *line, unsigned long len)
>  }
>  
>  static void fill_one(struct diff_filespec *one,
> -		     mmfile_t *mf, struct userdiff_driver **textconv)
> +		     mmfile_t *mf, struct userdiff_driver *textconv)
>  {
>  	if (DIFF_FILE_VALID(one)) {
> -		mf->size = fill_textconv(*textconv, one, &mf->ptr);
> +		mf->size = fill_textconv(textconv, one, &mf->ptr);
>  	} else {
>  		memset(mf, 0, sizeof(*mf));
>  	}
> @@ -101,8 +101,8 @@ static int diff_grep(struct diff_filepair *p, struct diff_options *o,
>  		textconv_two = get_textconv(p->two);
>  	}
>  
> -	fill_one(p->one, &mf1, &textconv_one);
> -	fill_one(p->two, &mf2, &textconv_two);
> +	fill_one(p->one, &mf1, textconv_one);
> +	fill_one(p->two, &mf2, textconv_two);

This is a sensible cleanup, though as I mentioned elsewhere, I think it
would make sense to come first before the other patch.

After this, fill_one is _almost_ identical to just calling
fill_textconv; the exception is that for the !DIFF_FILE_VALID case,
fill_textconv gives us an empty buffer rather than a NULL one.

What do you think of something like this on top (this is on top of your
patches, but again, I would suggest re-ordering your two, so it would
come as patch 2/3):

 diffcore-pickaxe.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index c378ea0..26ddf00 100644
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
@@ -101,15 +91,15 @@ static int diff_grep(struct diff_filepair *p, struct diff_options *o,
 		textconv_two = get_textconv(p->two);
 	}
 
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
@@ -228,16 +218,16 @@ static int has_changes(struct diff_filepair *p, struct diff_options *o,
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
