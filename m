From: Jeff King <peff@peff.net>
Subject: Re: bug in name-rev on linux-2.6 repo?
Date: Thu, 22 Apr 2010 10:54:55 -0400
Message-ID: <20100422145455.GC28923@coredump.intra.peff.net>
References: <20100421195822.GX10984@baikonur.stro.at>
 <r2sbe6fef0d1004220354g6443218ezbd0452428ad9e4b5@mail.gmail.com>
 <20100422121408.GI3211@stro.at>
 <20100422124042.GA1433@progeny.tock>
 <m2hbn37e7q.fsf@igel.home>
 <20100422144433.GB28923@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	maximilian attems <max@stro.at>,
	Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Thu Apr 22 16:55:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4xoW-0006Ee-Ii
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 16:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755543Ab0DVOz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 10:55:28 -0400
Received: from peff.net ([208.65.91.99]:42254 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755511Ab0DVOz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 10:55:28 -0400
Received: (qmail 1831 invoked by uid 107); 22 Apr 2010 14:55:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 22 Apr 2010 10:55:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Apr 2010 10:54:55 -0400
Content-Disposition: inline
In-Reply-To: <20100422144433.GB28923@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145538>

On Thu, Apr 22, 2010 at 10:44:33AM -0400, Jeff King wrote:

> Hmm. Maybe clock skew in the commit timestamps is at fault? With this
> patch to git:
> 
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index 06a38ac..7a024ab 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -29,9 +29,6 @@ static void name_rev(struct commit *commit,
>  	if (!commit->object.parsed)
>  		parse_commit(commit);
>  
> -	if (commit->date < cutoff)
> -		return;
> -
>  	if (deref) {
>  		char *new_name = xmalloc(strlen(tip_name)+3);
>  		strcpy(new_name, tip_name);
> 
> I get:
> 
>   $ $ git name-rev a1de02dccf906faba2ee2d99cac56799bda3b96a
>   a1de02dccf906faba2ee2d99cac56799bda3b96a tags/v2.6.34-rc1~199^2~35
> 
> but I haven't tracked down the problematic commit and timestamp yet.

Still looking, but definitely some kind of skew problem. Reverting the
patch above and doing this also works:

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 06a38ac..198e04d 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -5,7 +5,7 @@
 #include "refs.h"
 #include "parse-options.h"
 
-#define CUTOFF_DATE_SLOP 86400 /* one day */
+#define CUTOFF_DATE_SLOP (60*86400)
 
 typedef struct rev_name {
 	const char *tip_name;

but a 59-day slop does not.

-Peff
