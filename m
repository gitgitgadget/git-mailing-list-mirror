From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v11 05/13] ref-filter: implement an `align` atom
Date: Mon, 17 Aug 2015 19:58:10 +0530
Message-ID: <CAOLa=ZRfA-8_w6VKgWQsoL7TrdyjEq5LTHwas=_04tmx9MWhqA@mail.gmail.com>
References: <1439661643-16094-6-git-send-email-Karthik.188@gmail.com> <CAPig+cR=gCBiEnZbnPfZZs0WmjBsQyL+2BjSHggWWp_43rC9cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 16:28:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRLP3-00086k-EE
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 16:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753811AbbHQO2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 10:28:41 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:35459 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbbHQO2k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 10:28:40 -0400
Received: by obbop1 with SMTP id op1so114224008obb.2
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 07:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=eA2Ia5nNhJxKvxnUxgTj1p89h5V70w2A6v5NLpBT7Ew=;
        b=CEdTU67g8jH/XmRnjjmkUsAQukmKpeK6Cgsu3fkt6qK9Kna6grlnFG5u6aO6OTdVh+
         5srQFvQj6ai2cVXMvybXXhGf3i0unxxbF7aK+s+FkC2jxQQWYEugKm3jFkfxHT12mgcC
         PPQSwxyjsryr+/Sc6Lnt6eoDXv6eK0o+43riMy+UFETIzl4ORiwbCxsuaFWdFqH6xA/s
         IhGchvQLMB+OztRZW4/2IbxgT+Rw9UO/thyyhHefb5OrXb1SNibNWVqMVnkIFb09tDhC
         o5hHxozfYCZDbSgcJWtNr87ykjvE1CCorM3kSQjXqI9nLpvSkMVom/XTV9nKpYbp/+JQ
         EuOA==
X-Received: by 10.182.81.98 with SMTP id z2mr1434315obx.70.1439821720076; Mon,
 17 Aug 2015 07:28:40 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Mon, 17 Aug 2015 07:28:10 -0700 (PDT)
In-Reply-To: <CAPig+cR=gCBiEnZbnPfZZs0WmjBsQyL+2BjSHggWWp_43rC9cg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276052>

On Mon, Aug 17, 2015 at 7:37 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Aug 15, 2015 at 2:00 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Implement an `align` atom which left-, middle-, or right-aligns the
>> content between %(align:..) and %(end).
>>
>> It is followed by `:<width>,<position>`, where the `<position>` is
>> either left, right or middle and `<width>` is the size of the area
>> into which the content will be placed. If the content between
>> %(align:) and %(end) is more than the width then no alignment is
>> performed. e.g. to align a refname atom to the middle with a total
>> width of 40 we can do: --format="%(align:middle,40)%(refname)%(end)".
>>
>> This is done by calling the strbuf_utf8_align() function in utf8.c.
>>
>> Add documentation and tests for the same.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> diff --git a/ref-filter.c b/ref-filter.c
>> index 3259363..eac99d0 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -10,6 +10,7 @@
>>  #include "quote.h"
>>  #include "ref-filter.h"
>>  #include "revision.h"
>> +#include "utf8.h"
>>
>>  typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
>>
>> @@ -53,16 +54,27 @@ static struct {
>>         { "flag" },
>>         { "HEAD" },
>>         { "color" },
>> +       { "align" },
>> +       { "end" },
>> +};
>> +
>> +struct align {
>> +       align_type position;
>> +       unsigned int width;
>>  };
>>
>>  struct ref_formatting_state {
>>         struct strbuf output;
>>         struct ref_formatting_state *prev;
>> +       void (*attend)(struct ref_formatting_state *state);
>
> Junio's suggestion for this member was "at end"; that is what to do
> when you are "at"-the-%(end), not "attend", which isn't meaningful
> here. You could also call it 'end_scope', 'finish' or 'close' or
> 'finalize' or something.
>

Weirdly, attend made sense to me, its a function you attend to at the end
types. probably "at_end" would be better.

>> +       void *cb_data;
>>         int quote_style;
>>  };
>>
>>  struct atom_value {
>>         const char *s;
>> +       struct align *align;
>> +       void (*handler)(struct atom_value *atomv, struct ref_formatting_state **state);
>>         unsigned long ul; /* used for sorting when not FIELD_STR */
>>  };
>>
>> @@ -137,12 +149,12 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
>>
>>  static struct ref_formatting_state *push_new_state(struct ref_formatting_state **state)
>>  {
>> -       struct ref_formatting_state *new_state = xcalloc(1, sizeof(struct ref_formatting_state));
>> -       struct ref_formatting_state *tmp = *state;
>> +       struct ref_formatting_state *new = xcalloc(1, sizeof(struct ref_formatting_state));
>> +       struct ref_formatting_state *old = *state;
>>
>> -       *state = new_state;
>> -       new_state->prev = tmp;
>> -       return new_state;
>> +       *state = new;
>> +       new->prev = old;
>> +       return new;
>>  }
>
> What are these changes about? They appear only to be renaming some
> variables which were introduced in patch 3. It would make more sense
> to give them the desired names in the patch which introduces them.
>

Agreed, will scrap them off.

