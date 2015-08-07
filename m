From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v9 03/11] ref-filter: implement an `align` atom
Date: Thu, 6 Aug 2015 23:27:20 -0400
Message-ID: <CAPig+cSTssDihF5cBwu=2uKX1y6GqH-5EhKnb92Fpp30JA7pwA@mail.gmail.com>
References: <CAOLa=ZRnnMBKpsq1ANBVgF2=xwK=A2EsPKKrGS0R4mZ8iATKfA@mail.gmail.com>
	<1438800854-19901-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 05:27:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNYJb-0006fl-2v
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 05:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778AbbHGD1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 23:27:22 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:35106 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098AbbHGD1V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 23:27:21 -0400
Received: by ykcq64 with SMTP id q64so74482862ykc.2
        for <git@vger.kernel.org>; Thu, 06 Aug 2015 20:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=o+Rwwj31akbN7TQJhFtbXVFfSnxRwyBlq5U+RXZGgEk=;
        b=ilcpsZKvEDxoCliEJMe97aD2AOgbrHpOOaGho3BTOoz6w+8UwqEnDjXeV5r+IcnYNf
         Zclzjgr6xOwGD/3ay/uO7SBV2RoYpV4x9CV5b0siE1EpzNPtxzIsWjdfox/9Bq85+/nu
         hSIIrdR6Sqw9ybym+mhmejHiJ27OqruPBr+e/x5BD12lm6/xGwWu+NsjpZ/cafzsVOcz
         ppl75SeremvGLFWQMMW6rbJM2plsT9Rdjuc4Tmmzse/G/zqc/cxnTUGCIhwgrw/s6Nf4
         WDbMxpPlmb3Xi+1Xn442qOm1AxfqptwZ24U0CC/4/iretKpWkLSJKSX54yqo+RtznoHL
         XuJg==
X-Received: by 10.170.63.196 with SMTP id f187mr5470495ykf.82.1438918040970;
 Thu, 06 Aug 2015 20:27:20 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Thu, 6 Aug 2015 20:27:20 -0700 (PDT)
In-Reply-To: <1438800854-19901-1-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: nAqSjFeWU7pVFon1_qwYgIcI5i8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275456>

On Wed, Aug 5, 2015 at 2:54 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Implement an `align` atom which will act as a modifier atom and align
> any string with or without an %(atom) appearing before a %(end) atom
> to the right, left or middle.

For someone not familiar with the evolution of this patch series,
"align any string with or without an %(atom)" is confusing and
distracting and seems to imply that something extra mysterious is
going on behind the scenes. Keeping it simple makes it easier to
understand:

    Add an `align` atom which left-, middle-, or right-aligns the
    content between %(align:...) and %(end).

> It is followed by `:<type>,<paddinglength>`, where the `<type>` is

'type' may not be the best name. Perhaps 'style' or 'position' or
something else would be better?

> either left, right or middle and `<paddinglength>` is the total length

'paddinglength' is misleading. You're really describing the container
width in which alignment takes places, so perhaps call it 'width' or
'fieldwidth' or something.

> of the padding to be performed. If the atom length is more than the
> padding length then no padding is performed. e.g. to pad a succeeding
> atom to the middle with a total padding size of 40 we can do a

It's odd to have alignment described in terms of "padding" and
"padding length", especially in the case of "center" alignment. It
might be better to rephrase the discussion in terms of field width or
such.

> --format="%(align:middle,40).."

I may have missed the discussion, but why was comma chosen as a
separator here, rather than, say, colon? For instance:

    %(align:middle:40)

> Add documentation and tests for the same.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index e49d578..d865f98 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -127,6 +127,14 @@ color::
> +align::
> +       Align any string with or without %(atom) before the %(end)
> +       atom to the right, left or middle. Followed by

Ditto regarding "any string with or without %(atom)" being confusing
to someone not familiar with the evolution of this patch series.
Instead, perhaps:

    Left-, middle-, or right-align content between %(align:...)
    and %(end).

> +       `:<type>,<paddinglength>`, where the `<type>` is either left,
> +       right or middle and `<paddinglength>` is the total length of
> +       the padding to be performed. If the string length is more than
> +       the padding length then no padding is performed.

Ditto regarding above observations about 'type', 'paddinglength', and "padding".

> diff --git a/ref-filter.c b/ref-filter.c
> index 2c074a1..d123299 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -620,7 +623,7 @@ static void populate_value(struct ref_array_item *ref)
>                 const char *name = used_atom[i];
>                 struct atom_value *v = &ref->value[i];
>                 int deref = 0;
> -               const char *refname;
> +               const char *refname = NULL;

What is this change about?

