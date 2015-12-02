From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC 07/10] ref-filter: introduce align_atom_parser()
Date: Wed, 2 Dec 2015 16:23:59 -0500
Message-ID: <CAPig+cTYt1qaSLLOmwyZ-BQzOjWGxZ5koJNma1qc67UipPFW5w@mail.gmail.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
	<1447271075-15364-8-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 22:24:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4Esj-0007Id-7e
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 22:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756384AbbLBVYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 16:24:04 -0500
Received: from mail-vk0-f48.google.com ([209.85.213.48]:35100 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754437AbbLBVYA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 16:24:00 -0500
Received: by vkha189 with SMTP id a189so33333739vkh.2
        for <git@vger.kernel.org>; Wed, 02 Dec 2015 13:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=eFU9XAVWc3gCXQEXGMdbblz06jgjZ03ueiyqzBjo2+8=;
        b=ABKq5uB6mGO+9aWlSVzuPBnH6JvfgF4f5B9Lijaso1FnrZKwbx3IKUV1zik3hXnAaI
         D5UIhbrpaTh8uOCpRTthLJLEVoTBkLfiOaFtofQI8dCT2tPYcJi59qr2f0yNNEMoB3yn
         KzahLZL8fLtHnx605aGL1eA4TTCaDUuLGH4qEtC1uCyKIJwFF0UPOEfmgaMUcQ1y1PHj
         /DSRFzk28tX0nGgtWfAxE/sy0+HZSvh09Ruz0tbJkFlEhdNcjjbe9Yna2eYukm6DWeNg
         vFvlTGwcqkmuQEEljSHd9Zf8RbQMJkra+2SiYtQqx4TSvMocrdGU2n/ilB8+hJ5cmqp6
         KwHw==
X-Received: by 10.31.134.3 with SMTP id i3mr3780876vkd.14.1449091439654; Wed,
 02 Dec 2015 13:23:59 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Wed, 2 Dec 2015 13:23:59 -0800 (PST)
In-Reply-To: <1447271075-15364-8-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: t_bigQ4S590j1EYjY2tw0qFWJdk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281916>

On Wed, Nov 11, 2015 at 2:44 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Introduce align_atom_parser() which will parse 'align' atoms and store
> the required width and position into the 'used_atom' structure. While
> we're here, add support for the usage of 'width=' and 'position=' when
> using the 'align' atom (e.g. %(align:position=middle,width=30)).

This patch is doing too much by both moving code around and modifying
that code (somewhat dramatically), thus it is difficult for reviewers
to compare the old and new behaviors. It deserves to be split apart
into at least two patches. First, the code movement patch which
introduces align_atom_parser() (and possibly get_align_position())
without any behavior or logical change; then the patch which changes
behavior to recognize the spelled-out forms "width=" and "position=".
You may even want to spilt it into more patches, for instance by doing
the get_align_position() extraction in its own patch.

> Add documentation and modify the existing tests in t6302 to reflect
> the same.
>
> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> @@ -129,14 +129,16 @@ color::
>  align::
>         Left-, middle-, or right-align the content between
> -       %(align:...) and %(end). The "align:" is followed by `<width>`
> -       and `<position>` in any order separated by a comma, where the
> -       `<position>` is either left, right or middle, default being
> -       left and `<width>` is the total length of the content with
> -       alignment. If the contents length is more than the width then
> -       no alignment is performed. If used with '--quote' everything
> -       in between %(align:...) and %(end) is quoted, but if nested
> -       then only the topmost level performs quoting.
> +       %(align:...) and %(end). The "align:" is followed by
> +       `width=<width>` and `position=<position>` in any order
> +       separated by a comma, where the `<position>` is either left,
> +       right or middle, default being left and `<width>` is the total
> +       length of the content with alignment. The prefix for the
> +       arguments is not mandatory. If the contents length is more

This paragraph is so bulky that it's very easy to overlook the bit
about the "prefix for the arguments" being optional, and it's not
necessarily even clear to the casual reader what that means. It might,
therefore, be a good idea to spell it out explicitly. For instance,
you might say something like:

    For brevity, the "width=" and/or "position=" prefixes may be
    omitted, and bare <width> and <position> used instead.
    For instance, `%(align:<width>,<position>)`.

> +       than the width then no alignment is performed. If used with
> +       '--quote' everything in between %(align:...) and %(end) is
> +       quoted, but if nested then only the topmost level performs
> +       quoting.
> diff --git a/ref-filter.c b/ref-filter.c
> @@ -63,6 +69,61 @@ void color_atom_parser(struct used_atom *atom)
> +static align_type get_align_position(const char *type)

Taken in context of the callers, this isn't a great function name, as
it implies that it is retrieving some value, when in fact it is
parsing the input argument. A better name might be
parse_align_position().

Likewise, 'type' isn't necessarily a great argument name. You might
instead call it 'pos' or even just short and sweet 's'.

> +{
> +       if (!strcmp(type, "right"))
> +               return ALIGN_RIGHT;
> +       else if (!strcmp(type, "middle"))
> +               return ALIGN_MIDDLE;
> +       else if (!strcmp(type, "left"))
> +               return ALIGN_LEFT;
> +       return -1;
> +}
> +
> +void align_atom_parser(struct used_atom *atom)
> +{
> +       struct align *align = &atom->u.align;
> +       const char *buf = NULL;
> +       struct strbuf **s, **to_free;
> +       int width = -1;
> +
> +       match_atom_name(atom->str, "align", &buf);
> +       if (!buf)
> +               die(_("expected format: %%(align:<width>,<position>)"));

Is this still the way you want this error message to appear, or should
it show the long-form of the arguments? (I don't care strongly.)

> +       s = to_free = strbuf_split_str_without_term(buf, ',', 0);
> +
> +       /*  By default align to ALGIN_LEFT */

What is ALGIN? Regardless of the answer, this comment is not
particularly useful since it merely repeats what the code itself
already states clearly.

> +       align->position = ALIGN_LEFT;
> +
> +       while (*s) {
> +               int position;
> +               buf = s[0]->buf;
> +
> +               position = get_align_position(buf);

Why is this assignment way up here rather than down below in the
penultimate 'else' arm where its result is actually being checked? By
moving it closer to the point of use, the logic becomes easier to
understand.

> +               if (skip_prefix(buf, "position=", &buf)) {
> +                       position = get_align_position(buf);
> +                       if (position == -1)
> +                               die(_("improper format entered align:%s"), s[0]->buf);

At this point, you can give a better error message since you know that
you were parsing a "position=" argument. Maybe something like
"unrecognized position: %s".

> +                       align->position = position;
> +               } else if (skip_prefix(buf, "width=", &buf)) {
> +                       if (strtoul_ui(buf, 10, (unsigned int *)&width))
> +                               die(_("improper format entered align:%s"), s[0]->buf);

Ditto regarding better error message.

> +               } else if (!strtoul_ui(buf, 10, (unsigned int *)&width))
> +                               ;
> +               else if (position != -1)
> +                       align->position = position;
> +               else
> +                       die(_("improper format entered align:%s"), s[0]->buf);

Here too, it would be more user-friendly to say "unrecognized
%%(align) argument: %s".

> +               s++;
> +       }
> +
> +       if (width < 0)
> +               die(_("positive width expected with the %%(align) atom"));
> +       align->width = width;
> +       strbuf_list_free(to_free);
> +}
> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> @@ -97,7 +97,7 @@ test_expect_success 'left alignment is default' '
>         refname is refs/tags/three    |refs/tags/three
>         refname is refs/tags/two      |refs/tags/two
>         EOF
> -       git for-each-ref --format="%(align:30)refname is %(refname)%(end)|%(refname)" >actual &&
> +       git for-each-ref --format="%(align:width=30)refname is %(refname)%(end)|%(refname)" >actual &&
>         test_cmp expect actual
>  '
>
> @@ -113,7 +113,7 @@ test_expect_success 'middle alignment' '
>         |  refname is refs/tags/three  |refs/tags/three
>         |   refname is refs/tags/two   |refs/tags/two
>         EOF
> -       git for-each-ref --format="|%(align:middle,30)refname is %(refname)%(end)|%(refname)" >actual &&
> +       git for-each-ref --format="|%(align:position=middle,30)refname is %(refname)%(end)|%(refname)" >actual &&
>         test_cmp expect actual
>  '

While it may sometimes be reasonable to re-purpose existing tests like
this, this probably is not one of those cases. Instead, you should be
adding new tests to check all the permutations of the new argument
handling. For instance:

    %(align:42)
    %(align:middle,42)
    %(align:42,middle)
    %(align:position=middle,42)
    %(align:42,position=middle)
    %(align:middle,width=42)
    %(align:width=42,middle)
    %(align:position=middle,width=42)
    %(align:width=42,position=middle)

And, it wouldn't hurt to test handling of redundant or extra position
and width arguments. Should multiple arguments of the same type result
in an error, or should "last one wins (sliently)" be the policy? Once
you decide upon a policy, add tests to check that that policy works as
expected.

In this case, "last one wins (silently)" may be more friendly to
script writers, so it might be the better choice. You'd want to add
appropriate tests, using the various permutations. For instance:

    %(align:42,width=43)
    %(align:width=43,42)
    %(align:42,position=middle,right)
    %(align:42,right,position=middle)
