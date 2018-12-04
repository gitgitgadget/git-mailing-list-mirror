Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 748E4211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 02:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbeLDCp6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 21:45:58 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60965 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbeLDCp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 21:45:58 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8ED8F199D2;
        Mon,  3 Dec 2018 21:45:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Qr+3JO3yjv6XhKQ7qHvurUA7TIY=; b=YqD/Xh
        oK/oBi9OUu1nZmfbKbFdZU07Bi3o+2ybb6iJGeNQT9mz4gX8mYz02ewfq63kO+Lp
        s1S5mARRfm6Snxk22gurV640MaoYjSS2DalV0RkDDK7qm3+fiHW2GeMKyrzigVt4
        paTM9gorw9Gk2dcbttzbZ3sLkYVZ+womZOfOY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cF94e05LIlbuFMcstbyBEdrMxiZQN00m
        PC5QdBBP2tWwuX0NTkbxj9gNbm9MLIv0uHc50yEOhQaNPpam5a3V96HFb93gOUjV
        2Z0yPttK5aIeLXaln7oqqyrsNh5Ll2KrCV/w+nMX94/F1gm+qolFPq/yABh+3nTN
        zAYDqdxQLDo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 87EBC199D1;
        Mon,  3 Dec 2018 21:45:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A1245199CF;
        Mon,  3 Dec 2018 21:45:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     <git@vger.kernel.org>
Cc:     =?utf-8?B?J8OGdmFyIEFybmZqw7Zyw7A=?= Bjarmason' 
        <avarab@gmail.com>,
        "'Cameron Boehmer'" <cameron.boehmer@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [RFC] git clean --local
References: <CAM+q9MeVS1e11vzu+-RP-i5NhSsnRz=x21q3gcGy8L62yceiMw@mail.gmail.com>
        <87woosukkm.fsf@evledraar.gmail.com>
        <004101d48a65$afb0da40$0f128ec0$@nexbridge.com>
        <xmqqk1kriuu8.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 04 Dec 2018 11:45:51 +0900
In-Reply-To: <xmqqk1kriuu8.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 03 Dec 2018 04:37:03 +0900")
Message-ID: <xmqqk1kqf1r4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B7CA2404-F76E-11E8-97C2-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> If "git clean" takes a pathspec, perhaps you can give a negative
> pathspec to exclude whatever you do not want to get cleaned,
> something like
>
> 	git clean '*.o' ':!precious.o'
>
> to say "presious.o is ignored (hence normally expendable), but I do
> not want to clean it with this invocation of 'git clean'"?

Hmph, this leads me to an interesting thought.  With today's code,
these two commands behave in meaningfully different ways when I mark
some paths that match .gitignore patterns with the precious
attribute.

	echo "*.ignored" >>.git/info/exclude
	echo "precious.* precious" >>.git/info/attributes

	: >expendable.ignored 2>precious.ignored

	git clean -n -x
	git clean -n -x ':(exclude,attr:precious)'

I am not suggesting that giving "git clean" a configuration knob
that always append pathspec elements, which would allow users to use
the mechanism to set the above magic pathspec, would be a good
approach.  If we were to follow through this line of thought, an
obvious thing to do is to always unconditonally append the above
magic pathspec internally when running "git clean", which would mean

 * Existing projects and users' repositories will see no behaviour
   change, because they are unaware of the "precious" attribute.

 * People who learn the new feature can start using the "ignored but
   precious" class, without any need for transition period.


