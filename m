Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91722C4332F
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 06:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358743AbhKZG2R (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 01:28:17 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62832 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242483AbhKZG0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 01:26:16 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EC1F8104EE6;
        Fri, 26 Nov 2021 01:23:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6KdSB9O9/0L4/PcJUCO3hT5/0Lu0eypUbuj0kw
        v2cso=; b=Q9RH2de4QFJ7vhXaET5B5p8QYkMfr6VjTUuERA+UUMCxKtIggBFWT9
        BU5uTavBsl0gDZR+P/7BGqEnst6fWwK6emv6GcB+e+SaKs1t/WyMerOL/xR+fcDE
        xSfl1Cnl3Aywst+U2WsjlFVIeV7GAvJgGioUufYDbP64nbvi1Rkv0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BC322104EE5;
        Fri, 26 Nov 2021 01:23:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D341A104EE3;
        Fri, 26 Nov 2021 01:23:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Enzo Matsumiya <ematsumiya@suse.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4] pager: fix crash when pager program doesn't exist
References: <20211125000239.2336-1-ematsumiya@suse.de>
Date:   Thu, 25 Nov 2021 22:23:01 -0800
In-Reply-To: <20211125000239.2336-1-ematsumiya@suse.de> (Enzo Matsumiya's
        message of "Wed, 24 Nov 2021 21:02:39 -0300")
Message-ID: <xmqqbl27a116.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F3D400C-4E81-11EC-B362-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Enzo Matsumiya <ematsumiya@suse.de> writes:

> When prepare_cmd() fails for, e.g., pager process setup,
> child_process_clear() frees the memory in pager_process.args, but .argv
> was pointed to pager_process.args.v earlier in start_command(), so it's
> now a dangling pointer.
>
> setup_pager() is then called a second time, from cmd_log_init_finish()
> in this case, and any further operations using its .argv, e.g. strvec_*,
> will use the dangling pointer and eventually crash. According to trivial
> tests, setup_pager() is not called twice if the first call is
> successful.
>
> This patch makes sure that pager_process is properly initialized on
> setup_pager(). Drop CHILD_PROCESS_INIT from its declaration since it's
> no longer really necessary.
>
> Add a test to catch possible regressions.
>
> Reproducer:
> $ git config pager.show INVALID_PAGER
> $ git show $VALID_COMMIT
> error: cannot run INVALID_PAGER: No such file or directory
> [1]    3619 segmentation fault (core dumped)  git show $VALID_COMMIT
>
> Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
> ---
> Changes to v3:
>  - change test description, as per Eric's suggestion
>  - drop CHILD_PROCESS_INIT, as per Jeff's suggestion

Thanks.  Everything looks good.  Will queue.
