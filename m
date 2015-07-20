From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 4/9] ref-filter: add support to sort by version
Date: Sun, 19 Jul 2015 21:39:31 -0400
Message-ID: <CAPig+cRkwy_Dq3oYgHdNH6naaUDHZ_6DPopec1EG3aNwz56rzA@mail.gmail.com>
References: <1437246749-14423-1-git-send-email-Karthik.188@gmail.com>
	<1437246749-14423-5-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 03:47:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZH0AZ-0005ud-0X
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 03:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753947AbbGTBjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 21:39:32 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:35782 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753723AbbGTBjc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 21:39:32 -0400
Received: by ykdu72 with SMTP id u72so128896098ykd.2
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 18:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=piFmX/lCbRkDz1rQZBnQGvQArxRRATDwbZ+wazjk1X4=;
        b=v/MPmUdqPzewWd76xTHYy0Wsibkemej9B5HJSzVK2ydlt/xYKqVJaerIOxUY6aOwyK
         BY0ECqJBQlJUlRi+X7uqmc5A/7wSjPEPVT0hbtSqfNsQIWsczqIL3H6QUonkfgSIpbHX
         ZQR39nHGKOXZTtPqQwAVGxFmBotpyWkdfDRMLXjIJqD5mSBGl3WnUP7BULDMi6kOI0vj
         Bdi7qids0FTOanNPtKrPg9/cBtCCTBwSWii+G19UGUTmNA2Hw3Ic13btnEJFfPF2hgN2
         6aVKP3D3JZiHe3/hx4jdgkysinDr3Zx1Z45GSMqMme8haieXvGEHePY/Vaew+kQdq6LU
         Arvg==
X-Received: by 10.13.202.204 with SMTP id m195mr25779269ywd.48.1437356371562;
 Sun, 19 Jul 2015 18:39:31 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sun, 19 Jul 2015 18:39:31 -0700 (PDT)
In-Reply-To: <1437246749-14423-5-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: PDkAG8izo1JO95ABoLVyvDyEKrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274303>

On Sat, Jul 18, 2015 at 3:12 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Add support to sort by version using the "v:refname" and
> "version:refname" option. This is achieved by using the
> 'version_cmp()' function as the comparing function for qsort.

To agree with the actual code: s/version_cmp/versioncmp/

> This option is included to support sorting by versions in `git tag -l`
> which will eventaully be ported to use ref-filter APIs.
>
> Add documentation and tests for the same.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index e49d578..cc91275 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -144,6 +144,8 @@ blank line.  Finally, the optional GPG signature is `contents:signature`.
>  For sorting purposes, fields with numeric values sort in numeric
>  order (`objectsize`, `authordate`, `committerdate`, `taggerdate`).
>  All other fields are used to sort in their byte-value order.
> +There is also an option to sort by versions, this is done using the
> +field names ('version:refname' or 'v:refname').

Assuming I'm a reader without prior knowledge, the first question
which pops into my mind is "what's the difference between
'version:refname' and 'v:refname'?" Is one just shorthand for the
other, or is there some subtle difference in behavior, or what? The
documentation should explain this better.

Also, why are there parentheses around 'version:refname' or
'v:refname'? And, you should use backticks rather than apostrophes, as
is done with the other field names.

>  In any case, a field name that refers to a field inapplicable to
>  the object referred by the ref does not cause an error.  It
> diff --git a/ref-filter.c b/ref-filter.c
> index 82731ac..85c561e 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1169,18 +1170,22 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
>
>         get_ref_atom_value(a, s->atom, &va);
>         get_ref_atom_value(b, s->atom, &vb);
> -       switch (cmp_type) {
> -       case FIELD_STR:
> -               cmp = strcmp(va->s, vb->s);
> -               break;
> -       default:
> -               if (va->ul < vb->ul)
> -                       cmp = -1;
> -               else if (va->ul == vb->ul)
> -                       cmp = 0;
> -               else
> -                       cmp = 1;
> -               break;
> +       if (s->version)
> +               cmp = versioncmp(va->s, vb->s);
> +       else {
> +               switch (cmp_type) {
> +               case FIELD_STR:
> +                       cmp = strcmp(va->s, vb->s);
> +                       break;
> +               default:
> +                       if (va->ul < vb->ul)
> +                               cmp = -1;
> +                       else if (va->ul == vb->ul)
> +                               cmp = 0;
> +                       else
> +                               cmp = 1;
> +                       break;
> +               }

The logic might be slightly easier to follow, and give a much less
noisy diff if you rewrite it like this instead:

    if (s->version)
        cmp = versioncmp(va->s, vb->s);
    else if (cmp_type == FIELD_STR)
        cmp = strcmp(va->s, vb->s);
    else {
        if (va->ul < vb->ul)
            cmp = -1;
        else if (va->ul == vb->ul)
            cmp = 0;
        else
            cmp = 1;
    }

Or, if you don't mind a noisy diff, you can outdent the other branches, as well:

    if (s->version)
       cmp = versioncmp(va->s, vb->s);
    else if (cmp_type == FIELD_STR)
       cmp = strcmp(va->s, vb->s);
    else if (va->ul < vb->ul)
       cmp = -1;
    else if (va->ul == vb->ul)
       cmp = 0;
    else
       cmp = 1;

(I rather prefer the latter, despite the noisy diff.)

>         }
>         return (s->reverse) ? -cmp : cmp;
>  }
> diff --git a/ref-filter.h b/ref-filter.h
> index 7dfdea0..6f1646b 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -25,7 +25,7 @@ struct atom_value {
>  struct ref_sorting {
>         struct ref_sorting *next;
>         int atom; /* index into used_atom array (internal) */
> -       unsigned reverse : 1;
> +       unsigned reverse : 1, version : 1;

This is difficult to read. Style elsewhere (if I'm not mistaken) is to
place the declaration on a line by itself.

>  };
>
>  struct ref_array_item {
> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> index 505a360..c31fd2f 100755
> --- a/t/t6302-for-each-ref-filter.sh
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -81,4 +81,30 @@ test_expect_success 'filtering with --contains' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'version sort' '
> +       git tag -l --sort=version:refname | grep "foo" >actual &&
> +       cat >expect <<-\EOF &&
> +       foo1.3
> +       foo1.6
> +       foo1.10
> +       EOF
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'reverse version sort' '
> +       git tag -l --sort=-version:refname | grep "foo" >actual &&

Maybe use 'v:refname' in one of these tests in order to exercise that
alias as well?

> +       cat >expect <<-\EOF &&
> +       foo1.10
> +       foo1.6
> +       foo1.3
> +       EOF
> +       test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.4.6
