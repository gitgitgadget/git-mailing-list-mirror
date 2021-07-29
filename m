Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84ABBC4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 20:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60DF760F4A
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 20:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbhG2UqK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 16:46:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63449 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbhG2UqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 16:46:09 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DA309E2A7F;
        Thu, 29 Jul 2021 16:46:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JnKsl3wVtK690KYTqGBi5Xze1VaGvCgtQg9y0C
        lIYQk=; b=VpiTRO5HFjjg7jYhqDCE8DUzcubPqTFnt6PLCjA4mm3K/pNVaK13S3
        UxgdZcbcaRBZdhcfNFdt8VDr0gwvMXaL5sotjQ/1qYtQR4aw+J0gSTqkCzufDZko
        Pjm7g6nr45ChGfRLWZ1Cu/whInXP7paEhgkYXfcKsDgKi/blvZgqk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BE152E2A7E;
        Thu, 29 Jul 2021 16:46:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 86C18E2A7D;
        Thu, 29 Jul 2021 16:46:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitgitgadget@gmail.com,
        git@vger.kernel.org, hanwen@google.com,
        sandals@crustytoothpaste.net, rsbecker@nexbridge.com,
        bagasdotme@gmail.com, hji@dyntopia.com, avarab@gmail.com,
        felipe.contreras@gmail.com, sunshine@sunshineco.com,
        gwymor@tilde.club
Subject: Re: [PATCH v6 5/9] ssh signing: parse ssh-keygen output and verify
 signatures
References: <725764018ceb5bcecc748cc5169d4305ea9d7d23.1627501009.git.gitgitgadget@gmail.com>
        <20210728230452.2719333-1-jonathantanmy@google.com>
        <d4bda019-bbea-6645-e46a-18a702d3f0ad@gigacodes.de>
Date:   Thu, 29 Jul 2021 13:46:03 -0700
In-Reply-To: <d4bda019-bbea-6645-e46a-18a702d3f0ad@gigacodes.de> (Fabian
        Stelzer's message of "Thu, 29 Jul 2021 11:48:18 +0200")
Message-ID: <xmqq8s1o4zn8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FD60E260-F0AD-11EB-A951-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> On 29.07.21 01:04, Jonathan Tan wrote:
>
>> Also, is this output documented to be stable even across locales?
> Not really :/ (it currently is not locale specific)

We probably want to defeat l10n of the message by spawning it in the
C locale regardless.

> The documentation states to only check the commands exit code. Do we
> trust the exit code enough to rely on it for verification?

Is the exit code sufficient to learn who signed it?  Without knowing
that, we cannot see if the principal is in or not in our keychain,
no?

> If so then i can move the main result and only parse the text for the
> signer/fingerprint info thats used in log formats. This way only the 
> logs would break in case the output changes.
>
> I added the output check since the gpg code did so as well:
> ret |= !strstr(gpg_stdout.buf, "\n[GNUPG:] GOODSIG ");

Does ssh-keygen have a mode similar to gpg's --status-fd feature
where its output is geared more towards being stable and marchine
parseable than being human friendly, by the way?

Thanks.
