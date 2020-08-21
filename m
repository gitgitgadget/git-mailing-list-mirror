Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE7AC433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 18:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACF3F20720
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 18:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GCatROjR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgHUSJS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:09:18 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61138 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbgHUSJL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 14:09:11 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 05651E3430;
        Fri, 21 Aug 2020 14:09:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8rXVqFVbKURTw8Iv2apFdIkRsUo=; b=GCatRO
        jRcyBxjhkNL5JejMrGipFarwXKsWRgvK3byjFvDG0kIVK+VdJfUcBMh9n3PCHgdi
        wJwby0DPz50mvYoBTyaxW8L129QLi2Cnd+bzZXE/+4f+j9R4esWSdmSNg/PSEut/
        Gna6wMPYa4s6aQFDqLsaSwpRNEgMzM4ObUf0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uj5QsEwYNjlUfq2xUQkbRpmxmGFWs2fE
        kQM4DAWPXgs1KYZt7Rzlrs6p2yfOxZiSlMjrWFS2bkV/tuScF1o9waHhRO64e4f6
        JvT+duPnUzR0gKitymp2uuJSWe4NXrjGFmu8NN/SWk8AM7NcLJy/nC7VixDRN7Qp
        hZRwMP7Pww8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F1A03E342F;
        Fri, 21 Aug 2020 14:09:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2B9ADE342C;
        Fri, 21 Aug 2020 14:09:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, chriscool@tuxfamily.org,
        christian.couder@gmail.com, git@vger.kernel.org,
        kaartic.sivaraam@gmail.com, liu.denton@gmail.com,
        pc44800@gmail.com, stefanbeller@gmail.com
Subject: Re: [PATCH v3 4/4] submodule: port submodule subcommand 'summary' from shell to C
References: <20200821171705.GA16484@konoha>
Date:   Fri, 21 Aug 2020 11:09:04 -0700
In-Reply-To: <20200821171705.GA16484@konoha> (Shourya Shukla's message of
        "Fri, 21 Aug 2020 22:47:05 +0530")
Message-ID: <xmqq5z9ban27.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 66E5BF4A-E3D9-11EA-8D2E-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

>> I think a test that relies on platform-specific error string is a
>> bug.  It's like expecting an exact string out of strerror(), which
>> we had to fix a few times.
>
>> So I am not sure we would want to butcher compat/mingw.c only to
>> match such an expectation by a (buggy) test.
>
> Alright. That is understandable. What alternative do you suggest? Should
> we change the check in the test?

A buggy check should of course be changed.

It should be sufficient to ensure "git submodule summary" fails,
regardless of what exact error message it issues, no?

If the command does not exit with non-zero exit status, when it
gives a "fatal" error message, that may indicate another bug,
though.
