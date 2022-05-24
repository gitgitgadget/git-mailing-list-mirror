Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C516C433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 22:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241344AbiEXWDQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 18:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiEXWDP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 18:03:15 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690C66620D
        for <git@vger.kernel.org>; Tue, 24 May 2022 15:03:14 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C3C012C161;
        Tue, 24 May 2022 18:03:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6o5rE6oNXQ3dtYv6gwreyIq8JKWvDw1Vfm1tsT
        ehMJI=; b=M3npKSjtKaBrNlCBDkPqrmpUk/goMfRdcokTy2q6P8RQZ1UArgCVwo
        bOqqKGX9v9iuT7BDQ+rWLfo+PyW4ltH00aJYhAH0Nx6WJkzfwnlpv2k8gfGo69bY
        LLvxQjTQHM8Sno6BokWEyVwYJgF39YS/BABXQmfVo3gbrTXYtOZB0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 60EE612C160;
        Tue, 24 May 2022 18:03:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C02FF12C15D;
        Tue, 24 May 2022 18:03:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, vdye@github.com, jonathantanmy@google.com
Subject: Re: [PATCH v2 3/4] builtin/pack-objects.c: ensure included
 `--stdin-packs` exist
References: <cover.1652458395.git.me@ttaylorr.com>
        <cover.1653418457.git.me@ttaylorr.com>
        <cdc3265ec27f04accc433d9e4e54ac0edc3b3746.1653418457.git.me@ttaylorr.com>
Date:   Tue, 24 May 2022 15:03:11 -0700
In-Reply-To: <cdc3265ec27f04accc433d9e4e54ac0edc3b3746.1653418457.git.me@ttaylorr.com>
        (Taylor Blau's message of "Tue, 24 May 2022 14:54:31 -0400")
Message-ID: <xmqq1qwifv1c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E1D8E3E-DBAD-11EC-8862-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Calling `is_pack_valid()` early on makes it substantially less likely
> that we will have to deal with a pack going away, since we'll have an
> open file descriptor on its contents much earlier.

Sorry for asking a stupid question (or two), but I am confused.

This does make sure that we can read and use the contents of the
packfile even when somebody else removes it from the disk by
ensuring that

 (1) we have an open file descriptor to it, so that we could open
     mmap window into it at will; or

 (2) we have a mmap window that covers all of it (this should be the
     norm on platforms with vast address space); or

 (3) we are in the same state as (1) by opening the packfile to
     validate the pack right now.
     
and during the pack-object we are running (aka "repack"), we can
continue to read from that pack that may have already disappeared
from the disk.

But is that sufficient?  Are we writing the resulting new pack(s)
out in such a way that the repository is healthy without the pack
we noticed is disappearing?  How do we ensure that?

Thanks.
