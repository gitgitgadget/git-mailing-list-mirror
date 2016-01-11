From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/2] builtin/grep: add grep.fallbackToNoIndex config
Date: Mon, 11 Jan 2016 16:48:47 -0500
Message-ID: <20160111214846.GC21131@sigill.intra.peff.net>
References: <1452435597-12099-1-git-send-email-t.gummerer@gmail.com>
 <1452547580-30687-1-git-send-email-t.gummerer@gmail.com>
 <1452547580-30687-3-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
	gitster@pobox.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 22:48:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIkKb-0001n0-Sy
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 22:48:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934318AbcAKVsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 16:48:50 -0500
Received: from cloud.peff.net ([50.56.180.127]:51657 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932851AbcAKVst (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 16:48:49 -0500
Received: (qmail 15787 invoked by uid 102); 11 Jan 2016 21:48:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Jan 2016 16:48:49 -0500
Received: (qmail 6112 invoked by uid 107); 11 Jan 2016 21:49:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Jan 2016 16:49:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jan 2016 16:48:47 -0500
Content-Disposition: inline
In-Reply-To: <1452547580-30687-3-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283727>

On Mon, Jan 11, 2016 at 10:26:20PM +0100, Thomas Gummerer wrote:

> diff --git a/builtin/grep.c b/builtin/grep.c
> index 4229cae..5efe9bb 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -755,9 +755,20 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  			     PARSE_OPT_STOP_AT_NON_OPTION);
>  	grep_commit_pattern_type(pattern_type_arg, &opt);
>  
> -	if (use_index && !startup_info->have_repository)
> -		/* die the same way as if we did it at the beginning */
> -		setup_git_directory();
> +	if (use_index && !startup_info->have_repository) {
> +		int fallback = 0;
> +		git_config_get_bool("grep.fallbacktonoindex", &fallback);
> +		if (fallback) {
> +			int nongit = 0;
> +
> +			setup_git_directory_gently(&nongit);
> +			if (nongit)
> +				use_index = 0;
> +		} else {
> +			/* die the same way as if we did it at the beginning */
> +			setup_git_directory();
> +		}
> +	}

Hmm. We used to have problems accessing config before calling
setup_git_directory(). I am not sure if that is still the case, though.

I guess the startup sequence is muddied here, though. cmd_grep() is
marked as RUN_SETUP_GENTLY, so we would have already run setup, and here
we are following the "we are not in a repository" code path (i.e., we
saw "!startup_info->have_repository").

And the existing setup_git_directory() is just there to die(), as the
comment explains. So what is the new setup_git_directory_gently() doing?
We know we've already done setup, and that we're not in a git repo,
right? Shouldn't we just be able to set use_index to 0 and keep going?
Under what circumstances would it _not_ return "nongit == 1"?

> @@ -874,12 +885,14 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  		setup_pager();
>  
>  	if (!use_index && (untracked || cached))
> -		die(_("--cached or --untracked cannot be used with --no-index."));
> +		die(_("--cached or --untracked cannot be used with --no-index "
> +		      "or outside of a git repository"));

I'm lukewarm on this (and the other) change. What you've written is
technically correct, but it's getting rather verbose. We've presented
the option already as "turn on --no-index by default outside a
repository", so I'm not sure we need to clarify it here. Since it's a
feature people must turn on manually, presumably they would know that.

I don't know, maybe it would help somebody. I'm not strongly opposed.

-Peff
