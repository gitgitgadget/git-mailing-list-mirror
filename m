Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EE6C433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 21:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239234AbiBAVD6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 16:03:58 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61769 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbiBAVD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 16:03:57 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 909CE175179;
        Tue,  1 Feb 2022 16:03:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3hzEiCBmsD8/h9bNSEereiJ8To1IYbsAO0cm+C
        yfO60=; b=mUQH50FwLE54/h11+dsiEl0ZCPib1dCugvzLL/109uQHq2WJgIMZSm
        rWfbr3l4QX9xLSinFyc67qeN02JniD5mqcGfykMCuo+e9N5izXMTwgMUSzyloN2K
        Wa/C96dqA19jWiwoOLj62V5Q7tG0n+5o+O/HC2nahzZRf9ODhjFE8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8A58F175178;
        Tue,  1 Feb 2022 16:03:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E1EE0175177;
        Tue,  1 Feb 2022 16:03:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 2/3] t1405: mark test that checks existence as REFFILES
References: <pull.1209.git.git.1643651420.gitgitgadget@gmail.com>
        <1ded69d89709d23147b29f67122b659293414405.1643651420.git.gitgitgadget@gmail.com>
        <YfhUIJuO70va6gr8@nand.local> <xmqqzgnbh7rv.fsf@gitster.g>
        <CAFQ2z_OFRJh9cwxnbDzrshYPGOvJC6Rz1eHTF-aKURno+41Cvw@mail.gmail.com>
Date:   Tue, 01 Feb 2022 13:03:53 -0800
In-Reply-To: <CAFQ2z_OFRJh9cwxnbDzrshYPGOvJC6Rz1eHTF-aKURno+41Cvw@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Tue, 1 Feb 2022 21:06:08 +0100")
Message-ID: <xmqqa6facn9i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 77331AF4-83A2-11EC-BB13-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

>> Because there is no generic reflog API that says "enable log for
>> this ref", a test that checks this feature with files backend would
>> do "touch .git/refs/heads/frotz".
>
> There is refs_create_reflog(), so the generic reflog API exists. The
> problem is that there is no sensible way to implement it in reftable.

Ah, yes, that's correct.

> One option is (reflog exists == there exists at least one reflog entry
> for the ref).

Because the current callers of refs_create_reflog() does want a
reflog created that does not give any entry when iterated, I agree
with you that adding a "fake" reflog entry alone is not a sufficient
emulation of the API.  I think these are all ...

> This messes up the test from this patch, because it
> creates a reflog, but because it doesn't populate the reflog, so we
> return false for git-reflog-exists.
>
> It also turns out to mess up the tests in t3420, as follows:
>
> ++ git stash show -p
> error: refs/stash@{0} is not a valid reference
>
> I get
>
>   reflog_exists: refs/stash: 0
>
> and "git stash show -p" aborts with "error: refs/stash@{0} is not a
> valid reference".

... indications of hat.

I wonder if it is simple and easy to add a new reflog entry type
used as an implementation detail of the reftable.  If we can do so,
then, the reftable backend integrated to the ref API can do these
things:

 - reflog_exists() can say yes when one reflog entry of any type
   (internal to the reftable implementation) exists for the ref;

 - create_reflog() can add a reflog entry of the "fake" type
   (internal to the reftable implementation);

 - for_each_reflog_ent() and its reverse can learn to skip such a
   fake reflog entry.

As there is no way to ask, via the API, the number of the existing
reflog entries, the ref API callers would not be able to tell such
an implementation detail that with reftable backend, create_reflog()
does not create an empty reflog.  To them, a reflog created with the
API call would truly be empty as iterators will not return anything.

Or do we have a list of refs kept somewhere in the reftable data
structure in a separate chunk?  Do we have a bit for each of these
refs to record if the log is enabled for it?  Then instead of the
fake reflog entry, we could implement the necessary semantics a lot
more cleanly:

 - reflog_exists() can just peek the bit.

 - create_reflog() can just flip the bit.

 - there is no need to touch the iterators.

 - the equivalent to files_log_ref_write() can decide based on the
   bit (i.e. what reflog_exists() says) whether to log changes to
   the ref.

It is probably a lot more sensible to fail refs_create_reflog() and
safe_create_reflog() (which is a thin wrapper around the former), if
we cannot implement "a reflog can exist and have no entries yet"
semantics.

Outside the test helper, the only place the helper is used is
"checkout -l" when should_autocreate_reflog() returns false, which
should be rare (as we are updating a branch, it should be either a
detached HEAD or a ref under refs/heads/), so it would not be a huge
practical downside if we cannot prepare an empty reflog anyway, I
would think.

Thanks.

