From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] grep: fix "--quiet" overwriting current output
Date: Wed, 18 Mar 2015 15:01:08 -0400
Message-ID: <20150318190107.GB650@peff.net>
References: <1426701613-12533-1-git-send-email-wimschuermann@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Wilhelm Schuermann <wimschuermann@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 20:01:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYJDQ-0003zx-AT
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 20:01:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933550AbbCRTBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 15:01:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:34777 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932366AbbCRTBL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 15:01:11 -0400
Received: (qmail 24405 invoked by uid 102); 18 Mar 2015 19:01:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Mar 2015 14:01:10 -0500
Received: (qmail 5809 invoked by uid 107); 18 Mar 2015 19:01:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Mar 2015 15:01:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Mar 2015 15:01:08 -0400
Content-Disposition: inline
In-Reply-To: <1426701613-12533-1-git-send-email-wimschuermann@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265748>

On Wed, Mar 18, 2015 at 07:00:13PM +0100, Wilhelm Schuermann wrote:

> When grep is called with the --quiet option, the pager is initialized
> despite not being used.  When the pager is "less", anything output by
> previous commands and not ended with a newline is overwritten.
> [...]
> This patch prevents calling the pager in the first place, saving an
> unnecessary fork() call.

Thanks, I think this makes sense. We do a similar thing for "git diff
--quiet". If you do not set "-F" in your $LESS variable, it is even more
annoying. E.g., with:

  if git grep -q foo; then
    : do something
  fi

which will pause, waiting for the user to hit 'q'.

> diff --git a/builtin/grep.c b/builtin/grep.c
> index e77f7cf..fe7b9fd 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -885,7 +885,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  		}
>  	}
>  
> -	if (!show_in_pager)
> +	if (!show_in_pager && !opt.status_only)
>  		setup_pager();

Patch looks obviously correct.

-Peff
