From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Allow multiple merges to invalid HEAD
Date: Sun, 3 Apr 2011 17:22:56 -0500
Message-ID: <20110403222234.GB6537@elie>
References: <1301813216-19507-1-git-send-email-tnachen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Timothy Chen <tnachen@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 00:23:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6VhN-0003Go-Vf
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 00:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066Ab1DCWXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 18:23:04 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40329 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736Ab1DCWXD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 18:23:03 -0400
Received: by iwn34 with SMTP id 34so5222275iwn.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 15:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ONj8vdggqMrvJwhUolUOtERNZ8X5ai97l7+g3XcYPEY=;
        b=xHTyopjZZv7cpuml6ObVIiRTyJlYfPmIHyTscYLPIPSgMqvYhtKPz4JHctvuflJZqW
         n93RumllhZhtgC+NSqbIfMhgH30OdE+ZbW+E3x3LoI5GIMlq6UYh3xG3TK3NGl6235q/
         eeDwKvhcRsJkGjY67mBPbGm161YRwzxtCiFDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=uCpbp8r4h58fgVl11DCiErDzYE/LiJ8ZpygD3w+IQs54B3LmSNO6ezfEBOQourugeJ
         bw0Z7CYff/fsArdIwZWPr2E1iBSgTi4AMa6wpvlUKAFGFwrVioFwqCyH2AMyLNyD4UVD
         A6jifwUjydJIYLMdtasY69Q4T6gqltaDMSdf8=
Received: by 10.231.92.132 with SMTP id r4mr2846013ibm.57.1301869382162;
        Sun, 03 Apr 2011 15:23:02 -0700 (PDT)
Received: from elie (adsl-69-209-53-77.dsl.chcgil.sbcglobal.net [69.209.53.77])
        by mx.google.com with ESMTPS id i20sm3272350iby.14.2011.04.03.15.23.00
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 15:23:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1301813216-19507-1-git-send-email-tnachen@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170783>

Hi,

Timothy Chen wrote:

>  builtin/merge.c |   57 +++++++++++++++++++++++++++++-------------------------
>  1 files changed, 31 insertions(+), 26 deletions(-)

Now for mechanics.

> --- a/builtin/merge.c
> +++ b/builtin/merge.c
[...]
> @@ -1101,36 +1098,44 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  		remote_head = peel_to_type(argv[0], 0, NULL, OBJ_COMMIT);
>  		if (!remote_head)
>  			die(_("%s - not something we can merge"), argv[0]);
> -		read_empty(remote_head->sha1, 0);
>  		update_ref("initial pull", "HEAD", remote_head->sha1, NULL, 0,
>  				DIE_ON_ERR);
> -		return 0;
> +
> +		if (argc < 2)
> +			return 0;

When argc == 1, this means read_empty never gets called.  Is that
intended?

It breaks 7607.13.  Running "make test" is a good way to find some
breakages.

> +
> +		hashcpy(head, remote_head->sha1);
> +		read_empty(remote_head->sha1, 0);
> +		head_arg = argv[0];
> +		argc--;
> +		argv++;

As always when pretending something, I think a comment would be
helpful.  Something to the effect of:

	/*
	 * We were called as "git merge <branch1> <branch2> <branch3>...".
	 *
	 * Now HEAD has advanced to <branch1>, and we can pretend
	 * we were called as "git merge <branch2> <branch3>...".
	 */

Though I think I prefer the more explicit comment I suggested last
time[1].

> +	}
> +
> +	struct strbuf merge_names = STRBUF_INIT;
> +
> -	} else {
> -		struct strbuf merge_names = STRBUF_INIT;
> -
> -		/* We are invoked directly as the first-class UI. */
> +	/* We are invoked directly as the first-class UI. */

Won't this break

	git merge "message here" $(git rev-parse HEAD) foo bar

?  Previously this code was in an "else" block so it wasn't reached in
the is_old_style_invocation case.

> -	if (head_invalid || !argc)
> +	if (!argc)
>  		usage_with_options(builtin_merge_usage,
>  			builtin_merge_options);

What happens with

	git merge "message here" HEAD foo bar

from an unborn branch?

Hope that helps.
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/170456
