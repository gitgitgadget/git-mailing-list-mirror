From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v12 03/13] ref-filter: introduce the ref_formatting_state
 stack machinery
Date: Wed, 19 Aug 2015 21:09:47 +0530
Message-ID: <CAOLa=ZTy8QO=H9g9g3SKU4HaG=qg71GidGuXKLXNgu7Su3FQ9A@mail.gmail.com>
References: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com>
 <1439923052-7373-4-git-send-email-Karthik.188@gmail.com> <vpqvbcb2uoi.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 19 17:40:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS5TY-000776-4i
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 17:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539AbbHSPkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 11:40:21 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:33055 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530AbbHSPkR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 11:40:17 -0400
Received: by obbhe7 with SMTP id he7so7555452obb.0
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 08:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YwIFYBaMDWJ8d605PHpvrQwnRsEvTkr87IpJD/HgQWw=;
        b=zdieklfyBe6q2r12no+uNlUXKHnjlALQO+VSOs5EYsIDEKHbONLVViO/F2eR0oGBIA
         2IpLcKBDjG6G6/n6hu7vmQgg7ANUnbCWMh2MGwG/MdIqZjzFIND9pXM/IJjdEYNdKoR9
         zhKZEzOe4acYrqMNMaXhlUHEEKUJURDaQ9dXTznE87qXR4dP9cUlqMzXaHv5uhGUb3zp
         M9ZCknGqji0B7h2RmV7CL+2gqAudfvz70wDG7EVcAMF8eZ95vM314Pg/mZVBYrzpJWQ7
         eWUqZQj/BE4ZGadlYhdzdA+Eik+kq0pIBZjgza82LwQT7BNQI5u0Ghy+YLfZu565d8A/
         GXwg==
X-Received: by 10.60.65.68 with SMTP id v4mr11031496oes.84.1439998816693; Wed,
 19 Aug 2015 08:40:16 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Wed, 19 Aug 2015 08:39:47 -0700 (PDT)
In-Reply-To: <vpqvbcb2uoi.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276196>

On Wed, Aug 19, 2015 at 8:26 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +static void pop_state(struct ref_formatting_state **stack)
>> +{
>> +     struct ref_formatting_state *current = *stack;
>> +     struct ref_formatting_state *prev = current->prev;
>> +
>> +     if (prev)
>> +             strbuf_addbuf(&prev->output, &current->output);
>
> I find this "if (prev)" suspicious: if there's a previous element in the
> stack, push to it, but otherwise, you're throwing away the content of
> the stack top silently.
>
> Given the rest of the patch, this is correct, since you're using
> state->output before pop_state(), but I find it weird to have the same
> function to actually pop a state, and to destroy the last element.
>
> Just thinking out loudly, I don't have specific alternative to propose
> here.
>

Hmm, but destroying the last element is also pop'ing it off the stack in a way.
I can't think of a something else.

>> @@ -1262,23 +1284,24 @@ static void append_literal(const char *cp, const char *ep, struct ref_formatting
>>  void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
>>  {
>>       const char *cp, *sp, *ep;
>> -     struct ref_formatting_state state;
>> +     struct strbuf *final_buf;
>> +     struct ref_formatting_state *state = NULL;
>>
>> -     strbuf_init(&state.output, 0);
>> -     state.quote_style = quote_style;
>> +     push_new_state(&state);
>> +     state->quote_style = quote_style;
>
> I do not think that the quote_style should belong to the stack. At the
> moment, only the bottom of the stack has it set, and as a result you're
> getting weird results like:
>
> $ ./git for-each-ref --shell --format '|%(align:80,left)<%(author)>%(end)|' | head -n 3
> |<Junio C Hamano <gitster@pobox.com> 1435173702 -0700>                           ''|
> |<Junio C Hamano <gitster@pobox.com> 1435173701 -0700>                           ''|
> |<Junio C Hamano <gitster@pobox.com> 1433277352 -0700>                           ''|
>
> See, the '' are inserted where the %(end) was, but not around atoms as
> one would expect.
>
> One stupid fix would be to propagate the quote_style accross the stack,
> like this:
>
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -155,6 +155,8 @@ static void push_new_state(struct ref_formatting_state **stack)
>
>         strbuf_init(&s->output, 0);
>         s->prev = *stack;
> +       if (*stack)
> +               s->quote_style = (*stack)->quote_style;
>         *stack = s;
>  }
>
>

This seems about right, why do you think it's a stupid fix?

> After applying this, I do get the '' around the author (= correct
> behavior I think), but then one wonders even more why this is part of
> the stack.
>
> You replaced the quote_style argument with ref_formatting_state, and I
> think you should have kept this argument and added ref_formatting_state.
> The other option is to add an extra indirection like
>
> struct ref_formatting_state {
>         int quote_style;
>         struct ref_formatting_stack *stack;
> }
>
> (ref_formatting_stack would be what you currently call
> ref_formatting_state). But that's probably overkill.
>

Yes, seems like an overkill.

> Also, after applying my toy patch above, I get useless '' around
> %(align) and %(end). I can get rid of them with
>
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1499,7 +1501,8 @@ void show_ref_array_item(struct ref_array_item *info, const char *format,
>                 get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
>                 if (atomv->handler)
>                         atomv->handler(atomv, &state);
> -               append_atom(atomv, state);
> +               else
> +                       append_atom(atomv, state);
>         }
>         if (*cp) {
>                 sp = cp + strlen(cp);
>
> Unless I missed something, this second patch is sensible anyway and
> should be squashed into [PATCH v12 05/13]: you don't need to call
> append_atom() when you have a handler, right?

Yes, this I'll squash into 05/13.

-- 
Regards,
Karthik Nayak
