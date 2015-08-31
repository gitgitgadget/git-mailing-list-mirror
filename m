From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v14 04/13] ref-filter: implement an `align` atom
Date: Mon, 31 Aug 2015 15:25:58 +0530
Message-ID: <CAOLa=ZS53BNNvnYv2TU6xQbEihi1GiKBaEEZ=KT6p_gDBR9Y9Q@mail.gmail.com>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
 <1440857537-13968-5-git-send-email-Karthik.188@gmail.com> <CAPig+cRHRPehkd+9PwOqpXkRUvaJa42zLtCKMEfv2W=ZJUZJzA@mail.gmail.com>
 <CAOLa=ZTHtps2gJb9asSzG_4NOwx_xiA7OuCzjW=BTTFfkaYoQg@mail.gmail.com> <CAPig+cQF=1FPFP_7Bn2m2J+ay5ZupG25USWc9LT9SqO1=VDZvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 11:56:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWLpI-0005dB-SH
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 11:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752311AbbHaJ43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 05:56:29 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:34921 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbbHaJ42 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 05:56:28 -0400
Received: by oigk185 with SMTP id k185so55563118oig.2
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 02:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1zCX4434jgd64vPgfhmCEBsA1Y0xIdDhpObOkM4HiuI=;
        b=Vzrlp6AMFXZkjmTCn6OxwaiUizXjxcHeouYqTpBHabFjzA1Eo6S6s7dF4dc6pd228D
         ZTz+Q1grWY0pr6Wgq4Q2A81jm06xfIWfQeI1M14LvVt4SRnSwLy839vAfDpqreu2k/xt
         oCUjSD55lNxFUKFNAo1Yr90BIbKohdyKqvMJY45CkuVcEZF8MgQTxOXL/06zArst5Dkt
         3oE7++/bD8Fj9G5BBiHj3cmQi8V/2mnqgREiG7r5PpkE3VgK1jR8lGDZ1nRJtQLsYG9p
         g9xHGwelrDZyp46Cqnj6kiHVGm+K1hmu15AKloVYMDNnjpSs+uzAVS/LwlHaTNYqgT8f
         Xe4Q==
X-Received: by 10.202.58.86 with SMTP id h83mr12439974oia.102.1441014988001;
 Mon, 31 Aug 2015 02:56:28 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Mon, 31 Aug 2015 02:55:58 -0700 (PDT)
In-Reply-To: <CAPig+cQF=1FPFP_7Bn2m2J+ay5ZupG25USWc9LT9SqO1=VDZvg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276861>

