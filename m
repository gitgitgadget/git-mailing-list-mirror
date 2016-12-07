Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC0301FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 20:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932784AbcLGUg5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 15:36:57 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57614 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932561AbcLGUg4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 15:36:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D2E4562D8;
        Wed,  7 Dec 2016 15:32:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=oy/SUOZuXR0U
        0z7wxu3zxmsDxfc=; b=sIY8iVye1yiQlRfMJ8ISzPrFn27TIZ47IGrfaBq1Xb4L
        EMJKAkOmbL5vcz7HbAt6zFwpKD6OR88WBNqIDT/0wf0GFKMsBzz2FqHentKDtU0I
        izR+r5//UdTUgmFFnyP0S496RE1Zrd3M5jpKP0tame/pLQDoxTsAOMu2+HZlFbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=dPd7a1
        MACQ0X/fS4K/VN8ay7cwtQYZ/X/ZMkHSlcat/P7EVQnLDkrVTjWbYhiWhJpGun2Y
        dzDtLAo0sq0KiCl2tqa6Rb4bPv9UTgs3V7GR1wvWTZaCQYfTNBpV+9CIrxAwgEdS
        rP9t+xxdWG0ZrwmacxNBRbH+eSO8Vs9LWSaCI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3530D562D5;
        Wed,  7 Dec 2016 15:32:16 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A4BD4562D4;
        Wed,  7 Dec 2016 15:32:15 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, peff@peff.net, jacob.keller@gmail.com
Subject: Re: [PATCH] real_path: make real_path thread-safe
References: <1480964316-99305-1-git-send-email-bmwill@google.com>
        <1480964316-99305-2-git-send-email-bmwill@google.com>
        <xmqqtwagy65q.fsf@gitster.mtv.corp.google.com>
        <20161207001018.GD103573@google.com>
        <b73e61f8-0cff-b33e-118a-e530d367c94c@ramsayjones.plus.com>
        <20161207201409.GA19743@tb-raspi>
Date:   Wed, 07 Dec 2016 12:32:14 -0800
In-Reply-To: <20161207201409.GA19743@tb-raspi> ("Torsten =?utf-8?Q?B=C3=B6?=
 =?utf-8?Q?gershausen=22's?=
        message of "Wed, 7 Dec 2016 20:14:09 +0000")
Message-ID: <xmqqtwafwkdt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3DBB1806-BCBC-11E6-A6C5-E98412518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> But in any case it seems that e.g.
> //SEFVER/SHARE/DIR1/DIR2/..
> must be converted into
> //SEFVER/SHARE/DIR1
>
> and=20
> \\SEFVER\SHARE\DIR1\DIR2\..
> must be converted into
> \\SEFVER\SHARE\DIR1

Additional questions that may be interesting are:

    //A/B/../C		is it //A/C?  is it an error?
    //A/B/../../C/D	is it //C/D?  is it an error?

