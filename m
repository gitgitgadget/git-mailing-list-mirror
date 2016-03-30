From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 2/3] pretty: enable --expand-tabs by default for
 selected pretty formats
Date: Tue, 29 Mar 2016 21:38:51 -0400
Message-ID: <20160330013851.GF2237@sigill.intra.peff.net>
References: <1458775426-2215-1-git-send-email-gitster@pobox.com>
 <1459293309-25195-1-git-send-email-gitster@pobox.com>
 <1459293309-25195-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 03:38:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al562-0007LB-Qs
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 03:38:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752986AbcC3Biy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 21:38:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:40530 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751550AbcC3Biy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 21:38:54 -0400
Received: (qmail 24058 invoked by uid 102); 30 Mar 2016 01:38:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Mar 2016 21:38:54 -0400
Received: (qmail 30743 invoked by uid 107); 30 Mar 2016 01:38:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Mar 2016 21:38:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Mar 2016 21:38:51 -0400
Content-Disposition: inline
In-Reply-To: <1459293309-25195-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290261>

On Tue, Mar 29, 2016 at 04:15:08PM -0700, Junio C Hamano wrote:

> diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
> index 4fb5c76..23967b6 100644
> --- a/Documentation/pretty-options.txt
> +++ b/Documentation/pretty-options.txt
> @@ -43,10 +43,16 @@ people using 80-column terminals.
>  	commit may be copied to the output.
>  
>  --expand-tabs::
> +--no-expand-tabs::
>  	Perform a tab expansion (replace each tab with enough number
>  	of spaces to fill to the next display column that is
>  	multiple of 8) in the log message before using the message
>  	to show in the output.
> ++
> +By default, tabs are expanded in pretty formats that indent the log
> +message by 4 spaces (i.e.  'medium', which is the default, 'full',
> +and "fuller').  `--no-expand-tabs` option can be used to disable
> +this.

Mismatched quote types on "fuller".

> @@ -172,6 +173,7 @@ void get_commit_format(const char *arg, struct rev_info *rev)
>  
>  	rev->commit_format = commit_format->format;
>  	rev->use_terminator = commit_format->is_tformat;
> +	rev->expand_tabs_in_log = commit_format->expand_tabs_in_log;
>  	if (commit_format->format == CMIT_FMT_USERFORMAT) {
>  		save_user_format(rev, commit_format->user_format,
>  				 commit_format->is_tformat);

This feels like the wrong time to set the value in rev_info, as it means
that:

  git log --no-expand-tabs --pretty=full

and

  git log --pretty=full --no-expand-tabs

behave differently. The other values set in get_commit_format, like
"use_terminator", are inherently part of the format, but I don't think
this is. We just want to set the default if the user did not express
another preference.

Likewise, if we were to eventually add config like "[log]expandtab = 4",
it should not be overridden by "--pretty=full" (but we probably _would_
want to have it kick in only for certain formats).

So I think we really want to set an alternate variable here, and then do
something like:

  if (rev->expand_tabs_in_log < 0)
	rev->expand_tabs_in_log = rev->commit_format_expand_tab_default;

-Peff
