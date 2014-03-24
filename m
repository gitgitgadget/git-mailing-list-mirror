From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 14/19] tree-diff: rework diff_tree interface to be sha1 based
Date: Mon, 24 Mar 2014 14:36:22 -0700
Message-ID: <xmqqa9cfp9d5.fsf@gitster.dls.corp.google.com>
References: <cover.1393257006.git.kirr@mns.spb.ru>
	<0b82e2de0edee4a590e7b4165c65938aef7090f5.1393257006.git.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Mon Mar 24 22:36:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSCXo-0000Tx-6V
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 22:36:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbaCXVg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 17:36:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60017 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751158AbaCXVg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 17:36:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD72475257;
	Mon, 24 Mar 2014 17:36:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WYsUkQ2oZv3LjLYQYKIXj/SmNT4=; b=qs4CgM
	vK5vE0YArAu9rZnVxK6sspdrR1++F86ab50s7PRt33SiZ02GDenwR+HhOMHOOnXb
	krVZNMBX6nRPGDNEqoYZfofKaFdIabAioREh6UVuR2/Ws+3WBxZRnaDwhfoH6Dwh
	+RO6SAqX/h253/CwyUmIvciJXIe/s8LOyQfPU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DL9/z4sf8cdrAC/IMxTXrIUVmQ8DaC2w
	hbLHNLXNvyCwbOjEEQObsumUNQKGq1A//1Fl9GNeu+KyI3EFEQ3Cu3q0GX3dg1Fj
	ugH8Cw6SLp3db40dPBzXg4DR5pmwQO4WO8zSA2E5UUMDhjz5//FMSvgzgA5ece0t
	ZkrRFvq2iUU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9FA075256;
	Mon, 24 Mar 2014 17:36:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 10F2675252;
	Mon, 24 Mar 2014 17:36:24 -0400 (EDT)
