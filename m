Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E113C433B4
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 03:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 570856143A
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 03:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhD3DLg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 23:11:36 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53495 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhD3DLf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 23:11:35 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 07B62121AC1;
        Thu, 29 Apr 2021 23:10:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7cSSqQ1a8Hh1wIL4cE5xfbV+AFyZo4aQ4e6mX/
        YsQ4U=; b=UoDqvrY8cg2DgVluqnsSh91NaauLyBUuq9YMv9PgKaCVJn1PmWHmq/
        ODFpn9LD4QvKV5EOoF3fmiUgGLMFuq5yItELIj2vjKp2WyBq8TDCLtPEBiwHCiFz
        PXJAGMfKX1eL0FzYit7ZKXiQwxrg38C6yWfAUQWNOuvnTgZd5Rk6w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 008AD121AC0;
        Thu, 29 Apr 2021 23:10:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 37742121ABE;
        Thu, 29 Apr 2021 23:10:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 2/8] refs/files-backend: stop setting errno from
 lock_ref_oid_basic
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
        <b2c72097e5e8985e7fdd8e3eee66cdf43d1b65c0.1619710329.git.gitgitgadget@gmail.com>
Date:   Fri, 30 Apr 2021 12:10:43 +0900
In-Reply-To: <b2c72097e5e8985e7fdd8e3eee66cdf43d1b65c0.1619710329.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Thu, 29 Apr 2021
        15:32:02 +0000")
Message-ID: <xmqqbl9weabw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A785D550-A961-11EB-8E5B-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I 100% agree with you that errno is cumbersome to use and carries
far less information than we want (we do not learn what operation
failed on what path) over a long distance.  It only is useful when
the callchain still knows what path was operated on.

But...

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> For the copy/rename support, calls to lock_ref_oid_basic() in this file are
> followed by:
>
> * lock_ref_oid_basic (copy/rename rollback error path)
>
> * write_ref_to_lockfile (both in the rollback path and the success path of
>   copy/rename)
>
> These calls do not inspect the incoming errno. As they perform I/O, they can
> clobber errno. For this reason, callers cannot reliably observe the errno that
> lock_ref_oid_basic() generated, so it is unsound for programmatic use.

In the latter part of the above, "callers" refers to the callers of
"the copy/rename support" (aka files_copy_or_rename_ref())?

Then I am not sure why "callers cannot reliably observe the errno
that lock_ref_oid_basic() generated" is a problem.  They will see
the errno from the last system call that failed, if they care.  So
their performing I/O is perfectly acceptable, too.

Hence, I am not sure what change the above justifies, if any.

If we can show that no caller of files_copy_or_rename_ref() uses
errno, it is a clear indication that lock_ref_oid_basic() is saving
and restoring errno for no good reason.  I think that is what was
done for the other two callers below.

So I traced what happens after the copy-rename thing gets called.

refs_rename_ref(), rename_ref(), refs_copy_existing_ref() and
copy_existing_ref() (all in refs.c) should be the only callers of
the function.  All callers in builtin/branch.c and builtin/remote.c
of these functions (by the way, refs_X() variants do not seem to be
called from anywhere---are they over-engineered?) just die() when
they signal a failure by returning non-zero, so I think it is safe
and much easier to understand to justify this change like so:

    refs/files-backend.c::lock_ref_oid_basic() tries hard to signal
    how it failed to its callers using errno.  The three callers of
    this file-scope static function are 

    * files_copy_or_rename_ref()
    * files_create_symref()
    * files_reflog_expire()

    None of them looks at errno after seeing a negative return from
    lock_ref_oid_basic() to make any decision, and no caller of
    these three functions looks at errno after they signal a failure
    by returning a negative value.

> For files_create_symref() and files_reflog_expire(), grepping over callers
> showed no callers inspecting errno.

Yes, this is a lot more relevant justification to allow these two
functions, and functions that are called _only_ _by_ these two
functions, stop worrying about errno.
