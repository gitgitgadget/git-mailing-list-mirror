Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 991221FCA9
	for <e@80x24.org>; Wed, 14 Sep 2016 21:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933393AbcINVrG (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 17:47:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51894 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933168AbcINVrF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 17:47:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C5813ECED;
        Wed, 14 Sep 2016 17:46:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NEdVUTnZnJcsNXRfCgRVGD15xyI=; b=Q3YTXc
        9cCoj4tSuRu95XCh/VcBACcFL/GRD8Mt1TkRAbiukZ50CWDkQylU67rnUyutk/Hy
        vtP3FTPUSk3jxRD8wtlq3Db32jl4VO1enjcIoyFPGMHmIkAYfHIEigOCCRiuJK8Q
        hsio76bwRlG5hCKXbBctRrZSlgfJqGmzQoIkU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=U7Q7YRPs2v3GYSEm3bLXkxCaMKkw92Bl
        FHBAp166/2QhmWqbreq7dGZvspIWEedinfzXFlb8uNylTq2HuGx6r6bYUClEMuU1
        WnpRvvsCo02ceDXkdWqOMVMilnVfi0RZnPp6tYSNzir2tq+5+0p0wAC/mqnqdiMQ
        dXG14ynjzJs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 015FD3ECEC;
        Wed, 14 Sep 2016 17:46:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6E4613ECEB;
        Wed, 14 Sep 2016 17:46:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Jan Keromnes <janx@linux.com>,
        Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>,
        Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH v4 3/4] read-cache: introduce chmod_index_entry
References: <20160912210818.26282-1-t.gummerer@gmail.com>
        <20160914210747.15485-1-t.gummerer@gmail.com>
        <20160914210747.15485-4-t.gummerer@gmail.com>
Date:   Wed, 14 Sep 2016 14:46:56 -0700
In-Reply-To: <20160914210747.15485-4-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Wed, 14 Sep 2016 22:07:46 +0100")
Message-ID: <xmqqbmzqqhm7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C302C354-7AC4-11E6-B1BF-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> As there are chmod options for both add and update-index, introduce a
> new chmod_index_entry function to do the work.  Use it in update-index,
> while it will be used in add in the next patch.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  builtin/update-index.c | 16 ++--------------
>  cache.h                |  2 ++
>  read-cache.c           | 29 +++++++++++++++++++++++++++++
>  3 files changed, 33 insertions(+), 14 deletions(-)
>
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index bbdf0d9..9e9e040 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -423,26 +423,14 @@ static void chmod_path(char flip, const char *path)
>  {
> ...
> -	mode = ce->ce_mode;
> -	if (!S_ISREG(mode))
> -		goto fail;
> -	switch (flip) {
> -	case '+':
> -		ce->ce_mode |= 0111; break;
> -	case '-':
> -		ce->ce_mode &= ~0111; break;
> -	default:
> +	if (chmod_cache_entry(ce, flip) < 0)
>  		goto fail;
> -	}
> -	cache_tree_invalidate_path(&the_index, path);

This used to always work on the default index, hence the_index
reference is here, but ...

> +int chmod_index_entry(struct index_state *istate, struct cache_entry *ce,
> +		      char flip)
> +{
> +	if (!S_ISREG(ce->ce_mode))
> +		return -1;
> +	switch (flip) {
> +	case '+':
> +		ce->ce_mode |= 0111;
> +		break;
> +	case '-':
> +		ce->ce_mode &= ~0111;
> +		break;
> +	default:
> +		return -2;
> +	}
> +	cache_tree_invalidate_path(&the_index, ce->name);

... this one takes istate, so you need to use it, instead of the
hard-coded the_index reference.

> +	ce->ce_flags |= CE_UPDATE_IN_BASE;
> +	istate->cache_changed |= CE_ENTRY_CHANGED;
> +
> +	return 0;
> +}
> +
>  int ce_same_name(const struct cache_entry *a, const struct cache_entry *b)
>  {
>  	int len = ce_namelen(a);

Other than that, this looks good to me.
