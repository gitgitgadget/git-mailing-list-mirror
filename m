Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D303C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 20:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0301D60F4B
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 20:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbhG2Unz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 16:43:55 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51314 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbhG2Unz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 16:43:55 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5C9161484BD;
        Thu, 29 Jul 2021 16:43:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E9iLPTqUTHxu5ThIKVQFYZt1p0rr08WhXyRJoE
        x7D5E=; b=h7aKczQPsPjOxRs9GfmLHWkF9Tn2rBzZvcsDh/jcD9L6610tArbuLP
        IwqemqBSlDCfgv1dyWgmcWZ/imI8/NxYcRl8CvEpRUZ2pGDS+OTm5+l/SAi/IQE8
        3Zr00nGj7WWyustJYJykmywM1XRdGpVorXpFmL9zire3MV5szpLEI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 545011484BC;
        Thu, 29 Jul 2021 16:43:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9AF871484BB;
        Thu, 29 Jul 2021 16:43:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>
Subject: Re: [PATCH v6 5/9] ssh signing: parse ssh-keygen output and verify
 signatures
References: <pull.1041.v5.git.git.1627391744.gitgitgadget@gmail.com>
        <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
        <725764018ceb5bcecc748cc5169d4305ea9d7d23.1627501009.git.gitgitgadget@gmail.com>
        <xmqq35ry85or.fsf@gitster.g>
        <54671c83-4b1f-5e24-a6ad-226a4f45f952@gigacodes.de>
Date:   Thu, 29 Jul 2021 13:43:46 -0700
In-Reply-To: <54671c83-4b1f-5e24-a6ad-226a4f45f952@gigacodes.de> (Fabian
        Stelzer's message of "Thu, 29 Jul 2021 11:12:27 +0200")
Message-ID: <xmqqczr04zr1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ACF2995E-F0AD-11EB-AFB8-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

>>> +		/* Search for the last "with" to get the full principal */
>>> +		principal = line;
>>> +		do {
>>> +			search = strstr(line, " with ");
>>> +			if (search)
>>> +				line = search + 1;
>>> +		} while (search != NULL);
>>> +		sigc->signer = xmemdupz(principal, line - principal - 1);
>>> +		sigc->fingerprint = xstrdup(strstr(line, "key") + 4);
>> OK.  This does not care the "RSA" part, which is future resistant.
>> It assumes the <algo>:<fingerprint> comes after literal " key ",
>> which I think is a reasonable thing to do.
>> However, we never checked if the line has "key" in it, so
>> strstr(line, "key") + 4 may not be pointing at where this code
>> expects.
>
> Hmm. What would i do if i don't find "key"? Still mark the signature
> as valid an just leave fingerprint & key empty?

We didn't get a satisfactory response from the ssh-keygen we expect
that tells us that the external tool successfully decided that the
signature is good or bad.  I would feel safer if we said we did not
see a good signature in such a case.
