From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 3/3 v2] use cache for function names in hunk headers
Date: Sun, 26 Sep 2010 18:26:56 +0200
Message-ID: <4C9F7450.9060208@lsrfire.ath.cx>
References: <1284890369-4136-1-git-send-email-drizzd@aon.at> <20100923070439.GA29764@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Sep 26 18:27:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ozu4Z-0000OW-98
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 18:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754448Ab0IZQ10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 12:27:26 -0400
Received: from india601.server4you.de ([85.25.151.105]:60814 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675Ab0IZQ1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 12:27:25 -0400
Received: from [10.0.1.100] (p4FC5675F.dip.t-dialin.net [79.197.103.95])
	by india601.server4you.de (Postfix) with ESMTPSA id 1C4412F8084;
	Sun, 26 Sep 2010 18:27:23 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20100923070439.GA29764@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157237>

Am 23.09.2010 09:04, schrieb Clemens Buchacher:
> For each hunk, xdl_find_func searches the preimage
> for a function name until the beginning of the
> file. If the file does not contain any function
> names, this search has complexity O(n2) in the
> number of hunks n.
> 
> The timing test in t3419 creates a file with 50000
> lines and a one-line change every 10 lines, i.e.,
> about 5000 hunks. Since none of the lines matches
> a function definition the file is searched 5000
> times.
> 
> Instead of searching the entire file for each hunk
> individually, cache and reuse the search result
> from previous hunks.
> 
> Diff performance for the test described above
> before and after this optimization:
> 
> 2.78user 0.01system 0:02.82elapsed 99%CPU
> 0.05user 0.01system 0:00.06elapsed 96%CPU
> 
> Signed-off-by: Clemens Buchacher <drizzd@aon.at>
> ---
> 
> I have added the test description as requested by
> Sverre. There are no code changes with respect to
> the previous version of the patch.
> 
> The test scenario might seem quite obscure.  But I
> have this case in some text files which are not
> edited directly by humans.
> 
> Clemens
> 
>  xdiff/xemit.c |   44 ++++++++++++++++++++++++++++++++------------
>  1 files changed, 32 insertions(+), 12 deletions(-)
> 
> diff --git a/xdiff/xemit.c b/xdiff/xemit.c
> index c4bedf0..349bd6b 100644
> --- a/xdiff/xemit.c
> +++ b/xdiff/xemit.c
> @@ -85,8 +85,15 @@ static long def_ff(const char *rec, long len, char *buf, long sz, void *priv)
>  	return -1;
>  }
>  
> -static void xdl_find_func(xdfile_t *xf, long i, char *buf, long sz, long *ll,
> -		find_func_t ff, void *ff_priv) {
> +struct xdl_find_func_cache {
> +	char buf[80];
> +	long len;
> +	xdfile_t *xf;
> +	int line;
> +};

Is xf needed?  Does xdl_emit_diff() handle multiple files in one go?

If you inline xdl_find_func() the struct isn't needed anymore.

> +
> +static void xdl_find_func(xdfile_t *xf, long line, find_func_t ff,
> +		          void *ff_priv, struct xdl_find_func_cache *cache) {
>  
>  	/*
>  	 * Be quite stupid about this for now.  Find a line in the old file
> @@ -96,13 +103,28 @@ static void xdl_find_func(xdfile_t *xf, long i, char *buf, long sz, long *ll,
>  
>  	const char *rec;
>  	long len;
> +	int i, l;
>  
> -	while (i-- > 0) {
> -		len = xdl_get_rec(xf, i, &rec);
> -		if ((*ll = ff(rec, len, buf, sz, ff_priv)) >= 0)
> +	if (line < cache->line)
> +		cache->xf = 0;

NULL is preferred.

> +
> +	i = line;
> +	l = -1;
> +	while (--i >= 0 && l < 0) {
> +		if (xf == cache->xf && i < cache->line) {
> +			cache->line = line;
>  			return;
> +		}
> +
> +		len = xdl_get_rec(xf, i, &rec);
> +		l = ff(rec, len, cache->buf, sizeof(cache->buf), ff_priv);
>  	}
> -	*ll = 0;
> +	if (l < 0)
> +		l = 0;
> +
> +	cache->xf = xf;
> +	cache->len = l;
> +	cache->line = line;
>  }
>  
>  
> @@ -125,8 +147,7 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
>  		  xdemitconf_t const *xecfg) {
>  	long s1, s2, e1, e2, lctx;
>  	xdchange_t *xch, *xche;
> -	char funcbuf[80];
> -	long funclen = 0;
> +	struct xdl_find_func_cache func_cache = { "", 0, NULL, -1 };
>  	find_func_t ff = xecfg->find_func ?  xecfg->find_func : def_ff;
>  
>  	if (xecfg->flags & XDL_EMIT_COMMON)
> @@ -150,12 +171,11 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
>  		 */
>  
>  		if (xecfg->flags & XDL_EMIT_FUNCNAMES) {
> -			xdl_find_func(&xe->xdf1, s1, funcbuf,
> -				      sizeof(funcbuf), &funclen,
> -				      ff, xecfg->find_func_priv);
> +			xdl_find_func(&xe->xdf1, s1, ff, xecfg->find_func_priv,
> +					&func_cache);
>  		}
>  		if (xdl_emit_hunk_hdr(s1 + 1, e1 - s1, s2 + 1, e2 - s2,
> -				      funcbuf, funclen, ecb) < 0)
> +				      func_cache.buf, func_cache.len, ecb) < 0)
>  			return -1;
>  
>  		/*

How about something like this?  It also removes an outdated comment.  The
inlining part should probably split out in its own patch..

 xdiff/xemit.c |   38 ++++++++++++++------------------------
 1 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index c4bedf0..a663f21 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -85,27 +85,6 @@ static long def_ff(const char *rec, long len, char *buf, long sz, void *priv)
 	return -1;
 }
 
-static void xdl_find_func(xdfile_t *xf, long i, char *buf, long sz, long *ll,
-		find_func_t ff, void *ff_priv) {
-
-	/*
-	 * Be quite stupid about this for now.  Find a line in the old file
-	 * before the start of the hunk (and context) which starts with a
-	 * plausible character.
-	 */
-
-	const char *rec;
-	long len;
-
-	while (i-- > 0) {
-		len = xdl_get_rec(xf, i, &rec);
-		if ((*ll = ff(rec, len, buf, sz, ff_priv)) >= 0)
-			return;
-	}
-	*ll = 0;
-}
-
-
 static int xdl_emit_common(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
                            xdemitconf_t const *xecfg) {
 	xdfile_t *xdf = &xe->xdf1;
@@ -127,6 +106,7 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 	xdchange_t *xch, *xche;
 	char funcbuf[80];
 	long funclen = 0;
+	long funclineprev = -1;
 	find_func_t ff = xecfg->find_func ?  xecfg->find_func : def_ff;
 
 	if (xecfg->flags & XDL_EMIT_COMMON)
@@ -150,9 +130,19 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 		 */
 
 		if (xecfg->flags & XDL_EMIT_FUNCNAMES) {
-			xdl_find_func(&xe->xdf1, s1, funcbuf,
-				      sizeof(funcbuf), &funclen,
-				      ff, xecfg->find_func_priv);
+			long l;
+			for (l = s1 - 1; l >= 0 && l > funclineprev; l--) {
+				const char *rec;
+				long reclen = xdl_get_rec(&xe->xdf1, l, &rec);
+				long newfunclen = ff(rec, reclen, funcbuf,
+						     sizeof(funcbuf),
+						     xecfg->find_func_priv);
+				if (newfunclen >= 0) {
+					funclen = newfunclen;
+					break;
+				}
+			}
+			funclineprev = s1 - 1;
 		}
 		if (xdl_emit_hunk_hdr(s1 + 1, e1 - s1, s2 + 1, e2 - s2,
 				      funcbuf, funclen, ecb) < 0)
