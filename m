Return-Path: <SRS0=aDBb=CX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E87C433E2
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 20:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A27A221BE5
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 20:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="q/qd+On8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgINUzH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Sep 2020 16:55:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54883 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgINUzF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Sep 2020 16:55:05 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E68F3746F3;
        Mon, 14 Sep 2020 16:55:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+gGauewmaJJVlhY/ggzYr0759KA=; b=q/qd+O
        n8l68B9AY+Me3FbaqlUB7yGREYCN2jS9UOcWmOgPRZFa8DzNARC8EkrVfjaz7t0L
        8MQBf65yMZIfNf8XmOIYkc9hwHDE5nso/xuhGVw3iioIDrmWMeWaHnAutP8d5WHq
        gJ67pw9QmY+UR0xILBbhitDg1vXB7mWFqQya4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=b8FQQssHrb3NIPcdCzDck43791YajhQ3
        oyAfr/HZ0FPisL0w9tRzDhoPnItooiGehIEZOFaz431zikGdZczFNeNg9V1u8zAr
        MKelx+e5usW3jdCQa8NLXwpi+EffDgp0eigmOptZXiXeE20ZiXV9qe2D3MS+9d+j
        5ONwi0kaZMI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D1D1C746EF;
        Mon, 14 Sep 2020 16:55:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 33C0A746ED;
        Mon, 14 Sep 2020 16:55:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Rafael Silva <rafaeloliveira.cs@gmail.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: bug found on the new git maintenance builtin command
References: <20200914194938.GA4235@contrib-buster.localdomain>
        <0b35829f-a83b-a093-2dc5-0e7d3b42fd15@gmail.com>
Date:   Mon, 14 Sep 2020 13:55:00 -0700
In-Reply-To: <0b35829f-a83b-a093-2dc5-0e7d3b42fd15@gmail.com> (Derrick
        Stolee's message of "Mon, 14 Sep 2020 16:48:35 -0400")
Message-ID: <xmqq7dsw2i57.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8FAAD11C-F6CC-11EA-8BFD-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 9/14/2020 3:49 PM, Rafael Silva wrote:
>> Hi Everyone,
>> 
>> I found a minor bug when testing the new maintenance built-in command that was
>> introduced on 679768e2a1 (maintenance: create basic maintenance runner, 2020-08-25) submitted in [1]
>
> Thank you for identifying the original patch! My gut reaction was that
> this is just in the Part III code which adds subcommands, but that is
> incorrect.
>
>> (gdb) list
>> 1628    int cmd_maintenance(int argc, const char **argv, const char *prefix)
>> 1629    {
>> 1630        if (argc == 2 && !strcmp(argv[1], "-h"))
>> 1631            usage(builtin_maintenance_usage);
>> 1632
>> 1633        fprintf(stdout, "run");
>> 1634        if (!strcmp(argv[1], "run"))
>> 1635            return maintenance_run(argc - 1, argv + 1, prefix);
>> 1636        if (!strcmp(argv[1], "start"))
>> 1637            return maintenance_start();
>> (gdb) print argc
>> $5 = 1
>> (gdb) print argv[1]
>> $6 = 0x0
>> 
>> Hope all this information helps with the fixing it
>
> Thank you so much for the report!
>
> The patch below applies to ds/maintenance-part-1, to fix the problem.
> Hopefully it also merges cleanly with the changes in ds/maintenance-part-3,
> but I can deal with that when I submit my next re-roll.

Yuck.  I am pretty sure that I did spot this myself during the
review cycle, but apparently it slipped through X-<.

Will apply.  Thanks.
