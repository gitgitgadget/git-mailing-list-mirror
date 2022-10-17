Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A33C433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 18:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiJQSvm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 14:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiJQSvk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 14:51:40 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AC76C978
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 11:51:39 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 672361B2A4A;
        Mon, 17 Oct 2022 14:51:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IJXymFTuteKpLkBA6IITpVwPToCwBnbQ0ZmyDi
        fc644=; b=AnL1D0PjGcdjO1H/TM5Ch19CYIy4j3vq9ft1yd0q7hCiqymy3pKZ9n
        bBSOcM145lnHNwnGpvO0F2vcRx10IXUg9TnNuzw7wL/zjRI60tLNBkkcJTMPlrzi
        jWFo3F25R5gfy7hLPQilZMixZM+SS4fD8nDUPHOEbvK+7BlOabFJE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5F0F71B2A49;
        Mon, 17 Oct 2022 14:51:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 17A4F1B2A47;
        Mon, 17 Oct 2022 14:51:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 3/8] rebase: be stricter when reading state files
 containing oids
References: <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
        <pull.1323.v4.git.1666012665.gitgitgadget@gmail.com>
        <1d5e0419c45087c474f33d5ea6b3bcdacd072fa5.1666012665.git.gitgitgadget@gmail.com>
Date:   Mon, 17 Oct 2022 11:51:35 -0700
In-Reply-To: <1d5e0419c45087c474f33d5ea6b3bcdacd072fa5.1666012665.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Mon, 17 Oct 2022 13:17:40
        +0000")
Message-ID: <xmqqtu42z3k8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B9DDD996-4E4C-11ED-BBEC-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/commit.c b/commit.c
> index 0db461f9735..de30b098dd3 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -59,6 +59,14 @@ struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref
>  	return c;
>  }
>  
> +struct commit *lookup_commit_object (struct repository *r,
> +				     const struct object_id *oid)

Let's lose the SP before opening parenthesis (I'll do that while
queuing unless I forget ;-).

> +{
> +	struct object *obj = parse_object(r, oid);
> +	return obj ? object_as_type(obj, OBJ_COMMIT, 0) : NULL;
> +
> +}
> +
>  struct commit *lookup_commit(struct repository *r, const struct object_id *oid)
>  {
>  	struct object *obj = lookup_object(r, oid);
> diff --git a/commit.h b/commit.h
> index 21e4d25ce78..fa39202fa6b 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -64,6 +64,19 @@ enum decoration_type {
>  void add_name_decoration(enum decoration_type type, const char *name, struct object *obj);
>  const struct name_decoration *get_name_decoration(const struct object *obj);
>  
> +/*
> + * Look up commit named by "oid" respecting replacement objects.
> + * Returns NULL if "oid" is not a commit or does not exist.
> + */
> +struct commit *lookup_commit_object(struct repository *r, const struct object_id *oid);
> +
> +/*
> + * Look up commit named by "oid" without replacement objects or
> + * checking for object existence. Returns the requested commit if it
> + * is found in the object cache, NULL if "oid" is in the object cache
> + * but is not a commit and a newly allocated unparsed commit object if
> + * "oid" is not in the object cache.
> + */
>  struct commit *lookup_commit(struct repository *r, const struct object_id *oid);

I was going to ask documenting the differences of the two API
functions, which is done here.  Good.

>  struct commit *lookup_commit_reference(struct repository *r,
>  				       const struct object_id *oid);
