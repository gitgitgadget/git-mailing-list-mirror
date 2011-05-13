From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 7/8] revert: Implement parsing --continue, --abort and --skip
Date: Fri, 13 May 2011 14:46:22 +0530
Message-ID: <20110513091619.GC14272@ramkum.desktop.amazon.com>
References: <1305100822-20470-1-git-send-email-artagnon@gmail.com> <1305100822-20470-8-git-send-email-artagnon@gmail.com> <20110511125900.GH2676@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 13 11:16:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKoUC-0007vI-4C
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 11:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094Ab1EMJQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 05:16:33 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:57045 "EHLO
	smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758035Ab1EMJQd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 05:16:33 -0400
X-IronPort-AV: E=Sophos;i="4.64,363,1301875200"; 
   d="scan'208";a="435344928"
Received: from smtp-in-5102.iad5.amazon.com ([10.218.9.29])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 May 2011 09:16:24 +0000
Received: from ramkum.desktop.amazon.com (ramkum.desktop.amazon.com [172.25.205.64])
	by smtp-in-5102.iad5.amazon.com (8.13.8/8.13.8) with ESMTP id p4D9GMir022086;
	Fri, 13 May 2011 09:16:23 GMT
Received: by ramkum.desktop.amazon.com (Postfix, from userid 272482)
	id 173E175483F; Fri, 13 May 2011 14:46:22 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <20110511125900.GH2676@elie>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173514>

Hi Jonathan,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
> 
> > Introduce three new command-line options: --continue, --abort, and
> > --skip resembling the correspoding options in "rebase -i".  For now,
> > just parse the options into the replay_opts structure, making sure
> > that two of them are not specified together. They will actually be
> > implemented later in the series.
> 
> I'd suggest squashing this patch with the next one.  If a "git
> cherry-pick" accepting an --abort option that does not do anything
> leaked into the wild, that would not be a good outcome.

What about --continue and --skip? They're no-ops too here, and
there'll soon be patches adding the functionality.  Do you think it's
alright to parse and exit immediately?

> > --- a/builtin/revert.c
> > +++ b/builtin/revert.c
> > @@ -145,7 +153,47 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
> >  	opts->xopts_nr = xopts_nr;
> >  	opts->xopts_alloc = xopts_alloc;
> >  
> > -	if (opts->commit_argc < 2)
> > +	/* Check for incompatible command line arguments */
> > +	if (opts->abort_oper || opts->skip_oper || opts->continue_oper) {
> > +		char *this_oper;
> > +		if (opts->abort_oper) {
> > +			this_oper = "--abort";
> > +			die_opt_incompatible(me, this_oper,
> > +					"--skip", opts->skip_oper,
> > +					NULL);
> > +			die_opt_incompatible(me, this_oper,
> > +					"--continue", opts->continue_oper,
> > +					NULL);
> 
> What happened to
> 
> 			...(me, "--abort",
> 				"--skip", opts->skip,
> 				"--continue", opts->continue);

Huh? Why? I've caught every possible combination of two of those
options -- that already covers all three.

> ?  I also wonder if there should not be a function to deal with
> mutually incompatible options:
> 
> 	va_start(ap, commandname);
> 	while ((arg1 = va_arg(ap, const char *))) {
> 		int set = va_arg(ap, int);
> 		if (set)
> 			break;
> 	}
> 	while ((arg2 = va_arg(ap, const char *))) {
> 		int set = va_arg(ap, int);
> 		if (set)
> 			die(arg1 and arg2 are incompatible);
> 	}
> 	va_end(ap);

I personally think having a function is cleaner: I even like the new
API suggested by Junio.  We can probably even move it to a common
place, and have others use it as well.

> > +		die_opt_incompatible(me, this_oper,
> > +				"--no-commit", opts->no_commit,
> [...]
> 
> Seems reasonable.  A part of me would want to accept such options and
> only error out if the saved state indicates that they are different
> from the options supplied before, so if a person has
> 
> 	alias applycommits = git cherry-pick --no-commit
> 
> then "applycommits --continue" could work without trouble, but
> that's probably overegineering.

Over-engineering definitely! I'm looking to get something working
first; add-on functionality like this can come as later patches.

And yes, as you pointed out in another review, the name
verify_opt_incompatible_or_die is more appropriate.

Thanks for the detailed review.

-- Ram
