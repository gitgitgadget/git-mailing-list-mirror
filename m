Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD0CC433DB
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 20:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8A7D229C4
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 20:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbhAJUZG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 15:25:06 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62832 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbhAJUZF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jan 2021 15:25:05 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 696D79744B;
        Sun, 10 Jan 2021 15:24:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9KWFcPLynkPN
        KaO5weo7SQ4QQlM=; b=hTVhwRitqS3cYV5/b56niV7iojvM40sk/aXERwIU0Egm
        WmZF+Nc65ltFSua34GM+exsxuhaT0WTXibtTh4fgDkPg4SQ11AolM9lulXwi+ciJ
        h9FLNGxVYw/BZxqTLt/VZkYfgn0mUmQe/BjEZwpSFf1SDIKmHfSkvTG05CZ9QMU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=OQvv4g
        KeT+ZLtnAG4iEdQuE0IG2sGUGn8Rq2w0B8Iydd9tXA0onywHGsGPWGxJIwMIr3Zr
        BQrUoTYWGpKa+Z19zQ/m+8z39R0wNgr6SzGHThiiLH50SqmPsTnmusDRVw0X2Dpa
        Z5ZgDtEObPL2nTuBif66Z3WfZFG9TBo++zsyI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 61E889744A;
        Sun, 10 Jan 2021 15:24:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EA60C97449;
        Sun, 10 Jan 2021 15:24:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v3 0/2] refs: allow @{n} to work with n-sized reflog
References: <cover.1609923643.git.liu.denton@gmail.com>
        <cover.1610015769.git.liu.denton@gmail.com>
        <20210110144423.GU8396@szeder.dev>
Date:   Sun, 10 Jan 2021 12:24:21 -0800
In-Reply-To: <20210110144423.GU8396@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Sun, 10 Jan 2021 15:44:23 +0100")
Message-ID: <xmqq4kjoa6bu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D3886978-5381-11EB-9588-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> Junio,
>
> On Thu, Jan 07, 2021 at 02:36:57AM -0800, Denton Liu wrote:
>> When there is only one reflog entry (perhaps caused by expiring the
>> reflog and then making a single commit) @{1} errors out even though
>> there is technically enough information to do the lookup. Look at the
>> old side of the reflog instead of the new side so that this does not
>> fail. This is explained in more detail in the commit of the last patch=
.
>
>> Denton Liu (2):
>>   refs: factor out set_read_ref_cutoffs()
>>   refs: allow @{n} to work with n-sized reflog
>
> Topic 'dl/reflog-with-single-entry', i.e. these two patches queued
> directly on top of v2.29.2, break the test case "61 - valid ref of the
> form "n", n < N" in 't3903-stash.sh'.  Queueing them on top of
> something already containing commit 4f44c5659b (stash: simplify reflog
> emptiness check, 2020-10-24) fixes this issue.

Thanks for carefully watching ;-)

There is no reason why this fix needs to be backported down to 2.29
track, I would think.
