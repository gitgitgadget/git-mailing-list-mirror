Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 406931F6C1
	for <e@80x24.org>; Sat, 27 Aug 2016 21:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754841AbcH0VWm (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Aug 2016 17:22:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53415 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754209AbcH0VWl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2016 17:22:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 178D83836B;
        Sat, 27 Aug 2016 17:22:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m8opL7PdYX7mcHIzgkLKt5lYINY=; b=M+TTYv
        oyl3xgOta3EV9H90XVo/0bPMs28+lYQomDuS/015Zpc8Z28FXiIzxqvpJHY76oY/
        pK/qjj/fZTEY26NyPdO/Pvp8meVgDhH+YmDiUaJEjpTC/na6y7yzZ4Ua3Ipz7MNN
        f/xax8ajFrh+rMZrUm9iPp/OZUBNQCz/o8OxE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PibTAnSqOWz87FPHw9SvTPmle2tpoRdV
        tsCgGtlySP8cRO5+wEKFfY4lainPc5OX/BagHIDmu1cdrvtZGMfkBLJe+U48xksM
        Co/A+1L5OlWcvga9I3rKG7DNg8LNWNXzGf+ePirTNfA1kUpaXyiwRvG02A88V7hk
        MxCAQCAaYaE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F7243836A;
        Sat, 27 Aug 2016 17:22:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 853BC38367;
        Sat, 27 Aug 2016 17:22:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH v14 09/27] bisect--helper: `bisect_write` shell function in C
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
        <01020156b73fe6a7-2e9df745-e3f4-4830-a1af-4acae7964c11-000000@eu-west-1.amazonses.com>
        <xmqqfuptol4h.fsf@gitster.mtv.corp.google.com>
        <CAFZEwPMcUf-Tm_ijJbEG1Bh7F+7ML2fw6Vw2Gt94B9gyoGL1FQ@mail.gmail.com>
Date:   Sat, 27 Aug 2016 14:22:37 -0700
In-Reply-To: <CAFZEwPMcUf-Tm_ijJbEG1Bh7F+7ML2fw6Vw2Gt94B9gyoGL1FQ@mail.gmail.com>
        (Pranit Bauva's message of "Sat, 27 Aug 2016 15:03:57 +0530")
Message-ID: <xmqqtwe5di02.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 61F5D802-6C9C-11E6-B308-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

>>> +struct bisect_terms {
>>> +     struct strbuf term_good;
>>> +     struct strbuf term_bad;
>>> +};
>>
>> I think "struct strbuf" is overrated.  ...
>> I think you can just say "const char *" in this case.
>
> Using struct strbuf is not really overrated but in fact required. But

Nothing is required.

I can make your life easier by requiring you to never use struct
strbuf as a structure field type, though.  You will almost never
need it unless you are building something exotic anyway.

Step back and think what "strbuf" is good for.  It holds a pointer
to a piece of memory the field owns, over-allocates and knows the
size of allocation and usage.  That is good if you need to

 (1) frequently find out the length of the string; without a
     separate .len member you would have to run strlen().

 (2) incrementally add to the string in-place; as it overallocates,
     appending to the string would not have to involve realloc()
     every time and the cost of it is amortized.

 (3) make complex operations like splicing another string in,
     trimming substring out, etc.

You need to do none of the above to these fields.  term.term_good is
either taken from an argv[] element, or you read from a line from a
file and set it.  You may do some trivial computation and set it to
the result, like "the other field uses 'old', so this one need to be
set to 'new'".  The user of the field either has the string and sets
it there, or reads the field's value as a whole string.  No string
manipulation in the field in-place is needed.

> yes, for this patch it might seem as overrated. In the shell code
> initally TERM_GOOD is set to "good" while TERM_BAD is set to "bad".
> Now there are a lot of instances (one of which is bisect_start()
> function) where this can change. So if we keep it as "const char *",
> it would be right to change the value of it after wards. And we cannot
> keep it as "char []" because we don't know its size before hand.

You are not making sense.  Nobody would suggest to use a fixed-size
char array in this structure.  That wouldn't even work in the case
where you are stuffing what comes in an argv[] element in there,
e.g.

    terms.term_good = argv[3];

And you can of course support changing the value of the field
without using strbuf.  Just update the pointer to point at the piece
of memory that holds the new value.

In short, I do not see any good reason why the term_good field has
to be anything other than "char *term_good" or "const char *term_good".

Now, what you need to consider choosing between the two depends on
where these strings can come from.  If they are known to be always
unchanging between the time you set it til the end of the program
(e.g. using an element in argv[]), you can just assign without
making any copy and you can use "const char *term_good".  All other
cases, the structure needs to take the ownership, and you would need
to make a copy if you don't have the ownership, e.g.

	terms.term_good = xstrdup(argv[3]);

You may be reading from a file, a line at a time and you may have a
line's content in a strbuf.  You do not (yet) own the buffer after
reading it, e.g.

	strbuf_getline(&buf, fp);
	terms.term_good = strbuf_detach(&buf, NULL);

Of course, if you need to take ownership of the memory, you would
need to free(3) it as needed, which means the pattern to set the
field would become

	free(terms.term_good);
        terms.term_good = ... some new value ...;

Using strbuf as a local variable is good.  It gives a higher level
of abstraction when you are actually performing string operations.
In most applications, however, a field in a struct is where the
result of a step of computation is kept, not a scratch-pad to
perform steps of computation in.  When you are ready to update the
value of a field, you _have_ a completed string, and you can just
use "char *" field to point at it.  There is no need for strbuf in
the field.

Don't look at the data structure used in trailer.[ch] as a model; it
is an example of a terribly bad implementation taste, a pattern that
should not be followed.  Print it, not read it and burn it as a good
symbolic gesture.


