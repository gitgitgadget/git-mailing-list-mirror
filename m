From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v11 03/13] ref-filter: introduce ref_formatting_state
Date: Sun, 16 Aug 2015 19:31:22 -0400
Message-ID: <CAPig+cRmFCpbJVzrAYqPRcJVKD7czfi7Mni_BzaoB2RkJnFJMg@mail.gmail.com>
References: <1439661643-16094-4-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 01:31:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZR7Oj-00033q-LK
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 01:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbbHPXbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2015 19:31:24 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:34728 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348AbbHPXbX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2015 19:31:23 -0400
Received: by ykdt205 with SMTP id t205so111964418ykd.1
        for <git@vger.kernel.org>; Sun, 16 Aug 2015 16:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=CG7O1iQfigetFB/jI11UmB8zc0pSXLvZwIPpX+qcr2w=;
        b=qAAEIQw5w6/q1NWdHNkkMGGZ+UUClz5ztcXHw9yXELVpMfr35xpezhNlT+UhW/EbhM
         jueVYb9NcT0IcuJQyZwVPwEIeubqdjztjDfMbQffUvFlGIvFJvH8riCR8kZRoJZ0Y3pU
         z/5+lVlo3QE5qOz9ZC/mWK6psm9ZY7anlKcKb5pm/Zh1WJ7QgN3a1Wy78g0X4/cwoS8u
         SrIkAtCDVTfK0vn/wpOzC2zprGG+135NVorFpNkYXFdDWXGCYJ3V0iDv/KKvjP+IFDZb
         a2gw+oqV3Z1KT6uUweuoUgR44RaABBJx86wPdDOTsl7rrDjxfbYcwl+vHyXpYu/Tre33
         MNuA==
X-Received: by 10.13.202.80 with SMTP id m77mr29608744ywd.166.1439767882595;
 Sun, 16 Aug 2015 16:31:22 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Sun, 16 Aug 2015 16:31:22 -0700 (PDT)
In-Reply-To: <1439661643-16094-4-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: rvW1PrdrkNO7HbdT-TCqjVnDebo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276024>

On Sat, Aug 15, 2015 at 2:00 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Introduce ref_formatting_state which will hold the formatted
> output strbuf and is used for nesting of modifier atoms.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> index edfb1c7..3259363 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -55,6 +55,12 @@ static struct {
>         { "color" },
>  };
>
> +struct ref_formatting_state {
> +       struct strbuf output;
> +       struct ref_formatting_state *prev;

Upon initial read-through of this patch, I found the name 'prev'
confusing since it seems you sometimes treat this as a linked-list
and, for a linked-list, this member is customarily named 'next'.
However, you also sometimes treat it as a stack, in which case 'prev'
makes a certain amount of sense semantically, although so does 'next'.
I'd probably have named it 'next', however, attr.c:struct attr_stack
names its member 'prev', so there is some precedence for the current
choice.

Also, it's customary for this member to be the first (or less
frequently last) member in the structure.

> +       int quote_style;
> +};
> +
>  struct atom_value {
>         const char *s;
>         unsigned long ul; /* used for sorting when not FIELD_STR */
> @@ -129,6 +135,26 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
>         return at;
>  }
>
> +static struct ref_formatting_state *push_new_state(struct ref_formatting_state **state)

This interface seems confused. The caller receives the new state as
both the return value of the function and as an out-value of its sole
argument. I'd suggest choosing one or the other.

Which one you choose depends upon how you view the operation and the
data structure. If you view it as linked-list manipulation, then you'd
probably want the new state returned, and accept a pointer argument
(rather than pointer-to-pointer). On the other hand, if you view it as
a stack, then you'd probably want to have it return void and
manipulate the sole argument. For this case, it might be clearer to
name the argument 'stack' rather than 'state'.

> +{
> +       struct ref_formatting_state *new_state = xcalloc(1, sizeof(struct ref_formatting_state));
> +       struct ref_formatting_state *tmp = *state;
> +
> +       *state = new_state;
> +       new_state->prev = tmp;
> +       return new_state;
> +}

A couple issues:

First, you need to initialize the strbuf member of
ref_formatting_state after allocation:

    new_state = xcalloc(1, sizeof(struct ref_formatting_state));
    strbuf_init(&new_state->output, 0);

Second, if you re-order the code slightly, the 'tmp' variable becomes
unnecessary.

Assuming that your intention was to match pop_state() and treat this
opaquely as a stack rather than exposing its linked-list
implementation, I'd have expected the function to look something like
this:

    static void push_new_state(struct ref_formatting_state **stack)
    {
        struct ref_formatting_state *s = xcalloc(...);
        s->next = *stack;
        strbuf_init(&s->output, 0);
        *stack = s;
    }

