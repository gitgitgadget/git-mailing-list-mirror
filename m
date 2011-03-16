From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 8/8] diff --submodule: split into bite-sized pieces
Date: Wed, 16 Mar 2011 19:43:40 +0100
Message-ID: <4D8104DC.2010700@web.de>
References: <20110316024959.GA24932@elie> <20110316065256.GA5988@elie> <20110316071411.GI5988@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 19:44:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzvhM-0007nQ-Gk
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 19:43:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194Ab1CPSnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 14:43:52 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:35336 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483Ab1CPSnu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 14:43:50 -0400
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id DD0CA19A761B9;
	Wed, 16 Mar 2011 19:43:43 +0100 (CET)
Received: from [93.240.101.75] (helo=[192.168.178.43])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Pzvh9-00019z-00; Wed, 16 Mar 2011 19:43:43 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <20110316071411.GI5988@elie>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+28cqa6bb/dqBcXI2QQpFmCuf9LIUJFrFMRxk6
	g7wOdc6hw7/fGV06UdqqjnFUuYtP8+wEfOsdcSQeQWDBgC9uef
	nU9rj0HAjIqux9A4nXCA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169181>

Am 16.03.2011 08:14, schrieb Jonathan Nieder:
> Introduce two functions:
> 
>  - prepare_submodule_summary prepares the revision walker
>    to list changes in a submodule.  That is, it:
> 
>    * finds merge bases between the commits pointed to this
>      path from before ("left") and after ("right") the change;
>    * checks whether this is a fast-forward or fast-backward;
>    * prepares a revision walk to list commits in the symmetric
>      difference between the commits at each endpoint.
> 
>    It returns nonzero on error.
> 
>  - print_submodule_summary runs the revision walk and saves
>    the result to a strbuf in --left-right format.
> 
> The goal is just readability.  No functional change intended.

Ack, looks good and makes sense to me.


> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  submodule.c |  103 +++++++++++++++++++++++++++++++++++------------------------
>  1 files changed, 61 insertions(+), 42 deletions(-)
> 
> diff --git a/submodule.c b/submodule.c
> index 6f1c107..e9f2b19 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -152,17 +152,69 @@ void handle_ignore_submodules_arg(struct diff_options *diffopt,
>  		die("bad --ignore-submodules argument: %s", arg);
>  }
>  
> +static int prepare_submodule_summary(struct rev_info *rev, const char *path,
> +		struct commit *left, struct commit *right,
> +		int *fast_forward, int *fast_backward)
> +{
> +	struct commit_list *merge_bases, *list;
> +
> +	init_revisions(rev, NULL);
> +	setup_revisions(0, NULL, rev, NULL);
> +	rev->left_right = 1;
> +	rev->first_parent_only = 1;
> +	left->object.flags |= SYMMETRIC_LEFT;
> +	add_pending_object(rev, &left->object, path);
> +	add_pending_object(rev, &right->object, path);
> +	merge_bases = get_merge_bases(left, right, 1);
> +	if (merge_bases) {
> +		if (merge_bases->item == left)
> +			*fast_forward = 1;
> +		else if (merge_bases->item == right)
> +			*fast_backward = 1;
> +	}
> +	for (list = merge_bases; list; list = list->next) {
> +		list->item->object.flags |= UNINTERESTING;
> +		add_pending_object(rev, &list->item->object,
> +			sha1_to_hex(list->item->object.sha1));
> +	}
> +	return prepare_revision_walk(rev);
> +}
> +
> +static void print_submodule_summary(struct rev_info *rev, FILE *f,
> +		const char *del, const char *add, const char *reset)
> +{
> +	static const char format[] = "  %m %s";
> +	struct strbuf sb = STRBUF_INIT;
> +	struct commit *commit;
> +
> +	while ((commit = get_revision(rev))) {
> +		struct pretty_print_context ctx = {0};
> +		ctx.date_mode = rev->date_mode;
> +		strbuf_setlen(&sb, 0);
> +		if (commit->object.flags & SYMMETRIC_LEFT) {
> +			if (del)
> +				strbuf_addstr(&sb, del);
> +		}
> +		else if (add)
> +			strbuf_addstr(&sb, add);
> +		format_commit_message(commit, format, &sb, &ctx);
> +		if (reset)
> +			strbuf_addstr(&sb, reset);
> +		strbuf_addch(&sb, '\n');
> +		fprintf(f, "%s", sb.buf);
> +	}
> +	strbuf_release(&sb);
> +}
> +
>  void show_submodule_summary(FILE *f, const char *path,
>  		unsigned char one[20], unsigned char two[20],
>  		unsigned dirty_submodule,
>  		const char *del, const char *add, const char *reset)
>  {
>  	struct rev_info rev;
> -	struct commit *commit, *left = left, *right = right;
> -	struct commit_list *merge_bases, *list;
> +	struct commit *left = left, *right = right;
>  	const char *message = NULL;
>  	struct strbuf sb = STRBUF_INIT;
> -	static const char *format = "  %m %s";
>  	int fast_forward = 0, fast_backward = 0;
>  
>  	if (is_null_sha1(two))
> @@ -175,29 +227,10 @@ void show_submodule_summary(FILE *f, const char *path,
>  		 !(right = lookup_commit_reference(two)))
>  		message = "(commits not present)";
>  
> -	if (!message) {
> -		init_revisions(&rev, NULL);
> -		setup_revisions(0, NULL, &rev, NULL);
> -		rev.left_right = 1;
> -		rev.first_parent_only = 1;
> -		left->object.flags |= SYMMETRIC_LEFT;
> -		add_pending_object(&rev, &left->object, path);
> -		add_pending_object(&rev, &right->object, path);
> -		merge_bases = get_merge_bases(left, right, 1);
> -		if (merge_bases) {
> -			if (merge_bases->item == left)
> -				fast_forward = 1;
> -			else if (merge_bases->item == right)
> -				fast_backward = 1;
> -		}
> -		for (list = merge_bases; list; list = list->next) {
> -			list->item->object.flags |= UNINTERESTING;
> -			add_pending_object(&rev, &list->item->object,
> -				sha1_to_hex(list->item->object.sha1));
> -		}
> -		if (prepare_revision_walk(&rev))
> -			message = "(revision walker failed)";
> -	}
> +	if (!message &&
> +	    prepare_submodule_summary(&rev, path, left, right,
> +					&fast_forward, &fast_backward))
> +		message = "(revision walker failed)";
>  
>  	if (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
>  		fprintf(f, "Submodule %s contains untracked content\n", path);
> @@ -221,25 +254,11 @@ void show_submodule_summary(FILE *f, const char *path,
>  	fwrite(sb.buf, sb.len, 1, f);
>  
>  	if (!message) {
> -		while ((commit = get_revision(&rev))) {
> -			struct pretty_print_context ctx = {0};
> -			ctx.date_mode = rev.date_mode;
> -			strbuf_setlen(&sb, 0);
> -			if (commit->object.flags & SYMMETRIC_LEFT) {
> -				if (del)
> -					strbuf_addstr(&sb, del);
> -			}
> -			else if (add)
> -				strbuf_addstr(&sb, add);
> -			format_commit_message(commit, format, &sb, &ctx);
> -			if (reset)
> -				strbuf_addstr(&sb, reset);
> -			strbuf_addch(&sb, '\n');
> -			fprintf(f, "%s", sb.buf);
> -		}
> +		print_submodule_summary(&rev, f, del, add, reset);
>  		clear_commit_marks(left, ~0);
>  		clear_commit_marks(right, ~0);
>  	}
> +
>  	strbuf_release(&sb);
>  }
>  
