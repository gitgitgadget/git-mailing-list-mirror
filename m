From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] checkout: tone down the "forked status" diagnostic
	messages
Date: Wed, 20 Feb 2008 20:45:13 -0500
Message-ID: <20080221014513.GA7185@coredump.intra.peff.net>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com> <20080209030046.GA10470@coredump.intra.peff.net> <7vtzkihkx5.fsf@gitster.siamese.dyndns.org> <46a038f90802090350rc4780d1ted60c03b9abf1fc0@mail.gmail.com> <7vwspd5z1d.fsf@gitster.siamese.dyndns.org> <7vfxvs75kp.fsf_-_@gitster.siamese.dyndns.org> <46a038f90802190903g1a19e38i30198b368a800a89@mail.gmail.com> <7vy79f2pqk.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Martin Langhoff <martin.langhoff@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 02:46:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JS0Vm-00022a-Bb
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 02:46:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756528AbYBUBpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 20:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755409AbYBUBpg
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 20:45:36 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3435 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751890AbYBUBpR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 20:45:17 -0500
Received: (qmail 10311 invoked by uid 111); 21 Feb 2008 01:45:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 20 Feb 2008 20:45:15 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Feb 2008 20:45:13 -0500
Content-Disposition: inline
In-Reply-To: <7vy79f2pqk.fsf_-_@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74585>

On Wed, Feb 20, 2008 at 03:05:23PM -0800, Junio C Hamano wrote:

> @@ -301,64 +301,88 @@ static void adjust_to_tracking(struct branch_info *new, struct checkout_opts *op
>  	char *base;
>  	unsigned char sha1[20];
>  	struct commit *ours, *theirs;
> -	const char *msgfmt;
>  	char symmetric[84];
> -	int show_log;
> +	struct rev_info revs;
> +	const char *rev_argv[10];
> +	int rev_argc;
> +	int num_ours, num_theirs;
> +	const char *remote_msg;
>  	struct branch *branch = branch_get(NULL);

Shouldn't this be branch_get(new->name)? branch_get calls read_config(),
which caches the "current branch" information, so it's possible to end
up with stale branch info. Try:

  git clone git://git.kernel.org/pub/scm/git/git.git
  git checkout -b next origin/next

I get:

  Branch next set up to track remote branch refs/remotes/origin/next.
  Switched to a new branch "next"
  Your branch is ahead of the tracked remote branch 'origin/master' by 76
  commits.

Switching to master and then back to the already-created "next" works
fine.

Even safer, I think, would be a way to invalidate the information cached
in read_config when we change branches; this would fix it for any other
callsites that look at the current branch from the same git invocation
that changes the current branch.

> +	if (!num_theirs)
> +		printf("Your branch is ahead of the tracked%s branch '%s' "
> +		       "by %d commit%s.\n",
> +		       remote_msg, base,
> +		       num_ours, (num_ours == 1) ? "" : "s");
> +	else if (!num_ours)
> +		printf("Your branch is behind of the tracked%s branch '%s' "
> +		       "by %d commit%s,\n"
> +		       "and can be fast-forwarded.\n",

While not uncommon colloquially, "behind of" is not grammatically
correct. "behind" is a preposition, so the "of" is redundant (it is
necessary in the top string because "ahead" is an adverb).

-Peff
