Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953A1C433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 20:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A19D610FC
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 20:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbhDOU4j (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 16:56:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56901 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbhDOU4j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 16:56:39 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 79B7A13584D;
        Thu, 15 Apr 2021 16:56:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Ud6ShG4NRNXd
        qSMCNpZtheo0Nbk=; b=ssQyXvVpj26Wpnu7CyMCsnjQIea+1cQPTM2f5nGBDJje
        FeLejzve4ALGbOIgJm8Kk5UxXhn/mm+oe0DtNkQSawm7S55ZNc0DC4JievjQS/oC
        1ZWSr1FwptxLuLy/XHEVyxt9tumk9z8xqlW3odOozVVGA0OYQrz6E8EmywufnY4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=V2MsK/
        8lz+vmNcVw/qWFvmeZvlBag8sH4jGms0sCTsGrhfXxWYt/3flbaPqORb4THzExgx
        CdulTy9tvV67oXkVLZrNUddcHWxaUMkM3qzMd44JccPQAZt298YUDgcuoq9epeDa
        RRTHERe5g06dNhiRscv6B9J3srqbJj5tFBCCU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 72FC813584C;
        Thu, 15 Apr 2021 16:56:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9AF5D13584B;
        Thu, 15 Apr 2021 16:56:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@jeffhostetler.com, git@vger.kernel.org
Subject: Re: [PATCH] pkt-line: do not report packet write errors twice
References: <xmqqlf9jp9v5.fsf@gitster.g>
        <20210415204809.1818959-1-matheus.bernardino@usp.br>
Date:   Thu, 15 Apr 2021 13:56:09 -0700
In-Reply-To: <20210415204809.1818959-1-matheus.bernardino@usp.br> (Matheus
        Tavares's message of "Thu, 15 Apr 2021 17:48:09 -0300")
Message-ID: <xmqqczuvp8ra.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 026F2880-9E2D-11EB-A509-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> On Thu, Apr 15, 2021 at 5:32 PM Junio C Hamano <gitster@pobox.com> wrot=
e:
>>
>> Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:
>>
>> > Nice! :) Maybe we could also avoid the static strings without
>> > repeating the literals by making `do_packet_write()` receive a `stru=
ct
>> > strbuf *err` and save the error message in it? Then the two callers
>> > can decide whether to pass it to error() or die() accordingly.
>>
>> Sorry, but I do not understand what benefit we are trying to gain by
>> introducing an extra strbuf (which I assume is used to strbuf_add()
>> the error message into). =C2=A0Wouldn't the caller need two messages a=
nd
>> flip between <error,error_errno> vs <die,die_errno> pair?
>
> Hmm, I'm not sure I understand what you mean by the two messages, but
> what I was thinking of is something like this (on top of my original
> patch):

Ah, OK, you meant that you'd make do_packet_write() handle
die/error_errno itself by manually calling strerror(errno).

One small downside with the approach is that do_packet_write() needs
to hardcode how die/error_errno() mixes the strerror() with the
caller supplied error message, but I do not care too strongly either
way.  My original motivation of suggesting the rewrite was to avoid
overlong lines in the main flow of the code by replacing the long
messages with variable names that are much shorter, so as long as
that is done, I am fine either way.

Thanks.
