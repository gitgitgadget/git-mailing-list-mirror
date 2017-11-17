Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 934EF202A0
	for <e@80x24.org>; Fri, 17 Nov 2017 01:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754488AbdKQBMS (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 20:12:18 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57933 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753486AbdKQBMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 20:12:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CFEC99E332;
        Thu, 16 Nov 2017 20:12:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QkwA/MxvQC8XF2AkWd9GXJ2hR4w=; b=mMJNEa
        h1LMfynh/gnLu1hLtAhtjbeakGNExeO/NC+YyBTioO5sx6khrP5M8waAZpEpynNz
        WxlakArRcwVzkO9UXqw7Yu36k5/8hF+FcxRbOotuo433wQ+7zWrKwEAcvmQ3t4ua
        bho+ILLcGvLYXMkudVean0G+FYlROZBgIx3og=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=T2QLxm+R2cYp1mzLjYMvYtYxgHQxrv41
        y0QQOaJtbOUrCdQbJQ6/eExKoF/Qfar6MSZHdwWNOtSpOtbYU4FmwtuKG4AAJbMF
        GYLMdXsL1yMbFd6oQtl+8NLjefkp7BG+cke9Ov5N419yq2YSkoKqqDWvm+6IBzPD
        zt3bbayv42k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C78969E331;
        Thu, 16 Nov 2017 20:12:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2F9309E330;
        Thu, 16 Nov 2017 20:12:15 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        peff@peff.net, sbeller@google.com, William Yan <wyan@google.com>
Subject: Re: [PATCH 1/5] connect: split git:// setup into a separate function
References: <20171016171812.GA4487@google.com>
        <20171023212740.qodxzsq5w7rn2r6y@aiede.mtv.corp.google.com>
        <20171023213159.eitrjrqrh277advm@aiede.mtv.corp.google.com>
        <20171023151929.67165aea67353e5c24a15229@google.com>
        <20171023224310.o7ftwmbr7n74vvc6@aiede.mtv.corp.google.com>
        <20171023225106.GA73667@google.com>
        <20171023155713.5055125d7467d8daaee42e32@google.com>
        <20171023231625.6mhcyqti7vdg6yot@aiede.mtv.corp.google.com>
        <20171023231703.f457jp43dh7fddpv@aiede.mtv.corp.google.com>
        <xmqqpo9d9v5y.fsf@gitster.mtv.corp.google.com>
        <20171115202516.hduhzsgeoff5a22b@aiede.mtv.corp.google.com>
Date:   Fri, 17 Nov 2017 10:12:14 +0900
In-Reply-To: <20171115202516.hduhzsgeoff5a22b@aiede.mtv.corp.google.com>
        (Jonathan Nieder's message of "Wed, 15 Nov 2017 12:25:16 -0800")
Message-ID: <xmqq4lptvhch.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 592A91AC-CB34-11E7-A09C-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> Which means the defaulting of git_connect::conn to &no_fork is now
>> unneeded.  One of the things that made the original cascade a bit
>> harder to follow than necessary, aside from the physical length of
>> the PROTO_GIT part, was that the case where conn remains to point at
>> no_fork looked very special and it was buried in that long PROTO_GIT
>> part.
>
> Good idea.  Here's what I'll include in the reroll.

Sounds good.
