From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v11 05/13] ref-filter: implement an `align` atom
Date: Sun, 16 Aug 2015 22:07:24 -0400
Message-ID: <CAPig+cR=gCBiEnZbnPfZZs0WmjBsQyL+2BjSHggWWp_43rC9cg@mail.gmail.com>
References: <1439661643-16094-6-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 04:07:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZR9pj-0006VP-AA
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 04:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803AbbHQCHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2015 22:07:25 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:33028 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbbHQCHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2015 22:07:25 -0400
Received: by ykll84 with SMTP id l84so50666163ykl.0
        for <git@vger.kernel.org>; Sun, 16 Aug 2015 19:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=vj+70Gool5yCNvCEyrJPk2kUKHzoCy0b5q+TS5m3JEY=;
        b=WOKn/QKzPlNet0CDlGqMamzudyo0+vXx2omJpX925CBQFS0b/X9LMfeTrCOjxSZpRj
         QwbOjo5FxIQZyPLtEundzMIctX4zmRvCn+KZZZpEzW12EhTBixBuO7dby3w1Bh5WSStz
         J1OWsmPyE737yEML3LxD84fWg2jupKye9Gc3GvQ0wyAmKXl7FOe7f3pTauc8LcFvPLRf
         j+FHft7EOb5MmcPSHziBLwLHxtYkeI79CDoMpXqczIRBUdukT9+vxhPpNl/Cka5CBuaq
         rwSlq9129kr8o20QHfiA7DACmNMkPjfmcgUZKi/OYj8tJd+q79qbFHcS+srh5+dF8i8O
         /oUA==
X-Received: by 10.170.81.133 with SMTP id x127mr56990555ykx.13.1439777244643;
 Sun, 16 Aug 2015 19:07:24 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Sun, 16 Aug 2015 19:07:24 -0700 (PDT)
In-Reply-To: <1439661643-16094-6-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: vmRA8t4guCxyteuU5PO5vdKoQBI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276028>

On Sat, Aug 15, 2015 at 2:00 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Implement an `align` atom which left-, middle-, or right-aligns the
> content between %(align:..) and %(end).
>
> It is followed by `:<width>,<position>`, where the `<position>` is
> either left, right or middle and `<width>` is the size of the area
> into which the content will be placed. If the content between
> %(align:) and %(end) is more than the width then no alignment is
> performed. e.g. to align a refname atom to the middle with a total
> width of 40 we can do: --format="%(align:middle,40)%(refname)%(end)".
>
> This is done by calling the strbuf_utf8_align() function in utf8.c.
>
> Add documentation and tests for the same.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> index 3259363..eac99d0 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -10,6 +10,7 @@
>  #include "quote.h"
>  #include "ref-filter.h"
>  #include "revision.h"
> +#include "utf8.h"
>
>  typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
>
> @@ -53,16 +54,27 @@ static struct {
>         { "flag" },
>         { "HEAD" },
>         { "color" },
> +       { "align" },
> +       { "end" },
> +};
> +
> +struct align {
> +       align_type position;
> +       unsigned int width;
>  };
>
>  struct ref_formatting_state {
>         struct strbuf output;
>         struct ref_formatting_state *prev;
> +       void (*attend)(struct ref_formatting_state *state);

Junio's suggestion for this member was "at end"; that is what to do
when you are "at"-the-%(end), not "attend", which isn't meaningful
here. You could also call it 'end_scope', 'finish' or 'close' or
'finalize' or something.

> +       void *cb_data;
>         int quote_style;
>  };
>
>  struct atom_value {
>         const char *s;
> +       struct align *align;
> +       void (*handler)(struct atom_value *atomv, struct ref_formatting_state **state);
>         unsigned long ul; /* used for sorting when not FIELD_STR */
>  };
>
> @@ -137,12 +149,12 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
>
>  static struct ref_formatting_state *push_new_state(struct ref_formatting_state **state)
>  {
> -       struct ref_formatting_state *new_state = xcalloc(1, sizeof(struct ref_formatting_state));
> -       struct ref_formatting_state *tmp = *state;
> +       struct ref_formatting_state *new = xcalloc(1, sizeof(struct ref_formatting_state));
> +       struct ref_formatting_state *old = *state;
>
> -       *state = new_state;
> -       new_state->prev = tmp;
> -       return new_state;
> +       *state = new;
> +       new->prev = old;
> +       return new;
>  }

What are these changes about? They appear only to be renaming some
variables which were introduced in patch 3. It would make more sense
to give them the desired names in the patch which introduces them.

>  static void pop_state(struct ref_formatting_state **state)
> @@ -625,6 +637,34 @@ static inline char *copy_advance(char *dst, const char *src)
>         return dst;
>  }
>
> +static void align_handler(struct ref_formatting_state *state)

