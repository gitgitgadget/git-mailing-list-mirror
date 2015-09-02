From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v15 05/13] ref-filter: implement an `align` atom
Date: Wed, 2 Sep 2015 17:21:06 +0530
Message-ID: <CAOLa=ZQ0nyaQmvE3suT6hh0jO3s_iYxFLjSuLUY4STneMFJf9Q@mail.gmail.com>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
 <1441131994-13508-6-git-send-email-Karthik.188@gmail.com> <xmqqegihrg6t.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 13:52:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZX6a5-0007xn-PE
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 13:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752380AbbIBLvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 07:51:38 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:35985 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451AbbIBLvh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 07:51:37 -0400
Received: by obqa2 with SMTP id a2so5535588obq.3
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 04:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZYEmJp45pZ4bbB5NVBdwTkn9v1pIZNQqHwNW6cRpU9U=;
        b=TplZb0aurGbHnkvyCpJ1piz1NvRdoHJiSlB46OnHsHHJ5GXP5Fm1M+Xzt46ugapcqF
         39l2q55HBgfNtbkxPQIx4ze80NSObrJTYA4Ervzej1OxINXa2SHT3oa262/UofUhgd9F
         1EYDKYgL1RPMg5hqkGUl91fkfbElCSQYLoVzUu4mc2DU9e7rdThmlMn/LULGzzKQFtVJ
         7TKfoeZsUnPbjYHAdrLpcj80L6FRm/Ew4Kp+V6mb/IK9Gz+Cd3ciilS41xXhNeoOzOo1
         1H3bC8QepU5d8+EAIgYxDYrqUDrnv0o7zQKqPlH/1uYO/uLZHjL4W6aJIx/tWnxrpRvp
         JH2g==
X-Received: by 10.60.81.69 with SMTP id y5mr14845341oex.30.1441194696356; Wed,
 02 Sep 2015 04:51:36 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Wed, 2 Sep 2015 04:51:06 -0700 (PDT)
In-Reply-To: <xmqqegihrg6t.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277086>

On Wed, Sep 2, 2015 at 2:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> We have an `at_end` function for each element of the stack which is to
>> be called when the `end` atom is encountered. Using this we implement
>> the aling_handler() for the `align` atom, this aligns the final strbuf
>
> align_handler().

Will change.

>
>>  struct ref_formatting_stack {
>>       struct ref_formatting_stack *prev;
>>       struct strbuf output;
>> +     void (*at_end)(struct ref_formatting_stack *stack);
>> +     void *cb_data;
>>  };
>
> s/cb_data/at_end_data/ or something, as this is not really about a
> function callback.  Imagine a fictional future where you add a new
> functions at_middle---the readers cannot tell what cb_data is about
> at that point.
>

Makes sense will change.

