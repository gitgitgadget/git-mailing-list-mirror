Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FCEC433B4
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 04:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE154613FF
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 04:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhD1EVi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 00:21:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57724 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhD1EVh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 00:21:37 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C0B8EAEA10;
        Wed, 28 Apr 2021 00:20:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t9Xu0Djod1iwUX4uPToOw4J9WDE9VJolGy6UOW
        PK8Pk=; b=XkK87oyb1WKMY864xPn8IqGIR5+zWYyh/Q92zx/OcvQYRhbIPQd5eg
        WhDg4TIeSYozrCYOD3izOY39xdSyIrosO3tnr3eIl4WtVK2ikOSMs9gN0U+ZlHP1
        CgvdwuIO2bogmjHcKBByhh08IIx6sThm3Jn0vivc24n5ZizIXRqNc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B789BAEA0E;
        Wed, 28 Apr 2021 00:20:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3BAF0AEA0D;
        Wed, 28 Apr 2021 00:20:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 2/3] refs/files-backend: stop setting errno from
 lock_ref_oid_basic
References: <pull.1011.git.git.1619173446857.gitgitgadget@gmail.com>
        <pull.1011.v2.git.git.1619191907.gitgitgadget@gmail.com>
        <db5da7d7fb5178c14c1f5733d35bb69813c9c644.1619191907.git.gitgitgadget@gmail.com>
Date:   Wed, 28 Apr 2021 13:20:51 +0900
In-Reply-To: <db5da7d7fb5178c14c1f5733d35bb69813c9c644.1619191907.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Fri, 23 Apr 2021
        15:31:46 +0000")
Message-ID: <xmqqzgxjavks.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E46BA04-A7D9-11EB-8638-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Errno is a global variable written by almost all system calls, and therefore it
> is hard to reason about its state.
>
> This is a functional noop, because calls to lock_ref_oid_basic() in this file
> are followed by:
>
> * lock_ref_oid_basic (copy/rename rollback error path)
>
> * write_ref_to_lockfile (both in the rollback path and the success path of
>   copy/rename)
>
> * create_symref_locked (files_create_symref)
>
> * refs_reflog_exists (reflog expiry)
>
> These calls do I/O and therefore clobber errno. They are not inspecting the
> incoming errno.

Hmph, are you saying that these calls do I/O and always the I/O
would fail?  A system call that is successfull don't touch errno;
only the calls that resulted in failure do.
