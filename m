Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438D5C83003
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 10:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 228FF2082E
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 10:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgD2KIT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 06:08:19 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:34208 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbgD2KIS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 06:08:18 -0400
Received: from [92.30.123.115] (helo=[192.168.1.39])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jTjdV-00081i-58; Wed, 29 Apr 2020 11:08:14 +0100
Subject: Re: [PATCH v2] Teach git-rev-list --simplify-forks
To:     Antonio Russo <antonio.e.russo@gmail.com>,
        git-ml <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Derrick Stolee <dstolee@microsoft.com>
References: <df0b9e59-e6d7-8839-ca3b-86145dc3bdf3@gmail.com>
 <d3079ba8-33e1-3b68-23d2-ea97b9ca1e97@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <eda71f1e-b883-82c3-72f2-dc5221804c4b@iee.email>
Date:   Wed, 29 Apr 2020 11:08:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d3079ba8-33e1-3b68-23d2-ea97b9ca1e97@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Antonio,

On 29/04/2020 09:01, Antonio Russo wrote:
> When used with --graph, instead of displaying the full graph, display a
> spanning subgraph produced by a depth-first search of the graph visiting
> parents from left to right.  Edges to already visited commits are
> discarded.  This process is repeated for every commit to be displayed.
>
> This is valuable to reduce visual clutter when there are many merges
> that were not rebased onto each other and the user is primarily
> interested in the state of the branch being merged into.
>
> Also adds documentation and tests of the above.
>
> Signed-off-by: Antonio Russo <antonio.e.russo@gmail.com>
> ---
>  Documentation/rev-list-options.txt         |  8 +++
>  revision.c                                 | 62 ++++++++++++++++++++++
>  revision.h                                 |  6 +++
>  t/t6016-rev-list-graph-simplify-history.sh | 50 +++++++++++++++++
>  4 files changed, 126 insertions(+)
>
> Hello,
>
> This second revision of the patch sets revs->limited.  This forces the
> graph of commits to be loaded, and simplfiy_forks() therefore reliably
> traverses it.  This addresses the test failures mentioned before (see [1]).
>
> Antonio
>
> [1] https://travis-ci.org/github/aerusso/git/builds/680894920
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 04ad7dd36e..cbac09028c 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -363,6 +363,14 @@ Default mode::
>  	merges from the resulting history, as there are no selected
>  	commits contributing to this merge.
>
> +--simplify-forks::
> +	Convert the commit graph into a spanning subgraph produced by a
> +	depth-first-search of the history graph, searching the leftmost
> +	parent first, and discarding edges to commits already visited.
> +	Useful with `--graph` to visualize repositories with many merges
> +	when you are interested in was added to master, and not when the
> +	branch was last rebased.

Does this also need to actually mention that it effectively discard
edges to fork points, as per the option name?. No rebasing required for
it to be useful.
     s/when/where/
    "...and not where the branch was last rebased or forked from." - not
great but actually mentions the option.

