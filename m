Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C2311F42B
	for <e@80x24.org>; Thu,  4 Jan 2018 19:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753387AbeADTGa (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 14:06:30 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52666 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753382AbeADTG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 14:06:28 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 08C0EC4CA6;
        Thu,  4 Jan 2018 14:06:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FiwMnPHBirA+dEZmAudHCSyzCpo=; b=Aty9hP
        yNz9Vs/08/pItXPy3vTlZr/v0T5fEFbEf4SVcYmZldT6Uh9XVKcGaqVnc9NFAQaP
        8Xlw/9FKz7kSPMa0xNiFRMPq1W+RymszkR8i52pjLNLl4WH1x/eBGXsmpJu5ZDBm
        qwZshPq8NDZUuxQjRmxfARFyaInyRdw4HmkfY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bLg64rZM8k2P1VfUujcqN9lrYm9mYgF8
        43MbOExZfCJHLRd2XrkTWpz6g6heeVKCJqlEW3P/CC3ogHGDJMdiB1ykBmDfjF4+
        EEtbmHG5gnLCF1cK6MyZH8j0Tb1EbTza4QnDqmf96tXYYud96ugeApiK9j20x16T
        98iB1tueVGo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F31D3C4CA5;
        Thu,  4 Jan 2018 14:06:27 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5F4A0C4CA2;
        Thu,  4 Jan 2018 14:06:27 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Segev Finer <segev208@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] connect: add GIT_SSH_{SEND,RECEIVE}{,_COMMAND} env variables
References: <20180103102840.27897-1-avarab@gmail.com>
        <xmqq373mh62r.fsf@gitster.mtv.corp.google.com>
        <87bmiacwoz.fsf@evledraar.gmail.com>
        <20180104044230.GA12113@sigill.intra.peff.net>
Date:   Thu, 04 Jan 2018 11:06:26 -0800
In-Reply-To: <20180104044230.GA12113@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 3 Jan 2018 23:42:30 -0500")
Message-ID: <xmqq608hfnpp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5D7E14BC-F182-11E7-A8AA-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I get that you may have two different keys to go with two different
> identities on a remote system. But I'm not sure I understand why
> "sending" or "receiving" is the right way to split those up. Wouldn't
> you also sometimes want to fetch from repository X? IOW, wouldn't you
> want to tie identity "A" to repository "X", and "B" to repository "Y?
>
>> So now I just have a GIT_SSH_COMMAND that dispatches to different keys
>> depending on the operation, as noted in the commit message, and I can
>> assure you that without that logic it doesn't work.
>
> You mentioned host aliases later, which is the solution I've seen in the
> wild. And then you can map each remote to a different host alias.

Yup, I do agree that it is exactly the established solution for this
kind of situation.
