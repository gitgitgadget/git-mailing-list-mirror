Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4C9C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 21:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7156020721
	for <git@archiver.kernel.org>; Mon,  4 May 2020 21:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QU9lSN/r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgEDVJH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 17:09:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61575 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgEDVJH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 17:09:07 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 204D34C961;
        Mon,  4 May 2020 17:09:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Nh/FfAmj/GjZ3vmFb6EALp2aUQ0=; b=QU9lSN
        /rd6/B+wZ5doz1GpLckw/uVFsjFWtGbIWhsQKrB9wwwEUX3wulol+Y4P5PDzT9Ts
        fBsgYRPqeGr99ogIEFLy95qBuUYif7lUz86PASSP16kzSBawKawlr0aGBJb0czjU
        qreMSdcPJ7ElcIHTDH4Tegtkou8ICyk8yS0Uw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CKhO4mhtgkltniSTF26px4ZzKXe+tw0K
        EKio/9warM9jY7eM/IYZthDxdLP4vwFbv4/2+ZJRi3yMxm04eqvf0B1n+vahQaXX
        mGAPqbd4xj+x0LoaZqkoucfkptEzWsy39EIZxT1C+ZOyna1BmU8EZ0RwCC9nH9w0
        mUYoZCGSKfg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 152384C960;
        Mon,  4 May 2020 17:09:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 784104C95F;
        Mon,  4 May 2020 17:09:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] commit-graph: avoid memory leaks
References: <20200504191324.201663-1-jonathantanmy@google.com>
Date:   Mon, 04 May 2020 14:09:03 -0700
In-Reply-To: <20200504191324.201663-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 4 May 2020 12:13:24 -0700")
Message-ID: <xmqq8si7flw0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7C2AB84E-8E4B-11EA-9454-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> A fuzzer running on the entry point provided by fuzz-commit-graph.c
> revealed a memory leak when parse_commit_graph() creates a struct
> bloom_filter_settings and then returns early due to error. Fix that
> error by always freeing that struct first (if it exists) before
> returning early due to error.
>
> While making that change, I also noticed another possible memory leak -
> when the BLOOMDATA chunk is provided but not BLOOMINDEXES. Also fix that
> error.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> Here's a memory leak fix revealed by a fuzzer running at $DAYJOB, and
> another one that I noticed while making that fix.
> ---

Thanks.  The patch looks good.

Will queue.
