Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974E1C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 22:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ED8061C98
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 22:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhGFWGa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 18:06:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59005 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhGFWG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 18:06:29 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 315FCD2BDE;
        Tue,  6 Jul 2021 18:03:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yHETAcAONwd6voXxUnjKMFaYXsDlc0avyPmSBM
        gno+Q=; b=bIV3055VsHiYJ3klvMYt7FJluWfTPPRL6xDoxIRydCdoN0f9VIHGCc
        BqTMK40aSU0aPs0jrG30vJojufPBH8qG3CrPtZ01z7CkcnVp0whWRrSNhHj4AsEy
        MtygRvwOXJhnrVSF+CQTKqjWHarQvxqEStE8ysNGwu249eMEgLDEQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 291FAD2BDD;
        Tue,  6 Jul 2021 18:03:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 94F6FD2BDB;
        Tue,  6 Jul 2021 18:03:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Avishay Matayev <me@avishay.dev>
Cc:     git@vger.kernel.org, code@tpope.net
Subject: Re: [PATCH 2/3] Allow isatty to be overriden with GIT_FORCE_TTY
References: <20210706210317.706313-1-me@avishay.dev>
        <20210706210317.706313-3-me@avishay.dev>
Date:   Tue, 06 Jul 2021 15:03:49 -0700
In-Reply-To: <20210706210317.706313-3-me@avishay.dev> (Avishay Matayev's
        message of "Wed, 7 Jul 2021 00:03:17 +0300")
Message-ID: <xmqqbl7fgkvu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B0D3A40-DEA6-11EB-9F55-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avishay Matayev <me@avishay.dev> writes:

> There are several behaviors where git will not attempt to do an action if a
> tty is not present, for example - `git_pager` (pager.c) will instruct git
> to not use the GIT_PAGER environment variable if stdout is not a pty.

In general, I am negative on this approach, even though I agree that
the issue you are trying to solve is worth solving.  "Force pretend
that we are talking to a TTY" exposes too much of the internal
logic in the implementation to the end users.

Often we use isatty() as an approximation for "are we being
interactive?", and I wouldn't have as much problem as I have with
the "FORCE_TTY" to an approach to give users a knob to tell us "do
not use your logic to guess---I am telling you that we are
interactive, so behave as such".
