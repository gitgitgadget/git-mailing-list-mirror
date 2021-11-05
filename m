Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29DFC433F5
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 01:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 868486124B
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 01:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhKEBnF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 21:43:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64613 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbhKEBnD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 21:43:03 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B2E94FF51D;
        Thu,  4 Nov 2021 21:40:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=t45662GAWDnJcz7yI/2kDiR/2/PMUvvJwzeBhg4quvc=; b=v2nn
        mqBOuAfFyCS2NVG9oV5gTPEW4luj8bc1o1zQyIQQHRW3hyyAbsR2upsCMW40d7L4
        SqJc+UJtsB4jjleAoRvX1UZUIqvIBYFxRv8xA0NpCCJeF1fZvnLaeAAUY/DUk8sA
        dg7NGgCVKBmF3Ns48t389YwbxvM9Fqh0CSkMG1o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AA3CBFF51C;
        Thu,  4 Nov 2021 21:40:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 156CDFF51B;
        Thu,  4 Nov 2021 21:40:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Eric Wong <e@80x24.org>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH] refs: sync loose refs to disk before committing them
References: <dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im>
        <211104.86ilx8hwvi.gmgdl@evledraar.gmail.com>
        <xmqqk0hn1unp.fsf@gitster.g>
        <20211104223600.GA4069@neerajsi-x1.localdomain>
Date:   Thu, 04 Nov 2021 18:40:22 -0700
Message-ID: <xmqqfssbz8ft.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 58586FE4-3DD9-11EC-A7BA-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neeraj Singh <nksingh85@gmail.com> writes:

> Is there some reason we shouldn't die if writing the ref fails? We are
> already accustomed to dying if fsyncing a packfile or the index fails.

If we look at the surrounding code and the callers of the function,
this caller of fsync() is about to signal a failure to its callers
by returning an error().  The callers are prepared to see an error
and cope with it.

Introducing die() to such a library-ish part of the code deep in the
callchain is not exactly a good change, especially when it is
obvious how we can avoid it.
