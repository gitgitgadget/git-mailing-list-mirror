Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E676FC433DF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 22:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9863205ED
	for <git@archiver.kernel.org>; Wed, 13 May 2020 22:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rEc7hv7O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbgEMWHM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 18:07:12 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55412 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729775AbgEMWHM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 18:07:12 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 372D1BDC5D;
        Wed, 13 May 2020 18:07:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XlVv7mtreraHjI8GIfwEiURBcKo=; b=rEc7hv
        7OEgJ6ss8txASOhVwHDUBAcPFhNy464oXWcNmT/AafplfHsYoaRhpPyr1hqlBXZI
        IVBntU2wnI40Vyd6P9x3AobfrfmBjTnNgC7Pd21Sssx8CvQDcHeHIiOX4T5DspxE
        1Z+lTGKtge4RPzSdWOj363V91p9XuNkgNswiU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dXm0BCiTEvSI9Cgjx/wyPjGf5XNmfubo
        d9l464vlKk7BF/IcUJF+9MRSl91zzOLPcGf/sZbiq+SijfqlpaaBPznhx7K/Dtro
        6KlQKwIVL1nveouW5jQa1APTEBYgEw7G8H2s3S+EkZU2iHQqp3bzeAwaHF4bZdAR
        OGPIc/hOCxw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 222BEBDC59;
        Wed, 13 May 2020 18:07:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D6D81BDC58;
        Wed, 13 May 2020 18:07:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Xin Li <delphij@google.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrn@google.com>
Subject: Re: [PATCH] fetch: allow adding a filter after initial clone.
References: <20200513200040.68968-1-delphij@google.com>
        <xmqqo8qrsh0d.fsf@gitster.c.googlers.com>
        <CAOhzdui-4KeOit74fTy=3YxSncHGZzy+cE+6njyjHPyJ8xFpMA@mail.gmail.com>
Date:   Wed, 13 May 2020 15:07:05 -0700
In-Reply-To: <CAOhzdui-4KeOit74fTy=3YxSncHGZzy+cE+6njyjHPyJ8xFpMA@mail.gmail.com>
        (Xin Li's message of "Wed, 13 May 2020 14:41:00 -0700")
Message-ID: <xmqqwo5fqyk6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 158C5A6C-9566-11EA-BEF2-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Xin Li <delphij@google.com> writes:

> The proposed change would allow converting an existing git clone to
> use partial clones.  For example:
>
> $ git clone --depth=1 https://android.googlesource.com/platform/bionic .
> $ git fetch --unshallow --filter=blob:none origin
>
> Previously, to allow this one would have to do the following manually
> first; the existing code would handle the rest gracefully:
>
> $ git config core.repositoryFormatVersion 1
> $ git config extensions.partialClone origin
>
> And the proposed change would have git do it for the user
> automatically, the existing workflow remains otherwise unchanged.

Please do not explain these things to the list readers.  Instead,
remember to write them in the proposed log message when you are
ready to send an updated patch, which you would probably want to
wait before giving other people to comment on the patch.

Thanks.
