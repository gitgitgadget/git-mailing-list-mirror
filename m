Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11ADE2089A
	for <e@80x24.org>; Mon, 24 Jul 2017 19:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932589AbdGXTX5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 15:23:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50072 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751818AbdGXTX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 15:23:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D47AC923AF;
        Mon, 24 Jul 2017 15:23:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f/6agwtKaRV+yyHjhZsZQDgoeN4=; b=hVZhcd
        Rw8Tdd/n/Elj3svEqNoa2EBxLEhUAm2xfN4EvlCXB6gtZBryJdKPIfTcdLNlpZOi
        IZJi1ik+3GsDgPZ51qnfqzj/IPXrrU6T75xTLjt0AvW9Yxw/+rf5s9WwchVUv6ae
        hwZ9ceKtlH7i+Bgjjb98EEKjrXArh3daahAn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eNCYirwyj6bazMrZ6lrWtRFOqnDcwAT6
        dTpFaQI1DqGCaFrawQcO1yB+FP5vrJW1hB0lsmpF74Pb8XspsVFaltpdeK9tuam6
        zYawkfJkbMVEm8M8nAwYf64fXdZxxdfcbJeCAVAgyERPqfMtqfRHzFF61dGrq2Kn
        rK0K0ng2diY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CCFC0923AE;
        Mon, 24 Jul 2017 15:23:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3B613923AD;
        Mon, 24 Jul 2017 15:23:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     John Szakmeister <john@szakmeister.net>
Cc:     Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
Subject: Re: Expected behavior of "git check-ignore"...
References: <CAEBDL5URsbMazLBy-kWLJzECTEQ=61DN07xuu5NaO2Hw6r=j+w@mail.gmail.com>
        <1E42613B0CD743C6ADA24B9F1B43F0F9@PhilipOakley>
        <CAEBDL5X3wr=4A+W_sQzSE9BazoxoS2bwcOBZV5Jw=WCWZHAi6A@mail.gmail.com>
Date:   Mon, 24 Jul 2017 12:23:46 -0700
In-Reply-To: <CAEBDL5X3wr=4A+W_sQzSE9BazoxoS2bwcOBZV5Jw=WCWZHAi6A@mail.gmail.com>
        (John Szakmeister's message of "Mon, 24 Jul 2017 05:33:45 -0400")
Message-ID: <xmqq4lu1ej0d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9E1AC8FC-70A5-11E7-8E2F-61520C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Szakmeister <john@szakmeister.net> writes:

> Correct, it appears that if any line in the ignore matches, then it
> exits with 0.  So it's not that it's ignored, but that there is a
> matching line in an ignore file somewhere.  I can see the logic in
> this if it's meant to be a debugging tools, especially combined with
> -v.  Simply changing it does affect quite a few tests, but I'm not
> sure that it was intentional for negation to be treated this way.

I am reasonably sure that the command started its life as a pure
debugging aid.  

The treatment of the negation _might_ impose conflicting goals to
its purpose as a debugging aid---a user who debugs his .gitignore
file would want to know what causes a thing that wants to be ignored
is not or vice versa, and use of the exit status to indicate if it
is ignored may not mesh well with its goal as a debugging aid, but I
didn't think about the potential issues deeply myself while writing
this response.  As you mentioned, use of (or not using) "-v" could
be used as a sign to see which behaviour the end-user expects, I
guess.


