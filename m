Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 157C81F406
	for <e@80x24.org>; Thu, 28 Dec 2017 18:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753809AbdL1SeW (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 13:34:22 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60102 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751296AbdL1SeV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 13:34:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5674EC455C;
        Thu, 28 Dec 2017 13:34:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IJ1HtMQJZ2U38qh+4WsI14IBm60=; b=EGLga9
        7rnYXzGyCTbcuJxYu1EfH0Sz9oFvSDbeQMQBZbjLD3txZXVIoDLlnFc2DtH4a6Wi
        dkWr52EM54+r7F+TR+77swjO121izH+4H5f/AoDNR1X1nT3oQV4y3/wKkbCPhMKe
        JjPflqvsc09QvajbJ7C0t0mBNXOpc2u7gd0OI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JSI9USWcRZlu6BUA12YmEAnwa5swJ1Wg
        raA4cZtciZwBrE0PPPuWJcyOMHURVGpSa6voBckFOJmZkLsnLhWf1A5k2EEZfkAe
        kEaF0lOXkQst0ENLjzXT/UaiadN2koqKj494BaRHKNBwHfJrDyll2MakawQlKolb
        L8wymVZZpxQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D695C455B;
        Thu, 28 Dec 2017 13:34:20 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C5C84C455A;
        Thu, 28 Dec 2017 13:34:19 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH] status: add a failing test showing a core.untrackedCache bug
References: <20171222140032.21180-1-avarab@gmail.com>
        <xmqqlghoniuk.fsf@gitster.mtv.corp.google.com>
        <87mv24qa2y.fsf@evledraar.gmail.com>
        <20171228061027.GA22308@duynguyen.vn.dektech.internal>
Date:   Thu, 28 Dec 2017 10:34:18 -0800
In-Reply-To: <20171228061027.GA22308@duynguyen.vn.dektech.internal> (Duy
        Nguyen's message of "Thu, 28 Dec 2017 13:10:27 +0700")
Message-ID: <xmqq1sjen1lh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B7A33F56-EBFD-11E7-A7E3-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> Duy, what am I missing here?
>
> The problem is there, it's just easier to see or verify with
> symlinks. Below is my test patch on top of your original one. Two
> points:
>
> - if you look at the test-dump-untracked-cache output, you can see the
>   saved cache is wrong. The line
>
>     /one/ 0000000000000000000000000000000000000000 recurse valid
>
>   should not be there because that implies that cached travesal of
>   root includes the directory "one" which does not exist on disk
>   anymore. With the fix, this line is gone.

Nice.

> - We silently ignore opendir() error, the changes in dir.c shows this
> ...
> Report opendir() errors is a good and should be done regardless (i'm
> just not sure if it should be a fatal error or a warning like this, I
> guess die() is a bit too much).

Thanks; I agree that it definitely would be a good change to issue a
warning there.