In-Reply-To: <0b82e2de0edee4a590e7b4165c65938aef7090f5.1393257006.git.kirr@mns.spb.ru>
	(Kirill Smelkov's message of "Mon, 24 Feb 2014 20:21:46 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 599A4E10-B39C-11E3-B6EF-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244877>

Kirill Smelkov <kirr@mns.spb.ru> writes:

> The downside is that try_to_follow_renames(), if active, we cause
> re-reading of 2 initial trees, which was negligible based on my timings,

That would depend on how often the codepath triggered in your test
case, but is totally understandable.  It fires only when the path we
have been following disappears from the parent, and the processing
of try-to-follow itself is very compute-intensive (it needs to run
find-copies-harder logic) that will end up reading many subtrees of
the two initial trees; two more reading of tree objects will be
dwarfed by the actual processing.

> and which is outweighed cogently by the upsides.

> Changes since v1:
>
>  - don't need to touch diff.h, as diff_tree() became static.

Nice.  I wonder if it is an option to let the function keep its name
diff_tree() without renaming it to __diff_tree_whatever(), though.

>  tree-diff.c | 60 ++++++++++++++++++++++++++++--------------------------------
>  1 file changed, 28 insertions(+), 32 deletions(-)
>
> diff --git a/tree-diff.c b/tree-diff.c
> index b99622c..f90acf5 100644
> --- a/tree-diff.c
> +++ b/tree-diff.c
> @@ -137,12 +137,17 @@ static void skip_uninteresting(struct tree_desc *t, struct strbuf *base,
>  	}
>  }
>  
> -static int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
> -		     const char *base_str, struct diff_options *opt)
> +static int __diff_tree_sha1(const unsigned char *old, const unsigned char *new,
> +			    const char *base_str, struct diff_options *opt)
>  {
> +	struct tree_desc t1, t2;
> +	void *t1tree, *t2tree;
>  	struct strbuf base;
>  	int baselen = strlen(base_str);
>  
> +	t1tree = fill_tree_descriptor(&t1, old);
> +	t2tree = fill_tree_descriptor(&t2, new);
> +
>  	/* Enable recursion indefinitely */
>  	opt->pathspec.recursive = DIFF_OPT_TST(opt, RECURSIVE);
>  
> @@ -155,39 +160,41 @@ static int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
>  		if (diff_can_quit_early(opt))
>  			break;
>  		if (opt->pathspec.nr) {
> -			skip_uninteresting(t1, &base, opt);
> -			skip_uninteresting(t2, &base, opt);
> +			skip_uninteresting(&t1, &base, opt);
> +			skip_uninteresting(&t2, &base, opt);
>  		}
> -		if (!t1->size && !t2->size)
> +		if (!t1.size && !t2.size)
>  			break;
>  
> -		cmp = tree_entry_pathcmp(t1, t2);
> +		cmp = tree_entry_pathcmp(&t1, &t2);
>  
>  		/* t1 = t2 */
>  		if (cmp == 0) {
>  			if (DIFF_OPT_TST(opt, FIND_COPIES_HARDER) ||
> -			    hashcmp(t1->entry.sha1, t2->entry.sha1) ||
> -			    (t1->entry.mode != t2->entry.mode))
> -				show_path(&base, opt, t1, t2);
> +			    hashcmp(t1.entry.sha1, t2.entry.sha1) ||
> +			    (t1.entry.mode != t2.entry.mode))
> +				show_path(&base, opt, &t1, &t2);
>  
> -			update_tree_entry(t1);
> -			update_tree_entry(t2);
> +			update_tree_entry(&t1);
> +			update_tree_entry(&t2);
>  		}
>  
>  		/* t1 < t2 */
>  		else if (cmp < 0) {
> -			show_path(&base, opt, t1, /*t2=*/NULL);
> -			update_tree_entry(t1);
> +			show_path(&base, opt, &t1, /*t2=*/NULL);
> +			update_tree_entry(&t1);
>  		}
>  
>  		/* t1 > t2 */
>  		else {
> -			show_path(&base, opt, /*t1=*/NULL, t2);
> -			update_tree_entry(t2);
> +			show_path(&base, opt, /*t1=*/NULL, &t2);
> +			update_tree_entry(&t2);
>  		}
>  	}
>  
>  	strbuf_release(&base);
> +	free(t2tree);
> +	free(t1tree);
>  	return 0;
>  }
>  
> @@ -202,7 +209,7 @@ static inline int diff_might_be_rename(void)
>  		!DIFF_FILE_VALID(diff_queued_diff.queue[0]->one);
>  }
>  
> -static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, const char *base, struct diff_options *opt)
> +static void try_to_follow_renames(const unsigned char *old, const unsigned char *new, const char *base, struct diff_options *opt)
>  {
>  	struct diff_options diff_opts;
>  	struct diff_queue_struct *q = &diff_queued_diff;
> @@ -240,7 +247,7 @@ static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, co
>  	diff_opts.break_opt = opt->break_opt;
>  	diff_opts.rename_score = opt->rename_score;
>  	diff_setup_done(&diff_opts);
> -	diff_tree(t1, t2, base, &diff_opts);
> +	__diff_tree_sha1(old, new, base, &diff_opts);
>  	diffcore_std(&diff_opts);
>  	free_pathspec(&diff_opts.pathspec);
>  
> @@ -301,23 +308,12 @@ static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, co
>  
>  int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const char *base, struct diff_options *opt)
>  {
> -	void *tree1, *tree2;
> -	struct tree_desc t1, t2;
> -	unsigned long size1, size2;
>  	int retval;
>  
> -	tree1 = fill_tree_descriptor(&t1, old);
> -	tree2 = fill_tree_descriptor(&t2, new);
> -	size1 = t1.size;
> -	size2 = t2.size;
> -	retval = diff_tree(&t1, &t2, base, opt);
> -	if (!*base && DIFF_OPT_TST(opt, FOLLOW_RENAMES) && diff_might_be_rename()) {
> -		init_tree_desc(&t1, tree1, size1);
> -		init_tree_desc(&t2, tree2, size2);
> -		try_to_follow_renames(&t1, &t2, base, opt);
> -	}
> -	free(tree1);
> -	free(tree2);
> +	retval = __diff_tree_sha1(old, new, base, opt);
> +	if (!*base && DIFF_OPT_TST(opt, FOLLOW_RENAMES) && diff_might_be_rename())
> +		try_to_follow_renames(old, new, base, opt);
> +
>  	return retval;
>  }
