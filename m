Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02D7C433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 18:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbiCIStG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 13:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbiCIStF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 13:49:05 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D2DC73
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 10:48:06 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 26A8C10BD2D;
        Wed,  9 Mar 2022 13:48:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wsGHjkxcutKO4V0GPBU0fcD01Bv6Lf0f+JOoeU
        h7O9c=; b=xO51o1PT5BD2c+SDA1fiV09BSlbB7GU4d69TnpAiq0f4dEYo43p6zn
        oDcCyZetzwcsbiHcRpJnCYD2OOr81ViglYFP3I4fx4kI8V5TI+Js3Wnr4i9oiRXa
        H8YBjm80XxPwL8Io4mBNMslj0mPAFf7lsvEiQjn5tJ7/TlGovrFL8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1A0D910BD2C;
        Wed,  9 Mar 2022 13:48:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6150E10BD2B;
        Wed,  9 Mar 2022 13:48:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v4 03/13] revision: put object filter into struct rev_info
References: <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
        <pull.1159.v4.git.1646841703.gitgitgadget@gmail.com>
        <4ac09ddbfaa3f8aad2b77c7b250f6953a3ff9f24.1646841703.git.gitgitgadget@gmail.com>
Date:   Wed, 09 Mar 2022 10:48:03 -0800
In-Reply-To: <4ac09ddbfaa3f8aad2b77c7b250f6953a3ff9f24.1646841703.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 09 Mar 2022
        16:01:33 +0000")
Message-ID: <xmqqsfrrklng.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73FF7B2C-9FD9-11EC-A77E-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/revision.h b/revision.h
> index 3c58c18c63a..b1669a8cc33 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -8,6 +8,7 @@
>  #include "pretty.h"
>  #include "diff.h"
>  #include "commit-slab-decl.h"
> +#include "list-objects-filter-options.h"
>  
>  /**
>   * The revision walking API offers functions to build a list of revisions
> @@ -94,6 +95,12 @@ struct rev_info {
>  	/* The end-points specified by the end user */
>  	struct rev_cmdline_info cmdline;
>  
> +	/*
> +	 * Object filter options. No filtering is specified
> +	 * if and only if filter.choice is zero.
> +	 */
> +	struct list_objects_filter_options filter;

I wondered if s/zero/LOFC_DISABLED/ would make it more helpful, but
seeing changes like the one i the later "parse filter capability"
step, which can just become

-	if (header->filter.choice != LOFC_DISABLED) {
+	if (header->filter.choice) {
		... do things ...

relative to the previous round, I think what is in the posted patch
indeed is a better way to help developers.

