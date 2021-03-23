Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4F3C433C1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 06:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BC13619AB
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 06:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbhCWGje (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 02:39:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56825 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhCWGjd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 02:39:33 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 835D5B64E9;
        Tue, 23 Mar 2021 02:39:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rAQpktjozOf9+j/vogETupqwbFA=; b=M0B4Bx
        hDErDb9AQQkABDqCtsSWgTGTh/DM/SjtlJ+MK01nYwARCu8OWgQUtv8IjD/JCssY
        eOpZLh0tT6Td+E5l1xT8tjeDQB/z+KOFW6kUkF/3RGPvpOyNCsO5+8m8Gb72Amje
        zHpodjgurlVT8n+vxX4gCaO1BeJmz37gPkjTg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gqWAU0KopSLnzr27ZYvDh0ITUJX97dql
        qg59BYYjMrzx4GsTX2K1jaxBWW1IXUKzaFWNCDKxuA5KWsgMAdtzE9hopVSVliQz
        /yeXyV3G6LV5INHpPJO7BCeiRwNRonozUz+P3tIRJVPd3txAqmbkaqfk1On0wO90
        36jfhoP3fd4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 744C2B64E8;
        Tue, 23 Mar 2021 02:39:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F271DB64E7;
        Tue, 23 Mar 2021 02:39:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Madhu <enometh@meer.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] init: don't reset core.filemode on git-new-workdirs.
References: <xmqq7dlz94by.fsf@gitster.g>
        <20210322.143437.212295420302618690.enometh@meer.net>
        <xmqqr1k76p8d.fsf@gitster.g>
        <20210323.092748.1559327071188512317.enometh@meer.net>
Date:   Mon, 22 Mar 2021 23:39:31 -0700
In-Reply-To: <20210323.092748.1559327071188512317.enometh@meer.net> (Madhu's
        message of "Tue, 23 Mar 2021 09:27:48 +0530 (IST)")
Message-ID: <xmqqr1k64bmk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 865C1FF6-8BA2-11EB-906B-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Madhu <enometh@meer.net> writes:

> Avoiding the filemode check completely during reinit is ok with me
> because it gave me wrong results.  I can't speak for the original
> author of the code - if his intention was to do it explicitly as part
> of "reinitialization".

As the original author of the code, I know I meant filemode check to
be done and redone upon reinitialization in 4f629539 (init-db: check
template and repository format., 2005-11-25).

But then when 75d24499 (git-init: autodetect core.symlinks,
2007-08-31) started to autodetect symbolic link support, I somehow
ended up doing it only upon the repository creation.  Later,
2455406a (git-init: autodetect core.ignorecase, 2008-05-11) imitated
to check case sensitivity in the same block, doing it only once.

Either of these two commits would have been a good chance for us to
realize that filemode check should be done the same way, but somehow
nobody noticed X-<.

