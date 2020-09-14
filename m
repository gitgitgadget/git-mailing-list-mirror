Return-Path: <SRS0=aDBb=CX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498F0C433E2
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 20:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E92821741
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 20:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="itlDYU/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgINUIM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Sep 2020 16:08:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57529 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgINUIK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Sep 2020 16:08:10 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D264573F72;
        Mon, 14 Sep 2020 16:08:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=4WQPaUADiXjIRiljsag0FpyVJOQ=; b=itlDYU/JUgrcIakDuFFu
        cnFFKKH/XEmRqHw3GFxWO9i7wFEcqmSsiZcRZRoM23Yr3llnw8lm/2KSupfCw1AC
        fNra/jhCL+IBKhikV0RyoTp/5bCNuBDeReHcN/3zFfe5Lu9f1Yy7nAA9XRON8dN2
        fPU2bG2lCpEsERNpYu9pvgk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=ppB45+s2FOleEHmvnCI8XaRsXFWqYVg9cUdqEtgREvkMth
        2Y5+p2V6lng4NW13JVn/HH9ObrkPHudkL4J4WFfzf32q4JQALomV6JE2pAjBTEpU
        Z1Fs9ksSlQ8d8UZ4nVJ/ZhyiYzMthRzHQGJTvadl7Dp1BR1E1p78O4UO0Afp8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CAF6A73F71;
        Mon, 14 Sep 2020 16:08:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EE0A173F70;
        Mon, 14 Sep 2020 16:08:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] push: make `--force-with-lease[=<ref>]` safer
References: <20200904185147.77439-1-shrinidhi.kaushik@gmail.com>
        <nycvar.QRO.7.76.6.2009072119350.56@tvgsbejvaqbjf.bet>
        <xmqqr1rcxdsu.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2009090542430.54@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.2009101220400.56@tvgsbejvaqbjf.bet>
        <20200910144456.GA25125@mail.clickyotomy.dev>
        <nycvar.QRO.7.76.6.2009120013070.56@tvgsbejvaqbjf.bet>
Date:   Mon, 14 Sep 2020 13:08:06 -0700
Message-ID: <xmqqk0wwjf4p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 01AA25BC-F6C6-11EA-94AE-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Srinidhi,
>
> On Thu, 10 Sep 2020, Srinidhi Kaushik wrote:
>
>> On 09/10/2020 12:22, Johannes Schindelin wrote:
>>
>> > BTW I think the patch needs to cover a bit more, still: after I run `git
>> > pull --rebase`, the local branch will never have been at the same revision
>> > as the fetched one: `git rebase` moves to an unnamed branch before
>> > replaying the patches. So I think we need to see whether the remote tip
>> > was _reachable_ from (not necessarily identical to) any of the reflog's
>> > revisions.
>>
>> Good catch. Would adding in_merge_bases() along with checking if OIDs
>> are equal for each reflog entry in oid_in_reflog_ent() address the
>> problem? That way, we would check if remote ref is reachable from
>> one of the entries?

That sounds very expensive.  

If we switched to check the reflog of HEAD (and not any particular
local branch's reflog), then "has this ever been checked out", tests
would suffice, no?  We detach at the tip of the remote-tracking
branch and then reapply our work one by one in such a case, so we
should have the record of having their tip in the working tree at
some point (i.e. at the beginning of the "rebase" phase of the "pull
--rebase" operation).