--
Philip
> +
>  --ancestry-path::
>  	When given a range of commits to display (e.g. 'commit1..commit2'
>  	or 'commit2 {caret}commit1'), only display commits that exist
> diff --git a/revision.c b/revision.c
> index 5bc96444b6..51dbe21847 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2082,6 +2082,9 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  		revs->simplify_by_decoration = 1;
>  		revs->limited = 1;
>  		revs->prune = 1;
> +	} else if (!strcmp(arg, "--simplify-forks")) {
> +		revs->limited = 1;
> +		revs->simplify_forks = 1;
>  	} else if (!strcmp(arg, "--date-order")) {
>  		revs->sort_order = REV_SORT_BY_COMMIT_DATE;
>  		revs->topo_order = 1;
> @@ -3095,6 +3098,63 @@ static void simplify_merges(struct rev_info *revs)
>  	}
>  }
>
> +static void simplify_forks(struct rev_info *revs)
> +{
> +	struct commit_list *stack, *list_lr, *iter_list;
> +	struct commit_list **parents;
> +	struct commit *commit, *parent;
> +
> +	stack = NULL;
> +	list_lr = NULL;
> +
> +	clear_object_flags(SIMP_FORK_VISITED);
> +
> +	for(iter_list = revs->commits; iter_list; iter_list = iter_list->next) {
> +		/* process every commit to be displayed exactly once */
> +		if(iter_list->item->object.flags & SIMP_FORK_VISITED)
> +			continue;
> +		clear_object_flags(SIMP_FORK_VISITING);
> +		commit_list_insert(iter_list->item, &stack);
> +		iter_list->item->object.flags |= SIMP_FORK_VISITED | SIMP_FORK_VISITING;
> +		while(stack) {
> +			commit = pop_commit(&stack);
> +			/* process the parent nodes: removing links to
> +			 * commits already visited (creating a spanning tree)
> +			 */
> +			parents = &(commit->parents);
> +			while(*parents) {
> +				parent = (*parents)->item;
> +				if(parent->object.flags & SIMP_FORK_VISITING) {
> +					/* We have already visited this commit, from the same root.
> +					 * We do not explore it at all.
> +					 */
> +					pop_commit(parents);
> +				} else if(parent->object.flags & SIMP_FORK_VISITED) {
> +					/* We visited this commit before, but from a different root.
> +					 * Leave it attached, but do not explore it further.
> +					 */
> +					parents = &((*parents)->next);
> +				} else {
> +					/* We have not visited this commit yet. Explore it, as usual.
> +					 */
> +					parent->object.flags |= SIMP_FORK_VISITED | SIMP_FORK_VISITING;
> +					commit_list_insert(parent, &list_lr);
> +					parents = &((*parents)->next);
> +				}
> +			}
> +
> +			/* feed the parents, right to left (reversed) onto the
> +			 * stack to do a depth-first traversal of the commit graph
> +			 */
> +			while(list_lr) {
> +				commit_list_insert(pop_commit(&list_lr), &stack);
> +			}
> +		}
> +	}
> +
> +	clear_object_flags(SIMP_FORK_VISITED | SIMP_FORK_VISITING);
> +}
> +
>  static void set_children(struct rev_info *revs)
>  {
>  	struct commit_list *l;
> @@ -3392,6 +3452,8 @@ int prepare_revision_walk(struct rev_info *revs)
>  	if (revs->limited) {
>  		if (limit_list(revs) < 0)
>  			return -1;
> +		if (revs->simplify_forks)
> +			simplify_forks(revs);
>  		if (revs->topo_order)
>  			sort_in_topological_order(&revs->commits, revs->sort_order);
>  	} else if (revs->topo_order)
> diff --git a/revision.h b/revision.h
> index c1af164b30..f1abdb26b0 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -51,6 +51,11 @@
>  #define TOPO_WALK_EXPLORED	(1u<<27)
>  #define TOPO_WALK_INDEGREE	(1u<<28)
>
> +/* Re-use the TOPO_WALK flagspace for simplify_forks
> + */
> +#define SIMP_FORK_VISITED	(1u<<27)
> +#define SIMP_FORK_VISITING	(1u<<28)
> +
>  #define DECORATE_SHORT_REFS	1
>  #define DECORATE_FULL_REFS	2
>
> @@ -132,6 +137,7 @@ struct rev_info {
>  			no_walk:2,
>  			remove_empty_trees:1,
>  			simplify_history:1,
> +			simplify_forks:1,
>  			show_pulls:1,
>  			topo_order:1,
>  			simplify_merges:1,
> diff --git a/t/t6016-rev-list-graph-simplify-history.sh b/t/t6016-rev-list-graph-simplify-history.sh
> index f5e6e92f5b..d99214b6df 100755
> --- a/t/t6016-rev-list-graph-simplify-history.sh
> +++ b/t/t6016-rev-list-graph-simplify-history.sh
> @@ -85,6 +85,28 @@ test_expect_success '--graph --all' '
>  	test_cmp expected actual
>  	'
>
> +# Make sure that simplify_histpry_forks produces a spanning tree
> +test_expect_success '--graph --simplify-forks --all' '
> +	rm -f expected &&
> +	echo "* $A7" >> expected &&
> +	echo "*   $A6" >> expected &&
> +	echo "|\  " >> expected &&
> +	echo "| * $C4" >> expected &&
> +	echo "| * $C3" >> expected &&
> +	echo "* $A5" >> expected &&
> +	echo "*-.   $A4" >> expected &&
> +	echo "|\ \  " >> expected &&
> +	echo "| | * $C2" >> expected &&
> +	echo "| | * $C1" >> expected &&
> +	echo "| * $B2" >> expected &&
> +	echo "| * $B1" >> expected &&
> +	echo "* $A3" >> expected &&
> +	echo "* $A2" >> expected &&
> +	echo "* $A1" >> expected &&
> +	git rev-list --graph --simplify-forks --all > actual &&
> +	test_cmp expected actual
> +	'
> +
>  # Make sure the graph_is_interesting() code still realizes
>  # that undecorated merges are interesting, even with --simplify-by-decoration
>  test_expect_success '--graph --simplify-by-decoration' '
> @@ -157,6 +179,20 @@ test_expect_success '--graph --full-history -- bar.txt' '
>  	test_cmp expected actual
>  	'
>
> +test_expect_success '--graph --simplify-forks --full-history -- bar.txt' '
> +	rm -f expected &&
> +	echo "* $A7" >> expected &&
> +	echo "*   $A6" >> expected &&
> +	echo "|\\  " >> expected &&
> +	echo "| * $C4" >> expected &&
> +	echo "* $A5" >> expected &&
> +	echo "* $A4" >> expected &&
> +	echo "* $A3" >> expected &&
> +	echo "* $A2" >> expected &&
> +	git rev-list --graph --simplify-forks --full-history --all -- bar.txt > actual &&
> +	test_cmp expected actual
> +	'
> +
>  test_expect_success '--graph --full-history --simplify-merges -- bar.txt' '
>  	rm -f expected &&
>  	echo "* $A7" >> expected &&
> @@ -172,6 +208,20 @@ test_expect_success '--graph --full-history --simplify-merges -- bar.txt' '
>  	test_cmp expected actual
>  	'
>
> +test_expect_success '--graph --simplify-forks --full-history --simplify-merges -- bar.txt' '
> +	rm -f expected &&
> +	echo "* $A7" >> expected &&
> +	echo "*   $A6" >> expected &&
> +	echo "|\\  " >> expected &&
> +	echo "| * $C4" >> expected &&
> +	echo "* $A5" >> expected &&
> +	echo "* $A3" >> expected &&
> +	echo "* $A2" >> expected &&
> +	git rev-list --graph --simplify-forks --full-history --simplify-merges --all \
> +		-- bar.txt > actual &&
> +	test_cmp expected actual
> +	'
> +
>  test_expect_success '--graph -- bar.txt' '
>  	rm -f expected &&
>  	echo "* $A7" >> expected &&

