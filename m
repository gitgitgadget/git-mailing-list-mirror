Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F6C71F461
	for <e@80x24.org>; Thu, 29 Aug 2019 03:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfH2DlG (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 23:41:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64203 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbfH2DlG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 23:41:06 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C8BEA1685F9;
        Wed, 28 Aug 2019 23:41:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f324K3mbZAJzqwiHnHumwNUm8Uo=; b=hFUWuM
        XbyYjVLLoUjS8Dvzb0yRiWOSmqgNKsPjbWzv5aw4Yn9uuY3BTswNy5+dekuEhfjN
        d0fOjjF0cCkmP60gNaVD7xV+C9Nu3eV/kBlAAKYVNlaIVYctVGMt8Kq/J8QAA3Pz
        MvrOW2WTqkP8mNFQksWdUZ3BRSblThp28jf7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=T36wgydrxf3DQjGfdBHirCib1NNiPoF8
        AgoaiqTNyAcfpJflHh7EDCRl9UXLZgKXlMnlT6kcuogEt9XLZig38xNL4C+fTqoZ
        CMSD13SmCAOGxpKH6/LL8/m0D0oT+p/i91R7eJxovtKXpktyyoEkeeyGCbFtVkh6
        afMfq18AE8o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BFBB91685F8;
        Wed, 28 Aug 2019 23:41:03 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2FA041685F5;
        Wed, 28 Aug 2019 23:41:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
Subject: Re: Is git clone followed by git verify-tag meaningful?
References: <20190828203224.GE26001@chatter.i7.local>
Date:   Wed, 28 Aug 2019 20:41:02 -0700
In-Reply-To: <20190828203224.GE26001@chatter.i7.local> (Konstantin Ryabitsev's
        message of "Wed, 28 Aug 2019 16:32:24 -0400")
Message-ID: <xmqq36hk1vw1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D3227C92-CA0E-11E9-B2C2-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> If I know that a project uses tag signing, would "git clone" followed
> by "git verify-tag" be meaningful without a "git fsck" in-between?
> I.e. if an attacker has control over the remote server, can they sneak
> in any badness into any of the resulting files and still have the
> clone, checkout, and verify-tag return success unless the repository
> is fsck'd before verify-tag?
>
> I assume that it would break during the checkout stage, but I wanted
> to verify my assumptions.

What you are trusting and what you are trying to protect?

I am assuming that you are cloning and a commit that has a signed
tag is at the tip of the default branch, which gets checked out and
you want to make sure that what you see in the working tree after
checkout is healthy.  I also assume that you trust your local
machine, its Git and GPG binary included, and also you trust that
the underlying hash function Git uses has not been exploited for
this particular repository.

verify-tag would tell you that the tag you specify is signed by
which GPG key you have in your keychain.  Since tag records the
commit object name, you can check it against the HEAD.  As long
as you trust the underlying hash function and your local Git,
the trust flows from the HEAD's commit object name down to each
and every file checked out to the working tree.  As long as you
did not get any error from checkout, no fsck is needed here.

If your project is high-valued target like the Linux kernel, it is
probably a good idea to enable fetch.fsckobjects so that the
incoming objects are automatically checked while receiving over the
wire.


