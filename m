Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 774411FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 23:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942529AbdAIX30 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 18:29:26 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52914 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935104AbdAIX3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 18:29:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C9E4A5F28E;
        Mon,  9 Jan 2017 18:29:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SWGfneVHrE6d+DGJgL3iZ9P1tmg=; b=Ldaopt
        8erOctJTXhJaWHUuY+HtHWKlfHcvXRQl1oULu+t0ZiB8EP1IynO9A4KYZ1VIP+CR
        fXB+PAEMco4b2wE9G5gk+SH0emD8s4UeAZJ802AzpV/WSVedKtZTPF5EDb4YqEEL
        xk2y5HyMDalfVROJteiabUw7WZT+McwvXqgyU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hEYhZ6fzXLSBjPWS+qPexPpxKMciIb0n
        ZSVspElhPMW0CGBeqGlUsitUSidiX5BT0XVczrLzlMA1bfd2YozESK5yBlQm9wKW
        cczfqWlSVipjd1rOSyDv1v4yvcfiSoWwi36JJfTr3qSDBefFDAnJ2qqpvf2+1ZUK
        7jRE7hdgX2c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BF3A95F28D;
        Mon,  9 Jan 2017 18:29:24 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 157485F28A;
        Mon,  9 Jan 2017 18:29:24 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Richard Hansen <hansenr@google.com>
Cc:     git@vger.kernel.org, davvid@gmail.com, j6t@kdbg.org,
        sbeller@google.com, simon@ruderich.org
Subject: Re: [PATCH v3 13/13] mergetool: fix running in subdir when rerere enabled
References: <20170106010945.79382-1-hansenr@google.com>
        <20170109054238.42599-1-hansenr@google.com>
        <20170109054238.42599-14-hansenr@google.com>
        <xmqq4m18ump1.fsf@gitster.mtv.corp.google.com>
        <xmqqvatot5ob.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 09 Jan 2017 15:29:22 -0800
In-Reply-To: <xmqqvatot5ob.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 09 Jan 2017 11:05:40 -0800")
Message-ID: <xmqq37gru819.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 746D4E8E-D6C3-11E6-A649-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I wonder if it makes more sense to always move to toplevel upfront
>> and consistently use path from the toplevel, perhaps like the patch
>
> s/the patch/the attached patch/ I meant.
>
>> does.  The first hunk is what you wrote but only inside MERGE_RR
>> block, and the second hunk deals with converting end-user supplied
>> paths that are relative to the original relative to the top-level.
>>
>> The tweaking of $orderfile you have in the first hunk may have to be
>> tightened mimicking the way how "eval ... --sq ... ; shift" is used
>> in the second hunk to avoid confusion in case orderfile specified by
>> the end user happens to be the same as a valid revname
>> (e.g. "master").
>
> And here is a squash-able patch to illustrate what I mean.

By the way, I didn't think this through, but how is the orderfile
that comes from the configuration file handled when it is not an
absolute path?  I think it is _wrong_ to take it as relative to
where the user started the program.  The -O<file> parameter from the
command line, when <file> is not absolute, should be taken as
relative to where the user _thinks_ s/he is, but when it comes from
the diff.orderfile configuration and it is not absolute, it should
be taken as relative to the top of the working tree.  As we always
cd_to_top with the suggested SQUASH, it means that the orderfile
that came from the configuration does not have to be touched, while
the orderfile given via -O<file> on the command line needs
prefixing.



