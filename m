Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13BF92036D
	for <e@80x24.org>; Sun, 19 Nov 2017 01:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1765048AbdKSBHf (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 20:07:35 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64656 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1764651AbdKSBHd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 20:07:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E74E0A1FCF;
        Sat, 18 Nov 2017 20:07:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FLFxwdeG1KAIsEEzvMwpTwvyh4Q=; b=e+pBtS
        UatpUraKP3mjs30CP6MqYT+Q6sIdnRLcwExlo61I7BF2okOZQ0uUVYjtsjTCK4PQ
        PKdzmGbNLXHPDU1kkaWHNTTKaJ5pBEiGvPMan7VsfWmekbwDNtOi+GapZSuVlKY1
        4Tp7rw0edei7sTIdyd/7b14Y6z1lq/aP2O2mg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=S1nMbuK5T/ZU8osomhsx859GmyOrepfo
        veaAJLC21xk0sFrn11b0+YS0JnJHimUr194Sf0sWHZGvs8EyXDDSla8ZBw/hWMhQ
        /Bs1MBJpdjb1b5i6HLSID9VDgPp6NN+d0GonrrNQsgwyqXejO5RXJn0uX8JYaDHM
        MHWrjSUZ/RA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DEBDDA1FCE;
        Sat, 18 Nov 2017 20:07:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2AE33A1FCC;
        Sat, 18 Nov 2017 20:07:29 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] launch_editor(): indicate that Git waits for user input
References: <274B4850-2EB7-4BFA-A42C-25A573254969@gmail.com>
        <xmqqr2syvjxb.fsf@gitster.mtv.corp.google.com>
        <26256555-4463-7bc9-5d07-8617932cf6cb@gmail.com>
Date:   Sun, 19 Nov 2017 10:07:24 +0900
In-Reply-To: <26256555-4463-7bc9-5d07-8617932cf6cb@gmail.com> (Kaartic
        Sivaraam's message of "Sat, 18 Nov 2017 23:17:14 +0530")
Message-ID: <xmqq8tf3oz3n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 04118A98-CCC6-11E7-B78A-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> $ GIT_EDITOR=gedit ./git commit --allow-empty
> Launched your editor, waiting...error: gedit died of signal 15
> error: There was a problem with the editor 'gedit'.
> Please supply the message using either -m or -F option.
>
> Though this is not something that's going to happen very often, I'm
> not sure if this is to be considered. Just wanted to note what I
> observed.

See my earlier response to Eric Sunshine.

>> +		static const char *close_notice = NULL;
>
> Just a little curious, what's the advantage of making 'close_notice'
> 'static' over 'auto' ?

A second call, if an earlier call to the function already determined
that our standard error output is going to a terminal and what kind
of terminal we are on, would just use the result from the earliser
call.

> Being curious again, is flushing 'stderr' required ? AFAIK, 'stderr'
> is unbuffered by default and I didn't notice any calls that changed
> the buffering mode of it along this code path.

"By default" is the key phrase.  The code is merely being defensive
to changes in other area of the code.
