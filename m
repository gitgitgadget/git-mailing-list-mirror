Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEE9C433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 01:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9588761453
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 01:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbhD2B4A (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 21:56:00 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51061 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhD2Bz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 21:55:59 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8038213059A;
        Wed, 28 Apr 2021 21:55:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ekOZ5IrXmlEGbjcY8Vtn5B3GobQ10C68HX+yYR
        okjew=; b=f7BAwAtvfOy3IiOotlFUcOpsD/AP6JQzrO00oRFKilBthX9sBhimKx
        jAWLHL+bw7jDuP76S9r0aPBec2xrL6Z657gLpYp0brxl0ebX0DcNqREy98y+v/5W
        07eFJc5Mb51cLphKIdv9IrBkFy/swP45HWMmlmrEWBMw62xY356tw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 790B4130599;
        Wed, 28 Apr 2021 21:55:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 82858130598;
        Wed, 28 Apr 2021 21:55:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 2/3] refs/files-backend: stop setting errno from
 lock_ref_oid_basic
References: <pull.1011.git.git.1619173446857.gitgitgadget@gmail.com>
        <pull.1011.v2.git.git.1619191907.gitgitgadget@gmail.com>
        <db5da7d7fb5178c14c1f5733d35bb69813c9c644.1619191907.git.gitgitgadget@gmail.com>
        <xmqqzgxjavks.fsf@gitster.g>
        <CAFQ2z_O=4sUjh1wk6nRijp9Gz2eeqX4=EY+Q-OTi9ppb9ikg3g@mail.gmail.com>
Date:   Thu, 29 Apr 2021 10:55:08 +0900
In-Reply-To: <CAFQ2z_O=4sUjh1wk6nRijp9Gz2eeqX4=EY+Q-OTi9ppb9ikg3g@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Wed, 28 Apr 2021 12:55:07 +0200")
Message-ID: <xmqqa6pham83.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EE3924A4-A88D-11EB-B963-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Wed, Apr 28, 2021 at 6:20 AM Junio C Hamano <gitster@pobox.com> wrote:
>> > These calls do I/O and therefore clobber errno. They are not inspecting the
>> > incoming errno.
>>
>> Hmph, are you saying that these calls do I/O and always the I/O
>> would fail?  A system call that is successfull don't touch errno;
>> only the calls that resulted in failure do.
>
> I'm saying that callers cannot reliably observe the errno result of
> lock_ref_oid_basic, because it might be clobbered by a failing
> follow-up call.

Sorry, I still do not quite get it.  For example, you cite that a
call to lock_ref_oid_basic() in files_create_symref() is followed by
create_symref_locked() that may clobber errno when the latter fails.

But a failing lock_ref_oid_basic() would yield NULL and causes the
caller to leave, before calling create_symref_locked() and letting
it clobber errno, and the caller of files_create_symref() can
observe, when it returns -1 to signal an error, the errno left by
lock_ref_oid_basic(), no?  I would understand it if no caller of
files_create_symref() cares what is in errno when it receives
negative return to signal a failure, though.

And when lock_ref_oid_basic() did not fail, create_symref_locked()
calls helpers that can fail (e.g. fdopen_lock_file()) and result in
errno getting updated to record how it failed (this is also reported
to the user via "error(... strerror(errno))").

So a caller of files_create_symref() may not be able to tell between
lock_ref_oid_basic() and create_symref_locked() which one caused the
files_create_symref() call to fail, but in either case it should be
able to inspect errno to learn what kind of error we got from the
underlying system, no?

