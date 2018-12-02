Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 289CF211B3
	for <e@80x24.org>; Sun,  2 Dec 2018 04:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbeLBEoI (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Dec 2018 23:44:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54606 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbeLBEoI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Dec 2018 23:44:08 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F4A41232E8;
        Sat,  1 Dec 2018 23:44:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8dRM7fJzcMFPbiCXSn0SygQXiE8=; b=eQdW6T
        VYSjDGrfPpwZFVFR8Oy4U8nETmjkr+gMv8kc0xu3XBKpR3SlaPwRuJI6Qy6HdZ+e
        Y7CY/u51otSJkqoT37hIpN9fsEdvbEmw8az7wmeXGNfzJwQr6BaGSv/sy+Wi8Bdy
        Ds2ppMlEL4aIx+ZsaD18vH5XMmEfs1JjE+gQU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lsKtrhKaFkxruJjEZnP8MV8CrLR/l3Ia
        uj0pbZoOmpt/5zOQU+1KkNM96KRNUiSrHWW1pCswuJR7T8rhjaUaodx9BMdNHHFd
        gw1tyPV1QGjc3RGydPBFbdAWo5TJGhZjZzblwd3er9EHTLku1+ZzVx7BTJomJAAS
        Q2PTyp43DIE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 216511232E6;
        Sat,  1 Dec 2018 23:44:02 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A37E51232E5;
        Sat,  1 Dec 2018 23:44:00 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Cameron Boehmer <cameron.boehmer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] git clean --local
References: <CAM+q9MeVS1e11vzu+-RP-i5NhSsnRz=x21q3gcGy8L62yceiMw@mail.gmail.com>
        <xmqqsgzgiyk2.fsf@gitster-ct.c.googlers.com>
Date:   Sun, 02 Dec 2018 13:43:59 +0900
In-Reply-To: <xmqqsgzgiyk2.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Sun, 02 Dec 2018 09:04:29 +0900")
Message-ID: <xmqqo9a4ilm8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E326D27E-F5EC-11E8-A2CE-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Cameron Boehmer <cameron.boehmer@gmail.com> writes:
>
>> 1) add a new flag
>> -l, --local
>>     Do not consult git config --global core.excludesFile in
>> determining what files git ignores. This is useful in conjunction with
>> -x/-X to preserve user files while removing build artifacts.
> ...
> But it might be useful as an option that affects any "git" command,
> e.g. "git --local-config-only clean".  I dunno.

If you only want to say "there is no global excludes file", perhaps

    $ git -c core.excludesFile=/dev/null clean -x

may be sufficient, so for that particular use case, there is no need
to introduce a new command, I'd think.

In the longer term, however, I think we would want to introduce a
distinction among ignored files---we only support "ignored and
expendable" class, but not "ignored but precious" class.  With the
latter class introduced, it would make sense for "git clean -x/-X"
to notice that a path is ignored but precious and keep it.  If a
dir/foo is ignored, dir/bar is tracked in commit A that is currently
checked out, and there is no dir/ directory in commit B, checking
out commit B would remove dir/foo (because the last tracked file in
the directory goes away and all remaining files in the directory
would be ignored but expendable).  But if we introduced a new
"ignored but precious" class and made dir/foo a member of such a
class, then you will be prevented from checkout out B until you do
something about dir/foo that is now "precious".




