Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668ABC433FE
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 17:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348542AbiCHRaB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 12:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiCHRaA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 12:30:00 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CB854BE0
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 09:29:04 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D42A516B066;
        Tue,  8 Mar 2022 12:29:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Aj8I9Fq/ANVkFjZwnoVdl1vrpS6GGn/V7NgPex
        Jqadg=; b=hx5NAwcNBACHhH37LSeOfWKIf7hbFLI/fOiPda5VTQy3yZE+3379Co
        tCnB45nvKS+ykLcOiWgJxTmVM3lLtP9rwNenLFJtjRasn4c/A0NI0OGhlK2BnFj1
        s8NJr2/C/+G4YrPDi0L4/6EklBrU5DsY/Gg1TiIAzfLCyYPIFq1RM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CC34216B065;
        Tue,  8 Mar 2022 12:29:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5190216B063;
        Tue,  8 Mar 2022 12:29:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 08/12] bundle: parse filter capability
References: <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
        <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
        <025f38290f5a705c80854a42e1abcaba9a9f336d.1646750359.git.gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 09:29:00 -0800
In-Reply-To: <025f38290f5a705c80854a42e1abcaba9a9f336d.1646750359.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 08 Mar 2022
        14:39:15 +0000")
Message-ID: <xmqq4k48nyjn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E7AB680-9F05-11EC-B9B0-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/bundle.h b/bundle.h
> index 06009fe6b1f..7fef2108f43 100644
> --- a/bundle.h
> +++ b/bundle.h
> @@ -4,12 +4,14 @@
>  #include "strvec.h"
>  #include "cache.h"
>  #include "string-list.h"
> +#include "list-objects-filter-options.h"
>  
>  struct bundle_header {
>  	unsigned version;
>  	struct string_list prerequisites;
>  	struct string_list references;
>  	const struct git_hash_algo *hash_algo;
> +	struct list_objects_filter_options filter;
>  };

This used to be a pointer to the struct, with "NULL means do not
filter" semantics, with .nr==0 as BUG().  Which was the same
justification used when an earlier step added a pointer to the
filter struct to rev_info.

Should the same logic applies there to make it into an embedded
struct in rev_info as well?
