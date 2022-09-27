Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028B9C6FA82
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 16:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbiI0Qwd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 12:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbiI0Qvk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 12:51:40 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D86AAA4EA
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 09:50:49 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0D5B31CD3DE;
        Tue, 27 Sep 2022 12:50:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5RfyGfGsOFS9a9CZVveY7HzspBy5LThI/RMqIg
        ypGHM=; b=fN4T9gDV1vmtLwr509H77RyuAlKC98pXoRDAC1AfDZODnS+s6rfHHP
        UFmSOMnTIXk3oUpjne8gIS1ozLlJWpkDkoLAdisRpHZjICixo7zYRDf78G8wDU5n
        7EN9KKe5J2IwVgIw3YVgD7tUEsBs3bQFmDfO1Mtrb4bZjsewyzxDc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 05F211CD3DD;
        Tue, 27 Sep 2022 12:50:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9E3D71CD3DC;
        Tue, 27 Sep 2022 12:50:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] tmp-objdir: do not opendir() when handling a signal
References: <pull.1348.git.git.1664236383785.gitgitgadget@gmail.com>
        <YzLiI1HZeBszsIJq@coredump.intra.peff.net>
Date:   Tue, 27 Sep 2022 09:50:42 -0700
In-Reply-To: <YzLiI1HZeBszsIJq@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 27 Sep 2022 07:44:35 -0400")
Message-ID: <xmqqedvw7od9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 86CEB91C-3E84-11ED-A59D-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So all of that makes me think we should not add a new flag here, but
> instead just avoid calling the function entirely from
> tmp_objdir_destroy_1().

Thanks.  I missed that undefined access to errno that breaks the
intention of the patch.

> But then we can observe that tmp_objdir_destroy_1() is basically doing
> nothing if on_signal is set. So there is really no point in setting up
> the signal handler at all. We should just set up the atexit() handler.
> I.e., something like:
>
> diff --git a/tmp-objdir.c b/tmp-objdir.c
> index a8be92bca1..10549e95db 100644
> --- a/tmp-objdir.c
> +++ b/tmp-objdir.c
> @@ -169,7 +169,6 @@ struct tmp_objdir *tmp_objdir_create(const char *prefix)
>  	the_tmp_objdir = t;
>  	if (!installed_handlers) {
>  		atexit(remove_tmp_objdir);
> -		sigchain_push_common(remove_tmp_objdir_on_signal);
>  		installed_handlers++;
>  	}
>  
>
> with the commit message explaining that we can't do the cleanup in a
> portable and signal-safe way, so we just punt on the whole concept.
>
> There's also some minor cleanup we could do elsewhere to drop the
> "on_signal" argument (which can come as part of the same patch, or on
> top).

;-)  I like the simplification.
