Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32C851F453
	for <e@80x24.org>; Fri, 26 Apr 2019 02:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfDZCNN (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 22:13:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52225 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfDZCNM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 22:13:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8537011C4AB;
        Thu, 25 Apr 2019 22:13:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/yrjBDb51yxi+tmdPxn+8IUnUqM=; b=pSbTgp
        7+80PMCQImRvKpKoDP62fJeQaSyEIkkMtIiWS64pP1L0rTsAPqcf1FPZlr3mFvCv
        cJc9Z8rkYFL6N5ZPB6FeM7dD7xzIw9EolxUlTMyoKnC3p1d6tu8JDbJmz/Mrt1Mj
        v2SshDdaBzDnzXBveh4GdgpwkbeR64so1oVMg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OfbX2taHcE/IH4//a7US0szKW8sFazyD
        oXVrmtPOLf3OX/SGtIulyPCCymKe9a5c5YZBtsa7+KjWgOjz34lQYIA0LXS2q13m
        ij2tq8/t8mNNOz0ijhH64N/XlqcpRkyGCFgv6kw1dN38J+3oPY9OHVYVGxfPDvpj
        WXBzbyhf7Vk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D43811C4A9;
        Thu, 25 Apr 2019 22:13:07 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E385311C4A8;
        Thu, 25 Apr 2019 22:13:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Barret Rhoden <brho@google.com>, Olaf Hering <olaf@aepfle.de>
Subject: Re: How to undo previously set configuration? (again)
References: <20190424004948.728326-1-sandals@crustytoothpaste.net>
        <20190424023438.GE98980@google.com>
        <20190424230744.GL6316@genre.crustytoothpaste.net>
        <87k1fis8gq.fsf@evledraar.gmail.com>
        <20190425143614.GA91608@google.com>
Date:   Fri, 26 Apr 2019 11:13:05 +0900
In-Reply-To: <20190425143614.GA91608@google.com> (Jonathan Nieder's message of
        "Thu, 25 Apr 2019 07:36:14 -0700")
Message-ID: <xmqqmukdwm32.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D499673C-67C8-11E9-8AC0-1646B3964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> I'm confused.  Isn't that bog-standard Git usage, not a custom hack?

Depends on the definition of "hack".

The only native provision at the config API level that lets the
calling programs realize the "desired behaviour" you listed below
without doing anything special is "for a single-valued one, the last
one wins", for which the newer style config_get_value() will give
you the "last one wins" semantics.  With the original style parsing
using the git_config() with callback still needs to do the "last one
wins" by the caller of the config API.

The "empty clears the list" for multi-valued option is totally up to
the application.  Even the newer configset__get_value_multi() API
function does not reset a list to empty when it sees an empty
string.  The caller gets a list of value strings that happens to
have an empty string in the middle.

So, I think the "bog-standard" Git convention must be maintained by
each application codepath to implement it with a custom hack.

Perhaps you did not mean with "hack" a "hacky implementation", but a
"hacky design".  If that is the case, yeah, I agree with you that
the items #1 and #2 below are what we try to make sure our programs
follow; I am not sure about #3 myself, as I do not think offhand a
good example of it, though.

> That is, I thought the intended behavior is always
>
>  1. For single-valued options, last value wins.
>  2. For multi-valued options, empty clears the list.
>  3. When there is a special behavior triggered by not supplying the
>     option at all, offer an explicit value like "default" that triggers
>     the same behavior, too.
>
> and that any instance of a command that isn't following that is a bug.

If we make that declaration, we could enforce the "empty clears the
list" at the API level when the configset API is in use.
