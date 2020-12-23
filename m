Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9181C433DB
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 20:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 720BD223E4
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 20:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgLWUKk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 15:10:40 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53104 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728222AbgLWUKk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 15:10:40 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 26E53AA26E;
        Wed, 23 Dec 2020 15:09:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tYWVWiIJ4DX+HGoLfd9Bz35a2sU=; b=TuXtM6
        LePJanT+TaHkjAH2yt+aKGrnqMFXe5Svbsv70vuI4p4a0hpfB6vQg6zjvIi96jEF
        2RHzZ9A1Fb8G9qfnOPC/0yyirueqbxmeiUnLZ4nWY6W9lLbR/ZFsIClw6vNL2hXh
        CuRbrs3TF4FvMDhQSB4uP6Qs4kC/x3j8t5ruw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GlWTSkRA+RNTboMgKJjaIMWRO/0+dtUU
        39U6seXru52f64uhXd8U73lgo2TqRnr19P41j1PIo5NDrZhTyezTJR+r81RnzEhI
        SwR+2M9kzd3VXKQcK2jxwt2QyzEMgeugddcaZ7Th5t8cQW2koibUSiQBZSSZxEG5
        9JsiI0SuywM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DD68AA26D;
        Wed, 23 Dec 2020 15:09:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 97BA2AA26C;
        Wed, 23 Dec 2020 15:09:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     Miriam Rubio <mirucam@gmail.com>, git@vger.kernel.org,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v2 2/7] bisect--helper: reimplement `bisect_replay`
 shell function in C
References: <20201221162743.96056-1-mirucam@gmail.com>
        <20201221162743.96056-3-mirucam@gmail.com>
        <gohp6klfdpbca4.fsf@cpm12071.fritz.box>
        <xmqq4kkdfgln.fsf@gitster.c.googlers.com>
        <gohp6k35zw6drc.fsf@cpm12071.fritz.box>
Date:   Wed, 23 Dec 2020 12:09:57 -0800
In-Reply-To: <gohp6k35zw6drc.fsf@cpm12071.fritz.box> (Rafael Silva's message
        of "Wed, 23 Dec 2020 11:03:04 +0100")
Message-ID: <xmqqft3w8esq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D450F4D6-455A-11EB-A994-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rafael Silva <rafaeloliveira.cs@gmail.com> writes:

> That's a good point (and nice explanation, by the way). Before I was
> thinking more on the line "while we do not found a good line from
> process_line() and we do not finish processing the file, let's go to
> the next line" which lead me to proposed changes for shorten the code.
>
> However, after your explanation, I can see now and agree the original
> does seems easier to follow and we can as it is.

Well, it is very possible if you come with your version of a similar
loop in three months in a *new* codepath, I may say that it is a
good way to write it.  As I said, I do not mind shorter and crisper
code.

What I am saying is that I may have preference but it is not so
strong one in this case, and certainly it is not strong enough to
suggest rewriting one way to the other when the initial variant in
the patch (which may be either one) is good enough.

Thanks.