>> +static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
>> +{
>> +     struct ref_formatting_stack *current = state->stack;
>> +     struct strbuf s = STRBUF_INIT;
>> +
>> +     if (!current->at_end)
>> +             die(_("format: `end` atom used without a supporting atom"));
>
> Not a show-stopper, but we may need some wordsmithing for "a
> supporting atom" here; an end-user would not know what it is.
>

Probably something like "format: `end` atom should only be
used with modifier atoms".

>> +     current->at_end(current);
>> +
>> +     /*
>> +      * Perform quote formatting when the stack element is that of
>> +      * a modifier atom and right above the first stack element.
>> +      */
>> +     if (!state->stack->prev->prev) {
>> +             quote_formatting(&s, current->output.buf, state->quote_style);
>> +             strbuf_swap(&current->output, &s);
>> +     }
>> +     strbuf_release(&s);
>> +     pop_stack_element(&state->stack);
>> +}
>
> Nice.
>
>> @@ -687,6 +748,7 @@ static void populate_value(struct ref_array_item *ref)
>>               int deref = 0;
>>               const char *refname;
>>               const char *formatp;
>> +             const char *valp;
>>               struct branch *branch = NULL;
>>
>>               v->handler = append_atom;
>> @@ -754,6 +816,42 @@ static void populate_value(struct ref_array_item *ref)
>>                       else
>>                               v->s = " ";
>>                       continue;
>> +             } else if (skip_prefix(name, "align", &valp)) {
>
> This looked as if you are willing to take %(align) in addition to
> %(align:...), but...
>
>> +                     struct align *align = &v->align;
>> +                     struct strbuf **s;
>> +
>> +                     if (valp[0] != ':')
>> +                             die(_("format: usage %%(align:<width>,<position>)"));
>
> ... apparently that is not what is happening.  Why not skip "align:"
> with colon as the prefix, then?
>

Cause we wanted to provide an error for usage of "%(ailgn)" without any
subvalues as such.

>> +                     else
>> +                             valp++;
>> +                     s = strbuf_split_str(valp, ',', 0);
>> +
>> +                     /* If the position is given trim the ',' from the first strbuf */
>> +                     if (s[1])
>> +                             strbuf_setlen(s[0], s[0]->len - 1);
>> +
>> +                     if (strtoul_ui(s[0]->buf, 10, &align->width))
>> +                             die(_("positive width expected align:%s"), s[0]->buf);
>> +
>> +                     if (!s[1])
>> +                             align->position = ALIGN_LEFT;
>> +                     else if (!strcmp(s[1]->buf, "left"))
>> +                             align->position = ALIGN_LEFT;
>> +                     else if (!strcmp(s[1]->buf, "right"))
>> +                             align->position = ALIGN_RIGHT;
>> +                     else if (!strcmp(s[1]->buf, "middle"))
>> +                             align->position = ALIGN_MIDDLE;
>> +                     else
>> +                             die(_("improper format entered align:%s"), s[1]->buf);
>
> This does not reject %(align:40,left,junk), no?  Before "s[1] does
> not exist so default to left align", you would want
>
>         if (s[2])
>                 die("align:width,position followed by garbage: ,%s", s[2]->buf);
>

Yea we should probably do that.

> I have a few observations; these are not necessarily we would want
> to change in the scope of this series, though.
>
>  - The design of strbuf_split_buf API feels screwy.  A variant of
>    this function that strips the terminator at the end would be what
>    most callers would want.  Granted, leaving the terminator in the
>    resulting buffer does let the caller tell if the input ended with
>    an incomplete line that lacked the final terminator, but for all
>    s[i] for 0 <= i < N-1 where s[N] is the first element that is
>    NULL, they must end with the terminator---otherwise the elements
>    would not have split into the array in the first place.  "By
>    keeping the terminator, you can tell which one of the possible
>    terminators was used" could be a valid rationale for the API if
>    the function allowed more than one terminators, but that does not
>    apply here, either.
>
>  - I would have expected the above code to look more like this:
>
>         width = -1; position = ALIGN_LEFT;
>         s = strbuf_split_str(valp, ',', 0);
>         while (*s) {
>                 if (s[1])
>                         strbuf_setlen(*s, *s->len - 1);
>                 if (!strtoul_ui(*s->buf, 10, &width))
>                         ; /* parsed width successfully */
>                 else if (!strcmp(*s->buf, "left"))
>                         position = ALIGN_LEFT;
>                 else if ...
>                 else
>                         die("unknown parameter: %s", *s->buf);
>                 s++;
>         }
>         if (width < 0)
>                 ... perhaps set to the default width, or
>                 ... call die() complaining that you did not see
>                 ... an explicit width specified
>
>    Doing the code that way, it would be more obvious that a way to
>    extend the parser to accept forms like
>
>         %(align:width=40,position=left)
>
>    is by adding "keyword=value" parser before the fallbacks for
>    short-hand, i.e. "if looks like number" and everything else.
>

I'll keep this in mind, probably work on this later after this series is done.
Thanks

-- 
Regards,
Karthik Nayak
