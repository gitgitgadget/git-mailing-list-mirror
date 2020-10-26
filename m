Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0ECCC2D0A3
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 17:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5894422265
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 17:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pgHTPtHJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1788882AbgJZR4y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 13:56:54 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55653 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781915AbgJZR4y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 13:56:54 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 565AB10C5B9;
        Mon, 26 Oct 2020 13:56:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Q2ZfTJ8GDsUSc0fZEwHrLMRiCSY=; b=pgHTPt
        HJiAUcSHmhDEq56WBkXr6zr55lUWvnkhydmWDRaUDI86eeFO5jS2mH1Py5bAnYF6
        WCc0VGLZ/qKHRmgesVTxvRV8+jZsiJby3Tsxb+304l0onbbLUWGtINTc2JZjsbJL
        z9cB97jIbZ0Eg2BXXJrnPX1cX1K4Onm2rnv4o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HxUI/4Y0aAQNWbmrJ63sXuD9qGcQSu3a
        I201JAwuwKKyrcjJ86RImbjsw6UJG/0/RvUD6XpF7SUGuhhN4oIE/Qtcz/Ztjmys
        J0GaaxIQkFcikZkRobSUWthF6P4aIQNTiJN7P7zKd9dSV7PQfXLV+PKUFAtxgeww
        jdxthvmUtpg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4E81C10C5B8;
        Mon, 26 Oct 2020 13:56:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9ACD810C5B7;
        Mon, 26 Oct 2020 13:56:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
Subject: Re: Do porcelain command require lock management?
References: <20201024144637.cvwa22f2y4tvfn4z@chatter.i7.local>
Date:   Mon, 26 Oct 2020 10:56:48 -0700
In-Reply-To: <20201024144637.cvwa22f2y4tvfn4z@chatter.i7.local> (Konstantin
        Ryabitsev's message of "Sat, 24 Oct 2020 10:46:37 -0400")
Message-ID: <xmqqy2jseuqn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9F251A90-17B4-11EB-ACEB-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> A script I'm writing performs a succession of porcelain commands to 
> create a commit in a bare git repository:

Meaning 'plumbing' commands?

>
> git hash-object
> git mktree

These take input and create a new object or if the data fed to them
were somehow identical to an existing object, becomes a no-op.

We take the data, hash to compute its name while writing it out as a
loose object to a temporary file.  After finishing this
compute/write we can check if we already have the object and if so
we can just clean up and leave.  There is no race in this case.  If
there is no existing object, we rename the temporary file to the
filename derived from the object name.  If somebody else were
creating exactly the same object at the same time, the renaming to
the final name will fail for all but one of them, but in the end
everybody gets the object they wanted to see in the repository
unless you found a hash collision.  These other "failing" folks
would probably need to "redo" the operation, but when they do so,
their compute/writes would safely become no-op.

> git commit-tree

This may write more than one objects; compute/write for each object
competes with compute/write by other processes independently, but
the overall story is the same.

> git update-ref

You can use the "old value MUST BE this" variant to avoid a race
with another process that tries to update the same ref to a
different value, but if the other process updates the same ref to a
different value _after_ you are done, their update will overwrite
what you did, so they also need to be using the same "old value MUST
BE this" variant.
