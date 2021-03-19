Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187D7C433E0
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 00:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDDFE64E64
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 00:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhCSABT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 20:01:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60710 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbhCSAAy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 20:00:54 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AA868AFFEF;
        Thu, 18 Mar 2021 20:00:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=X5RIO8W5nlZ0V1BkYANboiCnJDI=; b=bEJHif
        N8XNV89eOYxA+Yl3gWlOSoHKkgb3mXd9LSKC6VOk3skm1lm4uZ3C3ZW6fdmX0f1A
        TIqMpA10LafoTOO9DtIFf5AjcqazCeHdkLA9zbri8IqrKLEmQllcs1NdKRth4cFc
        rzw63rw9bcN1/msk8wuRaUfI4Gcg5k8NjS2kI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yJvwwiehNHmVkVAqgjkzwpwMrgzmAVTY
        nwR7zXXijIjKJb1Zu/AVRnl28z6UucKrpy2X10SV3tLAN7OIzR6dKMvUMVdaAJq2
        BbCmgFIXnuPwuciH0M2jxV0bftiTApUzr5CTwx8GpPAE1obohTFRbBJm45SDcSVp
        uGarpt4yJQE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A0BFEAFFEE;
        Thu, 18 Mar 2021 20:00:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 21517AFFED;
        Thu, 18 Mar 2021 20:00:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, newren@gmail.com
Subject: Re: [PATCH v3 5/7] refresh_index(): add
 REFRESH_DONT_MARK_SPARSE_MATCHES flag
References: <cover.1615588108.git.matheus.bernardino@usp.br>
        <34a61a0d03868c43d68a04bca8d86dd98de2aa28.1615588109.git.matheus.bernardino@usp.br>
        <xmqqsg4sowks.fsf@gitster.g>
Date:   Thu, 18 Mar 2021 17:00:52 -0700
In-Reply-To: <xmqqsg4sowks.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        18 Mar 2021 16:45:23 -0700")
Message-ID: <xmqqo8fgovuz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2BF5A898-8846-11EB-8877-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Matheus Tavares <matheus.bernardino@usp.br> writes:
>
>> refresh_index() optionally takes a seen[] array to mark the pathspec
>> items that had matches in the index. This is used by `git add --refresh`
>> to find out if there was any pathspec without matches, and display an
>> error accordingly.
>
> It smells a bit iffy in that this allows a path to "match" a pattern
> but yet not result in seen[] to record that the pattern participated
> in the match.  If the series is working towards certain operations
> not to touch paths that are outside the sparse checkout, shouldn't
> it be making these paths not to match the pattern, and by doing so
> it would automatically cause the pattern to be considered "not yet
> matching any path" when the matcher attempts to match the pattern to
> such a path?

In other words, the change makes me wonder why we are not adding a
flag that says "do we or do we not want to match paths outside the
sparse checkout cone?", with which the seen[] would automatically
record the right thing.
