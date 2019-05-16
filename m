Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D03701F461
	for <e@80x24.org>; Thu, 16 May 2019 01:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfEPBun (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 21:50:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58889 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfEPBni (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 21:43:38 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E53EA145E8E;
        Wed, 15 May 2019 21:43:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yPEiFIbRSlvyHB3in5AdgZT4Q5g=; b=tj+Jww
        1MreJG5O8geArpZOoHdAWlWxsXGWlEQQvZ/dn/DDe1Jmrg1wRDkUzupMQZqLfnz/
        i6GNgmSy3gaxN77WKwExxbdznMWtCdSmih0rT/pulfH1V6ffyhbJAd/WulzGGRek
        kipUOGlu29GTJQu8j4wpU9DQ/ofnx4DrhP1XA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=N+eU2vknbo5YOq2TxBuw8vvp84VJkeBS
        F0067mpPOLFjIjyG4g673EjSgG57NRxaqpr4uovXz9cfoJAq6emRLn7R912byd2V
        UoKZwxCBTM+gjl5rhsOE0a1U5ux3rYlS5xAdv4S/qC5T/c1p/s34qel+ghDM3FuW
        2jpZZN98p8k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC792145E89;
        Wed, 15 May 2019 21:43:35 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 52A5C145E87;
        Wed, 15 May 2019 21:43:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>,
        Antonio Ospite <ao2@ao2.it>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] get_oid: handle NULL repo->index
References: <20190511205711.tdclwrdixaau75zv@dcvr>
        <20190511223120.GA25224@sigill.intra.peff.net>
        <20190511230204.GA18474@sigill.intra.peff.net>
        <20190514135455.GA17927@sigill.intra.peff.net>
        <CACsJy8AvsyOz2G1zjRjpKYVZ0DLKj02-v=hXJHS0BRHnxoeWAw@mail.gmail.com>
        <20190515014622.GB13255@sigill.intra.peff.net>
        <xmqqh89w70w8.fsf@gitster-ct.c.googlers.com>
        <CACsJy8BS8NR6aZR29VLYUrRjBE_oyzH=L6X7CSpCO9G+sPjcbA@mail.gmail.com>
Date:   Thu, 16 May 2019 10:43:34 +0900
In-Reply-To: <CACsJy8BS8NR6aZR29VLYUrRjBE_oyzH=L6X7CSpCO9G+sPjcbA@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 15 May 2019 16:29:12 +0700")
Message-ID: <xmqqftpf5g3d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 04E94DFE-777C-11E9-ADE0-E828E74BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> That is an approach to make it harder to make mistakes by accepting
>> possibly a small wasted resource; but at that point, I think calling
>> repo_read_index() unconditionally from here and similar places would
>> be a simpler fix in the same spirit.
>
> For repo_read_index() case, maybe. But we have a lot of
> "r(epo)->index->something". All or most of these references
> traditionally are the_index.something, which is always safe to
> dereference. Submodule repos with the optionally NULL repo->index
> break this assumption.

Ah, good point.  Thanks for a dose of sanity.
