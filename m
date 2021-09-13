Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2493C433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 18:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6E2960F23
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 18:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346559AbhIMSKi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 14:10:38 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56197 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346508AbhIMSKi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 14:10:38 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 261ED15EDB8;
        Mon, 13 Sep 2021 14:09:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mQ2Q+hK8wRvnvCKLdQEA8K6Hhpz8WCgEDDFNZ/
        JJra8=; b=jsGMI2Uo9p7YrTAXx1y5KUJkpx6maoY+CmtWMWkvlY1X1aNKgHcqIn
        rAR4gHZBM28JLt0j0crq1rk2Lj5HcseJOKN4v9OAbgDrTw4B9clEemuJimjiZKFg
        wgZF7GB+8XjsRvVa0DIMeDpKTOYt7fJ13Srd3mpv6yEPFQqwTEMT0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1E25215EDB7;
        Mon, 13 Sep 2021 14:09:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7E6F815EDB6;
        Mon, 13 Sep 2021 14:09:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, bagasdotme@gmail.com
Subject: Re: [PATCH v2 1/3] t0301: fixes for windows compatibility
References: <20210912202830.25720-1-carenas@gmail.com>
        <20210913085600.35506-1-carenas@gmail.com>
        <20210913085600.35506-2-carenas@gmail.com>
        <nycvar.QRO.7.76.6.2109131343440.55@tvgsbejvaqbjf.bet>
Date:   Mon, 13 Sep 2021 11:09:17 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2109131343440.55@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 13 Sep 2021 13:50:59 +0200 (CEST)")
Message-ID: <xmqqpmtcfiuq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B7200B6C-14BD-11EC-9CAB-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> +test_path_is_socket () {
>> +	test -S "$1"
>> +}
>> +
>> +# in Windows, Unix Sockets look just like regular files
>> +uname_s=$(uname -s)
>> +case $uname_s in
>> +*MINGW*)
>> +	test_socket_exist=test_path_exists
>> +	;;
>> +*)
>> +	test_socket_exist=test_path_is_socket
>> +	;;
>> +esac
>
> A more canonical way would probably be to imitate what we do with `pwd` in
> `t/test-lib.sh`:

Thanks for bringing up a better practice.

Referring to a variable when calling a function gives a "we are
doing something unusual" signal and it loses half its abstraction
value at the callsites.  E.g.

>>  	test_when_finished "git credential-cache exit" &&
>> -	test -S "$XDG_CACHE_HOME/git/credential/socket" &&
>> +	$test_socket_exist "$XDG_CACHE_HOME/git/credential/socket" &&
>>  	test_path_is_missing "$HOME/.git-credential-cache/socket" &&
>>  	test_path_is_missing "$HOME/.cache/git/credential/socket"

I actually do not think it is so bad to just use test_path_exists
without per-platform conditional in this case, but if we want to be
more conservative, I agree with you that

	case ... in
	*MINGW*)
                test_path_is_socket () {
                        test_path_exists "$@"
                }
        	;;
	*)
                test_path_is_socket () {
                        test -S "$1"
                }
		;;
	esac

is the way to go.
