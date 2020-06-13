Return-Path: <SRS0=iF2w=72=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CF0C433DF
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 00:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5A8520739
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 00:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iTkckI7F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgFMA2O (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 20:28:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55628 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgFMA2L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 20:28:11 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D57AC7DAF1;
        Fri, 12 Jun 2020 20:28:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dvIhUg29JlopqJQUX5DuJTOXhbo=; b=iTkckI
        7FFtruyBkZWLaAVHIrLSIzqkVaMIdkHwD6CUQrPEgRLHe8GR+ulURc3LuJFIXU2R
        MkpN0Du4KaJFuzf8w43+z1/CeWl4/BowMncujO5JL0JPP9gp3Ra8RH8KoRHEGbjy
        CQRP4SbPluTjtPecUfj9g45M3+7295z+Sy4qo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vpyqamtPoo0TajEnuPEFO5JkgWQAf/UK
        zDAedpmGry+oa43x7Cw+41Me0eSbpZrioFWx54nbyC1LO/Btsl+NzEjj+6k/wB80
        jrriGRQdc5wptIBivXhxwInOLiRsA51aS/U5WTWJXuje5TKMh/HN3NSA525ZTPxW
        c0JOjwddb8E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BA4AA7DAF0;
        Fri, 12 Jun 2020 20:28:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 101327DAEF;
        Fri, 12 Jun 2020 20:28:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, bmalehorn@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 4/4] clean: optimize and document cases where we recurse into subdirectories
References: <pull.806.git.git.1591858774.gitgitgadget@gmail.com>
        <b4cb448e8d76ae16f6fa38a773244bb4a8499938.1591858774.git.gitgitgadget@gmail.com>
Date:   Fri, 12 Jun 2020 17:28:07 -0700
In-Reply-To: <b4cb448e8d76ae16f6fa38a773244bb4a8499938.1591858774.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Thu, 11 Jun 2020
        06:59:33 +0000")
Message-ID: <xmqqzh97zu5k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C133E19C-AD0C-11EA-A346-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> ...
> However, in clean's case we don't need to recurse into ignored
> directories; that is just a waste of time.

Nice.

> Rather than relying on other bugs in fill_directory()'s former
> logic to provide the behavior of skipping ignored directories, make use
> of the DIR_SHOW_IGNORED_TOO_MODE_MATCHING value specifically added in
> commit eec0f7f2b7 ("status: add option to show ignored files
> differently", 2017-10-30) for this purpose.

Thanks.

