Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA995C3F2D7
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 18:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5FD20870
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 18:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SduNL+O3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731169AbgCCSVf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 13:21:35 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59180 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbgCCSVe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 13:21:34 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 27BDC41931;
        Tue,  3 Mar 2020 13:21:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wl820YDN2a79UUm5v6E2L9gqBHg=; b=SduNL+
        O3G3RToemVerbxfY6eBMVcNHfwNmDjfcr2wKw8r0BncR/cPIpiPzpnfuLLFd9gCV
        k4JRjzTOx0zoALehMr53RyD+LvfPqsV3UIjast3HbFLb88bjamWyob/f1rxIrmXu
        gOr6IQOB+qX8IWc+y67zbiW4peLkF8p9af5Ys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rffCxGFjfUw4uFRUWu8xbIcKCwJ3eUrd
        d//iLtRGjV00sEh5FKWCtmCNw3//ZIewFKg/vytgNpX0Ppu9PQjXsncaQ/wHZy4F
        mjaIgVOb3kymGuz0ar3cL5u3HwgDu5aRZQwqjReVRCdCz7xvMndianeVN06ffpgx
        cZJYARgInI8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C2544192F;
        Tue,  3 Mar 2020 13:21:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6B1774192E;
        Tue,  3 Mar 2020 13:21:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: Re: [PATCH v2 2/2] remote.c: fix handling of %(push:remoteref)
References: <20200302133217.GA1176622@coredump.intra.peff.net>
        <20200303161223.1870298-1-damien.olivier.robert+git@gmail.com>
        <20200303161223.1870298-3-damien.olivier.robert+git@gmail.com>
Date:   Tue, 03 Mar 2020 10:21:31 -0800
In-Reply-To: <20200303161223.1870298-3-damien.olivier.robert+git@gmail.com>
        (Damien Robert's message of "Tue, 3 Mar 2020 17:12:23 +0100")
Message-ID: <xmqqtv358fkk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CFA99892-5D7B-11EA-AF44-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Damien Robert <damien.olivier.robert@gmail.com> writes:

> Looking at the value of %(push:remoteref) only handles the case when an
> explicit push refspec is passed. But it does not handle the fallback
> cases of looking at the configuration value of `push.default`.
>
> In particular, doing something like
>
>     git config push.default current
>     git for-each-ref --format='%(push)'
>     git for-each-ref --format='%(push:remoteref)'
>
> prints a useful tracking ref for the first for-each-ref, but an empty
> string for the second.
>
> Since the intention of %(push:remoteref), from 9700fae5ee (for-each-ref:
> let upstream/push report the remote ref name) is to get exactly which
> branch `git push` will push to, even in the fallback cases, fix this.
>
> To get the meaning of %(push:remoteref), `ref-filter.c` calls
> `remote_ref_for_branch`. We simply add a new static helper function,
> `branch_get_push_remoteref` that follows the logic of
> `branch_get_push_1`, and call it from `remote_ref_for_branch`.
>
> We also update t/6300-for-each-ref.sh to handle all `push.default`
> strategies. This involves testing `push.default=simple` twice, once
> where there is a matching upstream branch and once when there is none.
>
> Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
> ---
>  remote.c                | 106 +++++++++++++++++++++++++++++++---------
>  t/t6300-for-each-ref.sh |  29 ++++++++++-
>  2 files changed, 112 insertions(+), 23 deletions(-)
>
> diff --git a/remote.c b/remote.c
> index c43196ec06..b3ce992d01 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -516,28 +516,6 @@ const char *pushremote_for_branch(struct branch *branch, int *explicit)
>  	return remote_for_branch(branch, explicit);
>  }
>  
> -const char *remote_ref_for_branch(struct branch *branch, int for_push)
> -{
> -	if (branch) {
> -		if (!for_push) {
> -			if (branch->merge_nr) {
> -				return branch->merge_name[0];
> -			}
> -		} else {
> -			const char *dst, *remote_name =
> -				pushremote_for_branch(branch, NULL);
> -			struct remote *remote = remote_get(remote_name);
> -
> -			if (remote && remote->push.nr &&
> -			    (dst = apply_refspecs(&remote->push,
> -						  branch->refname))) {
> -				return dst;
> -			}
> -		}
> -	}
> -	return NULL;
> -}

