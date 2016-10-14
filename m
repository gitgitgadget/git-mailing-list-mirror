Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3BEC1F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 18:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756274AbcJNS1c (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 14:27:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65476 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754568AbcJNS1V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 14:27:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0EF6A45C77;
        Fri, 14 Oct 2016 14:27:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4bgm2Io9ctzLoL8iJQyely66lnc=; b=h19ghP
        40aD2Y4BnYUBpJ8dQvXpaZL7r47QYN8pV9vSsrydZmnIHVOB6oKLZXUMFUijMt7j
        I+qujENHuAxMS7xhQpjMuRqQVhgLZL4R2IDWIMM9qr7iX2Dzv849jRxtwT9Hlacr
        +bqCR3uWODBR2ImH8FRh26DydJqRim/U4bFsk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YrooppV4CHo5gBQ+i+CL89CMb8Df5LVK
        jyS4MXZuFG7zbE7tKxC7+n1QNvwEBk7UvRYC1UpXzVX3tyduQCTqW6tp+cTsSyBX
        LtsuGAExt8V2nKXX8ZfIAxeIi/OhaURBVu7gT23TD9myuskDIiprCSvUgO+WbY1m
        pap2G2RHKbs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 06C7B45C76;
        Fri, 14 Oct 2016 14:27:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7990C45C75;
        Fri, 14 Oct 2016 14:27:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, christian.couder@gmail.com
Subject: Re: [PATCH v2 2/6] trailer: use list.h for doubly-linked list
References: <cover.1476314576.git.jonathantanmy@google.com>
        <cover.1476232683.git.jonathantanmy@google.com>
        <cover.1476314576.git.jonathantanmy@google.com>
        <a7b9f79ea1b61b80d1177740d5d78fcca848a4f6.1476314576.git.jonathantanmy@google.com>
Date:   Fri, 14 Oct 2016 11:27:17 -0700
In-Reply-To: <a7b9f79ea1b61b80d1177740d5d78fcca848a4f6.1476314576.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Wed, 12 Oct 2016 16:40:17 -0700")
Message-ID: <xmqq7f9azsze.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D75AAA54-923B-11E6-ACC5-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Replace the existing handwritten implementation of a doubly-linked list
> in trailer.c with the functions and macros from list.h. This
> significantly simplifies the code.
> ---

The handcrafted one in trailer.c somehow did not use the common
practice of using a doubly-linked cycle as a doubly-linked list with
a designated fake element as the pointers to the first and to the
last elements of the list (instead it used NULL as the "this is the
end in this direction" convention just like a common singly-linked
list), and this update removes the need for special cases handling
the elements at the beginning and at the end that comes from that
choice by switching to list.h macros.  update_last/update_first can
go, two parameters that were passed to point at the variables for
the beginning and the end can go, the special cases for the initial
condition in add_trailer_item() can go, all thanks to this change.

Very nice.

>  trailer.c | 258 ++++++++++++++++++++++----------------------------------------
>  1 file changed, 91 insertions(+), 167 deletions(-)
