Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787E7C4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 18:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FB622388E
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 18:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbgLSSNn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 13:13:43 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59746 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgLSSNn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 13:13:43 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1BBBA11619D;
        Sat, 19 Dec 2020 13:13:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mdzQPiZSZGATMgMIz+NKnNuTK/8=; b=Y+51+z
        iofNPQg5TIDEXF6HBIRmqAzjkclHMnyjgl8ijyy7vrBkMMa5o+h5L2NnGcp3XduB
        CV4tV5gQCk5PjMjfEFOMhu/Ne0mlkFjypA1WnEdcHeT8P3VJ1bf8WNDsR+1l/7LT
        kYKPdUwWxm4C6gvcdcTbK3x1SWL2Jnn7A9Y4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=isqwCalHN1U/nP+tfSFzQXMeKinjTLc/
        qhRXLeXQ0VHSnEVdwu0Lm3JMKZbuOQ0SIczvStA8gsdwFhMPgvN8qr215Eml6SSQ
        BMsghAMeL7m6ollvYXiLG8KxMIWkkjNmwJNeVf7yMRrzNvZuCo+qa0jML/5BnanM
        E0faKIvQjJY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1451F11619C;
        Sat, 19 Dec 2020 13:13:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5F2C211619A;
        Sat, 19 Dec 2020 13:12:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] apply: don't use core.sharedRepository to create
 working tree files
References: <xmqqpn3tqugm.fsf@gitster.c.googlers.com>
        <3f0403b84ab06b9deb7c5c189792bebe1db586a7.1606866276.git.matheus.bernardino@usp.br>
        <CA+kUOamDD_SDNLk3sPSwNAojrAAP+g38MjkfG4JMPRTGOVAKAQ@mail.gmail.com>
Date:   Sat, 19 Dec 2020 10:12:56 -0800
In-Reply-To: <CA+kUOamDD_SDNLk3sPSwNAojrAAP+g38MjkfG4JMPRTGOVAKAQ@mail.gmail.com>
        (Adam Dinwoodie's message of "Sat, 19 Dec 2020 17:51:39 +0000")
Message-ID: <xmqqtushoeaf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D2DFDB54-4225-11EB-AEA1-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Dinwoodie <adam@dinwoodie.org> writes:

> Extract from the relevant section of ./t4129-apply-samemode.sh -x
> output, when run with that commit checked out, below:
>
> expecting success of 4129.10 'do not use core.sharedRepository for
> working tree files':
>         git reset --hard &&
>         test_config core.sharedRepository 0666 &&
>         (
>                 # Remove a default ACL if possible.
>                 (setfacl -k newdir 2>/dev/null || true) &&
>                 umask 0077 &&
>
>                 # Test both files (f1) and leading dirs (d)
>                 mkdir d &&
>                 touch f1 d/f2 &&
>                 git add f1 d/f2 &&
>                 git diff --staged >patch-f1-and-f2.txt &&

... "point X" (see below) ...

>
>                 rm -rf d f1 &&
>                 git apply patch-f1-and-f2.txt &&
>
>                 echo "-rw-------" >f1_mode.expected &&
>                 echo "drwx------" >d_mode.expected &&
>                 test_modebits f1 >f1_mode.actual &&
>                 test_modebits d >d_mode.actual &&
>                 test_cmp f1_mode.expected f1_mode.actual &&
>                 test_cmp d_mode.expected d_mode.actual
>         )
> ...
> +++ diff -u f1_mode.expected f1_mode.actual
> --- f1_mode.expected    2020-12-19 16:50:20.169378700 +0000
> +++ f1_mode.actual      2020-12-19 16:50:20.249126000 +0000
> @@ -1 +1 @@
> --rw-------
> +-rw-rw-r--

This tells us that we are getting the umask (set to "me only")
ignored by "git apply".

What would we see in the "t4129-*.sh -x" output if we inserted

		ls -ld f1 d d/f2 &&

at "point X" above?

THanks.
