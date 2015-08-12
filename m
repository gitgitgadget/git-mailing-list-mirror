From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v10 05/13] ref-filter: implement an `align` atom
Date: Wed, 12 Aug 2015 21:54:29 +0530
Message-ID: <CAOLa=ZTnS0kL=CK8Lx-brO0tryB5YzOFUpapsM4LMW-m2Yf9pw@mail.gmail.com>
References: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
 <1439129506-9989-6-git-send-email-Karthik.188@gmail.com> <xmqqy4hhr72q.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 18:25:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPYpv-0003S5-Hz
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 18:25:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbbHLQZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 12:25:00 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:33913 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588AbbHLQY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 12:24:59 -0400
Received: by obbfr1 with SMTP id fr1so16638762obb.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 09:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0ugJ+7fw2nhJ8qDety8MLJBPKLwmsBXXyArXZk4Trzw=;
        b=bSddc4MRW1pfKq7uyiNw+ye/jMYZcd/NDD1U7MOJf6blRyevt/bIw9sMTft4HHTkM0
         iaFm7K8TPgpv+67sSS0m2KEUwhiWtFVBIoCpUYVEI9rNhnZwkil4WmhK18S5YiJUrlP0
         t1pJ4QscZLhrAcXcA8CDM7fM//yY70zJLUuWi22a9YNp6lnZBBX9nTiBlbwI0B6O3K/w
         S42RCo1AhsP5kXUh/tRXTHP57HyiuLaRSak8RWK2SJmam9LInhlfA9BUbZlIDC2kkJpD
         t36tUMy7lvlQVKgVlYW/IwyAMYOvXRV37dqEHF38Dec4YjSDlE1J896OMO9jZFwpB9TW
         +77g==
X-Received: by 10.60.62.105 with SMTP id x9mr30572346oer.1.1439396698756; Wed,
 12 Aug 2015 09:24:58 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Wed, 12 Aug 2015 09:24:29 -0700 (PDT)
In-Reply-To: <xmqqy4hhr72q.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275778>

