Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6A8C433ED
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 20:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 565F2610CF
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 20:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbhDAUOH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 16:14:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51678 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235593AbhDAUOG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 16:14:06 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 44EC4C0DD3;
        Thu,  1 Apr 2021 16:14:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QvqQC9k+gh6vhy7f9ZZ4T4Tg5bw=; b=cGuItH
        E9LnsMEJopzrAjdMUqFGSF/yVbXre/knFWAO5Ush0T7OP+D3y7SITdGxKfJ32wap
        iMLPUXZXcMCBLrH4prN0A1p7VF5cFEurSk6RDtNVSEuGVL0LCIF/dsutHou1Z1qx
        Kk5MDBUZ10W9Bw6cxoP6LJq7oxaEovIQMZB+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XozoVRRTy/7cgSUrjanVSzxe4lpmYdHJ
        E9bH8g9kpe6dRhycI4j970DySzbzrRM/ezn+VZ4Hc1zov+faQarEt1c21Vjyt5GR
        Kjhkw3BcnaxTNQofxxeOUZF1yQZ7hrVG63F0y4hQQdXKQIFmrA2f1/Bl1t1htVC4
        CtsgEQ3eiAw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 39EBDC0DD2;
        Thu,  1 Apr 2021 16:14:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A9071C0DD1;
        Thu,  1 Apr 2021 16:14:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Tom Saeger <tom.saeger@oracle.com>, git@vger.kernel.org
Subject: Re: should git maintenance prefetch be taught to honor remote.fetch
 refspec?
References: <20210401184914.qmr7jhjbhp2mt3h6@dhcp-10-154-148-175.vpn.oracle.com>
        <d246df21-fdaa-a391-847a-e03e8e664af1@gmail.com>
Date:   Thu, 01 Apr 2021 13:14:05 -0700
In-Reply-To: <d246df21-fdaa-a391-847a-e03e8e664af1@gmail.com> (Derrick
        Stolee's message of "Thu, 1 Apr 2021 15:07:37 -0400")
Message-ID: <xmqq8s613gqa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF12F982-9326-11EB-B923-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 4/1/2021 2:49 PM, Tom Saeger wrote:
>> I've recently setup git maintenance and noticed prefetch task
>> fetches ALL remote refs (well not tags) and does not honor
>> remote fetch config settings.
>
> This is intentional. The point is to get the latest objects
> without modifying any local copies of refs. You still need
> to run "git fetch" manually to update the refs, but that
> should be faster because you have most of the objects already
> in your copy of the repository.

You answered only half of the question, I think.

The plain vanilla refspec after you clone would be

    [remote "origin"]
	fetch = +refs/heads/*:refs/remotes/origin/*

and "maintenance prefetch" intentionally redirect the destination
part away from refs/remotes/origin/ to avoid disrupting the
reference to @{upstream} etc. that are used locally.  And
intentionally doing so is good.

But imagine you are tracking my 'todo' branch which has nothing
common with the history of Git.  You'd have

    [remote "origin"]
	url = git://git.kernel.org/pub/scm/git/git.git
	fetch = +refs/heads/todo:refs/remotes/origin/todo

If "maintenance prefetch" does "+refs/heads/*:refs/prefetch/origin/*",
you'd end up the history of Git, which is not interesting for you who
are only interested in the 'todo' branch (to be checked out in the
Meta subdirectory to use Meta/cook script or read Meta/whats-cooking.txt
file).

So, redirecting the right-hand of configured refspec is a good idea;
not copying the left-hand of configured refspec, and unconditionally
using "refs/heads/*" is not.

