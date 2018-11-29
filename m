Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41F9A211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 07:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbeK2S1Z (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 13:27:25 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56925 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbeK2S1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 13:27:25 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BA7273CB4F;
        Thu, 29 Nov 2018 02:22:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wREqaQGtZoayUqvpHdaiSBDXrNI=; b=mpQ2a0
        myIzLv6fG5WTbUuXdYZwln4JZG7GJ4T8EIPKzbc0Xdlo8BImVhgxIW1vUiuD4Ue0
        cOuY00qBEU4c0UmEJJFZByH9HNRGtDkZF/NJ95G9tLoe8Ac5skbeCqjdb1QyDIjt
        rTcHIfH4Z+Ogcii2UTcPJInc6p5Mg1pjZ8YQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GCraYka/T6v7ErG20Zg10K0f4evx6FUy
        T8NKOqVh8fnLJWx0JG34OKM1N+Tbm0RdvPHRxVk0+PI4OIRThIDq+lsim7UTk0dY
        a9PgypEfkUd/sd7ep2UNMUIihRBctA/h9D9vlrHjqK5/Gvvqp2pBYhMPLLhRY0Jc
        fYtwm8q9DWk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B298F3CB4D;
        Thu, 29 Nov 2018 02:22:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CC8FD3CB4C;
        Thu, 29 Nov 2018 02:22:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        avarab@gmail.com
Subject: Re: [PATCH v2] log -G: Ignore binary files
References: <1535679074.141165.1542834055343@ox.hosteurope.de>
        <c4eac0b0ff0812e5aa8b081e603fc8bdd042ddeb.1543403143.git.thomas.braun@virtuell-zuhause.de>
        <xmqqa7lsnyu5.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 29 Nov 2018 16:22:54 +0900
In-Reply-To: <xmqqa7lsnyu5.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 29 Nov 2018 16:10:26 +0900")
Message-ID: <xmqq5zwgny9d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97E927AE-F3A7-11E8-951F-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +test_expect_success 'log -G ignores binary files' '
>> +	git checkout --orphan orphan1 &&
>> +	printf "a\0a" >data.bin &&
>> +	git add data.bin &&
>> +	git commit -m "message" &&
>> +	git log -Ga >result &&
>> +	test_must_be_empty result
>> +'
>
> As this is the first mention of data.bin, this is adding a new file
> data.bin that has two 'a' but is a binary file.  And that is the
> only commit in the history leading to orphan1.
>
> The fact that "log -Ga" won't find any means it missed the creation
> event, because the blob is binary.  Good.

By the way, this root commit records another file whose path is
"file" and has "Picked<LF>" in it.  If the file had 'a' in it, it
would have been included in "git log" output, but that is too subtle
a point to be noticed by the readers who are only reading this patch
without seeing what has been done to the index before this test
piece.

If you are going to restructure these tests to create a three-commit
history in a single expect_success that is inspected with various
"log -Ga" invocations in subsequent tests, it is worth removing that
other file (or rather, starting with "read-tree --empty" immediately
after checking out the orphan branch, to clarify to the readers that
there is nothing but what you add in the set-up step in the index)
to make the test more robust.

