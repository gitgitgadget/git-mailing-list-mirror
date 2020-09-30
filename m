Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F78C4727C
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 20:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41E5320759
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 20:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gfA7o1Q9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbgI3UeO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 16:34:14 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58044 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3UeO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 16:34:14 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 41271101EDA;
        Wed, 30 Sep 2020 16:34:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nmWtLJ1d3D4rkYdYSFbYtrwftmQ=; b=gfA7o1
        Q97YHaVPsXxufYmEBKNoPBK6GY8Qaz2yfHZ5TuFx4pXnRUtXkwTSr6Kj8gsGhyLn
        TcvJ/RNdXSklvimLr2+TCD//FdbW+QwUoY6Id7wwxKAJd87Wa5PGWWjNb8yMkSOp
        o0YWfyq2jfhLY4oC5R8XlcPQ6VroC2vbcXekc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bUkC4uq4uq8XIMaFxuAX1MX+RDTtfXXW
        Ls4Wfwq/Gtadn7XGd/1tbUzveJ8F4B8lWoQ5/UMETQDa6y4HAWOxhKP/u6VxWpij
        ZVrS26AGPRijYQPl0IHUU+RnSSyp7DbbCvfy44aD6aklrGOwVk38twJYylv2+dRZ
        /oHs9N9abIU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 39995101ED9;
        Wed, 30 Sep 2020 16:34:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8355F101ED8;
        Wed, 30 Sep 2020 16:34:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Theodore Dubois <tbodt@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Propagate --quiet on submodule update to merge/rebase
References: <20200930074729.99629-1-tbodt@google.com>
        <xmqqft6zgjaj.fsf@gitster.c.googlers.com>
        <F2F35572-E88F-4D6F-844B-6E17FCFD2175@google.com>
Date:   Wed, 30 Sep 2020 13:34:07 -0700
In-Reply-To: <F2F35572-E88F-4D6F-844B-6E17FCFD2175@google.com> (Theodore
        Dubois's message of "Wed, 30 Sep 2020 12:44:34 -0700")
Message-ID: <xmqqblhngg1s.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4B065F12-035C-11EB-8458-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Theodore Dubois <tbodt@google.com> writes:

>> This is not the problem this patch introduces, but the way GIT_QUIET
>> variable is set up does not allow us to do the above so nicely, I
>> suspect.  Wouldn't the above change make "git submodule update -v"
>> invoke the underlying commands with "--quiet" option?
>
> Interesting. I didn't check every setting of GIT_QUIET, just
> looked at the first few and assumed the rest would be the
> same. The "git submodule--helper update-clone" invocation also has
> this problem. I'll resend with "unset GIT_QUIET".

It seems set_branch also is written with a strange sense of humor.
It pays attention to GIT_QUIET but never sets it itself.

Thanks.

