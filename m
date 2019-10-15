Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 111A61F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 01:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfJOBfl (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 21:35:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54709 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfJOBfk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 21:35:40 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E8F425955;
        Mon, 14 Oct 2019 21:35:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MmxDHgFNf1GgxCuMuXw70Joi4xk=; b=oD8eQc
        oIdqIY8Mnx7BfuCmRJmK/4SGCtI/Qg42clq33+p5yABUhwQfkLhx9ijJn1Guy9H4
        kbD3U9gjdAkUSRxSP1B39tP+U8H2pwqWVcTr2/lGLVBgwhLaIhTcmADFvdbCEKZ0
        kWaxPNfr6N5lkDhHxGZEgzK6wCPomCef2Gq44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gePmEWtdbvwWnqdoV77+BWSkNXVjPKuS
        N0HOyiydzyQW5bSLPOzosWMUPjPszaKggVuJ5yl2szo/hDcr+4DMZVzUt0ssWjCl
        2YAHl6PvO7L9Riib0ucVxgOEjPV+vJiF+Wr9StCdwj5SQP3t5sNG6+KNcp+QNROX
        IHzA6L5B0YQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 95EBE25952;
        Mon, 14 Oct 2019 21:35:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 089E825951;
        Mon, 14 Oct 2019 21:35:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakob Jarmar <jakob.j@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4] stash: avoid recursive hard reset on submodules
References: <CA+xNDHtVc7pJr=SdihKDKiLE9TE_TcpEWWmPq+N9+fFcfM36wA@mail.gmail.com>
        <20191011001114.GB640501@OJAN-PAAVO.localdomain>
        <xmqqeezjhlad.fsf@gitster-ct.c.googlers.com>
        <20191011222448.GA650182@OJAN-PAAVO.localdomain>
        <xmqqsgnyenwj.fsf@gitster-ct.c.googlers.com>
        <20191012153829.GB743557@OJAN-PAAVO.localdomain>
Date:   Tue, 15 Oct 2019 10:35:37 +0900
In-Reply-To: <20191012153829.GB743557@OJAN-PAAVO.localdomain> (Jakob Jarmar's
        message of "Sat, 12 Oct 2019 17:38:29 +0200")
Message-ID: <xmqqy2xmdc46.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 17342398-EEEC-11E9-B546-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakob Jarmar <jakob.j@gmail.com> writes:

> git stash push does not recursively stash submodules, but if
> submodule.recurse is set, it may recursively reset --hard them. Having
> only the destructive action recurse is likely to be surprising
> behaviour, and unlikely to be desirable, so the easiest fix should be to
> ensure that the call to git reset --hard never recurses into submodules.
>
> This matches the behavior of check_changes_tracked_files, which ignores
> submodules.
>
> Signed-off-by: Jakob Jarmar <jakob@jarmar.se>
> ---
>
> Notes:
>     1. Added space between function name and parentheses
>     2. Moved test_when_finished cleanup to top of setup_basic

Looks good; will queue.

Thanks.
