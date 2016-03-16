From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] help.c: strip suffix only if the STRIP_EXTENSION defined
Date: Wed, 16 Mar 2016 13:31:28 -0400
Message-ID: <20160316173127.GD4039@sigill.intra.peff.net>
References: <1458138449-26690-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 18:31:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agFIG-0004Et-09
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 18:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933654AbcCPRbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 13:31:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:60712 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933096AbcCPRbb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 13:31:31 -0400
Received: (qmail 8584 invoked by uid 102); 16 Mar 2016 17:31:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Mar 2016 13:31:30 -0400
Received: (qmail 15972 invoked by uid 107); 16 Mar 2016 17:31:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Mar 2016 13:31:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Mar 2016 13:31:28 -0400
Content-Disposition: inline
In-Reply-To: <1458138449-26690-1-git-send-email-kuleshovmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289001>

On Wed, Mar 16, 2016 at 08:27:29PM +0600, Alexander Kuleshov wrote:

> We stripping extension in the list_commands_in_dir() to get
> commands without '.exe' suffix. Let's do it only if STRIP_EXTENSION
> is defined to not spend time for unnecessary strip_suffix() call in
> this case.
> 
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
>  help.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/help.c b/help.c
> index 19328ea..c865991 100644
> --- a/help.c
> +++ b/help.c
> @@ -153,8 +153,9 @@ static void list_commands_in_dir(struct cmdnames *cmds,
>  			continue;
>  
>  		entlen = strlen(ent);
> -		strip_suffix(ent, ".exe", &entlen);
> -
> +#ifdef STRIP_EXTENSION
> +		strip_suffix(ent, STRIP_EXTENSION, &entlen);
> +#endif

This is billed as an optimization in the commit message, but these two
pieces of code are not the same. The original always strips ".exe",
whether or not STRIP_EXTENSION is defined, and whether or not it is
".exe".

In practice it works out because people on Unix systems do not have
"git-foo.exe", and nobody sets STRIP_EXTENSION to other things.  But I
tend to think this is an improvement in robustness.

I also wonder if this should be sharing the strip_extension() helper
added in your 63ca1c0.

-Peff
