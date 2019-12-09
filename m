Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5CDC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 21:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B1F206D5
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 21:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TWaByO1Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfLIVSU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 16:18:20 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57321 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfLIVSU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 16:18:20 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 820CFAA11C;
        Mon,  9 Dec 2019 16:18:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SKruxSlZW2K5PltrZsN9qSzMZtk=; b=TWaByO
        1ZeGaiTpnLwExGvrKMX0gB8DrP6s99oqWoGYSDn5lu+lgY55jkOCvJPZg0H6w9z5
        Emq4OjVYHJFa5f6emOhvtfjUshEeEayjtqNwdlkM3uyRSium0Fz4NNAIkl4i9LuY
        u5KpZuLXaYYlYVR1MpEls0HimpkDrs2GtQzGk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HbrjPtAQx7Ii3ItHI+pQyiJZL/WdR6tP
        8DB/uaOVoxKQ47U/vbJIaKGv1vGJyXA/Ovysfwq7qFHub9KANFLdUBy0gKySsVYg
        AojF/C9XC9Urr+9gfDuooDFYXPTOL4vab4jvsWe4QmbxvUDwAOSpAjrTMhiBNPtJ
        IYBT44zNEgc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7A74EAA11B;
        Mon,  9 Dec 2019 16:18:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A5B0AAA11A;
        Mon,  9 Dec 2019 16:18:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     otalpster@gmail.com, git <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] entry.c: use dir-iterator to avoid explicit dir traversal
References: <20191208180439.19018-1-otalpster@gmail.com>
        <CAHd-oW4MzH9Wrb2zNPF0JBN8+FRB4NtDX0166Qt2Kbqs0mDgcw@mail.gmail.com>
Date:   Mon, 09 Dec 2019 13:18:12 -0800
In-Reply-To: <CAHd-oW4MzH9Wrb2zNPF0JBN8+FRB4NtDX0166Qt2Kbqs0mDgcw@mail.gmail.com>
        (Matheus Tavares Bernardino's message of "Mon, 9 Dec 2019 14:41:31
        -0300")
Message-ID: <xmqqv9qptcyz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 69F97020-1AC9-11EA-B86A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:

>> The changes pass the test suite t/ and Travis CI.
>> Please point out any mistakes.
>> ...
>> -               strbuf_addch(path, '/');
>> -               strbuf_addstr(path, de->d_name);
>> -               if (lstat(path->buf, &st))
>> -                       die_errno("cannot lstat '%s'", path->buf);
>> -               if (S_ISDIR(st.st_mode))
>> -                       remove_subtree(path);
>> -               else if (unlink(path->buf))
>> -                       die_errno("cannot unlink '%s'", path->buf);
>> -               strbuf_setlen(path, origlen);
>> +               if (unlink(iter->path.buf)) {
>
> unlink()-ing a directory in Linux will return a EISDIR error. So I
> think you still need to use S_ISDIR() to check if iter->path.buf is a
> directory and call rmdir(), in this case.
>
> However, note that the dir-iterator API gives entries in pre-order.
> I.e. a directory appears before its subentries. In the use case of
> remove_subtree(), though, we need to traverse in post-order, since we
> have to remove the subentries before removing the directory where they
> reside. My suggestion is that you add a preliminary patch,
> implementing a new DIR_ITERATOR_POST_ORDER flag to dir-iterator.h, and
> then use it in this patch.

Thanks for a review and a few hints to nudge a new contributor in
the right direction.  Very much appreciated.

I wonder why the bugs in this patch weren't caught by self test we
already have, by the way.  We need a bit better test coverage,
perhaps?

