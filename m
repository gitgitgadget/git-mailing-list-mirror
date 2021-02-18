Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF271C433E0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 23:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97A2064EBD
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 23:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhBRXeu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 18:34:50 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50031 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhBRXet (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 18:34:49 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A3E6112C80D;
        Thu, 18 Feb 2021 18:34:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZS40sZbunbZB
        1dAzCaMksJFTxAA=; b=VLFZXa7mus6c9Sd/PENR/FXFmMpO7EfY03F0N58vgi8R
        3CPeTexYFEeHPCYJFNFFcEYR8m/8kGjfb4YaHIfP/Y5Saa9oXa59ljxrXgZaemcp
        3Hm+ZUnsH9zw40OIHh0KAUPyyRU+5HZ2Ya1uTNUgzWUE3c+h2cZYya9U2RRr/RY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=wU5Mjh
        ONCXueLjjhwzFbWYLbT/R+Cg5MlZGJQpodj7lsHsVbaokw35kyZcecrDUkuDmCFq
        wmbPPR9dPjr6OS/rEU7vSpGvmY1DCJ0ofS9qF+/yZlgJIJIG6Z6gafVyfy2rmZEE
        Iv9aSo/RZBX8zso47V7M0cWXuWcstZazWjNvE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9CBCC12C80C;
        Thu, 18 Feb 2021 18:34:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CC3B612C80B;
        Thu, 18 Feb 2021 18:34:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/4] Check .gitmodules when using packfile URIs
References: <20210115234300.350442-1-jonathantanmy@google.com>
        <cover.1611455251.git.jonathantanmy@google.com>
Date:   Thu, 18 Feb 2021 15:34:03 -0800
In-Reply-To: <cover.1611455251.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Sat, 23 Jan 2021 18:34:26 -0800")
Message-ID: <xmqqzh01ar2s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C9C52FAA-7241-11EB-8DE1-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> This patch set resolves the .gitmodules-and-tree-in-separate-packfiles
> issue I mentioned in [1] by having index-pack print out all dangling
> .gitmodules (instead of returning with an error code) and then teaching
> fetch-pack to read those and run its own fsck checks after all
> index-pack invocations are complete.
>
> As part of this, index-pack has to output (1) the hash that goes into
> the name of the .pack/.idx file and (2) the hashes of all dangling
> .gitmodules. I just had (2) come after (1). If anyone has a better idea=
,
> I'm interested.
>
> I also discovered a bug in that different index-pack arguments were use=
d
> when processing the inline packfile and when processing the ones
> referenced by URIs. Patch 1-3 fixes that bug by passing the arguments t=
o
> use as a space-separated URL-encoded list. (URL-encoded so that we can
> have spaces in the arguments.) Again, if anyone has a better idea, I'm
> interested. It is only in patch 4 that we have the dangling .gitmodules
> fix.

This seems to have been stalled but I think it would be a better
approach to use a custom callback for error reporting, suggested by
=C3=86var, which would be where his fsck API clean-up topic would lead
to.

If it is not ultra-urgent, perhaps you can retract the ones that are
queued right now, work with =C3=86var to finish the error-callback work
and rebuild this topic on top of it?  Thanks.
