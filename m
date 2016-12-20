Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B2671FF76
	for <e@80x24.org>; Tue, 20 Dec 2016 23:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933365AbcLTXrF (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 18:47:05 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54157 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932479AbcLTXrD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 18:47:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CDA9256E5D;
        Tue, 20 Dec 2016 18:46:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yzqbOfAkXIaJxKNWxe66HwJQsq8=; b=mBd6cU
        uI/rdkkfcEFY4N5qsJ95R+290JYjQzZtm3DoCkJEAGZFc0Se2Mq0zHSaiKhDlYx7
        pAwlr0c9n34G3ybNqmcQslPWpkh95+XyJ95RkfvKeJg23k8OScAq6hOrT2jWrhtd
        PUd8jjoXpn72ahwKnFek6sJO7PF+Zs/0n9PhY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Nc/x6f2U18BOUHx+FzFuJEq/Ff5nOp1K
        kiUqEYooyUrtpl2AqXOoG7QXs2iKsIh8cvf2zCc86YOajaxfqHOPoWH37xHaOxgJ
        87vmTlA78+W5Kg0EzyZ+IX7r3AyMABpBarJrplLGFXMB7izXoFocfkdtE3J7fMYF
        jVuzl0Wbxvs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C624F56E5B;
        Tue, 20 Dec 2016 18:46:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4160756E56;
        Tue, 20 Dec 2016 18:46:31 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 09/34] sequencer (rebase -i): write an author-script file
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
        <cover.1481642927.git.johannes.schindelin@gmx.de>
        <09c2718e119f809093794410ae1a738c1cd122d1.1481642927.git.johannes.schindelin@gmx.de>
        <xmqqd1gtuivc.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1612191800530.54750@virtualbox>
        <xmqqy3zbl718.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 20 Dec 2016 15:46:30 -0800
In-Reply-To: <xmqqy3zbl718.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 19 Dec 2016 17:32:19 -0800")
Message-ID: <xmqq37hijh9l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 885FC17A-C70E-11E6-9106-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> We keep coming back to the same argument. You want this quoting/dequoting
>> to be turned into a full-fledged parser. And I keep pointing out that the
>> code here does not *need* to parse but only construct an environment
>> block.
>
> I am afraid you are mis-reading me.  I see a code that _READS_ some
> data format, for which we already have a parser, and then write out
> things based on what it read.  I do not want you to make anything
> into a full-fledged parser---I just do not want to see an ad-hoc
> reader and instead the code to USE existing parser.

To extend this a bit.

I care rather deeply about not spreading the re-invention of parsers
and formatters throughout the code, because that would introduce
unnecesary maintenance burden.

Quoting a string so that it is acceptable inside a pair of single
quotes, occasionally stepping outside of the sq context and using
backquote to excape individual byte, for example, might feel simple
enough that anybody can just write inline instead of learning how to
call and actually calling sq_quote().  You open ', show each byte
unless it is a ', in which case you close ' and give \' and
immediately open '.  That was what sq_quote() did originally and for
a long time.  If however we allowed everybody to reinvent the code
to quote all over the place, with a lame "This is different and does
not *need* to call shared code" excuse, it would have required a lot
more effort to do a change like the one in 77d604c309 ("Enhanced
sq_quote()", 2005-10-10) that changed the quoting rules slightly to
make the output safer to accomodate different variants of shells.

The same thing can be said for split_ident() code.  The "author"
line has name, '<', email address, '>', timestring, '+' or '-', and
timezone.  Splitting them into NAME and TIME may be very simple, and
"does not *need* to parse", right?  Not really.  If you look at how
split_ident() evolved to accomodate the real world malformed lines
like duplicated closing '>' and realize that what we have there may
probably *NOT* the perfect one (i.e. there may be other malformed
input we may have to accomodate by tweaking the implementation
further), we really do not want a hand-rolled ad-hoc "splitter" that
"does not *need* to parse".

The same thing can be said for the code that reads the
author-script, too.

So please do not waste any more time arguing.  I think you spent
arguing more time than you would otherwise have had to spend if you
just used existing helper functions, both in this thread and the
older one about reading the author-script.
