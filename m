Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37641C10DCE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 19:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 017DD20716
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 19:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RIL4hsT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgCMTS1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 15:18:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65376 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgCMTS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 15:18:27 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D7A145580;
        Fri, 13 Mar 2020 15:18:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SSSUFbeS8bQYEIKehIHvwS+Mp2o=; b=RIL4hs
        T4WzTlVIai2vsFHdzCjmBc9eUm6VKZcrKj5YPMPFioH/UuiuDDY3QCTmZ2xlqiFH
        2nWIb2crBDuQqN6CS/3MpOy+ye0SoXAZjRvfrpS9w+h6Nck1f60kNppY+Yl+PikW
        ULWbj0FPo+enXHR1YmMsP7fJ3OG056g9mT/uQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=x9TwIP4AIgegErAzTrOUVjXuwty0P6c+
        VI9GCaplOKtzCIRI6TuW5maPziUiekQMnjwkNuZTqvRNR0rAQuyEAJ8pgQc+v5jr
        wF7EgW2luSisO0rX5V74/1sT6uklOQRv7CH6RbUXb0e/tlOD/z0gBd5D+qIDD1LA
        5BQR9rEyL0o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3592F4557F;
        Fri, 13 Mar 2020 15:18:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B5B474557E;
        Fri, 13 Mar 2020 15:18:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] t6022, t6046: fix flaky files-are-updated checks
References: <pull.725.git.git.1584125875550.gitgitgadget@gmail.com>
Date:   Fri, 13 Mar 2020 12:18:24 -0700
In-Reply-To: <pull.725.git.git.1584125875550.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Fri, 13 Mar 2020 18:57:55
        +0000")
Message-ID: <xmqqtv2sawsf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 69169B20-655F-11EA-90EC-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> Several tests wanted to verify that files were actually modified by a
> merge, which it would do by checking that the mtime was updated.  In
> order to avoid problems with the merge completing so fast that the mtime
> at the beginning and end of the operation was the same, these tests
> would first set the mtime of a file to something "old".  This "old"
> value was usually determined as current system clock minus one second,
> truncated to the nearest integer.  Unfortunately, it appears the system
> clock and filesystem clock are different and comparing across the two
> runs into race problems resulting in flaky tests.

Good observation (and if we were doing networked filesystems, things
would be worse).

> So, instead of trying to compare across what are effectively two
> different clocks, just avoid using the system clock.  Any new updates to
> files have to give an mtime at least as big as what is already in the
> file, so define "old" as one second before the mtime found in the file
> before the merge starts.

Is there a reason why we prefer as small an offset as possible?  I
am not objecting to the choice of 1 second, but am curious if
anything bad happens if we used a larger offset, say, 2 hours.

Thanks.
