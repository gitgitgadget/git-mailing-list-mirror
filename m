Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56B65207BD
	for <e@80x24.org>; Wed, 19 Apr 2017 03:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759419AbdDSDtO (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 23:49:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63105 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1759404AbdDSDtN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 23:49:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 428308294A;
        Tue, 18 Apr 2017 23:49:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=za7AcpZNGkGQ5K7BHCMqFGdctW4=; b=aQFMi2
        Fl37U/SWjRRwhDIAeUcwEtafkJbrEqTyJ18sZoL+7ahM9fKIpNij2V0b1SzUp7ta
        b5R0WEu+urKO5WmvLvBXxFupUFq6uJ3bK7GWs5b7fPWn4gwAly44mXpIvJLWhpQT
        bSGgx7beybQd5A4QsKgU8Je/XCsxZ4Nzb1sI8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SHaKsj8IvO6xtt9a+aS+o/wMyQyIz5jS
        TEvxe+VbTlVt/oRyM+sW4EOb+wmR1RJOuH+wD0WriQNoqlDqfbbu2FVkJZ4Q9sce
        3/PbX5uBOmvP/lfXM2zcWsx3MDYuodxBkXIVYowByzABz1yBzoO59PERDxz1Cmac
        0WYwBSwUg4E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3AE0782949;
        Tue, 18 Apr 2017 23:49:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9F7BF82947;
        Tue, 18 Apr 2017 23:49:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <David.Turner@twosigma.com>
Cc:     =?utf-8?Q?'Ren=C3=A9?= Scharfe' <l.s.r@web.de>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "peff\@peff.net" <peff@peff.net>,
        "jrnieder\@gmail.com" <jrnieder@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] xgethostname: handle long hostnames
References: <20170417161748.31231-1-dturner@twosigma.com>
        <xmqq1ssqikc5.fsf@gitster.mtv.corp.google.com>
        <xmqqwpaih4q2.fsf@gitster.mtv.corp.google.com>
        <281d0843-d48a-b7ab-737b-b9528689d44e@web.de>
        <e1f3ca5df4484496a2e0ab601a940ecb@exmbdft7.ad.twosigma.com>
Date:   Tue, 18 Apr 2017 20:49:10 -0700
In-Reply-To: <e1f3ca5df4484496a2e0ab601a940ecb@exmbdft7.ad.twosigma.com>
        (David Turner's message of "Tue, 18 Apr 2017 17:52:40 +0000")
Message-ID: <xmqqk26hawg9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 263295F6-24B3-11E7-984C-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <David.Turner@twosigma.com> writes:

> If the writer has the smaller HOST_NAME_MAX, this will work fine.  If the reader
> has the smaller HOST_NAME_MAX, and the writer's actual value is too long,
> then there's no way the strcmp would succeed anyway.  So I don't think we need
> to worry about it.

Hmph, I have to agree with that reasoning, only because the value we
read into locking_host[] is not used for error reporting at all.  I
would have insisted to read what is on the filesystem anyway if that
were not the case.

Thanks.
