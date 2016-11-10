Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF82720229
	for <e@80x24.org>; Thu, 10 Nov 2016 23:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965350AbcKJXOA (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 18:14:00 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61748 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965338AbcKJXN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 18:13:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 274794F37A;
        Thu, 10 Nov 2016 18:13:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WwM4mzT3lGv/134n9A/JAPUBmfk=; b=cndO5z
        ZvT0v3mBP9JUlzEIb86VstcmwzE4iWn1eTRAaZ5L+4mY6FKXRL3mDFdd1WnxKwCQ
        Dw+Aq+ZLDzmxMwOjUpbm6zJpLBnhp1G7GdFjRICln3AxSkHErXLxSuxVJE8Ns2Gv
        GovelIi8vh/+wlj74fG/xzpPVVATCoUxbbyCk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GzJwKZTDbfram+2bR9Y2nu3kJSKVJkXm
        0+2ap3TWPRZuAEWcb/ue8NE3vAWuSfO0/f1U6bFkgmzi+rjdbbrGxPw5V0tBMnXu
        G4meCN/uxhL6+obuXAp1pbJHCsZQq26JXIparkBVRS4iqAD/2PUDescLxWIgblfr
        fnmw9XtwOXM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DE004F379;
        Thu, 10 Nov 2016 18:13:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 875B74F378;
        Thu, 10 Nov 2016 18:13:56 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Karthik Nayak <karthik.188@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v7 01/17] ref-filter: implement %(if), %(then), and %(else) atoms
References: <20161108201211.25213-1-Karthik.188@gmail.com>
        <20161108201211.25213-2-Karthik.188@gmail.com>
        <CA+P7+xoAmYqi0OazZux+rooXW+D_N9L5s+2BzUyJJJXtmLZX-Q@mail.gmail.com>
Date:   Thu, 10 Nov 2016 15:13:55 -0800
In-Reply-To: <CA+P7+xoAmYqi0OazZux+rooXW+D_N9L5s+2BzUyJJJXtmLZX-Q@mail.gmail.com>
        (Jacob Keller's message of "Tue, 8 Nov 2016 15:13:30 -0800")
Message-ID: <xmqqwpgb3p3g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5AC01996-A79B-11E6-A741-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> Ok, so I have only one minor nit, but otherwise this looks quite good
> to me. A few comments explaining my understanding, but only one
> suggested
> change which is really a minor nit and not worth re-rolling just for it.

As you didn't snip parts you didn't comment, I'll use this to add my
own for convenience ;-)

>> +if::
>> +       Used as %(if)...%(then)...(%end) or
>> +       %(if)...%(then)...%(else)...%(end).  If there is an atom with
>> +       value or string literal after the %(if) then everything after
>> +       the %(then) is printed, else if the %(else) atom is used, then
>> +       everything after %(else) is printed. We ignore space when
>> +       evaluating the string before %(then), this is useful when we
>> +       use the %(HEAD) atom which prints either "*" or " " and we
>> +       want to apply the 'if' condition only on the 'HEAD' ref.
>> +
>>  In addition to the above, for commit and tag objects, the header
>>  field names (`tree`, `parent`, `object`, `type`, and `tag`) can
>>  be used to specify the value in the header field.

I see a few instances of (%end) that were meant to be %(end).

Aren't the following two paragraphs ...

>> +When a scripting language specific quoting is in effect (i.e. one of
>> +`--shell`, `--perl`, `--python`, `--tcl` is used), except for opening
>> +atoms, replacement from every %(atom) is quoted when and only when it
>> +appears at the top-level (that is, when it appears outside
>> +%($open)...%(end)).

>> +When a scripting language specific quoting is in effect, everything
>> +between a top-level opening atom and its matching %(end) is evaluated
>> +according to the semantics of the opening atom and its result is
>> +quoted.

... saying the same thing?


>> +               }
>> +       } else if (!if_then_else->condition_satisfied)
>
> Minor nit. I'm not sure what standard we use here at Git, but
> traditionally, I prefer to see { } blocks on all sections even if only
> one of them needs it. (That is, only drop the braces when every
> section is one line.) It also looks weird with a comment since it
> appears as multiple lines to the reader. I think the braces improve
> readability.
>
> I don't know whether that's Git's code base standard or not, however.
> It's not really worth a re-roll unless something else would need to
> change.
>

In principle, we mimick the kernel style of using {} block even on a
single-liner body in if/else if/else cascade when any one of them is
not a single-liner and requires {}.  But we often ignore that when a
truly trivial single liner follows if() even if its else clause is a
big block, e.g.

	if (cond)
		single;
	else {
		big;
		block;
	}

I agree with you that this case should just use {} for the following
paragraph, because it is technically a single-liner, but comes with
a big comment block and is very much easier to read with {} around
it.

>> +               /*
>> +                * No %(else) atom: just drop the %(then) branch if the
>> +                * condition is not satisfied.
>> +                */
>> +               strbuf_reset(&cur->output);

Thanks.
