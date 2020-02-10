Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57011C35254
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 18:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D6A2082F
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 18:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="M+pnrH2F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgBJSOU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:14:20 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60487 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgBJSOU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 13:14:20 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 400B8B86DB;
        Mon, 10 Feb 2020 13:14:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WMJBzCt5HVU8ZGh2YIlgQDDx9AE=; b=M+pnrH
        2FIaATb+Nb07cJ/0AQuywZUxIiarg/RHKN5iIel/7Y2IzWqcNP6pUGzfiQKWlfsq
        xFA9GK64/4bTHefIL3YqGTA7A2TIh3f4E6LixmvMk840BqxzlfZegBGAzyKmXQ0u
        lx/E9QByUaRcfJVvtRNWAZejv7DHn5pMekMU8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Bus9g4jxX+jAJit+iHRnB7Xe1z+rEkA6
        V5DtE8s7ubcbfWvmSsfJzbEkb5cbWFoatWc4bzsejdcQp/B+Dn5T1/3XvPqeoZ2u
        4DIZKYGluz1gkGxW2q/mVMRtk0wroSvAe0QEQIcSRg1dnkQqO3bYc1yY/BlxOGsf
        pl9e7LPXQOE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 27DC1B86DA;
        Mon, 10 Feb 2020 13:14:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 52135B86D9;
        Mon, 10 Feb 2020 13:14:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v7 08/10] config: teach git_config_source to remember its scope
References: <pull.478.v6.git.1580268865.gitgitgadget@gmail.com>
        <pull.478.v7.git.1581294660.gitgitgadget@gmail.com>
        <6c59c5cace7e1f8fc16737c2c9dcf2016397caa1.1581294660.git.gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 10:14:13 -0800
In-Reply-To: <6c59c5cace7e1f8fc16737c2c9dcf2016397caa1.1581294660.git.gitgitgadget@gmail.com>
        (Matthew Rogers via GitGitGadget's message of "Mon, 10 Feb 2020
        00:30:57 +0000")
Message-ID: <xmqqv9oez4wa.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 257146B4-4C31-11EA-8100-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Matthew Rogers <mattr94@gmail.com>
>
> There are many situations where the scope of a config command is known
> beforehand, such as passing of '--local', '--file', etc. to an
> invocation of git config.  However, this information is lost when moving
> from builtin/config.c to /config.c.  This historically hasn't been a big
> deal, but to prepare for the upcoming --show-scope option we teach
> git_config_source to keep track of the source and the config machinery
> to use that information to set current_parsing_scope appropriately.
>
> Signed-off-by: Matthew Rogers <mattr94@gmail.com>
> ---
>  builtin/config.c | 16 +++++++++++++---
>  config.c         |  3 +++
>  config.h         | 20 ++++++++++----------
>  3 files changed, 26 insertions(+), 13 deletions(-)

This is split from the last step in the previous round, and the
splitting makes sense.

Thanks.
