From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 5/5] branch: show upstream branch when double verbose
Date: Tue, 07 Apr 2009 10:02:34 +0200
Message-ID: <49DB089A.7080207@drmicha.warpmail.net>
References: <20090407070254.GA2870@coredump.intra.peff.net> <20090407071656.GE2924@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 07 10:04:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr6I8-0000I3-6Q
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 10:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045AbZDGICo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 04:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751570AbZDGICo
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 04:02:44 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:59221 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751814AbZDGICl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Apr 2009 04:02:41 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 1113D313E5B;
	Tue,  7 Apr 2009 04:02:40 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 07 Apr 2009 04:02:40 -0400
X-Sasl-enc: gyKoxSonpqukruQRXDbRmprmNNjrtHxtLhJzcBLtjtRT 1239091359
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3A3953BB64;
	Tue,  7 Apr 2009 04:02:39 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090407 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <20090407071656.GE2924@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115927>

Jeff King venit, vidit, dixit 07.04.2009 09:16:
> This information is easily accessible when we are
> calculating the relationship. The only reason not to print
> it all the time is that it consumes a fair bit of screen
> space, and may not be of interest to the user.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This one is very RFC. Should this information be part of the regular
> "-v"? Should it be part of "git branch" with regular verbosity?
> 
> Should the format be different? I wonder if
> 
>   master 1234abcd [origin/master: ahead 5, behind 6] whatever
> 
> will be interpreted as "origin/master is ahead 5, behind 6" when it is
> really the reverse. Maybe "[ahead 5, behind 6 from origin/master]" would
> be better?

Maybe [origin/master +5 -6]? That should be short enough for sticking it
into -v. We could even use [origin/master +0 -0] for an up-to-date
branch then.

In any case, I think often one is interested in one branch only. I would
expect "git branch -v foo" to give me the -v info just for branch foo.
Currently it does not. But that would be an independent patch on top.

>  Documentation/git-branch.txt |    4 +++-
>  builtin-branch.c             |   23 +++++++++++++++++------
>  2 files changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index 31ba7f2..ba3dea6 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -100,7 +100,9 @@ OPTIONS
>  
>  -v::
>  --verbose::
> -	Show sha1 and commit subject line for each head.
> +	Show sha1 and commit subject line for each head, along with
> +	relationship to upstream branch (if any). If given twice, print
> +	the name of the upstream branch, as well.
>  
>  --abbrev=<length>::
>  	Alter the sha1's minimum display length in the output listing.
> diff --git a/builtin-branch.c b/builtin-branch.c
> index ca81d72..3275821 100644
> --- a/builtin-branch.c
> +++ b/builtin-branch.c
> @@ -301,19 +301,30 @@ static int ref_cmp(const void *r1, const void *r2)
>  	return strcmp(c1->name, c2->name);
>  }
>  
> -static void fill_tracking_info(struct strbuf *stat, const char *branch_name)
> +static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
> +		int show_upstream_ref)
>  {
>  	int ours, theirs;
>  	struct branch *branch = branch_get(branch_name);
>  
> -	if (!stat_tracking_info(branch, &ours, &theirs) || (!ours && !theirs))
> +	if (!stat_tracking_info(branch, &ours, &theirs)) {
> +		if (branch && branch->merge && branch->merge[0]->dst &&
> +		    show_upstream_ref)
> +			strbuf_addf(stat, "[%s] ",
> +			    shorten_unambiguous_ref(branch->merge[0]->dst));
>  		return;
> +	}
> +
> +	strbuf_addch(stat, '[');
> +	if (show_upstream_ref)
> +		strbuf_addf(stat, "%s: ",
> +			shorten_unambiguous_ref(branch->merge[0]->dst));
>  	if (!ours)
> -		strbuf_addf(stat, "[behind %d] ", theirs);
> +		strbuf_addf(stat, "behind %d] ", theirs);
>  	else if (!theirs)
> -		strbuf_addf(stat, "[ahead %d] ", ours);
> +		strbuf_addf(stat, "ahead %d] ", ours);
>  	else
> -		strbuf_addf(stat, "[ahead %d, behind %d] ", ours, theirs);
> +		strbuf_addf(stat, "ahead %d, behind %d] ", ours, theirs);
>  }
>  
>  static int matches_merge_filter(struct commit *commit)
> @@ -379,7 +390,7 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
>  		}
>  
>  		if (item->kind == REF_LOCAL_BRANCH)
> -			fill_tracking_info(&stat, item->name);
> +			fill_tracking_info(&stat, item->name, verbose > 1);
>  
>  		strbuf_addf(&out, " %s %s%s",
>  			find_unique_abbrev(item->commit->object.sha1, abbrev),
