Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F90BC388F7
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 20:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCDC520735
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 20:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qKRSsryl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732099AbgKEUZR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 15:25:17 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64404 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgKEUZR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 15:25:17 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 37C2E7C773;
        Thu,  5 Nov 2020 15:25:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oZw31shP0OghJvnHojHgzskqHbg=; b=qKRSsr
        ylYKIafIqkDqazq3DHPnNZeZINgHQgfyA0Zv278pH1dTNQUI/mE7rEMYqq3RH1fZ
        8WLLSZoYU5yAvZMZS3etQPRgwcJsKOC+rKln1r/N1baZRKmJScz4m5LPBwJ0rHjD
        zfbGm3/beF5vy9WnqAG+LOFe/oHrWAPzNlvYo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kcKrrdh46iAyYuhsK6NJrha8W4gURzPO
        aevEL7gabMWtRQ0K0wEqIBiWNpvA69lpXkcBEoJ8EeZOHQH1OExH1H4ClmQr5iig
        NpGXTOKocGIXl8plLYwfcWr/3I0MsM7ExM9b3u65cLz72pqjS0rxQkJ4mViy8un1
        nps7wcGr4dM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2EDF47C771;
        Thu,  5 Nov 2020 15:25:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A5C0D7C770;
        Thu,  5 Nov 2020 15:25:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 00/13] Add struct strmap and associated utility
 functions
References: <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
        <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
        <20201105132909.GB91972@coredump.intra.peff.net>
Date:   Thu, 05 Nov 2020 12:25:14 -0800
In-Reply-To: <20201105132909.GB91972@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 5 Nov 2020 08:29:09 -0500")
Message-ID: <xmqq8sbfk0ut.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03B1B73C-1FA5-11EB-AFE4-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Subject: [PATCH] shortlog: drop custom strset implementation
>
> We can use the strset recently added in strmap.h instead. Note that this
> doesn't have a "check_and_add" function. We can easily write the same
> thing using separate "contains" and "adds" calls. This is slightly less
> efficient, in that it hashes the string twice, but for our use here it
> shouldn't be a big deal either way.
>
> I did leave it as a separate helper function, though, since we use it in
> three separate spots (some of which are in the middle of a conditional).

It makes sense, but check_dup() sounds like its use pattern would be

	if (check_dup(it) == NO_DUP)
		add(it);

where it is more like "add it but just once".

By the way, is a strset a set or a bag?  If it makes the second add
an no-op, perhaps your check_dup() is what strset_add() should do
itself?  What builtin/shortlog.c::check_dup() does smells like it is
a workaround for the lack of a naturally-expected feature.