Mental note: this function was moved down, the main part of the
logic extracted to a new branch_get_push_remoteref() helper, which
in addition got extended.

> @@ -1656,6 +1634,76 @@ static const char *tracking_for_push_dest(struct remote *remote,
>  	return ret;
>  }
>  
> +/**
> + * Return the local name of the remote tracking branch, as in
> + * %(push:remoteref), that corresponds to the ref we would push to given a
> + * bare `git push` while `branch` is checked out.
> + * See also branch_get_push_1 below.
> + */
> +static const char *branch_get_push_remoteref(struct branch *branch)
> +{
> +	struct remote *remote;
> +
> +	remote = remote_get(pushremote_for_branch(branch, NULL));
> +	if (!remote)
> +		return NULL;
> +
> +	if (remote->push.nr) {
> +		char *dst;
> +
> +		dst = apply_refspecs(&remote->push, branch->refname);
> +		if (!dst)
> +			return NULL;
> +
> +		return dst;
> +	}

That's a fairly expensive way to write

	if (remote->push.nr)
		return apply_refspecs(&remote->push, branch->refname);

one-liner.

In any case, up to this point, the code does exactly the same thing
as the original (i.e. when remote.<remotename>.push is set and
covers the current branch, use that to figure out which way we are
pushing).

> +	if (remote->mirror)
> +		return branch->refname;

If mirroring, we push to the same name, OK.

> +	switch (push_default) {
> +	case PUSH_DEFAULT_NOTHING:
> +		return NULL;
> +
> +	case PUSH_DEFAULT_MATCHING:
> +	case PUSH_DEFAULT_CURRENT:
> +		return branch->refname;

These three cases are straight-forward, I think.

> +	case PUSH_DEFAULT_UPSTREAM:
> +		{
> +			if (!branch || !branch->merge ||
> +			    !branch->merge[0] || !branch->merge[0]->dst)
> +			return NULL;
> +
> +			return branch->merge[0]->src;
> +		}

This is strangely indented and somewhat unreadable.  Why isn't this
more like:

	case PUSH_DEFAULT_UPSTREAM:
		if (branch && branch->merge && branch->merge[0] &&
		    branch->merge[0]->dst)
			return branch->merge[0]->src;
		break;

and have "return NULL" after the switch() statement before we leave
the function?

> +
> +	case PUSH_DEFAULT_UNSPECIFIED:
> +	case PUSH_DEFAULT_SIMPLE:
> +		{
> +			const char *up, *cur;
> +
> +			up = branch_get_upstream(branch, NULL);
> +			if (!up)
> +				return NULL;
> +			cur = tracking_for_push_dest(remote, branch->refname, NULL);
> +			if (!cur)
> +				return NULL;
> +			if (strcmp(cur, up))
> +				return NULL;

This is probably not all that performance critical, so

			up = branch_get_upstream(branch, NULL);
			current = tracking_for_push_dest(remote, branch->refname, NULL);
			if (!up || !current || strcmp(current, up))
				return NULL;

might be easier to follow.

> +			return branch->refname;

> +		}
> +	}
> +
> +	BUG("unhandled push situation");

This is better done / easier to read inside switch() as default:
clause.

By the way, I have a bit higher-level question.  

All of the above logic that decides what should happen in "git push"
MUST have existing code we already use to implement "git push", no?

Why do we need to reinvent it here, instead of reusing the existing
code?  Is it because the interface into the functions that implement
the existing logic is very different from what this function wants?

