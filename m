From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v14 04/13] ref-filter: implement an `align` atom
Date: Sun, 30 Aug 2015 18:10:37 -0400
Message-ID: <CAPig+cQF=1FPFP_7Bn2m2J+ay5ZupG25USWc9LT9SqO1=VDZvg@mail.gmail.com>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
	<1440857537-13968-5-git-send-email-Karthik.188@gmail.com>
	<CAPig+cRHRPehkd+9PwOqpXkRUvaJa42zLtCKMEfv2W=ZJUZJzA@mail.gmail.com>
	<CAOLa=ZTHtps2gJb9asSzG_4NOwx_xiA7OuCzjW=BTTFfkaYoQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 00:10:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWAoF-0003ci-0B
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 00:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587AbbH3WKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2015 18:10:39 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:35923 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbbH3WKi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2015 18:10:38 -0400
Received: by ykey204 with SMTP id y204so29862473yke.3
        for <git@vger.kernel.org>; Sun, 30 Aug 2015 15:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=9CwWMlZLMNlNSirJI0EDJbZzZwobH10UU1Bpw46PT/w=;
        b=rfuwiyH/OqQke/ko8KcJ+JFVbm/bxsskI1ZP4jjm/YR6avRjc3kRsduG99kq52uGIo
         s0Yu3UmWAas+/IElMbkywEqq53n5AqAWpcq97dGBX7tAE5brcb70IEBYUc1r/kXR0xEW
         809ni6rsE42rd2DuxojnWcBvNP/iQtH/ISn46PS0C96AY3KLrhxsz0xoM+r1xOdktDFX
         N3PtJWoTrJiLDBsnS0F4HiC551s5+FvwqzyReoTNVLfgM1cGadmW2KpE4AU+UFja7hzj
         MaFkQXzA6EdY3F2wTbhtO+l++aqt2oFin9Ub+FsoXxeoKUWdhPVRBkaf/KtgIAXRL33k
         JjDA==
X-Received: by 10.13.202.80 with SMTP id m77mr19077635ywd.166.1440972637827;
 Sun, 30 Aug 2015 15:10:37 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Sun, 30 Aug 2015 15:10:37 -0700 (PDT)
In-Reply-To: <CAOLa=ZTHtps2gJb9asSzG_4NOwx_xiA7OuCzjW=BTTFfkaYoQg@mail.gmail.com>
X-Google-Sender-Auth: 5MON7aaIS_D4YYBx50D_YQDG5ms
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276841>

On Sun, Aug 30, 2015 at 9:38 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Sun, Aug 30, 2015 at 8:57 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Sat, Aug 29, 2015 at 10:12 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>> +static void append_atom(struct atom_value *v, struct ref_formatting_state *state)
>>> +{
>>> +       /*
>>> +        * Quote formatting is only done when the stack has a single
>>> +        * element. Otherwise quote formatting is done on the
>>> +        * element's entire output strbuf when the %(end) atom is
>>> +        * encountered.
>>> +        */
>>> +       if (!state->stack->prev)
>>
>> With the disclaimer that I wasn't following the quoting discussion
>> closely: Is this condition going to be sufficient for all cases, such
>> as an %(if:) atom? That is, if you have:
>>
>>     %(if:notempty)%(bloop)%(then) --option=%(bloop)%(end)
>>
>> isn't the intention that, %(bloop) within the %(then) section should
>> be quoted but not the literal "--option="?
>>
>> The condition `!state->stack->prev' would be insufficient to handle
>> this if %(if:) pushes one or more states onto the stack, no? This
>> implies that you might want an explicit flag for enabling/disabling
>> quoting rather than relying upon the state of the stack, and that
>> individual atom handlers would control that flag.
>
>> Or, am I misunderstanding due to not having followed the discussion closely?
>
> Yes this wont be work for what you've said.
>
> To sum up the discussion:
> We didn't want atoms within the %(align)....%(end) to be quoted separately
> rather the whole aligned buffer to be quoted at the end.
>
> But this does conflict with %(if)...%(end). So it makes sense to change it to
> only have checks for %(align) atom being used.

If I understand Junio's response correctly, then this doesn't sound
correct either. Rather than imbuing only %(align:) with special
quoting knowledge, it sounds like quoting should be handled
generically for all top-level atoms and pseudo-atoms, including %(if:)
and others which may come later.

(But perhaps I'm still misunderstanding...)

> So probably:
>
> static void append_atom(struct atom_value *v, struct
> ref_formatting_state *state)
> {
>     if (state->stack->at_end == align_handler)

This couples append_atom() far too tightly with the %(align:) atom. If
you really need to do this sort of special-casing, then it probably
would make more sense to have an explicit flag saying whether or not
quoting should be done, rather than tying it specifically to the
%(align:) atom.

However, (again, if I'm understanding Junio's response), your original
`!state->stack->prev' condition might be sufficient after all.

>         strbuf_addstr(&state->stack->output, v->s);
>     else
>         quote_formatting(&state->stack->output, v->s, state->quote_style);
> }
>
> and
>
> static void end_atom_handler(struct atom_value *atomv, struct
> ref_formatting_state *state)
> {
>     struct ref_formatting_stack *current = state->stack;
>     struct strbuf s = STRBUF_INIT;
>
>     if (!current->at_end)
>         die(_("format: `end` atom used without a supporting atom"));
>     current->at_end(current);
>     /*
>      * Whenever we have more than one stack element that means we
>      * are using a align modifier atom. In that case we need to
>      * perform quote formatting.
>      */
>     if (current->at_end == align_handler) {

Ditto about being too tightly coupled to %(align:). Such logic should
likely be generic for any such atom.

>         quote_formatting(&s, current->output.buf, state->quote_style);
>         strbuf_reset(&current->output);
>         strbuf_addbuf(&current->output, &s);
>     }
>     strbuf_release(&s);
>     pop_stack_element(&state->stack);
> }
>>> @@ -725,6 +818,37 @@ static void populate_value(struct ref_array_item *ref)
>>>                         else
>>>                                 v->s = " ";
>>>                         continue;
>>> +               } else if (!strcmp(name, "align"))
>>> +                       die(_("format: incomplete use of the `align` atom"));
>>
>> Why does %(align) get flagged as a malformation of %(align:), whereas
>> %(color) does not get flagged as a malformation of %(color:)? Why does
>> one deserve special treatment but not the other?
>
> Didn't see that, I think its needed to add a check for both like :
>
> else if (!strcmp(name, "align") || !strcmp(name, "color"))
>             die(_("format: improper usage of %s atom"), name);
>
> I had a look if any other atoms need a subvalue to operate, couldn't
> find any.

Hmm, I'm not convinced that either %(align) or %(color) need to be
called out specially. What is the current behavior when these
"malformations" or any other misspelled atoms are used? Does it error
out? Does it simply ignore them and pass them through to the output
unmolested?
