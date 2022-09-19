Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCE6ECAAD8
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 01:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiISBNo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Sep 2022 21:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiISBNm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Sep 2022 21:13:42 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCEE183AC
        for <git@vger.kernel.org>; Sun, 18 Sep 2022 18:13:41 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6B2C81CA1BC;
        Sun, 18 Sep 2022 21:13:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Dt+DZPTjrEQS7JgWyf0+FpvttbL1OmlpLUiUb2
        Dqz7M=; b=l1BqHHtDu4/rXCYAMMbMdNDLggBGV2xFq+a19No2upFUg8bzsbcGOz
        VldLkRACwrP/evkXxHJBvITcSAr5uhAQq5jE3EvHfi2Oiqnfq95GdVXiAy/Fp36H
        XErpUuaI71UhZXtNBtIN7c96RZxeYR/iPeEH50NhPq/RZQ+8wDrAY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 619111CA1BB;
        Sun, 18 Sep 2022 21:13:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 491D91CA1B8;
        Sun, 18 Sep 2022 21:13:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, rsbecker@nexbridge.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] diagnose.c: refactor to safely use 'd_type'
References: <pull.1354.git.1663438615413.gitgitgadget@gmail.com>
Date:   Sun, 18 Sep 2022 18:13:34 -0700
In-Reply-To: <pull.1354.git.1663438615413.gitgitgadget@gmail.com> (Victoria
        Dye via GitGitGadget's message of "Sat, 17 Sep 2022 18:16:55 +0000")
Message-ID: <xmqqczbsdv41.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48CB1354-37B8-11ED-9927-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
>
> Refactor usage of the 'd_type' property of 'struct dirent' in 'diagnose.c'
> to instead utilize the compatibility macro 'DTYPE()'. On systems where
> 'd_type' is not present in 'struct dirent', this macro will always return
> 'DT_UNKNOWN'. In that case, instead fall back on using the 'stat.st_mode' to
> determine whether the dirent points to a dir, file, or link.
>
> Additionally, add a test to 't0092-diagnose.sh' to verify that files (e.g.,
> loose objects) are counted properly.
>
> Note that the new function 'get_dtype()' is based on 'resolve_dtype()' in
> 'dir.c' (which itself was refactored from a prior 'get_dtype()' in
> ad6f2157f9 (dir: restructure in a way to avoid passing around a struct
> dirent, 2020-01-16)), but differs in that it is meant for use on arbitrary
> files, such as those inside the '.git' dir. Because of this, it does not
> search the index for a matching entry to derive the 'd_type'.
>
> Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---

Beautiful.  Use of DTYPE() macro that already hides the platform
specifics, and get_dtype() implementation that calls lstat() lazily,
are exactly the solution I was expecting to see.

Nicely done.  Will queue.  Thanks.
