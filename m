Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A085C433DB
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 23:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6524D64DE8
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 23:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbhCRXp7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 19:45:59 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51899 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhCRXp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 19:45:28 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 23C2810FEB5;
        Thu, 18 Mar 2021 19:45:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+MVC7ges++LBLAoqit5TO9pz2XI=; b=MSKQXc
        xsHPKeZxbM9YcBSfzAgEI3BH2znMuji/driusQQhvsux1z81Ro7xoyJVhJ84/wNd
        fzCEcRxMDaISgt6aC+QLQrIECa8pGYa77V4Isa7aoiVn3rG/VK/6LM8DmEl7htk9
        G9QuYUjZNLcitEOhPB+qPqquBSl5KpBN1OkvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iYkY13Aa1T69po5WxShA9khIGSVe4lPR
        35mHFYy1r0UUcxyGU/R577bobIpTJYJX6mWOh8ZtPLYdtVXEZH4dNWUms3Ztal9u
        X6DZ7NmCVEYe9QpGbB20+hcrEivQ1u0iMt9Z422z+a/lu/4pmgL+HLQloSbZUZyv
        tvSqRxC6RXY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 16DE410FEB3;
        Thu, 18 Mar 2021 19:45:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5D62610FEB1;
        Thu, 18 Mar 2021 19:45:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, newren@gmail.com
Subject: Re: [PATCH v3 5/7] refresh_index(): add
 REFRESH_DONT_MARK_SPARSE_MATCHES flag
References: <cover.1615588108.git.matheus.bernardino@usp.br>
        <34a61a0d03868c43d68a04bca8d86dd98de2aa28.1615588109.git.matheus.bernardino@usp.br>
Date:   Thu, 18 Mar 2021 16:45:23 -0700
In-Reply-To: <34a61a0d03868c43d68a04bca8d86dd98de2aa28.1615588109.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Fri, 12 Mar 2021 19:48:00 -0300")
Message-ID: <xmqqsg4sowks.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 02F943D4-8844-11EB-8EB4-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> refresh_index() optionally takes a seen[] array to mark the pathspec
> items that had matches in the index. This is used by `git add --refresh`
> to find out if there was any pathspec without matches, and display an
> error accordingly.

It smells a bit iffy in that this allows a path to "match" a pattern
but yet not result in seen[] to record that the pattern participated
in the match.  If the series is working towards certain operations
not to touch paths that are outside the sparse checkout, shouldn't
it be making these paths not to match the pattern, and by doing so
it would automatically cause the pattern to be considered "not yet
matching any path" when the matcher attempts to match the pattern to
such a path?

