Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A3FC432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 03:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7AF2068D
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 03:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gOtlJYet"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfKVD4f (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 22:56:35 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60322 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfKVD4e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 22:56:34 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BB0978C656;
        Thu, 21 Nov 2019 22:56:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8HCQocySTDVVPPqWXQLill51VDw=; b=gOtlJY
        etLhMRUY5sBULw8zgxPeiPnYuMg4umFNbjsWF/9CRCX5kNMS4UHvrQ1kSWiXrANr
        LPJwI16MWekhMGS02vQUFosPYqUePjERafVC6EfXmZZb5mr2eqwwwV9cObdEGURF
        uMwxHVt+bhH9XuXMeF6XZsvQtF+KMgai1YvCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=E97+goG0cOjG17Wdbfo0AiSc5GTiIWhS
        e9VNqzSMr1652PxfEek5GuQozWWkAr+fcnUE10hmvLkxxATlO3vipXh/k3tA0Aq5
        usZx8ODGj5EmPe2h1s6vnuDvvSPepcOBhEwEWNwhZyOGgsS3MH5ixi0Tdpklejzk
        vlPXR/k45Wo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B35128C654;
        Thu, 21 Nov 2019 22:56:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E0D768C653;
        Thu, 21 Nov 2019 22:56:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] grep: provide pathspecs/patterns via file or stdin
References: <20191122011646.218346-1-emilyshaffer@google.com>
        <20191122021419.GA52557@generichostname>
        <xmqqwobs7i6u.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 22 Nov 2019 12:56:27 +0900
In-Reply-To: <xmqqwobs7i6u.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 22 Nov 2019 11:34:17 +0900")
Message-ID: <xmqqa78o7edw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 109EC03E-0CDC-11EA-89B3-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Denton Liu <liu.denton@gmail.com> writes:
>
>> The reason I ask is because (correct me if I'm wrong) a lot of other git
>> commands (like add, reset and checkout) don't seem to accept pathspecs
>> via stdin and could suffer the same problem. xargs seems like a more
>> general way of solving the problem of long command lines.
>
> There are things "xargs" is sufficient, and there are things that
> absolutely requires a single invocation of "git".  "grep" is a bit
> of both.

Sorry for not addressing your sample commands.

The "add", "reset", "checkout" subcommands are fine examples that
driving them with "xargs" is 100% sufficient and there is no need
for the pathspec-from-file thing; adding it to them would probably
not make the system any worse, but it is far far less important than
some other "git" subcommands for which "xargs" does not work as a
replacement.

Thanks.
