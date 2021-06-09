Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDD3C48BD1
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 03:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DFE761354
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 03:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236512AbhFIDkL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 23:40:11 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61998 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236501AbhFIDkK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 23:40:10 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 04245132766;
        Tue,  8 Jun 2021 23:38:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ph7ON4aQL7eY
        cBzz9vyBBLnrVSg++3XjAFdsT+Y2dOg=; b=quZkitoJQlyxpEhFSni/b4wUOmBH
        BzuOhYS0sszFuRafPsEUdbpiQ7xoGO48ahTO+yw8C4LMYB3IEdajYvWjh4+6GO8u
        ssOyeoBlO4a94x+Ndzdq1aJL/PL8FYZwUWB8+zIqcmmiDqZbhrdSNp05bKLBCTnu
        4c+p9j7b/aB2AEE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F1B25132765;
        Tue,  8 Jun 2021 23:38:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 34173132763;
        Tue,  8 Jun 2021 23:38:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] builtins + test helpers: use return instead of
 exit() in cmd_*
References: <patch-1.1-61d7e6e079-20210607T111008Z-avarab@gmail.com>
        <patch-1.1-f225b78e01-20210608T104454Z-avarab@gmail.com>
        <xmqqwnr3nc7i.fsf@gitster.g> <87im2n3gje.fsf@evledraar.gmail.com>
Date:   Wed, 09 Jun 2021 12:38:11 +0900
In-Reply-To: <87im2n3gje.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 09 Jun 2021 03:54:22 +0200")
Message-ID: <xmqqy2bjlnbw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1E526B30-C8D4-11EB-8B74-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> So it's really the opposite of what you're saying. If you have cleanups
> that are truly important, i.e. so important that you'd like to notify
> the user with a non-zero exit code if they fail, you *don't* want them
> in an atexit handler. That won't work.

Ah, OK.  What I had in mind was things like removing the directory
"clone" attempted to create and populate, removing temporary files,
etc.  when a function that is not marked as NORETURN calls die(), by
the atexit handler.  But you're right.  We leave a final clean-up
for normal returns (i.e. when cmd_foo() intends to return or exit
with 0) to be done to the caller that is git.::run_builtin().

Thanks.
