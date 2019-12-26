Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4294BC2D0C0
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 18:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB8A20828
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 18:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SGmuEtKs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfLZScn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 13:32:43 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51713 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfLZScn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 13:32:43 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 87AF6A7CB2;
        Thu, 26 Dec 2019 13:32:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uc2P6/OU+rPzMJNesbnkVNZO7rw=; b=SGmuEt
        Ks0Lyw55RP0JRx3aLupt7097z/ECh/pVNdUW7OpbN0FBQu1mU63dIqHlEsXf5tJY
        iu9ldbhvIk/KKBTrpc2uvr/iakqBLCGe3V5TYvu5w52kPiedh6SLFbNUw9pCzISD
        5RCSbSHHGR1F3nrdZm9B4id56oZXUtIKjkdVM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JtH7Wcb3mz5UrjRKsjFLLCLTc4ooxvzb
        8iGQZwngQ3qOJHEL1qZ77mHowv2g4eQepnsD8FT7sbIgTAynxR481NJc5hfpoeEN
        KKzG7GYVjAk94jr4tRuI1T6ngl089oatQs9ltS+BmHLwRAofqrCt4oNfqwW5aS3N
        sAOJ1gSjgqE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7F247A7CB1;
        Thu, 26 Dec 2019 13:32:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 97035A7CAE;
        Thu, 26 Dec 2019 13:32:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] packfile: replace lseek+read with pread
References: <20191226104220.27325-1-e@80x24.org>
        <20191226104220.27325-3-e@80x24.org>
        <xmqqzhffkku2.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 26 Dec 2019 10:32:35 -0800
In-Reply-To: <xmqqzhffkku2.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 26 Dec 2019 10:23:01 -0800")
Message-ID: <xmqqv9q3kke4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1773DFFA-280E-11EA-A6CA-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Eric Wong <e@80x24.org> writes:
>
>> We already have pread emulation for portability, so there's
>> there's no reason to make two syscalls where one suffices.
>>
>> Furthermore, readers of the packfile will be using mmap
>> (or pread to emulate mmap), anyways, so the file description
>> offset does not matter in this case.
>
> s/description/descriptor/ probably.
>
> After seeking to the packfile trailer and reading the pack id hash
> using lseek+read, this helper function does not read from the file
> descriptor, and the sole caller of it closes the file descriptor
> immediately after it returns, which means the read file offset after
> reading the packfile trailer does not matter.

Oops, that was not right.  When we successfully open the packfile,
we leave the file descriptor open, so we do need the "we never read
using read(2) from the file descriptor" guarantee for this change to
be correct.

But we do have the guarantee, and existing code does depend on the
guarantee, so the patch is good.

Thanks.
