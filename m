From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 05/10] ref-filter: add support to sort by version
Date: Wed, 29 Jul 2015 15:34:10 -0400
Message-ID: <CAPig+cSZzA+3BaP78VhQ3JjYbW_Y+KRhQ6c4-SPuxysKmL8bZw@mail.gmail.com>
References: <CAOLa=ZR6_2NBB4v0Ynq391=8Jk2RZON6R0YG=HKUNwKx249b7Q@mail.gmail.com>
	<1438065211-3777-1-git-send-email-Karthik.188@gmail.com>
	<1438065211-3777-5-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"christian.couder@gmail.com" <christian.couder@gmail.com>,
	"Matthieu.Moy@grenoble-inp.fr" <Matthieu.Moy@grenoble-inp.fr>,
	"gitster@pobox.com" <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 21:34:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKX7K-0002T1-7a
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 21:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754099AbbG2TeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 15:34:12 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:36241 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753199AbbG2TeL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 15:34:11 -0400
Received: by ykay190 with SMTP id y190so16674909yka.3
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 12:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=JQFlkV10wYZVHUe0X0W+qrMh7wUrkY6oQ0MVgDfS5Ks=;
        b=HfcgbmTvWNLNFiXxeRdawmierrOxD/f7IqFBY3HA9S9UmcLcrLWjWzcZtIa6AeXuT8
         w0htSTQkMUUALezoUJfCpqxNWxJn6E435Jav3bYv/CKi9MUH0P1hpRmM1NII+C8eRuiG
         SKk0TbKVUkf4caulQVA+AJCS+h8wgX3N5Iu04T15ncxDfipAavtf15Fd2wc6SJ+mlr4P
         S3O2sy04IXwW33vQMl9U8Z2R8TQDGCNsx+OOtY/XG7TVEipDsoFX2LBx3NycpAcVfHsJ
         vlmkWLgpctrE2nz/ryQ6sWOZCXYpnI454rOTbi1/Q/LFG7C87FRosy5bras9L9JdHDIe
         M3xw==
X-Received: by 10.170.196.4 with SMTP id n4mr46503393yke.127.1438198450892;
 Wed, 29 Jul 2015 12:34:10 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Wed, 29 Jul 2015 12:34:10 -0700 (PDT)
In-Reply-To: <1438065211-3777-5-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: k--98coahOHSPptUQMYsBMMXJsU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274944>

On Tuesday, July 28, 2015, Karthik Nayak <karthik.188@gmail.com> wrote:
> Add support to sort by version using the "v:refname" and
> "version:refname" option. This is achieved by using the 'versioncmp()'
> function as the comparing function for qsort.
>
> This option is included to support sorting by versions in `git tag -l`
> which will eventaully be ported to use ref-filter APIs.
>
> Add documentation and tests for the same.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index 45dd7f8..2b60aee 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -151,6 +151,9 @@ For sorting purposes, fields with numeric values sort in numeric
>  order (`objectsize`, `authordate`, `committerdate`, `taggerdate`).
>  All other fields are used to sort in their byte-value order.
>
> +There is also an option to sort by versions, this can be done by using
> +the fieldname `version:refname` or in short `v:refname`.

Nit: "or in short" reads a bit oddly. Perhaps:

    ...`version:refname` or its alias `v:refname`.

or

    ...`version:refname` or the short-form `v:refname`.

(I rather prefer the "alias" alternative.)

>  In any case, a field name that refers to a field inapplicable to
>  the object referred by the ref does not cause an error.  It
>  returns an empty string instead.
> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> index 19ac480..68688a9 100755
> --- a/t/t6302-for-each-ref-filter.sh
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -97,4 +97,40 @@ test_expect_success 'padding to the right using `padright`' '
> +test_expect_success 'version sort' '
> +       git for-each-ref --sort=version:refname --format="%(refname:short)" refs/tags/ | grep "foo" >actual &&
> +       cat >expect <<-\EOF &&
> +       foo1.3
> +       foo1.6
> +       foo1.10
> +       EOF
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'version sort (shortened)' '
> +       git for-each-ref --sort=v:refname --format="%(refname:short)" refs/tags/ | grep "foo" >actual &&
> +       cat >expect <<-\EOF &&
> +       foo1.3
> +       foo1.6
> +       foo1.10
> +       EOF
> +       test_cmp expect actual

Nit: In the earlier review when I suggested using "v:refname" for one
of the tests in order to exercise it (in addition to
"version:refname"), I didn't mean that you had to add another
(identical) test but rather that you could have one of the existing
tests use "v:refname". (Not a big deal. You can leave this as is if
you like. I just wanted to clarify.)

> +'
> +
> +test_expect_success 'reverse version sort' '
> +       git for-each-ref --sort=-version:refname --format="%(refname:short)" refs/tags/ | grep "foo" >actual &&
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
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