>>  static void pop_state(struct ref_formatting_state **state)
>> @@ -625,6 +637,34 @@ static inline char *copy_advance(char *dst, const char *src)
>>         return dst;
>>  }
>>
>> +static void align_handler(struct ref_formatting_state *state)
>
> The names 'align_handler' and 'align_atom_handler' are confusingly
> similar. Perhaps name this end_align() or do_align() or
> apply_alignment() or something?
>
>> +{
>> +       struct strbuf aligned = STRBUF_INIT;
>> +       struct ref_formatting_state *return_to = state->prev;
>> +       struct align *align = (struct align *)state->cb_data;
>> +
>> +       strbuf_utf8_align(&aligned, align->position, align->width, state->output.buf);
>> +       strbuf_addbuf(&return_to->output, &aligned);
>
> A couple comments:
>
> First, why is 'strbuf aligned' needed? Can't you instead just invoke
> strbuf_utf8_align(&return_to->output, ...)?

Yeah, will remove it.

>
> Second, I realize that Junio suggested the 'return_to' idea, but it
> seems like it could become overly painful since each handler of this
> sort is going to have to perform the same manipulation to append its
> collected output to its parent state's output. What if you instead
> make it the responsibility of pop_state() to append the 'output' from
> the state being popped to the "prev" state's 'output'? This way, it
> happens automatically, thus reducing code in each individual handler,
> and reducing the burden of having to keep writing the same code.
>

Good question, what if we don't want to append to strbuf at all?
For e.g., We were discussing an "%(if).....%(then)......%(end)"
atom structure, here if the if condition isn't met we wouldn't want to
append to the prev strbuf, hence I thought it's better if the handler
decided whether or not to append to prev strbuf.

>> +       strbuf_release(&aligned);
>> +}
>> +
>> +static void align_atom_handler(struct atom_value *atomv, struct ref_formatting_state **state)
>> +{
>> +       struct ref_formatting_state *new = push_new_state(state);
>> +       strbuf_init(&new->output, 0);
>
> I think this strbuf_init() should be the responsibility of
> push_new_state(), as mentioned in my patch 3 review, otherwise every
> caller of push_new_state() will have to remember to do this.
>

As mentioned in your previous review, this will be changed.

>> +       new->attend = align_handler;
>> +       new->cb_data = atomv->align;
>> +}
>> +
>> +static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_state **state)
>> +{
>> +       struct ref_formatting_state *current = *state;
>> +       if (!current->attend)
>> +               die(_("format: `end` atom used without a supporting atom"));
>> +       current->attend(current);
>> +       pop_state(state);
>> +}
>> +
>>  /*
>>   * Parse the object referred by ref, and grab needed value.
>>   */
>> @@ -653,6 +693,7 @@ static void populate_value(struct ref_array_item *ref)
>>                 int deref = 0;
>>                 const char *refname;
>>                 const char *formatp;
>> +               const char *valp;
>>                 struct branch *branch = NULL;
>>
>>                 if (*name == '*') {
>> @@ -718,6 +759,34 @@ static void populate_value(struct ref_array_item *ref)
>>                         else
>>                                 v->s = " ";
>>                         continue;
>> +               } else if (skip_prefix(name, "align:", &valp)) {
>> +                       struct align *align = xmalloc(sizeof(struct align));
>
> Who is responsible for freeing this memory?
>

Should have been done in align_handler().

>> +                       char *ep = strchr(valp, ',');
>> +
>> +                       if (ep)
>> +                               *ep = '\0';
>> +
>> +                       if (strtoul_ui(valp, 10, &align->width))
>> +                               die(_("positive width expected align:%s"), valp);
>> +
>> +                       if (!ep || starts_with(ep + 1, "left"))
>> +                               align->position = ALIGN_LEFT;
>> +                       else if (starts_with(ep + 1, "right"))
>> +                               align->position = ALIGN_RIGHT;
>> +                       else if (starts_with(ep + 1, "middle"))
>> +                               align->position = ALIGN_MIDDLE;
>
> Shouldn't these be strcmp() rather than starts_with()? You don't want
> to match "leftfoot" as "left".
>

Makes sense.

>> +                       else
>> +                               die(_("improper format entered align:%s"), ep + 1);
>> +
>> +                       if (ep)
>> +                               *ep = ',';
>
> What's this conditional about? Why restore the comma?

because we go through the atoms, once when we verify the format
using verify_format() and again when we call show_ref_array_item()
and this if the atom is changed this would cause a segfault in the second
pho

>
>> +
>> +                       v->align = align;
>> +                       v->handler = align_atom_handler;
>
> Junio's proposal for using handlers[1] is a pretty big change which
> would generalize atom processing overall, and which you haven't
> implemented here. Instead, your use of handlers is just to avoid
> having special-case 'align' and 'end' conditionals spread throughout
> several functions. Am I understanding that correctly?
>
> Is the idea to leave that larger change for a later date (and possibly
> a different programmer)?
>
> [1]: http://article.gmane.org/gmane.comp.version-control.git/275710
>

If you're referring to how he suggested everything could just use the
handler and
work on that, yes, I'm leaving that out for the moment, probably me or
someone else
could work on that after this.

>> +                       continue;
>> +               } else if (!strcmp(name, "end")) {
>> +                       v->handler = end_atom_handler;
>> +                       continue;
>>                 } else
>>                         continue;
>>
>> @@ -1296,6 +1365,8 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
>>                 if (cp < sp)
>>                         append_literal(cp, sp, state);
>>                 get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
>> +               if (atomv->handler)
>> +                       atomv->handler(atomv, &state);
>>                 append_atom(atomv, state);
>>         }
>>         if (*cp) {
>> diff --git a/ref-filter.h b/ref-filter.h
>> index 45026d0..144a633 100644
>> --- a/ref-filter.h
>> +++ b/ref-filter.h
>> @@ -5,6 +5,7 @@
>>  #include "refs.h"
>>  #include "commit.h"
>>  #include "parse-options.h"
>> +#include "utf8.h"
>
> Why does this need to be #included here?
>

I'll remove that.

-- 
Regards,
Karthik Nayak