On Wed, Aug 12, 2015 at 12:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>  struct atom_value{
>
> Obviously not a problem with this step, but you need a SP before the
> open brace.
>

Will add.

>> @@ -692,6 +704,26 @@ static void populate_value(struct ref_array_item *ref)
>>                       else
>>                               v->s = " ";
>>                       continue;
>> +             } else if (skip_prefix(name, "align:", &valp)) {
>> +                     struct align *align = xmalloc(sizeof(struct align));
>> +
>> +                     if (skip_prefix(valp, "left,", &valp))
>> +                             align->position = ALIGN_LEFT;
>> +                     else if (skip_prefix(valp, "right,", &valp))
>> +                             align->position = ALIGN_RIGHT;
>> +                     else if (skip_prefix(valp, "middle,", &valp))
>> +                             align->position = ALIGN_MIDDLE;
>> +                     else
>> +                             die(_("improper format entered align:%s"), valp);
>> +                     if (strtoul_ui(valp, 10, &align->width))
>> +                             die(_("positive width expected align:%s"), valp);
>
> Minor nits on the design.  %(align:<width>[,<position>]) would let
> us write %(align:16)...%(end) and use the "default position", which
> may be beneficial if one kind of alignment is prevalent (I guess all
> the internal users left-align?)  %(align:<position>,<width>) forces
> users to spell both out all the time.
>

Isn't that better? I mean It sets a format which the others eventually
can follow
%(atom:suboption,value).
For example: %(objectname:abbrev,size)
Changing this would cause inconsistency according to me.

>> @@ -1198,7 +1230,9 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
>>
>>  struct ref_formatting_state {
>>       struct strbuf output;
>> +     struct align *align;
>>       int quote_style;
>> +     unsigned int end : 1;
>>  };
>
> Mental note: it is not clear why you need 'end' field in the state.
> Perhaps it is an indication that the division of labor is poorly
> designed between the helper that updates the formatting state and
> the other helper that reflects the formatting state to the final
> string.
>

This goes with what you've said below!

>> @@ -1262,12 +1296,31 @@ static void append_non_atom(const char *cp, const char *ep, struct ref_formattin
>>
>>  static void set_formatting_state(struct atom_value *atomv, struct ref_formatting_state *state)
>>  {
>> -     /* Based on the atomv values, the formatting state is set */
>> +     if (atomv->align) {
>> +             state->align = atomv->align;
>> +             atomv->align = NULL;
>> +     }
>> +     if (atomv->end)
>> +             state->end = 1;
>> +}
>> +
>> +static int align_ref_strbuf(struct ref_formatting_state *state, struct strbuf *final)
>> +{
>> +     if (state->align && state->end) {
>
> ... and I think that is what I see.  If this function knows that we
> are processing %(end), i.e. perform-state-formatting is called for
> each atom and receives atomv, there wouldn't have to be a code like
> this.
>

Agreed, your suggestion below eradicates this

>> +             struct align *align = state->align;
>> +             strbuf_utf8_align(final, align->position, align->width, state->output.buf);
>> +             strbuf_reset(&state->output);
>> +             state->align = NULL;
>> +             return 1;
>> +     } else if (state->align)
>> +             return 1;
>> +     return 0;
>>  }
>>
>>  static void perform_state_formatting(struct ref_formatting_state *state, struct strbuf *final)
>>  {
>> -     /* More formatting options to be eventually added */
>> +     if (align_ref_strbuf(state, final))
>> +             return;
>
> At the design level, I have a strong suspicion that it is a wrong
> way to go.  It piles more "if (this state bit was left by the
> previous atom) then do this" on this function and will make an
> unmanageable mess.

Hmm, yeah makes sense.

>
> You have a dictionary of all possible atoms somewhere.  Why not hook
> a pointer to the "handler" function (or two) to each element in it,
> instead of duplicating "this one is special" information down to
> individual atom instantiations (i.e. atomv) as atomv.modifier_atom
> bit, an dstructure the caller more like this?
>
>         get_ref_atom_value(info, parse_ref_filter_atom, &atomv);
>         if (atomv->pre_handler)
>                 atomv->pre_handler(atomv, &state);
>         format_quote_value(atomv, &state);
>         if (atomv->post_handler)
>                 atomv->post_handler(atomv, &state);
>
> Actually, each atom could just have a single handler; an atom like
> %(refname:short) whose sole effect is to append atomv->s to the
> state buffer can point a function to do so in its handler.
>
> On the other hand, align atom's handler would push a new state on
> the stack, marking that it is the one to handle diverted output.
>
>         align_atom_handler(atomv, state)
>         {
>                 struct format_state *new = push_new_state(state);
>                 strbuf_init(&new->output);
>                 new->atend = align_handler;
>                 new->return_to = atomv; /* or whatever that holds width,pos */
>         }
>
> Then end atom's handler would pop the state from the stack, and the
> processing to be done
>
>         end_atom_handler(atomv, state)
>         {
>                 state->atend(state);
>                 pop_state(state);
>         }
>
> and the called align_handler would be something like:
>
>         align_handler(state)
>         {
>                 struct strbuf aligned = STRBUF_INIT;
>                 struct format_state *return_to = state->prev;
>                 struct atom_value *atomv = state->return_to;
>
>                 strbuf_utf8_align(&aligned,
>                         atomv->align.pos, atomv->align.width,
>                         state->output.buf);
>                 strbuf_addbuf(&return_to->output, &aligned);
>                 strbuf_release(&aligned);
>         }
>
> With an arrangement like that, the body of the loop in
> show_ref_array_item() could be as simple and regular as:
>
>         get_ref_atom_value(info, parse_ref_filter_atom, &atomv);
>         atomv->handler(atomv, &state);
>
> without any new "ah, this %(end) is special so we need a new
> mechanism to pass information between set_formatting_state and
> perform_formatting" logic introduced every time you add new things.
>

This I agree is a way better scheme, This could also eventually help cleanup
populate_value() which is a huge function at the moment.

I like your suggestion, I'll work on this, Thanks a lot :)

-- 
Regards,
Karthik Nayak