>                 const char *formatp;
>                 struct branch *branch = NULL;
>
> @@ -687,6 +690,29 @@ static void populate_value(struct ref_array_item *ref)
>                         else
>                                 v->s = " ";
>                         continue;
> +               } else if (starts_with(name, "align:")) {
> +                       const char *valp = NULL;

Unnecessary NULL assignment.

> +                       struct align *align = xmalloc(sizeof(struct align));
> +
> +                       skip_prefix(name, "align:", &valp);

You could simplify the code by combining this skip_prefix() with the
earlier starts_with() in the conditional:

    } else if (skip_prefix(name, "align:", &valp)) {
        struct align *align = xmalloc(sizeof(struct align));
        ...

> +                       if (skip_prefix(valp, "left,", &valp))
> +                               align->align_type = ALIGN_LEFT;
> +                       else if (skip_prefix(valp, "right,", &valp))
> +                               align->align_type = ALIGN_RIGHT;
> +                       else if (skip_prefix(valp, "middle,", &valp))
> +                               align->align_type = ALIGN_MIDDLE;
> +                       else
> +                               die(_("align: improper format"));

You could do a better job of helping the user track down the offending
"improper format" by actually including it in the error message.

> +                       if (strtoul_ui(valp, 10, &align->align_value))
> +                               die(_("align: positive value expected"));

Ditto.

> +                       v->align = align;
> +                       v->modifier_atom = 1;
> +                       continue;
> +               } else if (starts_with(name, "end")) {
> +                       v->end = 1;
> +                       v->modifier_atom = 1;
> +                       continue;
>                 } else
>                         continue;
>
> @@ -1251,12 +1277,48 @@ static void emit(const char *cp, const char *ep, struct ref_formatting_state *st
>  static void apply_formatting_state(struct ref_formatting_state *state, struct strbuf *final)
>  {
> -       /* More formatting options to be evetually added */
> +       if (state->align && state->end) {
> +               struct strbuf *value = state->output;
> +               int len = 0, buf_len = value->len;
> +               struct align *align = state->align;
> +
> +               if (!value->buf)
> +                       return;
> +               if (!is_utf8(value->buf)) {
> +                       len = value->len - utf8_strwidth(value->buf);

What is this doing, exactly? If the string is *not* utf-8, then you're
asking it for its utf-8 width. Am I reading that correctly?

Also, what is 'len' supposed to represent? I guess you want it to be
the difference between the byte length and the display length, but the
name 'len' doesn't convey that at all, nor does it help the reader
understand the code below where you do the actual formatting.

In fact, if I'm reading this correctly, then 'len' is always zero in
your tests (because the tests never trigger this conditional), so this
functionality is never being exercised.

> +                       buf_len -= len;
> +               }
> +
> +               if (align->align_value < buf_len) {

Shouldn't this be '<=' rather than '<'? There's no point going through
the formatting gyrations below if the string fills the alignment width
exactly.

Also, what's the purpose of 'buf_len'? It's value is always
(value->len - len), so you could just as easily say:

    if (align->align_value <= value->len - len) {

In fact, the misleading name 'len', along with 'buf_len' and
value->len tend to make this code difficult to comprehend. If,
instead, you had a variable named 'display_len', then its meaning
would be obvious, and computations involving it would be more easily
understood. The value of 'display_len' could be computed via:

    display_len = utf8_strnwidth(value->buf, value->len, 0);

which would give you the utf-8 width if utf-8, or value->len if not.

And, the above conditional would become the more readable:

    if (align->align_value <= display_len) {

although, I find it easier to understand the logic with the condition
switched around:

    if (display_len >= align->align_value) {
        ...don't bother with alignment gyrations...

(but that's just subjective)

> +                       state->align = NULL;
> +                       strbuf_addbuf(final, value);
> +                       strbuf_release(value);
> +                       return;
> +               }
> +
> +               if (align->align_type == ALIGN_LEFT)
> +                       strbuf_addf(final, "%-*s", len + align->align_value, value->buf);
> +               else if (align->align_type == ALIGN_MIDDLE) {
> +                       int right = (align->align_value - buf_len)/2;
> +                       strbuf_addf(final, "%*s%-*s", align->align_value - right + len,
> +                                   value->buf, right, "");

Why do you use the left-justifying format "%-*s" when interpolating
the zero-length string considering that "%*s" works just as well?

An aesthetic aside: When (align_value - buf_len) is an odd number,
this implementation favors placing more whitespace to the left of the
string, and less to the right. In practice, this often tends to look a
bit more awkward than the inverse of placing more whitespace to the
right, and less to the left (but that again is subjective).

> +               } else if (align->align_type == ALIGN_RIGHT)
> +                       strbuf_addf(final, "%*s", align->align_value, value->buf);

Why doesn't this case need to take 'len' into account like the other cases?

This is a tangent, but I could easily see all of the code from 'if
(align->align_value < buf_len)' down to this point being placed in
utf8.c as a general alignment utility function. Doing so would make
this function shorter, and the patch easier to review overall (which
might be an important consideration -- especially given that I've
already spent several hours reviewing this one patch).

> +               strbuf_release(value);
> +               state->align = NULL;
> +               return;
> +       } else if (state->align)
> +               return;

Do you expect additional types of state processing in the future? If
so, this function is likely to get very long. It might make sense to
break the alignment logic out into its own function which is called
from this one.

>         strbuf_addbuf(final, state->output);
>         strbuf_release(state->output);
>  }
> @@ -1301,6 +1372,7 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
>                 print_value(&resetv, &state);
>                 apply_formatting_state(&state, &final_buf);
>         }
> +

Sneaking in a whitespace change which an earlier patch perhaps should
have formatted correctly in the first place?

>         for (i = 0; i < final_buf.len; i++)
>                 printf("%c", final_buf.buf[i]);
>         putchar('\n');
> diff --git a/ref-filter.h b/ref-filter.h
> index 9e6c2d4..5575fe9 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -16,14 +16,30 @@
>  struct ref_formatting_state {
> -       int quote_style;
>         struct strbuf *output;
> +       struct align *align;
> +       int quote_style;

Perhaps decide where you'd like 'quote_style' to reside from the start
so that you don't have to add it at one location in its introductory
patch and then move it in a later patch. Also, why move it here?

> +       unsigned int end : 1;
> +};
> +
> +struct align {
> +       align_type align_type;

No need for an "align_" prefix on the members of 'struct align'.
That's just unneeded verbosity.

As mentioned above, 'type' may not be the best name. Perhaps 'style'
or 'position' or something better.

> +       unsigned int align_value;

Ditto. 'value' doesn't say much, whereas 'width' or 'fieldwidth' would
be more meaningful.

>  };
> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> index 505a360..76041a2 100755
> --- a/t/t6302-for-each-ref-filter.sh
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -81,4 +81,52 @@ test_expect_success 'filtering with --contains' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'left alignment' '
> +       cat >expect <<-\EOF &&
> +       refname is refs/heads/master  |refs/heads/master
> +       refname is refs/heads/side    |refs/heads/side
> +       refname is refs/odd/spot      |refs/odd/spot
> +       refname is refs/tags/double-tag|refs/tags/double-tag
> +       refname is refs/tags/four     |refs/tags/four
> +       refname is refs/tags/one      |refs/tags/one
> +       refname is refs/tags/signed-tag|refs/tags/signed-tag
> +       refname is refs/tags/three    |refs/tags/three
> +       refname is refs/tags/two      |refs/tags/two
> +       EOF
> +       git for-each-ref --format="%(align:left,30)refname is %(refname)%(end)|%(refname)" >actual &&
> +       test_cmp expect actual
> +'

Alluding to a previous review comment, for this left-alignment test,
perhaps add a third column to prove that the %(align:) atom isn't
leaking from column 1 to column 2 since it's not obvious to the
reader, given that trailing whitespace is not otherwise visible.

> +test_expect_success 'middle alignment' '
> +       cat >expect <<-\EOF &&
> +       | refname is refs/heads/master |refs/heads/master
> +       |  refname is refs/heads/side  |refs/heads/side
> +       |   refname is refs/odd/spot   |refs/odd/spot
> +       |refname is refs/tags/double-tag|refs/tags/double-tag
> +       |   refname is refs/tags/four  |refs/tags/four
> +       |   refname is refs/tags/one   |refs/tags/one
> +       |refname is refs/tags/signed-tag|refs/tags/signed-tag
> +       |  refname is refs/tags/three  |refs/tags/three
> +       |   refname is refs/tags/two   |refs/tags/two
> +       EOF
> +       git for-each-ref --format="|%(align:middle,30)refname is %(refname)%(end)|%(refname)" >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'right alignment' '
> +       cat >expect <<-\EOF &&
> +       |  refname is refs/heads/master|refs/heads/master
> +       |    refname is refs/heads/side|refs/heads/side
> +       |      refname is refs/odd/spot|refs/odd/spot
> +       |refname is refs/tags/double-tag|refs/tags/double-tag
> +       |     refname is refs/tags/four|refs/tags/four
> +       |      refname is refs/tags/one|refs/tags/one
> +       |refname is refs/tags/signed-tag|refs/tags/signed-tag
> +       |    refname is refs/tags/three|refs/tags/three
> +       |      refname is refs/tags/two|refs/tags/two
> +       EOF
> +       git for-each-ref --format="|%(align:right,30)refname is %(refname)%(end)|%(refname)" >actual &&
> +       test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.5.0
