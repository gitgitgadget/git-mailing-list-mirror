From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/8] revert: Implement parsing --continue, --abort and
 --skip
Date: Wed, 11 May 2011 07:59:51 -0500
Message-ID: <20110511125900.GH2676@elie>
References: <1305100822-20470-1-git-send-email-artagnon@gmail.com>
 <1305100822-20470-8-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 11 17:58:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKBnc-0003vF-AF
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 17:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756082Ab1EKP4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 11:56:24 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34336 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229Ab1EKP4W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 11:56:22 -0400
Received: by iwn34 with SMTP id 34so626121iwn.19
        for <git@vger.kernel.org>; Wed, 11 May 2011 08:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=COFzRLBAT5gpL0kFOgxR3nKG/YjhlvlGLAjSVSkj084=;
        b=OVtvtP4i4SVtrETr7XhURnaOcM35LihrQVzcT8f+g9LU50oJGL9dCFVxVPcfmqR577
         pr6o4EQY31SPZOT9UK2qwopkj301L+w9QVvb5SA8cQUezFUSZy1bi76npQgTXF6+EVS+
         jGdR4FpXmXQE7EWRK9IyzEqCNlIckmDjUTWm8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OzgaWSF7fugkMKt+aZAl2hRMjqNztOFyk/z2H8PLhE7D6CCExm3ZKHuiDoRmZ7ON2d
         eAlcHIgEAxDphnZnJrbNeMqLFAd0mGOTI9PB5Zvg/cz0ns5QBIeVV0knsXHQhUgnpRKc
         oEUnOW2G99TFJo4j1bXgvdiVretvalg+lN43A=
Received: by 10.231.178.1 with SMTP id bk1mr2207208ibb.81.1305118827051;
        Wed, 11 May 2011 06:00:27 -0700 (PDT)
Received: from elie (adsl-69-209-56-134.dsl.chcgil.ameritech.net [69.209.56.134])
        by mx.google.com with ESMTPS id 19sm49953ibx.1.2011.05.11.06.00.24
        (version=SSLv3 cipher=OTHER);
        Wed, 11 May 2011 06:00:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1305100822-20470-8-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173397>

Ramkumar Ramachandra wrote:

> Introduce three new command-line options: --continue, --abort, and
> --skip resembling the correspoding options in "rebase -i".  For now,
> just parse the options into the replay_opts structure, making sure
> that two of them are not specified together. They will actually be
> implemented later in the series.

I'd suggest squashing this patch with the next one.  If a "git
cherry-pick" accepting an --abort option that does not do anything
leaked into the wild, that would not be a good outcome.

> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -145,7 +153,47 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
>  	opts->xopts_nr = xopts_nr;
>  	opts->xopts_alloc = xopts_alloc;
>  
> -	if (opts->commit_argc < 2)
> +	/* Check for incompatible command line arguments */
> +	if (opts->abort_oper || opts->skip_oper || opts->continue_oper) {
> +		char *this_oper;
> +		if (opts->abort_oper) {
> +			this_oper = "--abort";
> +			die_opt_incompatible(me, this_oper,
> +					"--skip", opts->skip_oper,
> +					NULL);
> +			die_opt_incompatible(me, this_oper,
> +					"--continue", opts->continue_oper,
> +					NULL);

What happened to

			...(me, "--abort",
				"--skip", opts->skip,
				"--continue", opts->continue);

?  I also wonder if there should not be a function to deal with
mutually incompatible options:

	va_start(ap, commandname);
	while ((arg1 = va_arg(ap, const char *))) {
		int set = va_arg(ap, int);
		if (set)
			break;
	}
	while ((arg2 = va_arg(ap, const char *))) {
		int set = va_arg(ap, int);
		if (set)
			die(arg1 and arg2 are incompatible);
	}
	va_end(ap);

> +		die_opt_incompatible(me, this_oper,
> +				"--no-commit", opts->no_commit,
[...]

Seems reasonable.  A part of me would want to accept such options and
only error out if the saved state indicates that they are different
from the options supplied before, so if a person has

	alias applycommits = git cherry-pick --no-commit

then "applycommits --continue" could work without trouble, but
that's probably overegineering.
