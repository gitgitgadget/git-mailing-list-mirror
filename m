From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v14 04/13] ref-filter: implement an `align` atom
Date: Sat, 29 Aug 2015 23:27:23 -0400
Message-ID: <CAPig+cRHRPehkd+9PwOqpXkRUvaJa42zLtCKMEfv2W=ZJUZJzA@mail.gmail.com>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
	<1440857537-13968-5-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 05:27:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVtHV-0004Iw-1L
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 05:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753205AbbH3D1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2015 23:27:25 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:32866 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194AbbH3D1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Aug 2015 23:27:24 -0400
Received: by ykdz80 with SMTP id z80so49946431ykd.0
        for <git@vger.kernel.org>; Sat, 29 Aug 2015 20:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=cmoV9E7FK8HTOOT+ZCEY6OjckMTXvqjsdaJ5HxtGna0=;
        b=QqY6+wv6kKev4jfTgS6GRnzWdMJRNsxbioGMtPam5qdjMKy+jBXI6CFVq0jSY/YFyF
         m6kncDQLzLoYYYHLvFLhwjFMct6nmR9QFAEhif/OJAmmWfQ9/G3/LoXG0FovOvqE8a2p
         Mq3htAPoTyZoUTQm2vb3MUIVm5CjWXkn6SDJdEQYSPBUpOZXDwQiCHvrV17diKp+e+Uc
         83zDSsa8VxI62vjO8cuymaLhh3B8l4hZ1YK1We7/dJPcufhcCmQB8/9zsofeUAA1gvtQ
         meji9h6ItW8ibs3lFiu0sw9ekO8zyG4MD5J2/aHfH6o+IFHixND0xg22pIo5uByCZnB5
         PAUA==
X-Received: by 10.129.92.8 with SMTP id q8mr14965179ywb.163.1440905243754;
 Sat, 29 Aug 2015 20:27:23 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Sat, 29 Aug 2015 20:27:23 -0700 (PDT)
In-Reply-To: <1440857537-13968-5-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: 6-5YhOTujfaDQG3WnuSfEMOkyNo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276798>

On Sat, Aug 29, 2015 at 10:12 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
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
> We now have a `handler()` for each atom_value which will be called
> when that atom_value is being parsed, and similarly an `at_end`
> function for each element of the stack which is to be called when the
> `end` atom is encountered. Using this we implement the `align` atom
> which aligns the given strbuf by calling `strbuf_utf8_align()` from
> utf8.c.
>
> Extract perform_quote_formatting() from append_atom(). Given a string
> a quote_value and a strbuf, perform_quote_formatting() formats the
> string based on the quote_value and stores it into the strbuf.
>
> Ensure that quote formatting is performed on the whole of
> %(align)...%(end) rather than individual atoms. We do this by skipping
> individual quote formatting for atoms whenever the stack has more than
> one element, and performing formatting for the entire stack element
> when the `%(end)` atoms is encountered.

This patch seems to be conflating three distinct changes:

1. adding %(align:) atom
2. extracting quoting logic to a separate function
3. quoting top-level %(align:) but not contained atoms

In fact, #3 seems too specially tied to %(align:)...%(end). One might
expect that the logic for determining when to quote should be
independent of any particular atom, which suggests that this logic is
being handled at the wrong level, and that %(align:) shouldn't have to
know anything about quoting. I'd have thought the quoting logic would
naturally accompany the introduction of the formatting state stack
mechanism in patch 2/13, and that that would generically work with all
atoms, including %(align:) and whatever new ones are added in the
future.

But, I may not have been following the quoting discussion closely, so
perhaps these observations are incorrect?  See more below regarding
%(if:).

