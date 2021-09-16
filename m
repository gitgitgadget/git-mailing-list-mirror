Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2ACC433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 06:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6077601FC
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 06:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbhIPGUr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 02:20:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57187 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbhIPGUr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 02:20:47 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B8289D27C9;
        Thu, 16 Sep 2021 02:19:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2+IHuyN1PsXZvO9ELdwvcTSf43w/GC0ZTP6hFk
        wC8zY=; b=VZyRDUk+OMzxgTlKM8ohqXeSzItejh7KuqcEVik/zyNoBY6GLIa+KI
        GgZr3xccW1r+jAbmO9hl7yUOy5e5CJ11tI+xc0OVVKZ1aV4jGQZaGVgsY1fZfpmv
        ItiavPnci8Zr6MoS5WxqBu0sfTokktSeKQo8UfkhkQ5+8vaDgDc74=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9DEBDD27C8;
        Thu, 16 Sep 2021 02:19:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0B1B6D27C7;
        Thu, 16 Sep 2021 02:19:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v3 6/6] core.fsyncobjectfiles: enable batch mode for
 testing
References: <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com>
        <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com>
        <55a40fc8fd59df6180c8a87d93fcc9a232ff8d0a.1631590725.git.gitgitgadget@gmail.com>
        <xmqqtuilyfls.fsf@gitster.g>
        <CANQDOdc8F7a3ZeTDpUWrt8uUntnX4jHYxyj96SPwH-P=kMrneg@mail.gmail.com>
        <xmqqy27xv3g7.fsf@gitster.g>
Date:   Wed, 15 Sep 2021 23:19:24 -0700
In-Reply-To: <xmqqy27xv3g7.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        15 Sep 2021 16:12:08 -0700")
Message-ID: <xmqqczp9ujo3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0A1521F0-16B6-11EC-86CF-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Neeraj Singh <nksingh85@gmail.com> writes:
>
>> This commit is mainly to ensure that we get coverage of batch mode on all
>> platforms in the CI infrastructure.  I don't believe it should be included in
>> mainline git without significantly more discussion and experimentation.
>
> Am I incorrect to say that only just a handful of code paths can
> take advantage of the bulk checkin "plugging-unplugging" feature to
> begin with, so running _all_ the existing tests that cover
> everything with this core.fsyncobjectfiles=batch setting is rather
> pointless?
>
> If so, perhaps instead of 6/6, you should identify key code paths
> that would be affected by this feature (perhaps "git add" is one of
> them), and either write a new test script dedicated for this feature
> or piggy-back on existing test scripts that already tests the code
> paths and adding new test pieces there that exercise this new feature.
>
> If it is a good idea to run all the tests with core.fsyncobjectfiles
> set to batch, however, it probalby is easiest to invent a new
> environment variable GIT_TEST_FORCE_CORE_FSYNCOBJECTFILES and have
> it honored as the default when it is set, and add a NEW CI job that
> exports the environment with the value "batch".  

I have to take a part of this back.  A new environment variable that
is honored in the absense of core.fsyncobjectfiles would be needed
if you need to run all tests, but you do not necessarily have to add
a new CI job---instead you should be able to piggyback on an
existing job, by mimicking the way how ci/run-build-and-tests.sh
enables various test options on one of the jobs.

> Other people
> (including the ones from Microsoft, I think) are much more familiar
> than I am on how to make this kind of thing work in GitHub Actions.

This part still stands ;-)  There might be a better way than adding
yet another environment variable.

