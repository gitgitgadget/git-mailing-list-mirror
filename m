Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B462C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 00:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1744F60FD7
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 00:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbhG2A67 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 20:58:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50201 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbhG2A66 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 20:58:58 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 34967DBEDB;
        Wed, 28 Jul 2021 20:58:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fcU9rPIZdYRMiu6fGNmdg4WjsqnqRgAiHsTAES
        BcNK8=; b=sjwF5i1FmM8hYGtEZnIAwViCwO8S1XpPtIvno0cUoZjsH7UG+QQxY7
        WqKTLCxQ4wmK/Viu0HScEsy/rGS+t/rTMUkCh9v/tLahsstpp02Oif3o0I5M829v
        4gcP+PIO8B+DS5AGzwBTjb/AmxoiXkJM2M9uHxBXG2UsKb7CROpB4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2B674DBED9;
        Wed, 28 Jul 2021 20:58:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AEECCDBED8;
        Wed, 28 Jul 2021 20:58:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     gitgitgadget@gmail.com, git@vger.kernel.org, hanwen@google.com,
        fs@gigacodes.de, sandals@crustytoothpaste.net,
        rsbecker@nexbridge.com, bagasdotme@gmail.com, hji@dyntopia.com,
        avarab@gmail.com, felipe.contreras@gmail.com,
        sunshine@sunshineco.com, gwymor@tilde.club
Subject: Re: [PATCH v6 1/9] ssh signing: preliminary refactoring and clean-up
References: <7c8502c65b833e7e563a833b592f6932421b1056.1627501009.git.gitgitgadget@gmail.com>
        <20210728223206.2715554-1-jonathantanmy@google.com>
Date:   Wed, 28 Jul 2021 17:58:55 -0700
In-Reply-To: <20210728223206.2715554-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 28 Jul 2021 15:32:06 -0700")
Message-ID: <xmqqlf5q6ils.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 26453C9A-F008-11EB-A37C-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> -	fmt = get_format_by_sig(signature);
>> -	if (!fmt)
>> -		BUG("bad signature '%s'", signature);
>
> Here is the difference in functionality that I spotted. Here, lack of
> fmt is fatal...
>
>> +	fmt = get_format_by_sig(signature);
>> +	if (!fmt)
>> +		return error(_("bad/incompatible signature '%s'"), signature);
>
> ...but here it is not.

While I was reviewing this step, I was assumign that the callers
would respond to this error return appropriately.  If it is not the
case, then we do have to fix that.

The original's use of BUG() is wrong in any case, I woud think.  The
"signature" there is an external input, so we were reporting a data
error (it should have been die()), not a program logic error.

Thanks.
