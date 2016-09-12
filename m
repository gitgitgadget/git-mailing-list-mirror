Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C24ED207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 17:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932856AbcILRSk (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 13:18:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64401 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754664AbcILRSh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 13:18:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 26CFC3D45A;
        Mon, 12 Sep 2016 13:18:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BCkd2QD4hYhFsy27bB8/UCxhAdo=; b=P2woUK
        Hm4Wsdn2ztnEk8I2wpcjQ2ZewAtv6URqlJoxK217zAaFze1o3wVpXT7jFBH39KNK
        uc+5xC8t6PgoUfYyusCT7IylzKClrimHabJOmYsjWjPbkelR0KjQ8nDejj9kcyqx
        ymkkCzW402KeUFOmVtfe5bz0p1hksOvrLFIkc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yI3L1ppvBiRCV1kzCjqDOAooW7CMKjeu
        Eiluct/ILIBMjXeMLuES1SofPAZqKWJWY4JJWbGLj3hoPLMyvAIChMRUFZz7gyiY
        UW8KKmHoXoNqjC52MESzb9Lz6B+FdixBss/YdVnyyyKSXODOOF9mb4gePR3lPWPN
        AFoVmR3pyYA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F7BE3D458;
        Mon, 12 Sep 2016 13:18:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8DACC3D457;
        Mon, 12 Sep 2016 13:18:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Kevin Willford <kewillf@microsoft.com>,
        Xiaolong Ye <xiaolong.ye@intel.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH v3 0/2] patch-id for merges
References: <20160907075346.z6wtmqnfc6bsunjb@sigill.intra.peff.net>
        <20160907220101.hwwutkiagfottbdd@sigill.intra.peff.net>
        <20160909203406.5j5pmom442yoe4su@sigill.intra.peff.net>
        <xmqqfup8aiud.fsf@gitster.mtv.corp.google.com>
        <20160912155930.2acw4265nfjq3uyj@sigill.intra.peff.net>
Date:   Mon, 12 Sep 2016 10:18:33 -0700
In-Reply-To: <20160912155930.2acw4265nfjq3uyj@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 12 Sep 2016 11:59:31 -0400")
Message-ID: <xmqq37l53ul2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F0203AC4-790C-11E6-B0B6-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> That looks like the patch below (as a replacement for patch 2), which is
> even less invasive. It also performs a little better on my example case,
> because we avoid adding merges to the hashmap entirely.

After reading it, I did not find [v3 2/2] is too bad either, but
this is even better ;-)

> diff --git a/patch-ids.c b/patch-ids.c
> index 77e4663..5d2d96a 100644
> --- a/patch-ids.c
> +++ b/patch-ids.c
> @@ -7,10 +7,12 @@
>  int commit_patch_id(struct commit *commit, struct diff_options *options,
>  		    unsigned char *sha1, int diff_header_only)
>  {
> -	if (commit->parents)
> +	if (commit->parents) {
> +		if (commit->parents->next)
> +			return -1;
>  		diff_tree_sha1(commit->parents->item->object.oid.hash,
>  			       commit->object.oid.hash, "", options);
> -	else
> +	} else
>  		diff_root_tree_sha1(commit->object.oid.hash, "", options);

This looks familiar ;-)

> @@ -72,11 +74,20 @@ static int init_patch_id_entry(struct patch_id *patch,
>  	return 0;
>  }
>  
> +static int patch_id_defined(struct commit *commit)
> +{
> +	/* must be 0 or 1 parents */
> +	return !commit->parents || !commit->parents->next;
> +}

If we make the first hunk begin like so:

> +	if (commit->parents) {
> +		if (!patch_id_defined(commit))
> +			return -1;

I wonder if the compiler gives us the same code.

>  struct patch_id *has_commit_patch_id(struct commit *commit,
>  				     struct patch_ids *ids)
>  {
>  	struct patch_id patch;
>  
> +	if (!patch_id_defined(commit))
> +		return NULL;
> +
>  	memset(&patch, 0, sizeof(patch));
>  	if (init_patch_id_entry(&patch, commit, ids))
>  		return NULL;
> @@ -89,6 +100,9 @@ struct patch_id *add_commit_patch_id(struct commit *commit,
>  {
>  	struct patch_id *key = xcalloc(1, sizeof(*key));
>  
> +	if (!patch_id_defined(commit))
> +		return NULL;
> +
>  	if (init_patch_id_entry(key, commit, ids)) {
>  		free(key);
>  		return NULL;

Yup, these two hunks look a lot nicer.

> I'd probably do a preparatory patch to drop the return value from
> add_commit_patch_id(). No callers actually look at it.

Thanks.
