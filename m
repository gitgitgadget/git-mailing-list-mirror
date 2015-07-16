From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 20/20] checkout: drop intimate knowledge of newly created worktree
Date: Thu, 16 Jul 2015 11:13:06 -0700
Message-ID: <xmqqtwt43r9p.fsf@gitster.dls.corp.google.com>
References: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
	<1437034825-32054-21-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 20:13:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFnel-0002A5-Gp
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 20:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968AbbGPSNK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 14:13:10 -0400
Received: from mail-ig0-f194.google.com ([209.85.213.194]:35252 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbbGPSNI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 14:13:08 -0400
Received: by igcqs7 with SMTP id qs7so1615345igc.2
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 11:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=9SmaQUc8Iv+SkkGxvb1TxZ6sQMUve4b4fMHmEmR/HZA=;
        b=OjHi6LgXtrdVnbzpZ84ZjkxpgB6eyt5H77vVk8sUSGKghoK8pSll+BniFK5WBJFIVd
         hEnYTL/QVj+vsyU2Ljw1c71hc8lqa+nzwwAb16ooT0SUDO3KV0PvmhMb5U02nN5JOq6m
         jHwzXseEbPCn2SbiYG9JyVBt7rhNQqfDUOxXcf/9C5nc61ATF2+miavZiSB2O+Y2jLLw
         q/S2OSKEcRfKxTbslNRPNmZVp8r4gPSiJOLHH1uiNMx6T5tdORfJtFRYx2flGXj9EqOY
         2FaOEofKllwcdO+nYx3qlbsN5k/XNW9itaJ2ZNUxm62RbflRFUMubnQ5AxQ4CQpn3hB8
         Zefg==
X-Received: by 10.50.73.170 with SMTP id m10mr5371996igv.60.1437070388050;
        Thu, 16 Jul 2015 11:13:08 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:117b:74b0:a5d4:7d4c])
        by smtp.gmail.com with ESMTPSA id j3sm1808255igx.21.2015.07.16.11.13.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 16 Jul 2015 11:13:07 -0700 (PDT)
In-Reply-To: <1437034825-32054-21-git-send-email-sunshine@sunshineco.com>
	(Eric Sunshine's message of "Thu, 16 Jul 2015 04:20:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274036>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Now that git-worktree no longer relies upon git-checkout for new branch
> creation, new worktree HEAD set up, or initial worktree population,
> git-checkout no longer needs intimate knowledge that it may be operating
> in a newly created worktree. Therefore, drop 'new_worktree_mode' and the
> private GIT_CHECKOUT_NEW_WORKTREE environment variable by which
> git-worktree communicated to git-checkout that it was being invoked to
> manipulate a new worktree.
>
> This reverts the remaining changes to checkout.c by 529fef2 (checkout:
> support checking out into a new working directory, 2014-11-30).

The diff between 529fef2^ and the version after applying this series
in builtin/checkout.c looks very sensible; essentially it is just
10f102be (checkout: pass whole struct to parse_branchname_arg
instead of individual flags, 2015-01-03).

Thanks.

> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>
> Changes since v1: reword commit message.
>
>  builtin/checkout.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 4ae895c..02d78ba 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -48,8 +48,6 @@ struct checkout_opts {
>  	const char *prefix;
>  	struct pathspec pathspec;
>  	struct tree *source_tree;
> -
> -	int new_worktree_mode;
>  };
>  
>  static int post_checkout_hook(struct commit *old, struct commit *new,
> @@ -491,7 +489,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
>  			topts.dir->flags |= DIR_SHOW_IGNORED;
>  			setup_standard_excludes(topts.dir);
>  		}
> -		tree = parse_tree_indirect(old->commit && !opts->new_worktree_mode ?
> +		tree = parse_tree_indirect(old->commit ?
>  					   old->commit->object.sha1 :
>  					   EMPTY_TREE_SHA1_BIN);
>  		init_tree_desc(&trees[0], tree->buffer, tree->size);
> @@ -807,8 +805,7 @@ static int switch_branches(const struct checkout_opts *opts,
>  		return ret;
>  	}
>  
> -	if (!opts->quiet && !old.path && old.commit &&
> -	    new->commit != old.commit && !opts->new_worktree_mode)
> +	if (!opts->quiet && !old.path && old.commit && new->commit != old.commit)
>  		orphaned_commit_warning(old.commit, new->commit);
>  
>  	update_refs_for_switch(opts, &old, new);
> @@ -1151,8 +1148,6 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>  	argc = parse_options(argc, argv, prefix, options, checkout_usage,
>  			     PARSE_OPT_KEEP_DASHDASH);
>  
> -	opts.new_worktree_mode = getenv("GIT_CHECKOUT_NEW_WORKTREE") != NULL;
> -
>  	if (conflict_style) {
>  		opts.merge = 1; /* implied */
>  		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
