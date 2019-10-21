Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 790EF1F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 01:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfJUB7I (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Oct 2019 21:59:08 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50185 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfJUB7I (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Oct 2019 21:59:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D67ED9B3A6;
        Sun, 20 Oct 2019 21:59:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CRo0Y9LbF7zscedep9Au0rL8Mpc=; b=PlCQy4
        RewdevWjZPtKCZre+OI6TG9RnpPKDbjLi2PvoQplqQ79djhohwLOoinqw57jPDZx
        mznIdDMfjVMiKxlCyq4Tm1Ghg+h+eEDX73aWS4XtQDLfCfUt2ia793/CBMrNaXL0
        lUqX2E1CdFanlPyf3sV/Zmsrpizdq1oBKpHH4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VS0kZail+yRDSHoxhsizQCsLgH3HwyEe
        MzXoDr4t2kYlf1QWmzUU1z7TRBYrds9KuARWqq7s65WOa9JPGC9vzqJzMKswqVxj
        ssnHHuaMktzIJe6Gi0brtfi1YISp2xTTa0hFSah6fJR6hTKKOD7tHc6rMCp9Xl2t
        JjWioanE6gQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CFBB69B3A5;
        Sun, 20 Oct 2019 21:59:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 085339B3A3;
        Sun, 20 Oct 2019 21:59:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Peter Jones <pjones@redhat.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 2/4] libgit: Expose more worktree functionality.
References: <20191018194317.wvqphshpkfskvkyh@redhat.com>
        <20191018194542.1316981-1-pjones@redhat.com>
        <20191018194542.1316981-2-pjones@redhat.com>
Date:   Mon, 21 Oct 2019 10:59:01 +0900
In-Reply-To: <20191018194542.1316981-2-pjones@redhat.com> (Peter Jones's
        message of "Fri, 18 Oct 2019 15:45:40 -0400")
Message-ID: <xmqqpniqn9ju.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5BB9ADD0-F3A6-11E9-B706-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Peter Jones <pjones@redhat.com> writes:

Same comment on the commit title as 1/4; also, we tend not to upcase
the first word after the <area>: word and omit the full-stop on the
title (see "git shortlog -32 --no-merges" on our project for
examples).

> Add delete_worktrees_dir_if_empty() and prune_worktree() to the public
> API, so they can be used from more places.  Also add a new function,
> prune_worktree_if_missing(), which prunes unlocked worktrees if they
> aren't present on the filesystem.

It probably is cleaner to do the "also" part as a separate step, as
that allows readers to skip this step without reading it deeply, but
let's see how it is done.

> @@ -144,7 +73,7 @@ static void prune_worktrees(void)
>  		if (is_dot_or_dotdot(d->d_name))
>  			continue;
>  		strbuf_reset(&reason);
> -		if (!prune_worktree(d->d_name, &reason))
> +		if (!prune_worktree(d->d_name, &reason, expire))
>  			continue;
>  		if (show_only || verbose)
>  			printf("%s\n", reason.buf);
> diff --git a/worktree.c b/worktree.c
> index 4924805c389..08454a4e65d 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -608,3 +608,91 @@ int other_head_refs(each_ref_fn fn, void *cb_data)
> +int prune_worktree(const char *id, struct strbuf *reason, timestamp_t expire)

This is not a mere code movement, because the original relied on the
file-scope static "expire", and the public version wants to give
callers control over the expiration value.  That is a good change
that deserves to be advertised and explained in the proposed log
message.

> +int prune_worktree_if_missing(const struct worktree *wt)
> +{
> +	struct strbuf reason = STRBUF_INIT;
> +	int ret;
> +
> +	if (is_worktree_locked(wt) ||
> +	    access(wt->path, F_OK) >= 0 ||
> +	    (errno != ENOENT && errno == ENOTDIR)) {
> +		errno = EEXIST;
> +		return -1;
> +	}

When access() failed but not because the named path did not exist
(i.e. the directory may still exist---it is just this invocation of
the process happened to fail to see it---or it may not exist but we
cannot see far enough to notice that it does not exist) then we play
safe, assume it does exist, and refrain from calling prune_worktree()
on it.  Which makes sense, but do we need to set errno to EEXIST
here?  Does prune_worktree() ensure the value left in errno when it
returns failure in a similar way to allow the caller of this new
helper make effective and reliable use of errno?

> +	strbuf_addf(&reason, _("Removing worktrees/%s: worktree directory is not present"), wt->id);
> +	ret = prune_worktree(wt->id, &reason, TIME_MAX);
> +	return ret;
> +}
