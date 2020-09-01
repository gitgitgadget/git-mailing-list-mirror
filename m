Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3428C433E6
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 15:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEAFB207D3
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 15:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XA/axarn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731965AbgIAP7G (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:59:06 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59457 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732248AbgIAP7B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 11:59:01 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 55C02EF9B4;
        Tue,  1 Sep 2020 11:58:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=W2fmwKiWxcAkIdjCITi4m6ZrBlQ=; b=XA/axa
        rnv3RWiCiTtKuDEQE7s6UbzxSl2Ex5WmSNpvaSxCKO+SqXmSSGdBcn8+1J8WZ/36
        8npJfK3XKukfmWAkRqsGFypxQKkGJT7s5Bq85BpDo/THC4xTNRIAva29Y29eWMvo
        QrqMb2zOhPFlDye4m8WbfTvlDQYcZEPx2JlEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HDGV/25LJ9mINWNTuSyLPJnDGcr5R/xD
        3RvFkVsO6tFjuQqgRRW5EywHgqWfE6ldg7weptHkHlRNadegfXFanH+TPnuiJ/id
        QCWIc4fjlOc2l7zSfVhOMtHgk0mHFWU8tLG4nx/rwo7nuhiteO6AEIXnJHgpbbX0
        j1ygwYxZU8o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4F6CDEF9B3;
        Tue,  1 Sep 2020 11:58:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 88C8DEF9B2;
        Tue,  1 Sep 2020 11:58:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] xrealloc: do not reuse pointer freed by zero-length realloc()
References: <20200901111800.GA3115584@coredump.intra.peff.net>
        <c81b7225-a663-1598-62b3-bd80457d5648@gmail.com>
        <20200901135105.GA3284077@coredump.intra.peff.net>
Date:   Tue, 01 Sep 2020 08:58:54 -0700
In-Reply-To: <20200901135105.GA3284077@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 1 Sep 2020 09:51:05 -0400")
Message-ID: <xmqq3641ebep.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0A8B90A8-EC6C-11EA-969D-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If we do handle it up-front, then I think we'd actually want:
>
>   if (!size) {
>           free(ptr);
> 	  return xmalloc(0);
>   }
>
> (i.e., to never return NULL for consistency with xmalloc() and
> xcalloc()).

Makes sense.  I suspect that this is optimizing for a wrong case,
but in practice that should not matter.  Not having to worry about
a request to resize to 0-byte in the remainder of the function is
actually a plus for readability, I would say.

>> > @@ -120,7 +120,7 @@ void *xrealloc(void *ptr, size_t size)
>> >  	memory_limit_check(size, 0);
>> >  	ret = realloc(ptr, size);
>> >  	if (!ret && !size)
>> > -		ret = realloc(ptr, 1);
>> > +		ret = realloc(ret, 1);
>> 
>> I appreciate all the additional context for such a small change.
>
> Somebody's got to complete with you for ratio of commit message to diff
> lines. :)
>
> -Peff