The names 'align_handler' and 'align_atom_handler' are confusingly
similar. Perhaps name this end_align() or do_align() or
apply_alignment() or something?

> +{
> +       struct strbuf aligned = STRBUF_INIT;
> +       struct ref_formatting_state *return_to = state->prev;
> +       struct align *align = (struct align *)state->cb_data;
> +
> +       strbuf_utf8_align(&aligned, align->position, align->width, state->output.buf);
> +       strbuf_addbuf(&return_to->output, &aligned);

A couple comments:

First, why is 'strbuf aligned' needed? Can't you instead just invoke
strbuf_utf8_align(&return_to->output, ...)?

Second, I realize that Junio suggested the 'return_to' idea, but it
seems like it could become overly painful since each handler of this
sort is going to have to perform the same manipulation to append its
collected output to its parent state's output. What if you instead
make it the responsibility of pop_state() to append the 'output' from
the state being popped to the "prev" state's 'output'? This way, it
happens automatically, thus reducing code in each individual handler,
and reducing the burden of having to keep writing the same code.

> +       strbuf_release(&aligned);
> +}
> +
> +static void align_atom_handler(struct atom_value *atomv, struct ref_formatting_state **state)
> +{
> +       struct ref_formatting_state *new = push_new_state(state);
> +       strbuf_init(&new->output, 0);

I think this strbuf_init() should be the responsibility of
push_new_state(), as mentioned in my patch 3 review, otherwise every
caller of push_new_state() will have to remember to do this.

> +       new->attend = align_handler;
> +       new->cb_data = atomv->align;
> +}
> +
> +static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_state **state)
> +{
> +       struct ref_formatting_state *current = *state;
> +       if (!current->attend)
> +               die(_("format: `end` atom used without a supporting atom"));
> +       current->attend(current);
> +       pop_state(state);
> +}
> +
>  /*
>   * Parse the object referred by ref, and grab needed value.
>   */
> @@ -653,6 +693,7 @@ static void populate_value(struct ref_array_item *ref)
>                 int deref = 0;
>                 const char *refname;
>                 const char *formatp;
> +               const char *valp;
>                 struct branch *branch = NULL;
>
>                 if (*name == '*') {
> @@ -718,6 +759,34 @@ static void populate_value(struct ref_array_item *ref)
>                         else
>                                 v->s = " ";
>                         continue;
> +               } else if (skip_prefix(name, "align:", &valp)) {
> +                       struct align *align = xmalloc(sizeof(struct align));

Who is responsible for freeing this memory?

> +                       char *ep = strchr(valp, ',');
> +
> +                       if (ep)
> +                               *ep = '\0';
> +
> +                       if (strtoul_ui(valp, 10, &align->width))
> +                               die(_("positive width expected align:%s"), valp);
> +
> +                       if (!ep || starts_with(ep + 1, "left"))
> +                               align->position = ALIGN_LEFT;
> +                       else if (starts_with(ep + 1, "right"))
> +                               align->position = ALIGN_RIGHT;
> +                       else if (starts_with(ep + 1, "middle"))
> +                               align->position = ALIGN_MIDDLE;

Shouldn't these be strcmp() rather than starts_with()? You don't want
to match "leftfoot" as "left".

> +                       else
> +                               die(_("improper format entered align:%s"), ep + 1);
> +
> +                       if (ep)
> +                               *ep = ',';

What's this conditional about? Why restore the comma?

> +
> +                       v->align = align;
> +                       v->handler = align_atom_handler;

Junio's proposal for using handlers[1] is a pretty big change which
would generalize atom processing overall, and which you haven't
implemented here. Instead, your use of handlers is just to avoid
having special-case 'align' and 'end' conditionals spread throughout
several functions. Am I understanding that correctly?

Is the idea to leave that larger change for a later date (and possibly
a different programmer)?

[1]: http://article.gmane.org/gmane.comp.version-control.git/275710

> +                       continue;
> +               } else if (!strcmp(name, "end")) {
> +                       v->handler = end_atom_handler;
> +                       continue;
>                 } else
>                         continue;
>
> @@ -1296,6 +1365,8 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
>                 if (cp < sp)
>                         append_literal(cp, sp, state);
>                 get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
> +               if (atomv->handler)
> +                       atomv->handler(atomv, &state);
>                 append_atom(atomv, state);
>         }
>         if (*cp) {
> diff --git a/ref-filter.h b/ref-filter.h
> index 45026d0..144a633 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -5,6 +5,7 @@
>  #include "refs.h"
>  #include "commit.h"
>  #include "parse-options.h"
> +#include "utf8.h"

Why does this need to be #included here?

>  /* Quoting styles */
>  #define QUOTE_NONE 0
