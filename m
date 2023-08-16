Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF01C41513
	for <git@archiver.kernel.org>; Wed, 16 Aug 2023 18:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345481AbjHPSYz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Aug 2023 14:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345525AbjHPSYx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2023 14:24:53 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017D810C1
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 11:24:50 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5616F1AE030;
        Wed, 16 Aug 2023 14:24:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=W3o1qQSdOj1Ak5DOwM2Ye+BBnsJsrVqaCfU8yJ
        SxxaQ=; b=ix5rOQB73SiPWOq9vrQM06c5KFOCwGxzlGa6EXzjKmIMdaaAyFFCdz
        wcjRi4DUgnU0J4UICbczuXvjNXaneQNV37d9MeU17JcEmbtkJBwrVltIOCfnT0Up
        qbM+Aq3QEf3txNwPqOGR44aViiGgWRVa+orBbftjKEJDdTzzNz5pI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F9E31AE02F;
        Wed, 16 Aug 2023 14:24:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B488E1AE02E;
        Wed, 16 Aug 2023 14:24:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [Bug] In `git-rev-list(1)`, using the `--objects` flag doesn't
 work well with the `--not` flag, as non-commit objects are not excluded
References: <CAOLa=ZQmjroDiOcUsu_MHtQ-88QHU9qeZPOPh+KJJ3dFoF2q0A@mail.gmail.com>
        <xmqqttt0hzl2.fsf@gitster.g>
        <CAOLa=ZQPmtqT9OHxh5uFq0rg+9L02tnmh1UE52em-rXPmFR6yg@mail.gmail.com>
Date:   Wed, 16 Aug 2023 11:24:48 -0700
In-Reply-To: <CAOLa=ZQPmtqT9OHxh5uFq0rg+9L02tnmh1UE52em-rXPmFR6yg@mail.gmail.com>
        (Karthik Nayak's message of "Wed, 16 Aug 2023 00:56:58 +0200")
Message-ID: <xmqqbkf6g80f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2F90E846-3C62-11EE-B91A-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Karthik Nayak <karthik.188@gmail.com> writes:

> The provided reproduction recipe unfortunately uses a linear
> history and therefore, is not the same as the example provided by
> me. Here is a reproducible recipe following the same commands you
> used:
> $ rm -fr new ; git init new ; cd new
> $ echo foo >foo
> $ git add -A; git commit -m one; git rev-parse HEAD
> 26fb965d7439c1760677377bf314d8933de0b716
> $ mkdir bar; echo goo >bar/goo
> $ git add -A; git commit -m two; git rev-parse HEAD
> $ git checkout -B branch
> $ git reset --hard @~1
> HEAD is now at 26fb965 one
> $ git add -A; git commit -m three; git rev-parse HEAD
> 91ef508167eb683486c3df6f8d07622b61ed698d
>
> $ git rev-list --objects HEAD ^master
> 91ef508167eb683486c3df6f8d07622b61ed698d
> ff05824d2f76436c61d2c971e11a27514aba6948
> 8baef1b4abc478178b004d62031cf7fe6db6f903 abc
> 086885f71429e3599c8c903b0e9ed491f6522879 bar
> 7a67abed5f99fdd3ee203dd137b9818d88b1bafd bar/goo

Thanks, but the above is not recreating the same as your original
(where did "moo" go???).  Also "git rev-parse HEAD" for the sanity
checking should be spelled "git rev-parse HEAD:" if you want to help
others looking into the issue---anybody trying to reproduce will NOT
have the same commit object name, but the point of these checks is
to show the tree object name, which should reproduce for them.

