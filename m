From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/5] revert: simplify communicating command-line arguments
Date: Wed, 7 Dec 2011 02:09:44 -0600
Message-ID: <20111207080944.GF11737@elie.hsd1.il.comcast.net>
References: <1323239877-24101-1-git-send-email-artagnon@gmail.com>
 <1323239877-24101-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 09:09:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYCZe-0006yd-Tf
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 09:09:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534Ab1LGIJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 03:09:50 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42426 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752229Ab1LGIJt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 03:09:49 -0500
Received: by yenm1 with SMTP id m1so247163yen.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 00:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=vnwU0LjymaOK477+40cx/E2Fk2YxKUfbLfiiKNjQdcE=;
        b=LU/k/qyWQAq5U0J9CRTAn0DvNTpaM0vzAjuiQlKpoNmuJSxPRCDDOLgzd8qWGBg3eq
         hw9qwZd7tjCfDdaYRT0D+hRZo8oFrWA8bf3C/xgVjhVCHN57N0MhrZNyUeS8E/1WZA/t
         IP9PnM4wOoBAdJIcr5jBbsfMlW5PONeZ5DPOU=
Received: by 10.236.108.233 with SMTP id q69mr25459304yhg.120.1323245389479;
        Wed, 07 Dec 2011 00:09:49 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id l19sm2942471anc.14.2011.12.07.00.09.48
        (version=SSLv3 cipher=OTHER);
        Wed, 07 Dec 2011 00:09:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323239877-24101-6-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186440>

Ramkumar Ramachandra wrote:

> From: Jonathan Nieder <jrnieder@gmail.com>
>
> Currently, command-line arguments are communicated using (argc, argv)
> until a prepare_revs() turns it into a terse structure.  However,
> since we plan to expose the cherry-picking machinery through a public
> API in the future, we want callers to be able to call in with a
> filled-in structure.  For the revert builtin, this means that the
> chief argument parser, parse_args(), should parse into such a
> structure.  Make this change.

Fine.  I guess it can be said more clearly while emphasizing public
interfaces over implementation details:

	Since the "multiple cherry-pick" feature was introduced (commit
	7e2bfd3f, 2010-07-02), the pick/revert machinery has kept track
	of the set of commits to be cherry-picked or reverted using
	commit_argc and commit_argv variables storing the relevant
	command-line parameters.

	Future callers as other commands are built in (am, rebase,
	sequencer) may find it easier to pass rev-list options to this
	machinery in already-parsed form, though.  So teach
	cmd_cherry_pick and cmd_revert to parse the rev-list arguments
	in advance and pass the commit set to pick_revisions() as a
	value of type "struct rev_info".

[...]
> @@ -222,7 +220,20 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
>  				"-x", opts->record_origin,
>  				"--edit", opts->edit,
>  				NULL);
> -	opts->commit_argv = argv;
> +
> +	if (opts->subcommand == REPLAY_NONE) {
> +		opts->revs = xmalloc(sizeof(*opts->revs));
> +		init_revisions(opts->revs, NULL);
> +		opts->revs->no_walk = 1;
> +		if (argc < 2)
> +			usage_with_options(usage_str, options);
> +		argc = setup_revisions(argc, argv, opts->revs, NULL);
> +	} else
> +		opts->revs = NULL;
> +
> +	/* Forbid stray command-line arguments */
> +	if (argc > 1)
> +		usage_with_options(usage_str, options);
>  }

Looks good.

Tests?  What happens if I try "git cherry-pick --all"?  How about "git
cherry-pick HEAD..HEAD"?

FWIW, with the commit message clarified and with or without new tests,
Acked-by: Jonathan Nieder <jrnieder@gmail.com>
