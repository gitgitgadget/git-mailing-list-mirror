Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0DE51F461
	for <e@80x24.org>; Tue,  3 Sep 2019 18:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbfICSKW (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 14:10:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57297 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbfICSKV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 14:10:21 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1725F179EE;
        Tue,  3 Sep 2019 14:10:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EtOHBPuoAMA/srZ+3aspKkwQq9Y=; b=d+HvPA
        9zbYOb+6NZaSDiNi4KMnUT9KvSW6ejb+roGS1SabYETyDAZfBYsTGwUF23eZ/8x3
        RuHufCcyyfaJ3TMVAJrkxLqQaJdbkPkKSZcoQzweY2l9/heBW6k51UFRBbfIkn8R
        G2K6VHcJ3oxKIKMoWb2r9dAxyVbuwEkR95ROs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RU1y2p24axr9QYXKQtSN2eA0T9y0OQeJ
        KXVfFlSPzGBADJ+kws8XUPJPCciJxvMZyIugS38c3IsqM4VJnRr6hmWqehD88bQP
        QU/55wBV9fzzsU2auj+cpuWK756uFkwprOlVX27W788WfWVBg5pAcbqR6o8ygSFv
        FLLVU6KSuCw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0EE74179ED;
        Tue,  3 Sep 2019 14:10:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 721CC179EC;
        Tue,  3 Sep 2019 14:10:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     phillip.wood@dunelm.org.uk,
        Matt R via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Matt R <mattr94@gmail.com>
Subject: Re: [PATCH 1/1] rebase -r: let `label` generate safer labels
References: <pull.327.git.gitgitgadget@gmail.com>
        <4a02c38442dd8a4c0381adc8db0dce81c253da09.1567432900.git.gitgitgadget@gmail.com>
        <444f3ec4-abdf-1aa9-e8a8-8b5346b939e8@gmail.com>
        <nycvar.QRO.7.76.6.1909022124350.46@tvgsbejvaqbjf.bet>
Date:   Tue, 03 Sep 2019 11:10:19 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1909022124350.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 2 Sep 2019 21:42:18 +0200 (CEST)")
Message-ID: <xmqqo901tfn8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 175B972A-CE76-11E9-9E84-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I'm sightly concerned that this opens the possibility for unexpected effects
>> if two different labels get sanitized to the same string. I suspect it's
>> unlikely to happen in practice but doing something like percent encoding
>> non-alphanumeric characters would avoid the problem entirely.
>
> Oh, but we make sure that the labels are unique, via the `label_oid()`
> function! Otherwise, we would not be able to label more than one merge
> parent ;-)

It somewhat feels suboptimal, from code followability's point of
view, to have this "pre-sanitization" to replace isspace() to a
dash, which is being extended to "all non-alnums", and the uniquefy
of labels in label_oid(), in two separate places.  I wonder if the
resulting code becomes easier to follow and harder to introduce new
bugs, if this part is made to just yield label.buf it obtained form
the log message as-is and leave the munging to label_oid()?

