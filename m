Return-Path: <SRS0=BQqG=A5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3588AC433E0
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 00:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8F8620691
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 00:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FZiHU0Pg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgGRAHZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 20:07:25 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51906 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgGRAHY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 20:07:24 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E0EBAC8F61;
        Fri, 17 Jul 2020 20:07:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RSjcUYe8iaHv2D4dx5i+OAJaeg0=; b=FZiHU0
        Pg6Fjf6FvmrMFz54yHKKvpQsLH8kXxsjo9FusyX94JTUa4Mw74wMVbY2B44buxMd
        I1QbnPOFW0/R7SjR+ndeYNAemLXaeEaXODQvQNIquFxhSTUZDrRPfnx0jdM9zho7
        i2I2tTiE6j85nqL3j6pr9YbFnW143B+jfQpxY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=n0YG2zPxEq1x35dJn4zrpPZG5pIWNclA
        jXhsBIfhqvaFDn10t7xka2KXlAW+p04tTiHe7Va9wcs/kIjld1MryzEh/UHol+r6
        0Baclx45Y/H38dq4+V1gjpWGDUtA8+EkWl+GMrL+/8Ky5a0/LUfxG+s9OVtVRjmn
        xlmRGtuCCEs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C5170C8F60;
        Fri, 17 Jul 2020 20:07:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7B44CC8F5F;
        Fri, 17 Jul 2020 20:07:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Chris Torek via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH] git-mv: improve error message for conflicted file
References: <pull.678.git.1595028293855.gitgitgadget@gmail.com>
Date:   Fri, 17 Jul 2020 17:07:17 -0700
In-Reply-To: <pull.678.git.1595028293855.gitgitgadget@gmail.com> (Chris Torek
        via GitGitGadget's message of "Fri, 17 Jul 2020 23:24:53 +0000")
Message-ID: <xmqqeep9d6tm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5756E14-C88A-11EA-9365-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Chris Torek via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -		} else if (cache_name_pos(src, length) < 0)
> -			bad = _("not under version control");
> -		else if (lstat(dst, &st) == 0 &&
> +		} else if (cache_name_pos(src, length) < 0) {
> +			/*
> +			 * This occurs for both untracked files *and*
> +			 * files that are in merge-conflict state, so
> +			 * let's distinguish between those two.
> +			 */
> +			struct cache_entry *ce = cache_file_exists(src, length, ignore_case);
> +			if (ce == NULL)
> +				bad = _("not under version control");
> +			else
> +				bad = _("must resolve merge conflict first");


The original did not care about the cache entry itself, and that is
why cache_name_pos() was used.  Now you care what cache entry is at
that position, running both calls is quite wasteful.

Would it work better to declare "struct cache_entry *ce" in the
scope that surrounds this if/elseif cascade and then rewrite this
part more like so:

	} else if (!(ce = cache_file_exists(...)) {
		bad = _("not tracked");
	} else if (ce_stage(ce)) {
        	bad = _("conflicted");
	} else if (lstat(...)) { ...

