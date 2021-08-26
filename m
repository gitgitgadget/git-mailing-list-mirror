Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76877C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 20:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DACE6101C
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 20:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243510AbhHZUqt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 16:46:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54331 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbhHZUqs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 16:46:48 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB030D5407;
        Thu, 26 Aug 2021 16:45:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kaB7ps3ggFVS3bhuXAneQ+ht6nF+ChoVUp6qPG
        Midm8=; b=DSrBgroSh527fEnFFuGibD7X02L9/8yVxLjF1GA+UlOr+R94iGpYty
        xM/ms6eCPp06qyblcLCfDv/8TcY11iYM2IBdpj2dic/V0cAJEbJCbHRlNza3Te5T
        vYygEKeggvnkAwjM3ape9p3nBHwiIBlq2NRNjh6HBIJriy2MNwKuo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C410DD5405;
        Thu, 26 Aug 2021 16:45:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0D3EBD5404;
        Thu, 26 Aug 2021 16:45:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, jonathantanmy@google.com
Subject: Re: [PATCH v5 02/14] Add new parameter "carry_data" for
 "show_object" function
References: <cover.1629805395.git.dyroneteng@gmail.com>
        <bc8fea97e34b3ccb4b62bb4d48dac6e1c009236c.1629805396.git.dyroneteng@gmail.com>
Date:   Thu, 26 Aug 2021 13:45:58 -0700
In-Reply-To: <bc8fea97e34b3ccb4b62bb4d48dac6e1c009236c.1629805396.git.dyroneteng@gmail.com>
        (Teng Long's message of "Wed, 25 Aug 2021 10:21:46 +0800")
Message-ID: <xmqqlf4oc4u1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9E3FDC8E-06AE-11EC-AF6A-D601C7D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> Subject: Re: [PATCH v5 02/14] Add new parameter "carry_data" for "show_object" function

Since this lacks <area>: prefix, "git shortlog" readers will have a
hard time guessing which show_object() function this commit is
about.

> During the pack-objects process, "show_object" function will be called
> to find the object and show the process("show_object_fn" in
> "list-object.h"), the function definition contains three parameters:
>
> 	1. struct object *obj(contains object type, flags, and oid).
> 	2. const char *name(the object name).
> 	3. void *show_data(function to show progress info).
>
> This commit adds a new parameter: "void *carry_data", the reason is
> mainly based on scalability and performance considerations when showing
> an object, space for time, avoid costly temporary calculations in the
> "show" phase. For example, carry the ownership relationship between
> blob or tree object and the referred commit to avoid redundant and
> expensive calculations.

The above explains what we want to carry around extra data for
(i.e. compute something in one place, and use it later somewhere
else)

But it does not quite explain why we need another parameter to do
so, which involves changing the function signature of many
functions, instead of making show_data to point at a new structure
type that holds the original data show_data used to carry plus
another single void * member (or the set of members you'd be
carrying into these functions using this new parameter).

I also find "carry_data" a meaningless name for the parameter.  All
in-parameters into functions are used to carry some data into it
after all.  The existing "show_data" at least makes a bit more
sense; it contains data necessary for showing the object in these
code paths.  If the purpose this new thing was introduced is to
cache ownership relationship data, perhaps ownership_cache would be
a more descriptive and understandable name (be it a new parameter to
added to many functions, or a member to the new structure that
replaces show_data).

Thanks.