> +static void pop_state(struct ref_formatting_state **state)
> +{
> +       struct ref_formatting_state *current = *state;
> +       struct ref_formatting_state *prev = current->prev;
> +
> +       strbuf_release(&current->output);
> +       free(current);
> +       *state = prev;
> +}

This interface suggests that you're treating it as an opaque stack, in
which case naming the argument 'stack' might be clearer.

>  /*
>   * In a format string, find the next occurrence of %(atom).
>   */
> @@ -1195,23 +1221,23 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
>         qsort(array->items, array->nr, sizeof(struct ref_array_item *), compare_refs);
>  }
>
> -static void append_atom(struct atom_value *v, int quote_style, struct strbuf *output)
> +static void append_atom(struct atom_value *v, struct ref_formatting_state *state)
>  {
> -       switch (quote_style) {
> +       switch (state->quote_style) {
>         case QUOTE_NONE:
> -               strbuf_addstr(output, v->s);
> +               strbuf_addstr(&state->output, v->s);
>                 break;
>         case QUOTE_SHELL:
> -               sq_quote_buf(output, v->s);
> +               sq_quote_buf(&state->output, v->s);
>                 break;
>         case QUOTE_PERL:
> -               perl_quote_buf(output, v->s);
> +               perl_quote_buf(&state->output, v->s);
>                 break;
>         case QUOTE_PYTHON:
> -               python_quote_buf(output, v->s);
> +               python_quote_buf(&state->output, v->s);
>                 break;
>         case QUOTE_TCL:
> -               tcl_quote_buf(output, v->s);
> +               tcl_quote_buf(&state->output, v->s);
>                 break;
>         }
>  }

This patch touches all the same lines as the previous patch which
converted the code to append to a strbuf rather than emit to stdout,
thus it makes the previous patch seem wasted and the current patch
much noisier. As such, it might make sense to repartition these two
patches as so:

patch 2: Introduce ref_formatting_state (but without the 'prev'
field), and update callers to append to its 'output' member rather
than emitting to stdout.

patch 3: Introduce the ref_formatting_state stack machinery; this
patch would also add the 'prev' field.

> @@ -1234,7 +1260,7 @@ static int hex2(const char *cp)
>                 return -1;
>  }
>
> -static void append_literal(const char *cp, const char *ep, struct strbuf *output)
> +static void append_literal(const char *cp, const char *ep, struct ref_formatting_state *state)
>  {
>         while (*cp && (!ep || cp < ep)) {
>                 if (*cp == '%') {
> @@ -1243,13 +1269,13 @@ static void append_literal(const char *cp, const char *ep, struct strbuf *output
>                         else {
>                                 int ch = hex2(cp + 1);
>                                 if (0 <= ch) {
> -                                       strbuf_addch(output, ch);
> +                                       strbuf_addch(&state->output, ch);
>                                         cp += 3;
>                                         continue;
>                                 }
>                         }
>                 }
> -               strbuf_addch(output, *cp);
> +               strbuf_addch(&state->output, *cp);
>                 cp++;
>         }
>  }
> @@ -1257,20 +1283,24 @@ static void append_literal(const char *cp, const char *ep, struct strbuf *output
>  void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
>  {
>         const char *cp, *sp, *ep;
> -       struct strbuf output = STRBUF_INIT;
> +       struct strbuf *final_buf;
> +       struct ref_formatting_state *state = NULL;
> +
> +       state = push_new_state(&state);
> +       state->quote_style = quote_style;
>
>         for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
>                 struct atom_value *atomv;
>
>                 ep = strchr(sp, ')');
>                 if (cp < sp)
> -                       append_literal(cp, sp, &output);
> +                       append_literal(cp, sp, state);
>                 get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
> -               append_atom(atomv, quote_style, &output);
> +               append_atom(atomv, state);
>         }
>         if (*cp) {
>                 sp = cp + strlen(cp);
> -               append_literal(cp, sp, &output);
> +               append_literal(cp, sp, state);
>         }
>         if (need_color_reset_at_eol) {
>                 struct atom_value resetv;
> @@ -1279,11 +1309,12 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
>                 if (color_parse("reset", color) < 0)
>                         die("BUG: couldn't parse 'reset' as a color");
>                 resetv.s = color;
> -               append_atom(&resetv, quote_style, &output);
> +               append_atom(&resetv, state);
>         }
> -       fwrite(output.buf, 1, output.len, stdout);
> +       final_buf = &state->output;
> +       fwrite(final_buf->buf, 1, final_buf->len, stdout);
> +       pop_state(&state);
>         putchar('\n');
> -       strbuf_release(&output);
>  }
>
>  /*  If no sorting option is given, use refname to sort as default */
> --
> 2.5.0
