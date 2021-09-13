Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714C3C433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 18:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58E1660C40
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 18:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346191AbhIMSDO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 14:03:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54196 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346178AbhIMSDN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 14:03:13 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B7E3AE6CE2;
        Mon, 13 Sep 2021 14:01:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZtEqkzkLBSaG
        Us9Ry4doUwmZf5vX2tImGGHJs3B2aKU=; b=l0jZf3pKJ/5ygx9ou+hcufL7c5mK
        a771ODOm71tomSY7dOwcrYbBBaocNhr+34064bayGJ0/cxLoYe2oTBH4/pMZRbHu
        kam0alnKEC876WUpplicZS9bUTue9mtYE5oHMmgsZwPBa+QeT4KC+/dw2oLm74fH
        wCgAptnCNhIyQ7k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AEA91E6CDF;
        Mon, 13 Sep 2021 14:01:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0FB05E6CDE;
        Mon, 13 Sep 2021 14:01:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        lehmacdj@gmail.com
Subject: Re: [PATCH 1/3] t0301: fixes for windows compatibility
References: <20210912202830.25720-1-carenas@gmail.com>
        <20210912202830.25720-2-carenas@gmail.com>
        <0606160d-1192-2074-b1ad-9c5d86c953d5@gmail.com>
        <CAPUEspi1NzM34whXOT8T7NgJ1SCBGTPETcF0MY-UHz+kRqCTZQ@mail.gmail.com>
Date:   Mon, 13 Sep 2021 11:01:54 -0700
In-Reply-To: <CAPUEspi1NzM34whXOT8T7NgJ1SCBGTPETcF0MY-UHz+kRqCTZQ@mail.gmail.com>
        (Carlo Arenas's message of "Mon, 13 Sep 2021 00:13:50 -0700")
Message-ID: <xmqqtuiofj71.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AE35D672-14BC-11EC-856E-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> On Sun, Sep 12, 2021 at 10:34 PM Bagas Sanjaya <bagasdotme@gmail.com> w=
rote:
>> On 13/09/21 03.28, Carlo Marcelo Arenas Bel=C3=B3n wrote:
>> > test -S is not able to detect that a file is a socket, so use
>> > test -f instead.
>>
>> Isn't test -f just check for socket as regular file?
>
> and that is exactly how they look; ironically a -f check in Linux
> fails for sockets so maybe better to do -e?
>
> an empty file with nothing that indicates in Windows Explorer or a
> stat call (from WSL or git bash), that they are anything else.

It actually is a quite attractive idea to use "-e", or even more
preferrably, test_path_exists.  For example:

@@ -31,7 +42,7 @@ helper_test cache
=20
 test_expect_success "use custom XDG_CACHE_HOME if set and default socket=
s are not created" '
 	test_when_finished "git credential-cache exit" &&
-	test -S "$XDG_CACHE_HOME/git/credential/socket" &&
+	test $FLAG "$XDG_CACHE_HOME/git/credential/socket" &&
 	test_path_is_missing "$HOME/.git-credential-cache/socket" &&
 	test_path_is_missing "$HOME/.cache/git/credential/socket"
 '

test_path_exists contrasts better with the two test_path_is_missing
and explains what is being tested better.  Before this part, we have
run some "git credential" test, and there are three possible places
that the socket may appear (XDG, HOME/.git-credential-cache/ and
HOME/.cache/git/credential/), and we want to make sure only one of
them gets it.

One possible downside is that it makes us rely more on our knowledge
that we communicate via unix-domain socket (i.e. what the "socket"
the test is checking is).  By assuming that a mere presence of some
filesystem entity at the inspected path is OK, we may not notice a
breakage that creates a regular file or a directory there by mistake,
yet successfully carry out the credential tests.  It may even be a
good thing, if future ourselves have somehow found out how to use a
regular file or a directory for IPC instead of using a socket ;-).

Thanks.



