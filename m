Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A13D11F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 02:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbfJJCvU (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 22:51:20 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55462 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfJJCvU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 22:51:20 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2B1FA8E921;
        Wed,  9 Oct 2019 22:51:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T9AUz7SptXOZ9Ftl+MaNlfd092w=; b=iEFbkj
        BKOo6T1IVg92+aUMvzKF0sImwYkzn2NR01Jbdi9hhqAciPtEBQJ0ZE1k2s9B0MTk
        y++8QxKtjmnDytyTmOMALSAI3Wq9eYN58GSi3uGCuQMRDyl1SGgdegkzRZCZWuhE
        ssixJdfrGrS4eD9u0w8QNb0md3L43uvApYD+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=l4GmaC9jf8/BICwX9ReaoNyKZ+tn/kOG
        5+IGwHUH3zRyJCrUGgVQwg8ILov8tVbuOJbhmewRxfOLpH9jpo/yqWmbyVzVDbBb
        2h4hEzT7iiM92WtARJVQHGdxrL9Hjf+HWiJZChplUkM4yrI7bXz6PI/BrCT842D0
        cCB95uZsNmM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 239698E920;
        Wed,  9 Oct 2019 22:51:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 528218E91D;
        Wed,  9 Oct 2019 22:51:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lucas Oshiro <lucasseikioshiro@gmail.com>
Cc:     git@vger.kernel.org, kernel-usp@googlegroups.com,
        rcdailey.lists@gmail.com, me@ttaylorr.com, peff@peff.net,
        matheus.bernardino@usp.br,
        =?utf-8?Q?B=C3=A1rbara?= Fernandes <barbara.dcf@gmail.com>
Subject: Re: [RFC WIP PATCH 2/3] tag: factor out prepare tag template code
References: <20191008184727.14337-1-lucasseikioshiro@gmail.com>
        <20191008184727.14337-3-lucasseikioshiro@gmail.com>
Date:   Thu, 10 Oct 2019 11:51:13 +0900
In-Reply-To: <20191008184727.14337-3-lucasseikioshiro@gmail.com> (Lucas
        Oshiro's message of "Tue, 8 Oct 2019 15:47:26 -0300")
Message-ID: <xmqqo8ypjota.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D3956232-EB08-11E9-AF30-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lucas Oshiro <lucasseikioshiro@gmail.com> writes:

> Improve code readability by moving tag body reading to a new function called
> get_tag_body.

Quite honestly, I think the result of this splitting is harder to
follow than the original.

For example, the value of opt->message_given and the validity of
given_msg is very closely related, so if you made the helper
function receive non-NULL given_msg when !opt->message_given, the
helper could only check !given_msg without having to worry about
opt->message_given; with such a change, I could buy that the split
improves code readability, but I do not see any such change in the
patch.

> Enhance legibility by encapsulating code that loads previous tag message
> (if any) in new function prepare_tag_template....

The helper seems to be used to _write_ into path, and not load or
read any message from either an object or a file on disk.
