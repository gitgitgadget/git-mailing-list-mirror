Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9934520966
	for <e@80x24.org>; Thu, 30 Mar 2017 16:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933175AbdC3QrS (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 12:47:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50438 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750766AbdC3QrR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 12:47:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8DFF76B1F9;
        Thu, 30 Mar 2017 12:47:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6EtQf7vLU2zUr+zZtTFiCwVtS24=; b=ijgslR
        Ned/Z3aV3BL8kDpL38J56e4X5UzlF704z4rtrgOCj4XOoPFWKPler9Xnb+3U+Iyf
        wIoK2eNeWUXFCIN4wVfpsPBtrxC0RzZ2FC8e0Kb7uLYPn9y/o2VKxjln6qQMA9WK
        rZD8AvY0CpE8AZnrszwMduCgV/hl7GwZrImgw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ewnt04m2UlDV8nL1BgsoNGvCd5KPzYcY
        9YGKTnlQbM28NX/mJzO2AZVTacU720dqhSbDa1z6gp9AAs7k0m1cq5gwvGYKUQrX
        RMw0I3g5xBFCHRNQigu7xV/Qk2nN3tBu10CF/hzZ05tkmHhRwYy9SbhRu/4nIAe3
        20IG/cy7FC0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 80DF36B1F8;
        Thu, 30 Mar 2017 12:47:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D604F6B1F7;
        Thu, 30 Mar 2017 12:47:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/7] Makefile: optionally compile with both SHA1DC and SHA1_OPENSSL
References: <cover.1490397869.git.johannes.schindelin@gmx.de>
        <7a2444f08dea1b2fe497ae7498eba44626414d29.1490397869.git.johannes.schindelin@gmx.de>
        <xmqq37du7n9p.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 30 Mar 2017 09:47:13 -0700
In-Reply-To: <xmqq37du7n9p.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 30 Mar 2017 09:16:50 -0700")
Message-ID: <xmqqvaqq67am.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 874DE8E0-1568-11E7-B116-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ...
> The use of union is a good ingredient for a solution.  I would have
> chosen to do this slightly differently if I were doing it.
>
>         typedef struct {
>                 int safe;
>                 union {
>                         SHA1_CTX_SAFE safe;
>                         SHA1_CTX_FAST fast;
>                 } u;
>         } git_SHA_CTX;
>
>         void git_SHA1_Init(git_SHA_CTX *ctx, int safe);
> 	void git_SHA1_Update(git_SHA_CTX *ctx, const void *, unsigned long);
> 	git_SHA1_Final(uchar [20], git_SHA_CTX *ctx);
>
> where SHA1_CTX_FAST may be chosen from the Makefile just like we
> currently choose platform_SHA_CTX.  SHA1_CTX_SAFE could also be made
> configurable but it may be OK to hardcode it to refer to SHA1_CTX of
> DC's.
>
> As you already know, I am assuming that each codepath pretty much
> knows if it needs safe or fast one (e.g. the one used in csum-file.c
> knows it does not have to), so each git_SHA_CTX is told which one to
> use when it gets initialized.

And if we wanted to declare "git add" is always safe, we could still
do

    int sha1_safety_global_override = -1; /* unspecified */

    void git_SHA1_Init(git_SHA_CTX *ctx, int safe)
    {
	if (sha1_safety_global_override >= 0)
	    ctx->safe = sha1_safety_global_override;
        else
	    ctx->safe = safe;

	if (ctx->safe)
	    SHA1DCInit(&(ctx->u.safe));
	else
	    platform_SHA1_Init(&(ctx->u.fast));
   }

and then have cmd_add() in builtin/add.c to flip that global
override bit to say "this does not have to be safe".  I personally
do not think it is a good idea, but I am showing that it is still
doable.  

And as long as assignment to sha1_safety_global_override is done in
a thread-friendly way, such a scheme would be more thread-friendly
as a whole compared to the "toggle_sha1dc()" approach where each CTX
instance does not know which side of the union it is being used us
(which, if mixed-up, of course would lead to a funny behaviour).

