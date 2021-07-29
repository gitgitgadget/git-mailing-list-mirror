Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AF3C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 01:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C0D460F23
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 01:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbhG2BBp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 21:01:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55791 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbhG2BBo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 21:01:44 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 57F26E5C7D;
        Wed, 28 Jul 2021 21:01:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0Hs/PudV9JS4JRuB1tIgAeBFTrdQKWaJLDKF9F
        wlfZ8=; b=Jx3I4v2nxOfuapLkim8JohfoypbW5Pa2jE2qsDbyunQbj32w3bTIxI
        LncEb3FZ7mMtRR3DExoQvJsyln3CXAgEzcET+anJc/I+AKQfuQdbOR5ClQfsbioP
        pFFydGdYgRtl9aDRHLx2kmxorPaqKLVetEJotRaTi9fpN7/c7YwVw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E1B4E5C7C;
        Wed, 28 Jul 2021 21:01:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CD600E5C7B;
        Wed, 28 Jul 2021 21:01:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     gitgitgadget@gmail.com, git@vger.kernel.org, hanwen@google.com,
        fs@gigacodes.de, sandals@crustytoothpaste.net,
        rsbecker@nexbridge.com, bagasdotme@gmail.com, hji@dyntopia.com,
        avarab@gmail.com, felipe.contreras@gmail.com,
        sunshine@sunshineco.com, gwymor@tilde.club
Subject: Re: [PATCH v6 2/9] ssh signing: add ssh signature format and
 signing using ssh keys
References: <f05bab16096c080891ee8f7e179eecce7f32e839.1627501009.git.gitgitgadget@gmail.com>
        <20210728224523.2716969-1-jonathantanmy@google.com>
Date:   Wed, 28 Jul 2021 18:01:40 -0700
In-Reply-To: <20210728224523.2716969-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 28 Jul 2021 15:45:23 -0700")
Message-ID: <xmqqh7ge6ih7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 88B07732-F008-11EB-B21D-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> +/*
>> + * Strip CR from the line endings, in case we are on Windows.
>> + * NEEDSWORK: make it trim only CRs before LFs and rename
>> + */
>> +static void remove_cr_after(struct strbuf *buffer, size_t offset)
>> +{
>> +	size_t i, j;
>> +
>> +	for (i = j = offset; i < buffer->len; i++) {
>> +		if (buffer->buf[i] != '\r') {
>> +			if (i != j)
>> +				buffer->buf[j] = buffer->buf[i];
>> +			j++;
>> +		}
>> +	}
>> +	strbuf_setlen(buffer, j);
>> +}
>
> In the future, I would prefer refactoring like this to be in its own
> patch. For the moment, this should probably be called "remove_cr" (no
> "after" as CRs are removed wherever they are in the string).

You have me to blame for that "after".  It was meant to signal that
CR's before the given "offset" are retained.

> A config that has 2 modes of operation is quite error-prone, I think.
> For example, a user could put a path starting with "ssh-" (admittedly
> unlikely since it would usually be an absolute path, but not
> impossible). And also from an implementation point of view, here the
> "ssh-" is case-sensitive, but in a future patch, there is a "ssh-" that
> is case-insensitive.
>
> Can this just always take a path?

Sensible simplification, I guess.

Thanks for a careful review.

>> +	if (ret) {
>> +		if (strstr(signer_stderr.buf, "usage:"))
>> +			error(_("ssh-keygen -Y sign is needed for ssh signing (available in openssh version 8.2p1+)"));
>> +
>> +		error("%s", signer_stderr.buf);
>> +		goto out;
>> +	}
>
> Checking for "usage:" seems fragile -  a binary running in a different
> locale might emit a different string, and legitimate output may somehow
> contain the string "usage:". Is there a different way to detect a
> version mismatch?

