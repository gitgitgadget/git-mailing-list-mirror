From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] push: Provide situational hints for non-fast-forward
 errors
Date: Fri, 16 Mar 2012 10:10:19 +0100
Message-ID: <20120316091019.GB22273@ecki>
References: <20120313232256.GA49626@democracyinaction.org>
 <vpqipi7zh3n.fsf@bauges.imag.fr>
 <7vty1rqek5.fsf@alter.siamese.dyndns.org>
 <7vlin1gl9l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christopher Tiwald <christiwald@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 16 10:11:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8TCF-0001Or-JB
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 10:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760070Ab2CPJLd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 05:11:33 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:38363 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757556Ab2CPJLc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 05:11:32 -0400
Received: from localhost (p5B22EAFE.dip.t-dialin.net [91.34.234.254])
	by bsmtp.bon.at (Postfix) with ESMTP id 8C75B1300B4;
	Fri, 16 Mar 2012 10:08:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vlin1gl9l.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193246>

On Thu, Mar 15, 2012 at 10:36:22PM -0700, Junio C Hamano wrote:
>
> +static const char message_advice_pull_before_push[] =
> +	N_("Update was rejected because the tip of your current branch is behind\n"
> +	   "the remote. Merge the remote changes (e.g. 'git pull') before\n"
> +	   "pushing again. See the 'Note about fast-forwards' section of\n"
> +	   "'git push --help' for details.");
> +
> +
> +static const char message_advice_use_upstream[] =
> +	N_("Some of your local branches were stale with respect to their\n"
> +	   "remote counterparts. If you did not intend to push these branches,\n"
> +	   "you may want to set the 'push.default' configuration variable to\n"
> +	   "'current' or 'upstream' to push only the current branch.");
> +
> +static const char message_advice_checkout_pull_push[] =
> +	N_("Updates were rejected because the tip of some of your branches are\n"
> +	   "behind the remote. Check out the branch and merge the remote\n"
> +	   "changes (e.g. 'git pull') before pushing again. See the\n"
> +	   "'Note about fast-forwards' section of 'git push --help'\n"
> +	   "for details.");

The first sentence of the above two warnings state the same thing, but
in different ways. Yet the difference does not reflect the different
situations. They should be the same, or maybe the first one should be
changed to the following variant of the second:

 "Updates were rejected because the tip of some of your branches are
 behind the remote branches with matching names."

I like that you changed the advice to 'current' _or_ 'upstream'. But
maybe the variable name should change from message_advice_use_upstream
to message_advice_push_default.

> -	if (nonfastforward == NONFASTFORWARD_HEAD) {
> +	switch (nonfastforward) {
> +	default:
> +		break;
> +	case NON_FF_HEAD:
>  		advise_pull_before_push();
> -	} else if (nonfastforward == NONFASTFORWARD_OTHER) {
> +		break;
> +	case NON_FF_OTHER:
>  		if (default_matching_used)
>  			advise_use_upstream();
>  		else
>  			advise_checkout_pull_push();
> +		break;
>  	}

We should not give advise_use_upstream if the user specified git push
--all. The advice_checkout_pull_push would make more sense in that case.

Actually, if the user decides that matching branches is indeed the
default they want to use, advise_checkout_pull_push would still be
helpful. So I think advise_checkout_pull_push should be given in any
case, while advise_use_upstream should be added if push.default=matching
and the user did not say git push --all.
