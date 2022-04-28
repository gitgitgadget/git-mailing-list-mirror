Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0864C433EF
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 20:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351886AbiD1Ut1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Apr 2022 16:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236992AbiD1UtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 16:49:25 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BBE6929A
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 13:46:09 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3F4D417DB02;
        Thu, 28 Apr 2022 16:46:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=purj9X+KPl330K6do385x+IIy+CH8hMSkjxwfS
        3vADQ=; b=cGM8oO7kcpV1iZ3dR85fQXurfShDCVHo2xXgZS1IhbgkP3mHefL6dT
        7kxAzCNjol6p1DsPb+lO35t7ySuPbYm32X9aXip3eUVoesTOHqN+Jxst8MWf2fc2
        D6olNy2Ao7Rya4LPWQScPZ5AZ/BVQ6McNTqhUOyHQ0z5iPHTzylU8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 37D8017DB01;
        Thu, 28 Apr 2022 16:46:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B416617DAFB;
        Thu, 28 Apr 2022 16:46:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     rsbecker@nexbridge.com, git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] t: add tests for safe.directory when running
 with sudo
References: <20220428033544.68188-1-carenas@gmail.com>
        <20220428105852.94449-1-carenas@gmail.com>
        <20220428105852.94449-4-carenas@gmail.com>
        <xmqq7d79du6c.fsf@gitster.g>
        <000001d85b39$9d5cfc90$d816f5b0$@nexbridge.com>
        <CAPUEsph+p-fD8vMOMU4Djkc8cFUmm=9JVFdgaxkQ4-CpKZgnCA@mail.gmail.com>
Date:   Thu, 28 Apr 2022 13:46:04 -0700
In-Reply-To: <CAPUEsph+p-fD8vMOMU4Djkc8cFUmm=9JVFdgaxkQ4-CpKZgnCA@mail.gmail.com>
        (Carlo Arenas's message of "Thu, 28 Apr 2022 13:22:42 -0700")
Message-ID: <xmqq4k2dey2b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 39700E86-C734-11EC-A1A4-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> It won't, because it is running with sudo ;).  note that as stated in
> the commit message, this requires a fairly open sudo setup (like the
> one github provides with their actions).

Ahh, OK.  So this is pretty much only for CI environment and such,
not on a typical developer and end-user box.

OK, but the potential issues that I raised about cleansed
environment, not limited to $PATH, still exists.  Perhaps
the prereq check can be tightened to something like:

    GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=no-no-name \
    PATH=no-such-path:$PATH \
    sudo sh -c "echo '\$PATH \$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME'" |
    grep "^no-such-path.* no-no-name$"

i.e. we export an envionment with a known value that is unlikely
value for the variable in tester's environment, prepend a known
string that unlikely begins the tester's $PATH, and ask sudo what
values, if any, the process sudo spawned sees in these two
environment variables.  An environment that does not molest PATH and
passes environment variables we set in the tests to affect execution
of "git" being tested will pass the above test.  Otherwise the
environment would silently be breaking our expectation.

