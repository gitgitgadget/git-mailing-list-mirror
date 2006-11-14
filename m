X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/5] support fetching into a shallow repository
Date: Mon, 13 Nov 2006 23:24:41 -0800
Message-ID: <7vac2u1oee.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0610302008520.26682@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 14 Nov 2006 07:24:57 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31336>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gjsf0-0001aF-Vo for gcvg-git@gmane.org; Tue, 14 Nov
 2006 08:24:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933238AbWKNHYn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 02:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933139AbWKNHYn
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 02:24:43 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:35985 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S933238AbWKNHYn
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 02:24:43 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061114072442.YQSG18207.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Tue, 14
 Nov 2006 02:24:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id mXQo1V00Y1kojtg0000000; Tue, 14 Nov 2006
 02:24:48 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> A shallow commit is a commit which has parents, which in turn are
> "grafted away", i.e. the commit appears as if it were a root.
>
> Since these shallow commits should not be edited by the user, but
> only by core git, they are recorded in the file $GIT_DIR/shallow.
>
> A repository containing shallow commits is called shallow.
>
> The advantage of a shallow repository is that even if the upstream
> contains lots of history, your local (shallow) repository needs not
> occupy much disk space.
>
> The disadvantage is that you might miss a merge base when pulling
> some remote branch.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/shallow.c b/shallow.c
> new file mode 100644
> index 0000000..3cf2127
> --- /dev/null
> +++ b/shallow.c
>...
> +struct commit_list *get_shallow_commits(struct object_array *heads, int depth)
> +{
> +	int i = 0, cur_depth = 0;
> +	struct commit_list *result = NULL;
> +	struct object_array stack = {0, 0, NULL};
> +	struct commit *commit = NULL;
> +
> +	while (commit || i < heads->nr || stack.nr) {
> +		struct commit_list *p;
> +		if (!commit) {
>...
> +		}
> +		parse_commit(commit);
> +		cur_depth++;
> +		for (p = commit->parents, commit = NULL; p; p = p->next) {
> +			if (!p->item->util) {
>...
> +			} else {
>...
> +			}
> +			if (cur_depth < depth) {
> +				if (p->next)
> +					add_object_array(&p->item->object,
> +							NULL, &stack);
> +				else {
> +					commit = p->item;
> +					cur_depth = *(int *)commit->util;
> +				}
> +			} else
> +				commit_list_insert(p->item, &result);
> +		}
> +	}
> +
> +	return result;
> +}

I think the "commit = p->item" part is trying to do a tail
recursion optimization, but this is a bit too clever to my
liking (at first I mistook that the code forgot to re-point p at
its parents list and incrementing cur_depth).
