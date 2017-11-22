Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 917262036D
	for <e@80x24.org>; Wed, 22 Nov 2017 02:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751500AbdKVCMY (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 21:12:24 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61467 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751415AbdKVCMX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 21:12:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6BE33BA50D;
        Tue, 21 Nov 2017 21:12:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ORjlEuN7ZKEatg1AhU7ZbhC31ao=; b=Yy7KyO
        Xf6m30CpBNZammmFqlmRM4y/u1Quwjcwz6T34PSn6aON1JXFXsAOP+Q/C5CDRRQe
        1eUNrscuWp3i5rDfXNpILf9vCd1pXANsbpjt2R02/39cSg8bcH/Rw9pMmnzE9W8R
        Yz9HHa946ZFSYbn/3fr4KFoeM2boqcX5664Co=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sjTdmdUe2ioO55iCvV48nD7j1Db5OAPu
        8jOKrF9XLLLM1J6iTkqIpcKFEDU8OiTLlMMoSYzW8w4HVSVFc4xsehzbmGK9FDAR
        +NhW/fImmA3i4PmsfcwmZNTsZTPUBwVQbgOR+ResCSuyRNOUwbpJWApmoDzHe3k8
        sY/hDbR7cYM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 64393BA50C;
        Tue, 21 Nov 2017 21:12:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D79D3BA50B;
        Tue, 21 Nov 2017 21:12:22 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4g?= =?utf-8?B?VGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [RFC PATCH] builtin/worktree: enhance worktree removal
References: <20171121150954.3227-1-kaartic.sivaraam@gmail.com>
        <CAPig+cQrC1MiPrwwPqtdX2tzj1ntFHxO28uqnMBcmVpPPrc_Rg@mail.gmail.com>
Date:   Wed, 22 Nov 2017 11:12:21 +0900
In-Reply-To: <CAPig+cQrC1MiPrwwPqtdX2tzj1ntFHxO28uqnMBcmVpPPrc_Rg@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 21 Nov 2017 16:37:58 -0500")
Message-ID: <xmqqa7zfxdru.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 938A08CE-CF2A-11E7-99D8-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Let me see if I understand. Sometimes you know that you've deleted the
> worktree directory, in which case 'git worktree prune' is the obvious
> choice. However, there may be cases when you've forgotten that you
> deleted the worktree directory (or it got deleted some other way), yet
> it still shows up in "git worktree list" output with no indication
> that it has been deleted (though, ideally, it should tell you so[1]).
> In this case, you see a worktree that you know you no longer want, so
> you invoke "git worktree remove" but that errors out because the
> actual directory is already gone. This patch make the operation
> succeed, despite the missing directory. Is that correct?

Hmph, so the user could be using "git worktree prune" after seeing
the error?  Was there a reason behind "git worktree remove" to be
extra careful to make sure both existed before going forward, or was
this a simple oversight?
