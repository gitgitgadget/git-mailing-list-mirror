Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 428461F407
	for <e@80x24.org>; Fri, 15 Dec 2017 18:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755554AbdLOSam (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 13:30:42 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64411 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755419AbdLOSal (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Dec 2017 13:30:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4AF18B9763;
        Fri, 15 Dec 2017 13:30:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vlXsg2lfqCpQ8wYV9aKeUk1XTH4=; b=rhI8Dx
        V3E6wKYKKvXdNVmirZ+w5bBc0bGG7wxK8D/k0NFNW5aK/aV8oucUSTlg4Io2bv6B
        6Gd3K/AIxuWiCV2rtWcw/IeJKpeqpqlwDdP8eIi8i0DA/AOQ6ctggHZbyxG27eVF
        s5sIgiWPPEEwpt+5s6W/0gNmEM41yah0xgKUA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uJ9G/P3mIRrtHRPyQMF+FtUXaPWFLI9W
        2ToUGlZZ3OLWiScuj2bdGYv1lKqcfU/WpouHLuauI2Oj5G+dFu0WXE20AGY4H3sb
        Awefo5Ab4ojTnFVqdG2a8NAkZnAJDL8pHbWqs2WjtCZ62ZKo7mN6sa2aFTpQaujh
        T/0D4NPlWzk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 41593B9762;
        Fri, 15 Dec 2017 13:30:40 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B536DB9760;
        Fri, 15 Dec 2017 13:30:39 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Peart <peartben@gmail.com>,
        Jameson Miller <jameson.miller81@gmail.com>
Subject: Re: Question about the ahead-behind computation and status
References: <030bf57c-7a23-3391-4fc0-93efee791543@jeffhostetler.com>
        <20171215100835.GC3567@sigill.intra.peff.net>
        <88175f57-082d-ad61-c2dd-53ae50540460@jeffhostetler.com>
        <d16339e0-54bd-073b-fa4a-7c3a84a025e9@gmail.com>
Date:   Fri, 15 Dec 2017 10:30:38 -0800
In-Reply-To: <d16339e0-54bd-073b-fa4a-7c3a84a025e9@gmail.com> (Derrick
        Stolee's message of "Fri, 15 Dec 2017 10:43:34 -0500")
Message-ID: <xmqqa7yjrghd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D189FA4-E1C6-11E7-97D2-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> The biggest reason for the 20 seconds is not just the number of
> commits in the ahead/behind but how many commits are walked (including
> common to both branches) before paint_down_to_common() breaks its
> while loop due to queue_has_nonstale().

Hmm, queue_has_nonstale() looks to see if any element is not STALE
(where the definition of STALE is "known to be a common ancestor")
by potentially checking all elements in the queue.  I wonder if we
have an opportunity for a trivial optimization?  When the caller
knows that it dug one level and added the parents that are not
stale, it does not have to ask queue_has_nonstale() if there is any
non stale element, for example.

What do you exactly mean by "not just the number of commits in the
ahead/behind"?  Aren't the number of these commits pretty much
proportional to the number of commits we need to paint down to
common ancestors?  Is the latter a lot larger than the former
(i.e. are we somehow not stopping when we _could_ notice that we
can with better information)?


