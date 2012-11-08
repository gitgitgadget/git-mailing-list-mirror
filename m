From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] diff: introduce diff.submodule configuration variable
Date: Thu, 8 Nov 2012 15:51:10 -0500
Message-ID: <20121108205110.GB8376@sigill.intra.peff.net>
References: <1351766630-4837-1-git-send-email-artagnon@gmail.com>
 <1351766630-4837-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 21:51:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWZ4T-0006Np-1V
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 21:51:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756935Ab2KHUvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 15:51:15 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36708 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756785Ab2KHUvO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 15:51:14 -0500
Received: (qmail 325 invoked by uid 107); 8 Nov 2012 20:52:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Nov 2012 15:52:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Nov 2012 15:51:10 -0500
Content-Disposition: inline
In-Reply-To: <1351766630-4837-3-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209191>

On Thu, Nov 01, 2012 at 04:13:49PM +0530, Ramkumar Ramachandra wrote:

> diff --git a/builtin/diff.c b/builtin/diff.c
> index 9650be2..6d00311 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -297,6 +297,10 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>  	DIFF_OPT_SET(&rev.diffopt, ALLOW_EXTERNAL);
>  	DIFF_OPT_SET(&rev.diffopt, ALLOW_TEXTCONV);
>  
> +	/* Set SUBMODULE_LOG if diff.submodule config var was set */
> +	if (submodule_format_cfg && !strcmp(submodule_format_cfg, "log"))
> +		DIFF_OPT_SET(&rev.diffopt, SUBMODULE_LOG);
> +

Yuck. Why is this parsing happening in cmd_diff?

Wouldn't you want it to kick in for "git log --submodule", too? It seems
like it should go into diff_setup(), and the porcelain/plumbing aspect
should be controlled by parsing it in git_diff_ui_config or
git_diff_basic_config. See how diff_no_prefix and diff_mnemonic prefix
are handled for an example.

Then you can keep the parsing logic for "log" in diff.c. And you should
factor it out into a function so that the command-line option and the
config parser can share the same code. I know it's only one line now,
but anybody who wants to add an option will have to update both places.
See the parsing of diff.dirstat for an example.

>  	else if (!prefixcmp(arg, "--submodule=")) {
>  		if (!strcmp(arg + 12, "log"))
>  			DIFF_OPT_SET(options, SUBMODULE_LOG);
> +		if (!strcmp(arg + 12, "short"))
> +			DIFF_OPT_CLR(options, SUBMODULE_LOG);
>  	}

Much better (although arguably should go in a separate patch). Should we
also produce an error if somebody says "--submodule=foobar"?

-Peff
