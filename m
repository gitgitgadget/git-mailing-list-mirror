From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] lockfile: fix buffer overflow in path handling
Date: Sun, 7 Jul 2013 00:12:36 -0400
Message-ID: <20130707041236.GB30898@sigill.intra.peff.net>
References: <1373140132-12351-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Jul 07 06:12:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvgLG-0004wC-1s
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 06:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316Ab3GGEMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 00:12:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:44480 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750802Ab3GGEMj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 00:12:39 -0400
Received: (qmail 28060 invoked by uid 102); 7 Jul 2013 04:13:53 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 06 Jul 2013 23:13:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Jul 2013 00:12:36 -0400
Content-Disposition: inline
In-Reply-To: <1373140132-12351-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229727>

On Sat, Jul 06, 2013 at 09:48:52PM +0200, Michael Haggerty wrote:

> When and if resolve_symlink() is called, then that function is
> correctly told to treat the buffer as (PATH_MAX - 5) characters long.
> This part is correct.  However:
> 
> * If LOCK_NODEREF was specified, then resolve_symlink() is never
>   called.
> 
> * If resolve_symlink() is called but the path is not a symlink, then
>   the length check is never applied.
> 
> So it is possible for a path with length (PATH_MAX - 5 <= len <
> PATH_MAX) to make it through the checks.  When ".lock" is strcat()ted
> to such a path, the lock_file::filename buffer is overflowed.

Thanks for posting this. I independently discovered this about a month
ago while working on an unrelated series, and then let it languish
unseen and forgotten at the base of that almost-done series.

So definitely a problem, and my patch looked almost identical to
yours. The only difference is:

>  static int lock_file(struct lock_file *lk, const char *path, int flags)
>  {
> -	if (strlen(path) >= sizeof(lk->filename))
> -		return -1;
> -	strcpy(lk->filename, path);
>  	/*
>  	 * subtract 5 from size to make sure there's room for adding
>  	 * ".lock" for the lock file name
>  	 */
> +	if (strlen(path) >= sizeof(lk->filename)-5)
> +		return -1;
> +	strcpy(lk->filename, path);
>  	if (!(flags & LOCK_NODEREF))
>  		resolve_symlink(lk->filename, sizeof(lk->filename)-5);

It might be worth consolidating the magic "-5" into a constant near the
comment, like this:

diff --git a/lockfile.c b/lockfile.c
index c6fb77b..2aeb2bb 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -124,15 +124,16 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 
 static int lock_file(struct lock_file *lk, const char *path, int flags)
 {
-	if (strlen(path) >= sizeof(lk->filename))
-		return -1;
-	strcpy(lk->filename, path);
 	/*
 	 * subtract 5 from size to make sure there's room for adding
 	 * ".lock" for the lock file name
 	 */
+	static const size_t max_path_len = sizeof(lk->filename) - 5;
+	if (strlen(path) >= max_path_len)
+		return -1;
+	strcpy(lk->filename, path);
 	if (!(flags & LOCK_NODEREF))
-		resolve_symlink(lk->filename, sizeof(lk->filename)-5);
+		resolve_symlink(lk->filename, max_path_len);
 	strcat(lk->filename, ".lock");
 	lk->fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (0 <= lk->fd) {

But either way, the fix looks good to me.

-Peff
