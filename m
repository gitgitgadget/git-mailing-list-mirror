Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20528C43334
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 16:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344867AbiFIQze (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 12:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238833AbiFIQz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 12:55:26 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5767F79827
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 09:55:23 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A1B321465D2;
        Thu,  9 Jun 2022 12:55:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zbWdiPXzoJZA
        wAalyGv7iI6coPkisHCbtNPho8BIoYE=; b=v1I+tKLNMKwShArXxe8hxJWaXqPi
        fmiKg3z+S2Dtk/OMtRwQ90IFalstNg3sHBJPbEWztUjnmYGID/QXgCREqV/P11ec
        GdELd5nAC6J8DeRCvM4DwWdHrcoH0w7uamePzTz5S6iQPtIC1GbNSceDXymSzN8Q
        B/z6khGgDpUXTDY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 986C11465D1;
        Thu,  9 Jun 2022 12:55:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0976F1465D0;
        Thu,  9 Jun 2022 12:55:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] connected: distinguish local/remote bad objects
References: <20220608210537.185094-1-jonathantanmy@google.com>
Date:   Thu, 09 Jun 2022 09:55:20 -0700
In-Reply-To: <20220608210537.185094-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 8 Jun 2022 14:05:37 -0700")
Message-ID: <xmqqwndpn5dz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F34D59CA-E814-11EC-A5AC-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>  builtin/fetch.c              |  2 +-
>  connected.c                  |  1 +
>  revision.c                   | 16 ++++++++++++--
>  revision.h                   |  3 +++
>  t/t5518-fetch-exit-status.sh | 43 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 62 insertions(+), 3 deletions(-)

This seems to break linux-leaks CI job by making 5518, which was
marked in some topic in flight to expect to be leak-free, fail.

Because of the way linux-leaks test framework is done, it is not
easy to tell if the code changes essential to this topic introduced
new leaks, in which case we would want to fix that.

Note that this may not the fault of the code changes in this patch.
If the tests added by the patch started using git commands that are
known to leak (i.e. not ready to be subjected to the "leaks" test)
in order to prepare the scenario or to inspect the result, even if
the code changes in this topic did not introduce any leak, we can
see the same breakage in linux-leaks CI job.  An easy way out would
be to disable leak-check CI for the entire 5518, but that is not
very satisfactory, as the earlier part of that script should still
be leak-free.  Another way out might be to add these two tests in a
new script, which is not marked as not-leaking.  After all, what the
new topic adds is not about exit status but how that exit status
comes about, so it might not be a bad idea even without the CI leak
stuff anyway.

=C3=86var, does the internal state used for revision walking count as
leaking when it is still held by the time we hit die() in
bad_object(), or anything on stack when we die() are still reachable
and won't be reported as a failure?

Thanks.
