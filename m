Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C6A8205C9
	for <e@80x24.org>; Wed, 11 Jan 2017 20:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758702AbdAKUrJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 15:47:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60041 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754552AbdAKUpf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 15:45:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD5385F4B0;
        Wed, 11 Jan 2017 15:45:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=osLPjMyaJxTkmPwTUoNmj/p3oDU=; b=VuLsQ8
        9G2SjSSpzEwiIetYPvGN3zEMv6qPE+P5mRmhxzL1dPjuP0CmN1F6sDEvdqFg0qYn
        pB8uVi9xOHQ/uQyf9iYU7jNvToRo/QjYXCOl1CSclpt06lHKOoAZFmRiCGYeoQ0W
        cc6JD+WKPvd51mizUN73EjyH0a1iVOQzwrPwk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uea4utWcHQL2mTB/IDMFYu1NaDBjaYHQ
        rLTm3pNXw7fAZ1RFds0A4b7/5SSl3ZpNaL4wbVKlMfcQ4/0jJbltRS/V9DmBNz1t
        TTBJngBFWrgiNwTH7KCQzQP7ht3yIdblKyX2h43yxN+tLIm6GTrW0XhE1xNjunLf
        SKPSoiW1DVk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ABFBF5F4AC;
        Wed, 11 Jan 2017 15:45:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 024C85F4A2;
        Wed, 11 Jan 2017 15:45:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>, Eric Wong <e@80x24.org>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6g?= =?utf-8?Q?ershausen?= 
        <tboegi@web.de>, Taylor Blau <ttaylorr@github.com>
Subject: Re: [PATCH v1] convert: add "status=delayed" to filter process protocol
References: <20170108191736.47359-1-larsxschneider@gmail.com>
        <xmqqa8b115ll.fsf@gitster.mtv.corp.google.com>
        <3165D057-7486-4ACB-8336-E63F49182CBE@gmail.com>
Date:   Wed, 11 Jan 2017 12:45:31 -0800
In-Reply-To: <3165D057-7486-4ACB-8336-E63F49182CBE@gmail.com> (Lars
        Schneider's message of "Wed, 11 Jan 2017 10:43:55 +0100")
Message-ID: <xmqqk2a1nx5g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E5793FB2-D83E-11E6-9DE2-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> Hmm, I would have expected that the basic flow would become
>> 
>> 	for each paths to be processed:
>> 		convert-to-worktree to buf
>> 		if not delayed:
>> 			do the caller's thing to use buf
>> 		else:
>> 			remember path
>> 
>> 	for each delayed paths:
>> 		ensure filter process finished processing for path
>> 		fetch the thing to buf from the process
>> 		do the caller's thing to use buf
>> 
>> and that would make quite a lot of sense.  However, what is actually
>> implemented is a bit disappointing from that point of view.  While
>> its first part is the same as above, the latter part instead does:
>> 
>> 	for each delayed paths:
>> 		checkout the path
>> ...
>
> I am not sure I can follow you here.
> ...
> I implemented the "checkout_delayed_entries" function in v1 because
> it solved the problem with minimal changes in the existing code. Our previous 
> discussion made me think that this is the preferred way:
>
>      I do not think we want to see such a rewrite all over the
>      codepaths.  It might be OK to add such a "these entries are known
>      to be delayed" list in struct checkout so that the above becomes
>      more like this:
>
>        for (i = 0; i < active_nr; i++)
>           checkout_entry(active_cache[i], state, NULL);
>      + checkout_entry_finish(state);
>
>      That is, addition of a single "some of the checkout_entry() calls
>      done so far might have been lazy, and I'll give them a chance to
>      clean up" might be palatable.  Anything more than that on the
>      caller side is not.

But that is apples-and-oranges comparision, no?  The old discussion
assumes there is no "caller's thing to use buf" other than "checkout
to the working tree", which is why the function its main loop calls
is "checkout_entry()" and the caller does not see the contents of
the filtered blob at all.  In that context, checkout_entry_finish()
that equally does not let the caller see the contents of the
filtered blob is quite appropriate.

