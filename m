From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] graph: Fix log's graph's colors when merging branches.
Date: Thu, 17 Oct 2013 09:13:36 +0100
Message-ID: <20131017081336.GS27238@serenity.lan>
References: <20131017064853.GA7419@duunidell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 17 10:13:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWiiK-0006DT-Ti
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 10:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831Ab3JQINo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Oct 2013 04:13:44 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:58705 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291Ab3JQINl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Oct 2013 04:13:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id F2BC3CDA598
	for <git@vger.kernel.org>; Thu, 17 Oct 2013 09:13:40 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B79ce9DJq++v for <git@vger.kernel.org>;
	Thu, 17 Oct 2013 09:13:40 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id BA257CDA5BB
	for <git@vger.kernel.org>; Thu, 17 Oct 2013 09:13:38 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20131017064853.GA7419@duunidell>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236289>

On Thu, Oct 17, 2013 at 09:52:09AM +0300, Hemmo Nieminen wrote:
> The log's graph's colors were off sometimes when merging several
> branches. For example in the graph depicted below, the '-----.' part
> following the asterisk was colored with incorrect colors. This was
> caused by the fact that the leftmost branches, not part of the merge,
> were not taken into account when calculating the column numbers
> (colors).
> 
>   | |     Merge of http://members.cox.net/junkio/git-jc.git
>   | |
>   | *-----.   commit 211232bae64bcc60bbf5d1b5e5b2344c22ed767e
>   | |\ \ \ \  Merge: fc54a9c 9e30dd7 c4b83e6 6602659 b28858b
>   | | | | | | Author: Junio C Hamano <junkio@cox.net>
> 
> Signed-off-by: Hemmo Nieminen <hemmo.nieminen@iki.fi>

It took me a minute to spot the problem when I tested this, but you're
right that there is a bug and I agree that the patch below is the right
fix.

Perhaps a better commit message will help others looking at this, maybe
something like this?

    graph: fix coloring around octopus merges

    When drawing the graph of an octopus merge, we draw a horizontal
    line from parents 3 and above into the asterisk representing the
    commit.  The sections of this line should be colored to match the
    graph lines coming in from above.

    However, if the commit is not in the left-most column we do not take
    into account the columns to the left of the commit when calculating
    these colors.  Fix this by adding the appropriate offset to the
    column index used for calculating the color.
    ---

    Commit 211232b (Octopus merge of the following five patches.,
    2005-05-05) in git.git's history exhibits this problem.

The section below the "---" does not become part of the commit message,
when the patch is added to Git, but is used for notes that might help
reviewers.

> ---
>  graph.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/graph.c b/graph.c
> index b24d04c..6404331 100644
> --- a/graph.c
> +++ b/graph.c
> @@ -801,10 +801,10 @@ static int graph_draw_octopus_merge(struct git_graph *graph,
>  	int num_dashes =
>  		((graph->num_parents - dashless_commits) * 2) - 1;
>  	for (i = 0; i < num_dashes; i++) {
> -		col_num = (i / 2) + dashless_commits;
> +		col_num = (i / 2) + dashless_commits + graph->commit_index;
>  		strbuf_write_column(sb, &graph->new_columns[col_num], '-');
>  	}
> -	col_num = (i / 2) + dashless_commits;
> +	col_num = (i / 2) + dashless_commits + graph->commit_index;
>  	strbuf_write_column(sb, &graph->new_columns[col_num], '.');
>  	return num_dashes + 1;
>  }
