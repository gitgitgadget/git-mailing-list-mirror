Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B19AC433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 04:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3461120709
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 04:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237759AbhA0D65 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 22:58:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60042 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S317048AbhA0Bj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 20:39:28 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BCA889E402;
        Tue, 26 Jan 2021 20:38:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lHNxba/VymFI
        OW5mUv5RVs3Ie8Q=; b=nzrEPtLm/gRngK6rU2nyZlyOQGo4g7RK7QMo5rbh042b
        iv1P8fhG6yrmTfKZKm2pGMcnSVjHxfQ0lAIX/RJyDowqnoK8jhuUXGvDrjMpgqey
        VAhH25MU+1H4KqJ78WYWBSucLMrB9RA9jhAnsBEzMJfJvN7cWvX1Eu8BsyZts2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=hvaxcw
        NaxooaJ4gb50NMei0Zyl26FgLIMslyMis1f1+ZB2LnGI2nf1SmLOSYAXZWjry5t9
        UUV+TJkRLICgWW/WjMgCAycSUibfkN2aNDoCaHmKPC8So63bmKQLHU86d9vKjR2F
        cj1glXbZFt81xNwe0MYUzciZTZLTzUeXWbAzU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B46699E401;
        Tue, 26 Jan 2021 20:38:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 421989E400;
        Tue, 26 Jan 2021 20:38:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/4] Makefile: micro-optimize light non-test builds
References: <20210126160708.20903-1-avarab@gmail.com>
        <YBCGtd9if0qtuQxx@coredump.intra.peff.net>
Date:   Tue, 26 Jan 2021 17:38:08 -0800
In-Reply-To: <YBCGtd9if0qtuQxx@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 26 Jan 2021 16:16:37 -0500")
Message-ID: <xmqq5z3jyxa7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4F7FFB3E-6040-11EB-B613-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Jan 26, 2021 at 05:07:04PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>
>> This small series speeds up builds where you just want to get to a
>> working "git" binary, but don't care about running git's own tests, or
>> about making/installing fallbacks for "git svn" et al (which we do
>> even with NO_PERL).
>
> I have to wonder if you really care about non-builtins here. If not,
> then doesn't "make git" do what you want?

I had the same thought, while wondering if all the ugliness in [4/4]
is really worth it.

The steps 2/4 and 3/4 did look like a useful feature, but I wonder
why we even need to introduce NO_TEST_TOOLS in the first place.
Wouldn't it be more natural to arrange them to be built by making
"test::" target depend on them?  IOW, why do we need to have "all::"
(our default) target depend on them?

And if we are not doing [4/4], I suspect [1/4], while it is not bad
as a clean-up, would become less attractive.

So...

