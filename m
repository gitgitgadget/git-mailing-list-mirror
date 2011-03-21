From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 2/3] revision.c: introduce --min-parents and --max-parents
Date: Mon, 21 Mar 2011 15:04:53 +0100
Message-ID: <4D875B05.50401@drmicha.warpmail.net>
References: <4D870157.2070309@drmicha.warpmail.net> <41d12c53966faa9c9cb5acc7646e9098dcd911ea.1300702130.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Mar 21 15:08:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1fmn-00034V-86
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 15:08:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410Ab1CUOIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 10:08:32 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:38585 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753194Ab1CUOIX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2011 10:08:23 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9C8672082A;
	Mon, 21 Mar 2011 10:08:22 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Mon, 21 Mar 2011 10:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=T7OjP3c7+wZgA+OsA+A3IJy0Q9E=; b=TiziJCzBqCMBHjNZP+LyTu4QNW16TXRzqyZZcFz/Dr4JirLCdcOjzhdrFGU3gjbEClptBvmc8T7zeX4MhNgj5QcaNhEduqOjvPk9pE+vM21JGR+7Uj0gvx11FyJVs9ddt7oWCHLOZyL/fwzCP6DjuON9MFBwSz6Umw1qSA3zLKI=
X-Sasl-enc: 2uABTN82/ybHXbDM4BKmTCvdeu6n4giPZADPla3QjKgw 1300716502
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DEAF1405CBF;
	Mon, 21 Mar 2011 10:08:21 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <41d12c53966faa9c9cb5acc7646e9098dcd911ea.1300702130.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169595>

Michael J Gruber venit, vidit, dixit 21.03.2011 11:14:
> --merges and --no-merges are named confusingly and cannot be overridden
> by each other, but they are there to stay for plumbers' sake.
> 
> Introduce --min-parents and --max-parents which limit the revisions to
> those commits which have at least resp. at most that many commits, where
> negative arguments for --max-parents= denote infinity (i.e. no upper
> limit).
> 
> In particular:
> 
> --max-parents=1: no merges
> --min-parents=2: merges only
> --max-parents=0: only roots
> --min-parents=3: only octopusses
> 
> --min-parents=n --max-parents=m with n>m gives you what you ask for
> (nothing) just like --merges --no-merges does, but at least for an
> obvious reason.
> 
> Implementation note:
> 
> We compute the number of parents only when we limit by that, so there
> is no performance impact when there are no limiters.
> 
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  builtin/log.c       |    2 +-
>  builtin/rev-list.c  |    2 ++
>  builtin/rev-parse.c |    2 ++
>  revision.c          |   24 +++++++++++++++++-------
>  revision.h          |    4 ++--
>  5 files changed, 24 insertions(+), 10 deletions(-)
...
> @@ -2029,10 +2034,15 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
>  		return commit_ignore;
>  	if (revs->min_age != -1 && (commit->date > revs->min_age))
>  		return commit_ignore;
> -	if (revs->no_merges && commit->parents && commit->parents->next)
> -		return commit_ignore;
> -	if (revs->merges_only && !(commit->parents && commit->parents->next))
> -		return commit_ignore;
> +	if (revs->min_parents || (revs->max_parents >= 0)) {
> +		int n = 0;
> +		struct commit_list *p;
> +		for (p = commit->parents; p; p = p->next)
> +			n++;
> +		if ((n < revs->min_parents) ||
> +		    ((revs->max_parents >= 0) && (n > revs->max_parents)))
> +			return commit_ignore;
> +	}
>  	if (!commit_match(commit, revs))
>  		return commit_ignore;
>  	if (revs->prune && revs->dense) {

BTW: Version v2-eps had this conditional:

(n < revs->min_parents) || (n > (unsigned int) revs->max_parents)

I actually compared runs of "git rev-list origin/next >/dev/null"
without options and with "--merges" or "--no-merges" for git without
this patch and with it (v2) and do not see any measurable difference
(between without or with the patch; the runs with limiting options are
faster, so I redid it with --count, again no difference with or without
patch).

So, the clearer version above should be preferred over the unsigned
trick, and special casing seems not worth it.

Michael
