Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F2671F404
	for <e@80x24.org>; Fri, 19 Jan 2018 14:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755718AbeASOxN (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 09:53:13 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:36834 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754860AbeASOxM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 09:53:12 -0500
Received: from [192.168.2.201] ([92.22.6.159])
        by smtp.talktalk.net with SMTP
        id cY2YeWBSebjdZcY2Yepw63; Fri, 19 Jan 2018 14:53:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1516373591;
        bh=Xij2QqDgQIt0IaxiUahNC7AuTvaEJA1lnMBSyNd6CCc=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=BnWoyauLfQiUL7QZQVyITckRmnYFDd8xBkaYBzU90OvTGjsCdAwvakAQmwt4ZjHc0
         ZxvB9bAc3/pQexnpPtsbogCvdmvBwU6l2u5xTrD09YqhFalYqgm+xClv8iydiv1AUT
         OoxgH23N5OX3X494BDadf8ZVPCeC2+xKoR3FIQxs=
X-Originating-IP: [92.22.6.159]
X-Spam: 0
X-OAuthority: v=2.2 cv=ONFX5WSB c=1 sm=1 tr=0 a=zHCrIP3pJrCm+L4FAUKT3Q==:117
 a=zHCrIP3pJrCm+L4FAUKT3Q==:17 a=IkcTkHD0fZMA:10 a=4Ih5-cJaxJSgcgI5BZIA:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/8] sequencer: fast-forward merge commits, if possible
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
 <9878bd57cc82daf08309943305460c1e8a050518.1516225925.git.johannes.schindelin@gmx.de>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <7e6906c9-d642-ee8d-82fd-29ee6c60e308@talktalk.net>
Date:   Fri, 19 Jan 2018 14:53:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <9878bd57cc82daf08309943305460c1e8a050518.1516225925.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPG33T+jQfTI2kyAPhDzKomsuh+ZaTM3ApJdxjp9/kHBpqutYvlHXRkXY4bGUXkanAeepuY/iNgEVfYIfbk61OtUAcq2ZsGy0+NoY02iUdTNzx+SDN/6
 vR6uDlkfhbNB7zgSTI5NHDTCVIsUqESn4qFwSGq0xPoXSPBF43neV1ka+hovn54OWj5v8r/tI/qeBILwN7XW1d5oaW4NrcQwN1MUpUxPVBsgq1Tmu4gqMd1Z
 pWZYLGln4WXwspYMjZFBsvTMq/FlBe3/RhRLJTj2f2w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/01/18 15:35, Johannes Schindelin wrote:
> 
> Just like with regular `pick` commands, if we are trying to recreate a
> merge commit, we now test whether the parents of said commit match HEAD
> and the commits to be merged, and fast-forward if possible.
> 
> This is not only faster, but also avoids unnecessary proliferation of
> new objects.

I might have missed something but shouldn't this be checking opts->allow_ff?

Another possible optimization is that if the parent branches have only
reworded commits or some commits that have been squashed but no other
changes then their trees will be the same as in the original merge
commit and so could be reused without calling merge_recursive().

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 567cfcbbe8b..a96255426e7 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2085,7 +2085,7 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
>  	struct commit *head_commit, *merge_commit, *i;
>  	struct commit_list *common, *j, *reversed = NULL;
>  	struct merge_options o;
> -	int ret;
> +	int can_fast_forward, ret;
>  	static struct lock_file lock;
>  
>  	for (merge_arg_len = 0; merge_arg_len < arg_len; merge_arg_len++)
> @@ -2151,6 +2151,14 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
>  		return error(_("Cannot merge without a current revision"));
>  	}
>  
> +	/*
> +	 * If HEAD is not identical to the parent of the original merge commit,
> +	 * we cannot fast-forward.
> +	 */
> +	can_fast_forward = commit && commit->parents &&
> +		!oidcmp(&commit->parents->item->object.oid,
> +			&head_commit->object.oid);
> +
>  	strbuf_addf(&ref_name, "refs/rewritten/%.*s", merge_arg_len, arg);
>  	merge_commit = lookup_commit_reference_by_name(ref_name.buf);
>  	if (!merge_commit) {
> @@ -2164,6 +2172,17 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
>  		rollback_lock_file(&lock);
>  		return -1;
>  	}
> +
> +	if (can_fast_forward && commit->parents->next &&
> +	    !commit->parents->next->next &&
> +	    !oidcmp(&commit->parents->next->item->object.oid,
> +		    &merge_commit->object.oid)) {
> +		strbuf_release(&ref_name);
> +		rollback_lock_file(&lock);
> +		return fast_forward_to(&commit->object.oid,
> +				       &head_commit->object.oid, 0, opts);
> +	}
> +
>  	write_message(oid_to_hex(&merge_commit->object.oid), GIT_SHA1_HEXSZ,
>  		      git_path_merge_head(), 0);
>  	write_message("no-ff", 5, git_path_merge_mode(), 0);
> 

