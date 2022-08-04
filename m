Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A318C19F2A
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 17:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbiHDRlD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 13:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbiHDRlB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 13:41:01 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B312316D
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 10:41:00 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1310C13E378;
        Thu,  4 Aug 2022 13:40:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TgchzaD9yze3XEfK2J2eF0PD00deLxz0bxUMg4
        NK7Qg=; b=HnqhqIlWtnOhJbwQUmLNAPOSPTpL3FRXE8Q1MCrOG+b1WL7X0JvpOp
        HubbftGkOBVp4B9cIaFzdm0Pn7iktajCmzGCn81/cf+bmC6uHEh/jjs5JHUA7dKf
        NNhJ7y5iIuJiEePVBKAY8Lvbcg6p28uTg9fIsCWE/MKKBd6hMwbJM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0693413E377;
        Thu,  4 Aug 2022 13:40:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3793713E376;
        Thu,  4 Aug 2022 13:40:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 05/10] log-tree: use ref_namespaces instead of
 if/else-if
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
        <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
        <53b15a0b7932f892505d07a509909b62c473037e.1659122979.git.gitgitgadget@gmail.com>
        <xmqqv8r9dei7.fsf@gitster.g>
        <b4f07dd1-b59d-864b-f881-110c9bf87202@github.com>
        <2d24b539-a5b8-ed7d-2320-97588854eb5b@github.com>
        <96cf691b-5190-5ba7-d612-e8473055c45c@github.com>
Date:   Thu, 04 Aug 2022 10:40:57 -0700
In-Reply-To: <96cf691b-5190-5ba7-d612-e8473055c45c@github.com> (Derrick
        Stolee's message of "Thu, 4 Aug 2022 10:50:57 -0400")
Message-ID: <xmqq8ro36h5i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 995544E4-141C-11ED-A4C3-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> My current workaround is to define the size of the array in the
> header file:
>
> ---
>
> enum ref_namespace {
> 	NAMESPACE_HEAD,
> 	NAMESPACE_BRANCHES,
> 	NAMESPACE_TAGS,
> 	NAMESPACE_REMOTE_REFS,
> 	NAMESPACE_STASH,
> 	NAMESPACE_REPLACE,
> 	NAMESPACE_NOTES,
> 	NAMESPACE_PREFETCH,
> 	NAMESPACE_REWRITTEN,
>
> 	/* Must be last */
> 	NAMESPACE__COUNT
> };
>
> /* See refs.c for the contents of this array. */
> extern struct ref_namespace_info ref_namespaces[NAMESPACE__COUNT];

Because there is no reason why we want to keep the size of the array
opaque in this particular case, it may even be preferrable over the
original ref_namespace[] array of unspecified size.  Nice.

BTW, I prefer to name my arrays with a singular noun, when the
predominant use of it in the code that is an API customer is to name
an individual element and use it.

In this case, many API users do things like

   ref_namespace[NAMESPACE_NOTES}.ref = ...;

so a singular name would be more appropriate.  thing[4] that means
the fourth thing feels more intuitive than things[4], at least to
me.

On the other hand, when API customers mostly pass the whole thing
around as an almost opaque collection to the API function, then a
plural name is more appropriate.  The reason why I focus on API
customers is because API implementation of course has to go in to
each individual element of the array and work on it at some level,
and "individual access means singular name" rule would become non
workable.  The names are mostly to help API customers, so if an
array is perceived by them as mostly a collection of things, then
naming it in plural would make it more natural.
