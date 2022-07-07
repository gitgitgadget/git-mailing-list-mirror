Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D653C43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 06:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbiGGGPM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 02:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGGGPK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 02:15:10 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E3924F3E
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 23:15:09 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ECF791AA79A;
        Thu,  7 Jul 2022 02:15:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rgN7wkPQuyxtBBENZ/v+6Z3QGfBHzppRMOTIsx
        ybTUk=; b=e2H8WMZILS9DBNrrxguKGHjST0II/uTId1MsrR4S4FlzdK8Mq50nOW
        zExOok1JXNteFEV6eFdOUA5xIGSPLbU2z5V1rBHAuCcHTH7Mu3rofArnzDnfwzlD
        LPiaReAikXQINKQmErcNUoIe91EPPygJEELr6UDpSGJR2KW/Jtctk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E517A1AA799;
        Thu,  7 Jul 2022 02:15:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 85D7D1AA798;
        Thu,  7 Jul 2022 02:15:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: t0301-credential-cache test failure on cygwin
References: <9dc3e85f-a532-6cff-de11-1dfb2e4bc6b6@ramsayjones.plus.com>
Date:   Wed, 06 Jul 2022 23:15:04 -0700
In-Reply-To: <9dc3e85f-a532-6cff-de11-1dfb2e4bc6b6@ramsayjones.plus.com>
        (Ramsay Jones's message of "Thu, 7 Jul 2022 02:50:21 +0100")
Message-ID: <xmqqtu7t30uv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 24DADE60-FDBC-11EC-9BC5-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> However, I had some time to kill tonight, so I decided to take a _quick_ look
> to see if there was something that could be done ... (famous last words).
> ...
>   diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
>   index 78c02ad531..84fd513c62 100644
>   --- a/builtin/credential-cache.c
>   +++ b/builtin/credential-cache.c
>   @@ -27,7 +27,7 @@ static int connection_fatally_broken(int error)
>    
>    static int connection_closed(int error)
>    {
>   -	return (error == ECONNRESET);
>   +	return (error == ECONNRESET) || (error == ECONNABORTED);
>    }

This feels like papering over the problem.

> Having noticed that the 'timeout' test was not failing, I decided to try
> making the 'action=exit' code-path behave more like the timeout code, as
> far as exiting the server is concerned. Indeed, you might ask why the
> timeout code doesn't just 'exit(0)' as well ...
>
> Anyway, the following patch does that, and it also provides a 'fix' for this
> issue!

If this codepath was written like this (i.e. [PATCH 1C]) from the
beginning, I would have found it very sensible (i.e. instead of
caling exit() in the middle of the infinite client serving loop,
exiting the loop cleanly is easier to follow and maintain), even if
we didn't know the issue on Cygwin you investigated.

