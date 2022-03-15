Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2161EC433EF
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 19:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239127AbiCOTHI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 15:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351438AbiCOTHC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 15:07:02 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A52E26AE1
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 12:05:23 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 08BF418653E;
        Tue, 15 Mar 2022 15:05:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uAQJ8UE6/csz0mCmr2IwdTRZrfplOO40gS/tTV
        bSdhw=; b=FA0Df+kETLXUuMzo2shXseHZjsnf9T6pUIoYMnnRkxqA0EuXZtTYcq
        Z62HcV1u42BKrllE1UC0x4jXm3wqBhC6nRDfbVKlZ/sK3EnRud6fEFOVipSfGSfH
        iRXem5bjUUtEfvMrbto9lUiXIUrTJ4s6gnhFF+BfGpBOQvCh6W/+c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0088318653D;
        Tue, 15 Mar 2022 15:05:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6D2CD18653C;
        Tue, 15 Mar 2022 15:05:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     "'Phillip Wood'" <phillip.wood123@gmail.com>,
        "'Git Mailing List'" <git@vger.kernel.org>,
        "'Phillip Wood'" <phillip.wood@dunelm.org.uk>,
        =?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?= 
        <avarab@gmail.com>, "'Carlo Arenas'" <carenas@gmail.com>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "'Ramsay Jones'" <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3 2/4] terminal: don't assume stdin is /dev/tty
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
        <20220315105723.19398-1-phillip.wood123@gmail.com>
        <20220315105723.19398-3-phillip.wood123@gmail.com>
        <xmqqzglrdsd8.fsf@gitster.g>
        <02fd01d83896$c0261240$407236c0$@nexbridge.com>
Date:   Tue, 15 Mar 2022 12:05:19 -0700
In-Reply-To: <02fd01d83896$c0261240$407236c0$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Tue, 15 Mar 2022 14:01:46
        -0400")
Message-ID: <xmqqilsfdok0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DBFD44E4-A492-11EC-AAE3-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

>>The check before closing it is wrong.  It should be
>>
>>	if (0 <= term_fd)
>
> Should this expression succeed if term_fd == stdin? I might be missing the point here.

We could use "if (0 < term_fd)" to make this guard both about
avoiding to call close() on an uninitialized FD and also about
avoiding to close standard input.  I'd prefer to see them handled
separately as these live at different conceptual levels
(i.e. closing -1 is a no-no no matter what, closing 0 is bad if it
is what we did not open but what the caller supplied us via the
SAVE_TERM_STDIN bit, but it may be warranted if it was what we
obtained from an earlier call to open("/dev/tty") we did ourselves).



