Return-Path: <SRS0=aDBb=CX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA39C433E2
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 21:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9DE620759
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 21:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hccKbSTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgINVhZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Sep 2020 17:37:25 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53706 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgINVhV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Sep 2020 17:37:21 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5BFF7105192;
        Mon, 14 Sep 2020 17:37:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/tKUwZ1r1wsjwZeJnnvu8xBEZZY=; b=hccKbS
        ToueZKuV4yNBwuLHcaakKNainbm5EC1R62npr9CLOVqixfllpdUPkIa+KU9s+Ke7
        1hgyFGyIUcIG6QdZTgCR6QOUpwYlOF6S3jeUOWZGu99s9Ep/kXG61HHLMx/PkvE4
        CjVFkx85n90LPq6hPVGngU7gSXQmvBGzV5KD8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=x2Uox0EWIbpjyyyLB9BfIdwPB2E4Iuwk
        rS61+niuEnIfAD24IiWMiOyQ5K61H+MY6xxbVDlHYLqKtJ3FO8CmbltahyqwaXR6
        T7MneaK4EnOuBLbsOemwepgQGWJsv//d+W37TESIoFUrB7IGvZs20k1+zM+jNU33
        hhhITqrSEnU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5495E105191;
        Mon, 14 Sep 2020 17:37:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9EB1010518E;
        Mon, 14 Sep 2020 17:37:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Matheus Tavares <matheus.bernardino@usp.br>
Subject: Re: [PATCH] builtin/clone: avoid failure with GIT_DEFAULT_HASH
References: <20200911151717.43475-1-matheus.bernardino@usp.br>
        <20200911233815.2808426-1-sandals@crustytoothpaste.net>
        <20200912032448.GB1988@nand.local>
        <20200912195256.GN241078@camp.crustytoothpaste.net>
Date:   Mon, 14 Sep 2020 14:37:12 -0700
In-Reply-To: <20200912195256.GN241078@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Sat, 12 Sep 2020 19:52:56 +0000")
Message-ID: <xmqqo8m811mf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7484F60A-F6D2-11EA-9DE1-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> Alternatively, I certainly wouldn't complain if you did introduce a new
>> function and updated the call-site that passes reinit as 1.
>
> I thought about introducing a new function, but since it would share
> almost all of the code, it seemed a bit wasteful, even if the function
> is small.  We do have only two callers, I believe, since I recall
> making this function non-static and calling it from clone, so I think
> it's okay.

Perhaps.

FWIW, this seems to have strange interaction with something in
'seen' when merged; I suspect it is the topic that mucks with the
set-up sequence for "git clone", but didn't check.


