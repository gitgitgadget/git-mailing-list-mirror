Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 869B21F464
	for <e@80x24.org>; Sun, 29 Sep 2019 09:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfI2JWh (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Sep 2019 05:22:37 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51606 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfI2JWh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Sep 2019 05:22:37 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 75A8D87EF8;
        Sun, 29 Sep 2019 05:22:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cHIvGKN2w9lCTEG0RJG/ZVyc6FU=; b=LHfCu2
        CIHMrOzJOKftuQceN+blcci4GxqZ6bMDHP39BAhNtoQ75PXdw3+8O8I5s/Z6As+L
        CmJ1PBVPlTMnaCv0iDWy5MBW/dXJyQw8H1Ll6e7ptVyZy10QQocGxNdn1TWbi+iP
        JIiJuhutD6Y+BS7BIGfOGP/EzbUSks1PAqzCM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uvNWGYmHU5ZQqSLYAsfgY2TELbPS4B30
        oHXGnrrN7vhtYepaHIEelINOILHJXVHvjz8dNGnZuRV1VWvmQ3PK3/7c8263aWlp
        Td3nHidxbyE8WekPyOZ2tNP5GkcwANUNDk7v11S50ZVqvx11jVfsebxEiQnQ8dbk
        zaLAV+IkODE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6D9D887EF7;
        Sun, 29 Sep 2019 05:22:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9CDD087EF5;
        Sun, 29 Sep 2019 05:22:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [PATCH v2 00/19] hashmap bug/safety/ease-of-use fixes
References: <20190924010324.22619-1-e@80x24.org>
Date:   Sun, 29 Sep 2019 18:22:30 +0900
In-Reply-To: <20190924010324.22619-1-e@80x24.org> (Eric Wong's message of
        "Tue, 24 Sep 2019 01:03:05 +0000")
Message-ID: <xmqqy2y7ihih.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA9A6C2C-E29A-11E9-809F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Patches 1-11 are largely unchanged from the original series with the
> exception of 2, which is new and posted at:
>
> 	https://public-inbox.org/git/20190908074953.kux7zz4y7iolqko4@whir/
>
> 12-17 take further steps to get us away from hashmap_entry being
> the first element, but they're also a bit ugly because __typeof__
> isn't portable
>
> 18-19 finally brings me to the APIs I want to expose without
> relying on __typeof :)
>
> Apologies for the delays, been busy with other stuff...

Thanks.  clang version 6.0.1-10 (which is the version I happen to
have installed locally) seems to throw a lot of errors like these:

 -- -- --

$ make CC=clang config.o
    CC config.o
config.c:1944:50: error: variable 'entry' is uninitialized when used here [-Werror,-Wuninitialized]
        hashmap_for_each_entry(&cs->config_hash, &iter, entry,
                                                        ^~~~~
./hashmap.h:453:20: note: expanded from macro 'hashmap_for_each_entry'
                                                OFFSETOF_VAR(var, member)); \
                                                             ^~~
./git-compat-util.h:1346:16: note: expanded from macro 'OFFSETOF_VAR'
        ((uintptr_t)&(ptr)->member - (uintptr_t)(ptr))
                      ^~~
./hashmap.h:445:61: note: expanded from macro 'hashmap_iter_first_entry_offset'
        container_of_or_null_offset(hashmap_iter_first(map, iter), offset)
                                                                   ^~~~~~
config.c:1939:34: note: initialize the variable 'entry' to silence this warning
        struct config_set_element *entry;
                                        ^
                                         = NULL
1 error generated.
make: *** [Makefile:2365: config.o] Error 1

 -- -- --

even though gcc seems to be happy with the source.

