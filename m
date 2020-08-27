Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCF1C433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 00:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCFE520825
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 00:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Byw+UL2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgH0AN1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 20:13:27 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50935 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgH0AN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 20:13:27 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 33689E9D80;
        Wed, 26 Aug 2020 20:13:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aQBBo25z1LGIdOCfLRfYf8Dx9B0=; b=Byw+UL
        2AAQ1tgdax5j6HHycaMl81TQ3MokE32iyX9GjgsyAAu8iCLs/BnZAxM3lt3YrLn3
        gbqAN/fabmbQzGnF/zx0LaXaib88j57QkiwYja80CG79Njm0bKIn29vKiBaJ5qz7
        Zf2bptIda1UKrQ3K7STy5q1/jw1vQ72FA8qHM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=idmjvkuYMi9O1UEFuhmhTeMh1k3BTn2S
        iw9r5lShO096jEZvVx9WCIMHtqZuoPAcWID++KKLXzVCWTNroxEgaWJcINdAXDBR
        QPcNBYW4axACqMqi/xHPTE8Ytmg5Ghj8NiSNAFhIC9QWcOybiWCzpOFTqs5R420t
        EplBcgOlaCo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2C364E9D7F;
        Wed, 26 Aug 2020 20:13:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 75CAFE9D7E;
        Wed, 26 Aug 2020 20:13:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tom Rutherford <tmrutherford@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: post-checkout hook aborts rebase
References: <CAHr-Uu_KeAJZrd+GzymNP47iFi+dZkvVYsWQPtzT_FQrVnWTDg@mail.gmail.com>
Date:   Wed, 26 Aug 2020 17:13:19 -0700
In-Reply-To: <CAHr-Uu_KeAJZrd+GzymNP47iFi+dZkvVYsWQPtzT_FQrVnWTDg@mail.gmail.com>
        (Tom Rutherford's message of "Wed, 26 Aug 2020 16:10:42 -0700")
Message-ID: <xmqq7dtlt080.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1DBCB6AA-E7FA-11EA-8C8F-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tom Rutherford <tmrutherford@gmail.com> writes:

> What did you expect to happen? (Expected behavior)
>
> The rebase succeeds.
>
> I expect this because the documentation for the post-checkout hook
> states, "This hook cannot affect the outcome of git switch or git
> checkout" https://www.git-scm.com/docs/githooks#_post_checkout

In general, pre-<anything> hook is run before <anything> subcommand
is executed, and by exiting with non-zero status, the hook can tell
the <anything> subcommand not to proceed.  post-<anything> hook, on
the other hand, runs _after_ <anything> has done its thing already,
so by definition, it cannot say "Hey, <anything>, don't continue".

That is the primary meaning of "cannot affect" in that description. 

Without looking at the contents of the actual hook is, nobody can
say anything definite, but it also means that "Your hook is NOT
ALLOWED TO do any extra modification to files and the index 'git
switch' or 'git checkout' made".  If "git rebase" or whatever
command wanted to place files and the index into some state by using
"git checkout" command, and if the post-checkout hook mucked with
the state in such a way that contradicts with what the "git rebase"
command wanted them to be in, it is not surprising the hook's behavior
broke "git rebase"'s operation.
