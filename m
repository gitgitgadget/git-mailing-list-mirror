Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C23B1F406
	for <e@80x24.org>; Fri, 22 Dec 2017 18:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756322AbdLVSkm (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 13:40:42 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53566 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756037AbdLVSkl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 13:40:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EB743BD299;
        Fri, 22 Dec 2017 13:40:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ymM3+18Ai+kChbcvujVM+Y4qqfQ=; b=HJ+ibz
        jPMgJt7Fwgc3NYXVvOSwg0dNkEkbSph2XAZ0u4djxzy/4x1wZ2TDvEOTQVNEFI1Q
        XfRjpok5fGjrEhKsuKVq8p8Hj60sTZ0JDx2Bg+qPNza5y+AaxGNn0XVQ5tggIesi
        nXq3NTWHr36gY5U2halDPj9jKaNmaoGJTun9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XZuqAQcscxQSw8a0wY2EpH2czMxnygqJ
        +sv8YugQJFpoBnPsLno9+gzsPf06dJci5TKcOOCSrQ2prOGsloipqjuO0FmtDKiI
        mpFMGzsawT+UXYH1EM6ETeFOJYXTGvoA630tyt7qcZvwcrLic+USwthayp55a/bu
        dWiSQDN473g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D8AEABD298;
        Fri, 22 Dec 2017 13:40:40 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 211A6BD296;
        Fri, 22 Dec 2017 13:40:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "phillip.wood\@talktalk.net" <phillip.wood@talktalk.net>,
        git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH] sequencer: assign only free()able strings to gpg_sign
References: <f4420880aa4ee73b7c8e435de1efccf9a969fd41.1513943347.git.johannes.schindelin@gmx.de>
        <17655681.1077671513947507373.JavaMail.defaultUser@defaultHost>
        <alpine.DEB.2.21.1.1712221817470.406@MININT-6BKU6QN.europe.corp.microsoft.com>
Date:   Fri, 22 Dec 2017 10:40:38 -0800
In-Reply-To: <alpine.DEB.2.21.1.1712221817470.406@MININT-6BKU6QN.europe.corp.microsoft.com>
        (Johannes Schindelin's message of "Fri, 22 Dec 2017 18:20:31 +0100
        (STD)")
Message-ID: <xmqqpo76sj15.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9BD939A2-E747-11E7-BD7F-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I thought the bug could be triggered when commit.gpgsign was true and 
>> it was not overriden on the commandline, is it worth adding a test for 
>> that?
>
> ... If we want to verify that the
> gpg_sign is correctly allocated before it is free()d, then the test case I
> added *already* covers it,...

It depends on what we are testing, how we anticipate this code will
be broken by others in the future and how we want to futureproof the
code.  We can say "already covers it" if we know the implementation
(especially, the code calls free() when it replaces opts->gpg_sign
always, so the other side you are choosing not to test will die the
same way) and assume it won't be broken (i.e. the attitude is OK for
whitebox testing).

I'd think that this particular case it is sufficient to test just
one; I doubt that adding another will increse the test load
measurably, though.





