Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB22F1FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 16:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751779AbcHZQ33 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 12:29:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59602 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751223AbcHZQ33 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 12:29:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DE7C036D19;
        Fri, 26 Aug 2016 12:29:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2Y+sPv2JC4h2GEV1I9/iahHlnSM=; b=BzLpqP
        0njcCzjPQJb8s8j+Z3Ump0MuFAYVpASYLUsB8euNFVNJFyCNvbaiUiwzL+GJ1LPP
        4L292QGhSs1LRMWITaeIIGP9OJ6v/HmdUT0EgkY9RcKYAtpTLhHnfnIXZ/virFJn
        Tj3TXQlV09vUGPouZFRrG0guMGNjoVLuNGsIU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hx3r4BH+3Lj9T2jOQ4cOXvNIfg6YnZG7
        fhXwzORotPYhsWKuTHD4LQpOnxTAqs194MqLAlIgRiscGeR13Zppobpk7FVShxfZ
        +ofGiMHvUjJ4+teyWrggaVX96jLrXc/87p5ElqYGjoL+q7y5oF2We5EhHKclGjg0
        AFAl39fhv6w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C4B5436D18;
        Fri, 26 Aug 2016 12:29:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2CA6036D17;
        Fri, 26 Aug 2016 12:29:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH v14 07/27] bisect--helper: `bisect_reset` shell function in C
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
        <01020156b73fe69a-13136cfb-4daa-4f5d-9b56-537adf2c6942-000000@eu-west-1.amazonses.com>
        <xmqq4m69q3b2.fsf@gitster.mtv.corp.google.com>
        <CAFZEwPPfXvLUtcBR6cYAP2dT8FAePFPjDSnVm8BhpLN9cfR1uw@mail.gmail.com>
Date:   Fri, 26 Aug 2016 09:29:24 -0700
In-Reply-To: <CAFZEwPPfXvLUtcBR6cYAP2dT8FAePFPjDSnVm8BhpLN9cfR1uw@mail.gmail.com>
        (Pranit Bauva's message of "Fri, 26 Aug 2016 19:16:56 +0530")
Message-ID: <xmqqshtrijdn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 41AE6FAC-6BAA-11E6-B29A-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

>> Also this version fails to catch "bisect reset a b c" as an error, I
>> suspect.
>
> It didn't when I tried it right now. Could you please elaborate on why
> you think it can fail? There might be a thing which I haven't tested.

My bad.  I just compared your bisect_reset() implementation that had

    if (no specific commit) {
    	reset to the branch
    } else {
	reset to the commit
    }

with the original

    case $# in
    0)	reset to the branch ;;
    1)  reset to the commit ;;
    *)  give usage and die ;;
    esac

and took the difference and reacted "ah, excess parameters are not
diagnosed in this function".

Your caller does complain about excess parameters without giving
usage, and that is what I missed.

I am not sure if you intended to change the behaviour in this case
to avoid giving the usage string; I tend to think it is a good
change, but I didn't see it mentioned in the proposed commit log,
which also contributed to my not noticing the test in the caller.

