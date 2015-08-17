From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v11 03/13] ref-filter: introduce ref_formatting_state
Date: Mon, 17 Aug 2015 18:13:16 +0530
Message-ID: <CAOLa=ZTZEVaBCvxS0TekJGQq3pmi+-KCwL_QrTdpTqhrtBKdrg@mail.gmail.com>
References: <1439661643-16094-4-git-send-email-Karthik.188@gmail.com> <CAPig+cRmFCpbJVzrAYqPRcJVKD7czfi7Mni_BzaoB2RkJnFJMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 14:43:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRJlY-0007SA-QX
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 14:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754685AbbHQMnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 08:43:47 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:35584 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427AbbHQMnq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 08:43:46 -0400
Received: by obbop1 with SMTP id op1so111485907obb.2
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 05:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LwyE9dQPRUPUP6W8maJXdJfBjSAaIk/TOBmkkvlRTs8=;
        b=ha3ZUAyN7n6CByp7Yxf57jK5vWjNJQATzK4jqXNsIq2ShqONj6J7IjuR427WDtFQtW
         vW8ZjhO285HvpbCl4u/VKpMzvbYXsHT+NcrheaW698xGTAqmAW3PPFNstZhhPPj0gMcP
         FxAqbAXYeL8T8DUsoOveD97BVMTjhF9wawX6Av4XEgc02ULLWCcZjkig95D189fZSzfx
         SH/Dyn+2/GntMQifNeA09c7VFbsa62JrrLqQjimacM1xBNylFAqraf9o4snx7eLH1WSB
         0kb+mgbvzHpe3lj5OWLw9xIehbU6yXQTqQM1JpTLRoTsANfemQQYFmQqWIXNk8pQc94X
         +VDA==
X-Received: by 10.182.60.130 with SMTP id h2mr1013983obr.42.1439815426120;
 Mon, 17 Aug 2015 05:43:46 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Mon, 17 Aug 2015 05:43:16 -0700 (PDT)
In-Reply-To: <CAPig+cRmFCpbJVzrAYqPRcJVKD7czfi7Mni_BzaoB2RkJnFJMg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276048>

On Mon, Aug 17, 2015 at 5:01 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Aug 15, 2015 at 2:00 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Introduce ref_formatting_state which will hold the formatted
>> output strbuf and is used for nesting of modifier atoms.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> diff --git a/ref-filter.c b/ref-filter.c
>> index edfb1c7..3259363 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -55,6 +55,12 @@ static struct {
>>         { "color" },
>>  };
>>
>> +struct ref_formatting_state {
>> +       struct strbuf output;
>> +       struct ref_formatting_state *prev;
>
> Upon initial read-through of this patch, I found the name 'prev'
> confusing since it seems you sometimes treat this as a linked-list
> and, for a linked-list, this member is customarily named 'next'.
> However, you also sometimes treat it as a stack, in which case 'prev'
> makes a certain amount of sense semantically, although so does 'next'.
> I'd probably have named it 'next', however, attr.c:struct attr_stack
> names its member 'prev', so there is some precedence for the current
> choice.

Its sort of a stack in all sense, I mean we get new elements and push it onto
the top and pop them once we're done. So that's why prev, also it's
more of pushing the
current state into the previously defined state.

>
> Also, it's customary for this member to be the first (or less
> frequently last) member in the structure.
>

Ok will do that.

>> +       int quote_style;
>> +};
>> +
>>  struct atom_value {
>>         const char *s;
>>         unsigned long ul; /* used for sorting when not FIELD_STR */
>> @@ -129,6 +135,26 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
>>         return at;
>>  }
>>
>> +static struct ref_formatting_state *push_new_state(struct ref_formatting_state **state)
>
> This interface seems confused. The caller receives the new state as
> both the return value of the function and as an out-value of its sole
> argument. I'd suggest choosing one or the other.
>
> Which one you choose depends upon how you view the operation and the
> data structure. If you view it as linked-list manipulation, then you'd
> probably want the new state returned, and accept a pointer argument
> (rather than pointer-to-pointer). On the other hand, if you view it as
> a stack, then you'd probably want to have it return void and
> manipulate the sole argument. For this case, it might be clearer to
> name the argument 'stack' rather than 'state'.
>