> Add documentation and tests for the same.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> index 432cea0..21c8b5f 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -53,6 +54,13 @@ static struct {
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
>  #define REF_FORMATTING_STATE_INIT  { 0, NULL }
> @@ -69,6 +79,8 @@ struct ref_formatting_state {
>
>  struct atom_value {
>         const char *s;
> +       struct align *align;

Why does 'align' need to be heap-allocated rather than just being a
direct member of 'atom_value'? Does 'align' need to exist beyond the
lifetime of its 'atom_value'? If not, making it a direct member might
simplify resource management (no need to free it).

> +       void (*handler)(struct atom_value *atomv, struct ref_formatting_state *state);
>         unsigned long ul; /* used for sorting when not FIELD_STR */
>  };
>
> @@ -632,6 +644,84 @@ static inline char *copy_advance(char *dst, const char *src)
> +static void append_atom(struct atom_value *v, struct ref_formatting_state *state)
> +{
> +       /*
> +        * Quote formatting is only done when the stack has a single
> +        * element. Otherwise quote formatting is done on the
> +        * element's entire output strbuf when the %(end) atom is
> +        * encountered.
> +        */
> +       if (!state->stack->prev)

With the disclaimer that I wasn't following the quoting discussion
closely: Is this condition going to be sufficient for all cases, such
as an %(if:) atom? That is, if you have:

    %(if:notempty)%(bloop)%(then) --option=%(bloop)%(end)

isn't the intention that, %(bloop) within the %(then) section should
be quoted but not the literal "--option="?

The condition `!state->stack->prev' would be insufficient to handle
this if %(if:) pushes one or more states onto the stack, no? This
implies that you might want an explicit flag for enabling/disabling
quoting rather than relying upon the state of the stack, and that
individual atom handlers would control that flag.

Or, am I misunderstanding due to not having followed the discussion closely?

> +               quote_formatting(&state->stack->output, v->s, state->quote_style);
> +       else
> +               strbuf_addstr(&state->stack->output, v->s);
> +}
> +
> +static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
> +{
> +       struct ref_formatting_stack *current = state->stack;
> +       struct strbuf s = STRBUF_INIT;
> +
> +       if (!current->at_end)
> +               die(_("format: `end` atom used without a supporting atom"));
> +       current->at_end(current);
> +       /*
> +        * Whenever we have more than one stack element that means we
> +        * are using a certain modifier atom. In that case we need to
> +        * perform quote formatting.
> +        */
> +       if (state->stack->prev) {
> +               quote_formatting(&s, current->output.buf, state->quote_style);
> +               strbuf_reset(&current->output);
> +               strbuf_addbuf(&current->output, &s);

strbuf_swap() can replace the above two lines.

> +       }
> +       strbuf_release(&s);
> +       pop_stack_element(&state->stack);
> +}
> +
>  /*
>   * Parse the object referred by ref, and grab needed value.
>   */
> @@ -725,6 +818,37 @@ static void populate_value(struct ref_array_item *ref)
>                         else
>                                 v->s = " ";
>                         continue;
> +               } else if (!strcmp(name, "align"))
> +                       die(_("format: incomplete use of the `align` atom"));

Why does %(align) get flagged as a malformation of %(align:), whereas
%(color) does not get flagged as a malformation of %(color:)? Why does
one deserve special treatment but not the other?

> +               else if (skip_prefix(name, "align:", &valp)) {
> +                       struct align *align = xmalloc(sizeof(struct align));
> +                       struct strbuf **s = strbuf_split_str(valp, ',', 0);
> +
> +                       /* If the position is given trim the ',' from the first strbuf */
> +                       if (s[1])
> +                               strbuf_remove(s[0], s[0]->len - 1, 1);

This is a truncation operation, which may be more idiomatically stated as:

    strbuf_setlen(s[0], s[0]->len - 1);

> +
> +                       if (strtoul_ui(s[0]->buf, 10, &align->width))
> +                               die(_("positive width expected align:%s"), s[0]->buf);
> +
> +                       /* If no position is given, default to ALIGN_LEFT */
> +                       if (!s[1] || !strcmp(s[1]->buf, "left"))
> +                               align->position = ALIGN_LEFT;

If you structured the code like this:

    if (!s[1])
        align->position = ALIGN_LEFT;
    else if (!strcmp(s[1]->buf, "left"))
        align->position = ALIGN_LEFT;
    else if ...

then the comment about "default" would become unnecessary, and it
would be easier to change the default in the future (if the need ever
arose), however, this is a very minor point, and I don't care
strongly.

> +                       else if (!strcmp(s[1]->buf, "right"))
> +                               align->position = ALIGN_RIGHT;
> +                       else if (!strcmp(s[1]->buf, "middle"))
> +                               align->position = ALIGN_MIDDLE;
> +                       else
> +                               die(_("improper format entered align:%s"), s[1]->buf);
> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> index 505a360..cef7a41 100755
> --- a/t/t6302-for-each-ref-filter.sh
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -81,4 +81,89 @@ test_expect_success 'filtering with --contains' '
> +# Everything in between the %(align)...%(end) atom must be quoted, hence we test this by
> +# introducing single quote's in %(align)...%(end), which must not be escaped.
> +
> +sq="'"
> +
> +test_expect_success 'alignment with format quote' '
> +       cat >expect <<-EOF &&
> +       refname is ${sq}           ${sq}\\${sq}${sq}master${sq}\\${sq}${sq}           ${sq}|
> +       refname is ${sq}            ${sq}\\${sq}${sq}side${sq}\\${sq}${sq}            ${sq}|
> +       refname is ${sq}          ${sq}\\${sq}${sq}odd/spot${sq}\\${sq}${sq}          ${sq}|
> +       refname is ${sq}         ${sq}\\${sq}${sq}double-tag${sq}\\${sq}${sq}         ${sq}|
> +       refname is ${sq}            ${sq}\\${sq}${sq}four${sq}\\${sq}${sq}            ${sq}|
> +       refname is ${sq}            ${sq}\\${sq}${sq}one${sq}\\${sq}${sq}             ${sq}|
> +       refname is ${sq}         ${sq}\\${sq}${sq}signed-tag${sq}\\${sq}${sq}         ${sq}|
> +       refname is ${sq}           ${sq}\\${sq}${sq}three${sq}\\${sq}${sq}            ${sq}|
> +       refname is ${sq}            ${sq}\\${sq}${sq}two${sq}\\${sq}${sq}             ${sq}|
> +       EOF
> +       git for-each-ref --shell --format="refname is %(align:30,middle)${sq}%(refname:short)${sq}%(end)|" >actual &&

This can be much less noisy if you change the second argument of
test_expect_success to use double-quote rather than single-quote. That
would allow you to use single-quote directly in the test and expected
output rather than having to use ${sq} indirection.

    test_expect_success 'alignment with format quote' "
        cat >expect <<-\EOF &&
        refname is '           '''master'''           '|
        ...
        EOF
        git for-each-ref --shell --format='refname ...
\\'%(rename:short)\\'...|'
    "

or something.

> +       test_cmp expect actual
> +'
