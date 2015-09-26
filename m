From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 66/68] fsck: use for_each_loose_file_in_objdir
Date: Fri, 25 Sep 2015 23:36:36 -0400
Message-ID: <20150926033636.GA18753@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
 <20150924210832.GK30946@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 26 05:37:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfgIO-00052k-Ff
	for gcvg-git-2@plane.gmane.org; Sat, 26 Sep 2015 05:37:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbbIZDgj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2015 23:36:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:36656 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932316AbbIZDgi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2015 23:36:38 -0400
Received: (qmail 8580 invoked by uid 102); 26 Sep 2015 03:36:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 25 Sep 2015 22:36:38 -0500
Received: (qmail 9956 invoked by uid 107); 26 Sep 2015 03:36:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 25 Sep 2015 23:36:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Sep 2015 23:36:36 -0400
Content-Disposition: inline
In-Reply-To: <20150924210832.GK30946@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278684>

On Thu, Sep 24, 2015 at 05:08:32PM -0400, Jeff King wrote:

> +static int fsck_subdir(int nr, const char *path, void *progress)
> +{
> +	display_progress(progress, nr + 1);
> +	return 0;
> +}
> +
>  static void fsck_object_dir(const char *path)
>  {
> -	int i;
>  	struct progress *progress = NULL;
>  
>  	if (verbose)
> @@ -501,12 +481,9 @@ static void fsck_object_dir(const char *path)
>  
>  	if (show_progress)
>  		progress = start_progress(_("Checking object directories"), 256);
> -	for (i = 0; i < 256; i++) {
> -		static char dir[4096];
> -		sprintf(dir, "%s/%02x", path, i);
> -		fsck_dir(i, dir);
> -		display_progress(progress, i+1);
> -	}
> +
> +	for_each_loose_file_in_objdir(path, fsck_loose, fsck_cruft, fsck_subdir,
> +				      progress);
>  	stop_progress(&progress);

I happened to be running git-fsck today and noticed that it finished
with the progress bar still reading 94%. The problem is that we update
the progress when we finish a subdir, but of course we do not
necessarily have all 256 subdirs, and the for_each_loose code only
triggers our callback for ones that exist.

So we need this on top:

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 2fe6a31..d50efd5 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -484,6 +484,7 @@ static void fsck_object_dir(const char *path)
 
 	for_each_loose_file_in_objdir(path, fsck_loose, fsck_cruft, fsck_subdir,
 				      progress);
+	display_progress(progress, 256);
 	stop_progress(&progress);
 }
 

to make things pretty.

-Peff
