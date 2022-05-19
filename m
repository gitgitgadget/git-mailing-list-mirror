Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829E3C433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 20:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244591AbiESUFn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 16:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244588AbiESUFl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 16:05:41 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B8B712C7
        for <git@vger.kernel.org>; Thu, 19 May 2022 13:05:39 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DA98C116F01;
        Thu, 19 May 2022 16:05:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=P3xYkQNM+onVpEqsSI+yDKNHn7DZEq6hrAsSk1
        CkJFw=; b=lg7FybGV3fNDNg43LTr8Wl5220oBmjNgN0StAJS4uoLxQlBMm3zltr
        0Em8LWsJArKSA3GyiZcxYQhRUvyp5sNOf5/IQI9Ioha7bTYO76Libf6064cjQAxD
        SnYAvXx1MnO3YMOG5usFaVk7qbj5zywUJIWs/4kNkqBYN5/zI6S6A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CED9F116F00;
        Thu, 19 May 2022 16:05:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 29F50116EFF;
        Thu, 19 May 2022 16:05:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 04/10] sparse-index: introduce partially-sparse indexes
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
        <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
        <269c206c331bb43006678beaa20832a75754c3df.1652982758.git.gitgitgadget@gmail.com>
Date:   Thu, 19 May 2022 13:05:36 -0700
In-Reply-To: <269c206c331bb43006678beaa20832a75754c3df.1652982758.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 19 May 2022
        17:52:32 +0000")
Message-ID: <xmqqleuxmgof.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D2CDDDC-D7AF-11EC-BE48-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +enum sparse_index_mode {
> +	/*
> +	 * COMPLETELY_FULL: there are no sparse directories
> +	 * in the index at all.
> +	 */
> +	COMPLETELY_FULL = 0,

Two things that make me wonder are:

 * Do concrete values assigned to these symbols matter?  If we do

	if (some_function_that_returns_this_type())
		/* ok, we know it is full */
		do_full_thing();

   then the answer is yes.  If we write these values to on-disk
   file, and other versions and reimplementations of Git need to
   know the concrete values, then the answer is yes.  Otherwise, we
   may not want to say "= 0" and the like here.

 * Is it worth repeating the label in the comment?  IOW, I am
   wondering if

	/* there are no sparse directories in the index */
	COMPLETELY_FULL,

   is equally readable and slightly more maintainable.

Also these names being in cache.h and visible everywhere is somewhat
worrying.  Other CPP macros and enum constants in the file have
names that are prepared to be truly global, but COMPLETELY_FULL and
COLLAPSED do not hint that they are about sparse-index state as
strongly as PARTIALLY_SPARSE does.

> -		 /*
> -		  * sparse_index == 1 when sparse-directory
> -		  * entries exist. Requires sparse-checkout
> -		  * in cone mode.
> -		  */
> -		 sparse_index : 1;
> +		 fsmonitor_has_run_once : 1;
> +	enum sparse_index_mode sparse_index;

Good that we can lose the comment on a single bit.  Are some of the
enum sparse_index_mode values only possible in cone mode, just like
having true in this bit was only possible in cone mode?  Perhaps a
comment before "enum sparse_index_mode {" can say "in non-cone mode,
COMPLETELY_FULL is the only possible value" or somesuch?

Thanks.
