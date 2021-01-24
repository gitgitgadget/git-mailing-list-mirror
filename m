Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FDBC4332D
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 06:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A5FC22CA2
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 06:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbhAXGaZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 01:30:25 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51511 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbhAXGaP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 01:30:15 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C4D6711CC5C;
        Sun, 24 Jan 2021 01:29:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lGIn68qkJqPsQH7D4+ipbWYUIZk=; b=L9GNyC
        TmRQ5TtuwKkgtxW6an8oPnnY8cbvklq+Oy4VMeWxkCuXuilQQAUkKjrjcoySlP5m
        I7R8fvdP7NXcWdsZ3pDqIQV1YQC/noiBjH1tCUVW26OsXgZCVkQgpeKn0mD3Gu0Z
        HmFh/nDdRUcyDj9Ldmy2gp414TfTop/TMSfyM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A+YrPSzQ/km9PEmITLkxHathJ73yM/M5
        8zxSuTFEzg9O3zxeMB98aKvlp0gSn7XVfJcj4pE9oFrH7ltTalUv9+S7d+MEajkw
        2oHxnNRwet8GZJKMk1wjXNTM/cAup6BnWnvBJdJ5B3tJb0yfarM8mWWViKFogdAR
        SComih0R+GA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B287011CC5B;
        Sun, 24 Jan 2021 01:29:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EEB0011CC5A;
        Sun, 24 Jan 2021 01:29:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/4] Check .gitmodules when using packfile URIs
References: <20210115234300.350442-1-jonathantanmy@google.com>
        <cover.1611455251.git.jonathantanmy@google.com>
Date:   Sat, 23 Jan 2021 22:29:25 -0800
In-Reply-To: <cover.1611455251.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Sat, 23 Jan 2021 18:34:26 -0800")
Message-ID: <xmqqa6sy26gq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8261206C-5E0D-11EB-9B47-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> As part of this, index-pack has to output (1) the hash that goes into
> the name of the .pack/.idx file and (2) the hashes of all dangling
> .gitmodules. I just had (2) come after (1). If anyone has a better idea,
> I'm interested.

I have this feeling that the "blobs that need to be validated across
packs" will *not* be the last enhancement we'd need to make to the
output from index-pack to allow richer communication between it and
its invoker.  While there is no reason to change how the first line
of the output looks like, we'd probably want to make sure that the
future versions of Git can easily tell "list of blobs that require
further validation" from other additional information.

I am not comfortable to recommend "ok, then let's add a delimiter
line '---\n' if/when we need to have something after the list of
blobs and append more stuff in future versions of Git", because we
may find need to emit new kinds of info before the list of blobs
that needs further validation, for example, in future versions of
Git.

Having said all that, the internal communication between the
index-pack and its caller do not need as much care about
compatibility across versions as output visible to end-users, so
when a future version of Git needs to send different kinds of
information in different order from what you created here, we can do
so pretty much freely, I would guess.

Thanks.
