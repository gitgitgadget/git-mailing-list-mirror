Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFB3C433DF
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 18:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23D75206D7
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 18:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="S+488kZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgFNSYS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 14:24:18 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53399 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgFNSYS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 14:24:18 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EEA7CEE9F0;
        Sun, 14 Jun 2020 14:24:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vQx2PS+OydJzfDr1y9yBQ7VpI9g=; b=S+488k
        ZbAq8km0Mb24JeGcy9WkQZmlIfut5tXb1b0Irn0O/0I21iH6Ep3nf1bM33rsjS4C
        xQSwLC8EQKhlOlTducMHgBgBCFwzSLBR6xzIpWDywyryTesVbzLHprXVsYIGLeSe
        DNkoaRMACxKdXBwzxVzl5PH9ubkb99wjwmaCU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=w896HGlD4ooIIPN874pSe3bXu7jrXynn
        1tKSedNR79d8t42YZLUA+cA3iNhzJUw/umqnqPl6fz5P7HkL64KnN+kt2FvKmVDH
        eftOpWZZUXX8/OWtkY3TDG95IgaV+2y1Y9c/aGK7f4oD7skozs6mL9UEuX/rq3PT
        pWNcQQmu/iA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E7D4DEE9EF;
        Sun, 14 Jun 2020 14:24:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3F88EEE9EE;
        Sun, 14 Jun 2020 14:24:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] pkt-line: extract out PACKET_HEADER_SIZE
References: <7e803a2ba9458ce35c657e67323edfe4409205ec.1592055716.git.liu.denton@gmail.com>
        <20200613142306.GA4680@danh.dev>
        <xmqqimfuzz73.fsf@gitster.c.googlers.com>
Date:   Sun, 14 Jun 2020 11:24:10 -0700
In-Reply-To: <xmqqimfuzz73.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 13 Jun 2020 09:51:28 -0700")
Message-ID: <xmqqtuzdy08l.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3EDF934C-AE6C-11EA-B062-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> How about (this ugly code):
>>
>> 	packet_trace("0000", sizeof "0000" - 1, 1);
>> 	if (write_in_full(fd, "0000", sizeof "0000" - 1) < 0)
>
> Yeah, that is ugly.  I was thinking more in the direction of
> replacing these three-argument write_in_full with something like
>
> #define write_constant(fd, constant_string) \
> 	write_in_full((fd), (constant_string), strlen(constant_string))
>
> with some preprocessor magic to make the compilation break when the
> second parameter to the macro is not a string constant.

There is a bit of subtlety but I did mean C preprocessor macro and
not a helper function with the above.  With use of a macro defined
like above, the programmer can write

	write_constant(fd, "0000");

which would turn into

	write_in_full((fd), "0000", strlen("0000"));
	
Descent compilers know to produce identical code as

	write_in_full((fd), "0000", 4);

when seeing a literal constant string given to strlen().

But a helper function like this:

	static int write_constant(int fd, const char *string) {
		return write_in_full(fd, string, strlen(string));
	}

has less chance of getting the same kind of optimization (the helper
needs to be inlined before the compiler can realize that the
parameter to strlen() is a literal constant whose length can be
computed at the compile time).