On Sun, Aug 30, 2015 at 3:10 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Aug 30, 2015 at 9:38 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> On Sun, Aug 30, 2015 at 8:57 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Sat, Aug 29, 2015 at 10:12 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>>> +static void append_atom(struct atom_value *v, struct ref_formatting_state *state)
>>>> +{
>>>> +       /*
>>>> +        * Quote formatting is only done when the stack has a single
>>>> +        * element. Otherwise quote formatting is done on the
>>>> +        * element's entire output strbuf when the %(end) atom is
>>>> +        * encountered.
>>>> +        */
>>>> +       if (!state->stack->prev)
>>>
>>> With the disclaimer that I wasn't following the quoting discussion
>>> closely: Is this condition going to be sufficient for all cases, such
>>> as an %(if:) atom? That is, if you have:
>>>
>>>     %(if:notempty)%(bloop)%(then) --option=%(bloop)%(end)
>>>
>>> isn't the intention that, %(bloop) within the %(then) section should
>>> be quoted but not the literal "--option="?
>>>
>>> The condition `!state->stack->prev' would be insufficient to handle
>>> this if %(if:) pushes one or more states onto the stack, no? This
>>> implies that you might want an explicit flag for enabling/disabling
>>> quoting rather than relying upon the state of the stack, and that
>>> individual atom handlers would control that flag.
>>
>>> Or, am I misunderstanding due to not having followed the discussion closely?
>>
>> Yes this wont be work for what you've said.
>>
>> To sum up the discussion:
>> We didn't want atoms within the %(align)....%(end) to be quoted separately
>> rather the whole aligned buffer to be quoted at the end.
>>
>> But this does conflict with %(if)...%(end). So it makes sense to change it to
>> only have checks for %(align) atom being used.
>
> If I understand Junio's response correctly, then this doesn't sound
> correct either. Rather than imbuing only %(align:) with special
> quoting knowledge, it sounds like quoting should be handled
> generically for all top-level atoms and pseudo-atoms, including %(if:)
> and others which may come later.
>
> (But perhaps I'm still misunderstanding...)
>

I was sure about how %(align)...%(end) was to be quoted at the end.
From Junio's comment it seems all top level atoms need to be quoted at the end
so with regards to this, the new changes aren't needed and the old
changes will hold.

>> So probably:
>>
>> static void append_atom(struct atom_value *v, struct
>> ref_formatting_state *state)
>> {
>>     if (state->stack->at_end == align_handler)
>
> This couples append_atom() far too tightly with the %(align:) atom. If
> you really need to do this sort of special-casing, then it probably
> would make more sense to have an explicit flag saying whether or not
> quoting should be done, rather than tying it specifically to the
> %(align:) atom.
>
> However, (again, if I'm understanding Junio's response), your original
> `!state->stack->prev' condition might be sufficient after all.
>

same as above.

>>         strbuf_addstr(&state->stack->output, v->s);
>>     else
>>         quote_formatting(&state->stack->output, v->s, state->quote_style);
>> }
>>
>> and
>>
>> static void end_atom_handler(struct atom_value *atomv, struct
>> ref_formatting_state *state)
>> {
>>     struct ref_formatting_stack *current = state->stack;
>>     struct strbuf s = STRBUF_INIT;
>>
>>     if (!current->at_end)
>>         die(_("format: `end` atom used without a supporting atom"));
>>     current->at_end(current);
>>     /*
>>      * Whenever we have more than one stack element that means we
>>      * are using a align modifier atom. In that case we need to
>>      * perform quote formatting.
>>      */
>>     if (current->at_end == align_handler) {
>
> Ditto about being too tightly coupled to %(align:). Such logic should
> likely be generic for any such atom.
>

Shouldn't be needed, was mistaken, sticking to the old logic.

>>         quote_formatting(&s, current->output.buf, state->quote_style);
>>         strbuf_reset(&current->output);
>>         strbuf_addbuf(&current->output, &s);
>>     }
>>     strbuf_release(&s);
>>     pop_stack_element(&state->stack);
>> }
>>>> @@ -725,6 +818,37 @@ static void populate_value(struct ref_array_item *ref)
>>>>                         else
>>>>                                 v->s = " ";
>>>>                         continue;
>>>> +               } else if (!strcmp(name, "align"))
>>>> +                       die(_("format: incomplete use of the `align` atom"));
>>>
>>> Why does %(align) get flagged as a malformation of %(align:), whereas
>>> %(color) does not get flagged as a malformation of %(color:)? Why does
>>> one deserve special treatment but not the other?
>>
>> Didn't see that, I think its needed to add a check for both like :
>>
>> else if (!strcmp(name, "align") || !strcmp(name, "color"))
>>             die(_("format: improper usage of %s atom"), name);
>>
>> I had a look if any other atoms need a subvalue to operate, couldn't
>> find any.
>
> Hmm, I'm not convinced that either %(align) or %(color) need to be
> called out specially. What is the current behavior when these
> "malformations" or any other misspelled atoms are used? Does it error
> out? Does it simply ignore them and pass them through to the output
> unmolested?

It just simply ignores them currently, which is kinda bad, as the user
is given no
warning, and the atom is ineffective.

-- 
Regards,
Karthik Nayak