I guess it makes to stick to the stack arrangement, will change the argument
name to stack.

>> +{
>> +       struct ref_formatting_state *new_state = xcalloc(1, sizeof(struct ref_formatting_state));
>> +       struct ref_formatting_state *tmp = *state;
>> +
>> +       *state = new_state;
>> +       new_state->prev = tmp;
>> +       return new_state;
>> +}
>
> A couple issues:
>
> First, you need to initialize the strbuf member of
> ref_formatting_state after allocation:
>
>     new_state = xcalloc(1, sizeof(struct ref_formatting_state));
>     strbuf_init(&new_state->output, 0);
>

Was under the impression that strbuf_init() is not needed after a xcalloc,
had to look at that again.

> Second, if you re-order the code slightly, the 'tmp' variable becomes
> unnecessary.
>
> Assuming that your intention was to match pop_state() and treat this
> opaquely as a stack rather than exposing its linked-list
> implementation, I'd have expected the function to look something like
> this:
>
>     static void push_new_state(struct ref_formatting_state **stack)
>     {
>         struct ref_formatting_state *s = xcalloc(...);
>         s->next = *stack;
>         strbuf_init(&s->output, 0);
>         *stack = s;
>     }
>

You mean:

static void push_new_state(struct ref_formatting_state **stack)
{
    struct ref_formatting_state *s = xcalloc(...);

    strbuf_init(&s->output, 0);
    s->prev = *stack;
    *stack = s;
}

>> +static void pop_state(struct ref_formatting_state **state)
>> +{
>> +       struct ref_formatting_state *current = *state;
>> +       struct ref_formatting_state *prev = current->prev;
>> +
>> +       strbuf_release(&current->output);
>> +       free(current);
>> +       *state = prev;
>> +}
>
> This interface suggests that you're treating it as an opaque stack, in
> which case naming the argument 'stack' might be clearer.
>

Will do thanks.

>>  /*
>>   * In a format string, find the next occurrence of %(atom).
>>   */
>> @@ -1195,23 +1221,23 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
>>         qsort(array->items, array->nr, sizeof(struct ref_array_item *), compare_refs);
>>  }
>>
>> -static void append_atom(struct atom_value *v, int quote_style, struct strbuf *output)
>> +static void append_atom(struct atom_value *v, struct ref_formatting_state *state)
>>  {
>> -       switch (quote_style) {
>> +       switch (state->quote_style) {
>>         case QUOTE_NONE:
>> -               strbuf_addstr(output, v->s);
>> +               strbuf_addstr(&state->output, v->s);
>>                 break;
>>         case QUOTE_SHELL:
>> -               sq_quote_buf(output, v->s);
>> +               sq_quote_buf(&state->output, v->s);
>>                 break;
>>         case QUOTE_PERL:
>> -               perl_quote_buf(output, v->s);
>> +               perl_quote_buf(&state->output, v->s);
>>                 break;
>>         case QUOTE_PYTHON:
>> -               python_quote_buf(output, v->s);
>> +               python_quote_buf(&state->output, v->s);
>>                 break;
>>         case QUOTE_TCL:
>> -               tcl_quote_buf(output, v->s);
>> +               tcl_quote_buf(&state->output, v->s);
>>                 break;
>>         }
>>  }
>
> This patch touches all the same lines as the previous patch which
> converted the code to append to a strbuf rather than emit to stdout,
> thus it makes the previous patch seem wasted and the current patch
> much noisier. As such, it might make sense to repartition these two
> patches as so:
>
> patch 2: Introduce ref_formatting_state (but without the 'prev'
> field), and update callers to append to its 'output' member rather
> than emitting to stdout.
>
> patch 3: Introduce the ref_formatting_state stack machinery; this
> patch would also add the 'prev' field.
>

This sounds good, will do this.

--
Regards,
Karthik Nayak
