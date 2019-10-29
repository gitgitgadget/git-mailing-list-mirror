Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4A401F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 16:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390630AbfJ2Qou (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 12:44:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54562 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390625AbfJ2Qou (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 12:44:50 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B685536FB4;
        Tue, 29 Oct 2019 12:44:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ygPdjY70t+dIjhakOzkjPRX/m0E=; b=ZxD2/U
        JQi59WVghtVcQ+UPc5m9cn+1DcV/9rwbSxdp1Ax3GeNJ4M5kRddEd88IDnGT7Fag
        RdZxrlu7KYgUgg0FMNXSbW+NKfo8zmipetV9WCSS9coR6D/F3/Nn7VEhfS9PpMJk
        oznAOl7K63Y83DgA7zjHfVehKno6L9MTah1ac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BJEwiHAAIPBdZ5cG9aj/Nuqxj5SwM5QB
        P5DiBQsbKHTTleuNsHZED3yAA50/aPq2FKWAvcXb+XErkJ4+9/pK28WkET31kZ6Y
        mG7oTh5xGpD/ppcHiQlThAEAXdMxg8YHpxq8/+F6ipd1NtVCyZtNBRrGe+w093T8
        IOiKqxfB9Hk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AE38736FB3;
        Tue, 29 Oct 2019 12:44:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 13E3736FAD;
        Tue, 29 Oct 2019 12:44:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH 1/1] vreportf(): avoid buffered write in favor of unbuffered one
References: <pull.428.git.1572274859.gitgitgadget@gmail.com>
        <455026ce3ef2b2d7cfecfc4b4bf5b588eebddcfe.1572274859.git.gitgitgadget@gmail.com>
        <xmqqeeyw6xyr.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1910291222500.46@tvgsbejvaqbjf.bet>
        <20191029134932.GA2843@sigill.intra.peff.net>
Date:   Wed, 30 Oct 2019 01:44:48 +0900
In-Reply-To: <20191029134932.GA2843@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 29 Oct 2019 09:49:32 -0400")
Message-ID: <xmqqtv7r5wn3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6BF261D0-FA6B-11E9-8009-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Wow, they have truly taken "unbuffered" to a whole new level.
>
> I don't mind seeing this for all platforms, though. I can't think of any
> downside, and having one less moving part to contend with in our
> error-reporting code seems like a good thing.

FWIW, it was my mistake to sound as if I was unhappy to see this
done on all platforms.  As long as the end result is to reasonably
buffer, I do not mind us (as opposed to the system library we
sometimes cannot trust) being the one who implements the buffering.

I very much prefer to see the same code run everywhere than #ifdef
in this case.

> I'd recommend xsnprintf() here. If we have a prefix longer than our
> vreportf() buffer, I think a BUG() is the right outcome.
> ...
> I'd disagree here. Any caller sending an arbitrarily-large prefix is
> holding it wrong, and we'd probably want to know as soon as possible
> (and a BUG() is our best bet there).

Yes.  We are not using an unvetted input as the prefix here, if
somebody needs to use a larger prefix somewhere, that patch needs to
argue the pros-and-cons between making the buffer larger or
shortening that larger prefix.


