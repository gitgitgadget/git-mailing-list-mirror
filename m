Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22E24209BA
	for <e@80x24.org>; Tue, 12 Sep 2017 06:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751264AbdILGxU (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Sep 2017 02:53:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61028 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751244AbdILGxT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2017 02:53:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 81F6AA7230;
        Tue, 12 Sep 2017 02:53:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8vPO54Vb1A+UNtkIziT8o9/hG2g=; b=hVUY4d
        HFtaZNkEfzVJLmwlJSFxuPtanvnhn/litUN/GH6V8El64uMEMz7Lt5U6ZU6CeYV4
        c+LwR5st3XYVAXBlyDq8rTV15b9BzfgllyQo/KazT/NKWsyvjTW/ddaDuwXBHSXZ
        s1kFfmM4Uc4kor4EME/OhkykGeR4f3UDF5cl4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YMqo2DCcNhf6l+joj+DdFX1VDAGmJr28
        kDq+mXKf3e0P9dEQMWl527ekHxnD98JR3pNL5IHSg/C4aK91S62b7czaT3iYqeXX
        CkNVSnBoHIDncDSTQc6nK7nwubSBYEjfQznra++hEk5qEFmwEoHKsP1yaT6xOy1l
        ubluJOb5bew=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7826EA722F;
        Tue, 12 Sep 2017 02:53:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DF809A722E;
        Tue, 12 Sep 2017 02:53:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mahmoud Al-Qudsi <mqudsi@neosmart.net>
Cc:     git@vger.kernel.org
Subject: Re: Suggestion: better error message when an ambiguous checkout is executed
References: <CACcTrKdzVCKUR8EfwhqBQR7vWzRqTLcwRJ_r-hx3VztD=xvNuQ@mail.gmail.com>
        <xmqq8tivngkk.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 12 Sep 2017 15:53:17 +0900
In-Reply-To: <xmqq8tivngkk.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 07 Aug 2017 15:44:43 -0700")
Message-ID: <xmqqo9qg1k82.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0F303BE6-9787-11E7-9EBD-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Mahmoud Al-Qudsi <mqudsi@neosmart.net> writes:
>
>> The default git behavior when attempting to `git checkout xxx` for
>> some value of "xxx" that cannot be resolved to a single, unique
>> file/path/branch/tag/commit/etc is to display the following:
> ...
> So a possible implementation approach would be
>
>  - to let the current code do what it is doing
>
>  - except that you add new code immediately before the code that
>    issues 'xxx' did not match (i.e. the code already checked that
>    'xxx' taken as a pathspec does not match anything, and about to
>    give the error message but hasn't done so just yet).
>
>  - your new code 
>
>    . checks if 'xxx' could be an attempt to refer to a rev but
>      insufficiently spelled out (e.g. both origin[12]/xxx exists, or
>      for a bonus point, a similarly named origin/xxy exists and
>      could be a typo).
>
>    . if the above check found something, then you report it and
>      terminate without complaining "pathspec 'xxx' did not
>      match..."
>
>    . on the other hand, if the above check did not find anything,
>      then you let the current code issue the same error message as
>      before.

I was sweeping my mailbox to collect loose ends that haven't been
tied down, and noticed that this topic does not seem to have reached
a conclusion.  Do we want to reboot the effort?  Or should we just
throw it in the #leftoverbits bin for now?

Thanks.
