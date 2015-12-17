From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 08/11] ref-filter: introduce prefixes for the align atom
Date: Thu, 17 Dec 2015 03:59:24 -0500
Message-ID: <CAPig+cRmoOoSscuLcVHWkpH4uVU2Gei791qqn0GjyZ4b9fA45w@mail.gmail.com>
References: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
	<1450279802-29414-9-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 09:59:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9UPL-0007SZ-5K
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 09:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755332AbbLQI70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 03:59:26 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:35551 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450AbbLQI7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 03:59:25 -0500
Received: by mail-vk0-f47.google.com with SMTP id a189so42549165vkh.2
        for <git@vger.kernel.org>; Thu, 17 Dec 2015 00:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=lcFgD/MLv/b2tOWp2u2bNbyteUdmJqPTs2DA99Ks/qI=;
        b=nsc3rom0opkqV4amjYloaOZKPQ4SdfPUXJS+ZeGODGTSBSrWxtZsp5MzVwqknTfEpj
         8cediQUxrjL00w2238ApC71VIK8zV1v7oYxEf1AluM2steuG4ZVgktK2p8HgkV3+GHtE
         RF/ARmty79yHwtGvIi305Os/7/lx6uK5nQ/Nv28P7uy0eaTadlrwWOHbUYiPzDJT0IBZ
         /NTE0Zv36LceR+BXbJeLTsnBlVsoewJ8lEfiG3rpdiayfnVLS29/qUREaWG29EAyGwsq
         XP7rcHUC7+FSPTEOyvXhVu4cysCOk5XmCYmkzXSp9bHmH8qPsjg+GzF34SVUbgb2Mj1i
         ZwEg==
X-Received: by 10.31.128.138 with SMTP id b132mr9621175vkd.14.1450342765019;
 Thu, 17 Dec 2015 00:59:25 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 17 Dec 2015 00:59:24 -0800 (PST)
In-Reply-To: <1450279802-29414-9-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: frZRsBMQw-hMTG-XIbHtZNyS2a0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282642>

On Wed, Dec 16, 2015 at 10:29 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> ref-filter: introduce prefixes for the align atom

The prefixes are actually for the arguments to the 'align' atom, not
for the atom itself. However, it might be better to describe this at a
bit higher level. Perhaps:

    ref-filter: align: introduce long-form syntax

or something.

> Introduce optional prefixes "width=" and "position=" for the align atom
> so that the atom can be used as "%(align:width=<width>,position=<position>)".
>
> Add Documetation and tests for the same.
>
> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> @@ -96,10 +96,19 @@ static void align_atom_parser(struct used_atom *atom)
>
>         while (*s) {
>                 int position;
> +               buf = s[0]->buf;

It probably would be better to do this assignment in the previous
patch (7/11) since its presence here introduces unwanted noise
(textual replacement of "s[0]->buf" with "buf") in several locations
below which slightly obscure the real changes of this patch.

> -               if (!strtoul_ui(s[0]->buf, 10, (unsigned int *)&width))
> +               if (skip_prefix(buf, "position=", &buf)) {
> +                       position = parse_align_position(buf);
> +                       if (position == -1)

It may be more idiomatic in this codebase to detect errors via '< 0'
rather than explicit '== -1'. Ditto below.

> +                               die(_("unrecognized position:%s"), buf);
> +                       align->position = position;
> +               } else if (skip_prefix(buf, "width=", &buf)) {
> +                       if (strtoul_ui(buf, 10, (unsigned int *)&width))
> +                               die(_("unrecognized width:%s"), buf);
> +               } else if (!strtoul_ui(buf, 10, (unsigned int *)&width))
>                         ;
> -               else if ((position = parse_align_position(s[0]->buf)) > 0)
> +               else if ((position = parse_align_position(buf)) != -1)
>                         align->position = position;
>                 else
>                         die(_("unrecognized %%(align) argument: %s"), s[0]->buf);

s/s[0]->//

More below...

> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> @@ -133,6 +133,168 @@ test_expect_success 'right alignment' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'alignment with "position" prefix' '
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
> +       git for-each-ref --format="|%(align:30,position=right)refname is %(refname)%(end)|%(refname)" >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'alignment with "position" prefix' '
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
> +       git for-each-ref --format="|%(align:position=right,30)refname is %(refname)%(end)|%(refname)" >actual &&
> +       test_cmp expect actual
> +'

This (and below) is a lot of copy/paste code which makes it difficult
to read the tests and maintain (change) them. Since 'expect' doesn't
appear to change from test to test, one way to eliminate some of this
noisiness would be to create 'expect' once outside of the tests.

However, even better, especially from a comprehension,
maintainability, and extensibility standpoints would be to make this
all table-driven. In particular, I'd expect to see a table with
exactly the list of test inputs mentioned in my earlier review[1], and
have that table passed to a shell function which performs the test for
each element of the table. For instance, something like:

    test_align_permutations <<-\EOF
        middle,42
        42,middle
        position=middle,42
        42,position=middle
        middle,width=42
        width=42,middle
        position=middle,width=42
        width=42,position=middle
        EOF

where test_align_permutations is the name of the shell function which
reads each line of it stdin and performs the "git for-each-ref
--format=..." test with the given %(align:) arguments.

Ditto regarding the below "last one wins (silently) tests".

[1]: http://article.gmane.org/gmane.comp.version-control.git/281916

> +
> +test_expect_success 'alignment with "width" prefix' '
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
> +       git for-each-ref --format="|%(align:width=30,right)refname is %(refname)%(end)|%(refname)" >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'alignment with "width" prefix' '
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
> +       git for-each-ref --format="|%(align:right,width=30)refname is %(refname)%(end)|%(refname)" >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'alignment with "position" and "width" prefix' '
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
> +       git for-each-ref --format="|%(align:width=30,position=right)refname is %(refname)%(end)|%(refname)" >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'alignment with "position" and "width" prefix' '
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
> +       git for-each-ref --format="|%(align:position=right,width=30)refname is %(refname)%(end)|%(refname)" >actual &&
> +       test_cmp expect actual
> +'
> +
> +# Last one wins (silently) when multiple arguments of the same type are given
> +
> +test_expect_success 'alignment with multiple "<width>" values' '
> +       cat >expect <<-\EOF &&
> +       |refname is refs/heads/master  |refs/heads/master
> +       |refname is refs/heads/side    |refs/heads/side
> +       |refname is refs/odd/spot      |refs/odd/spot
> +       |refname is refs/tags/double-tag|refs/tags/double-tag
> +       |refname is refs/tags/four     |refs/tags/four
> +       |refname is refs/tags/one      |refs/tags/one
> +       |refname is refs/tags/signed-tag|refs/tags/signed-tag
> +       |refname is refs/tags/three    |refs/tags/three
> +       |refname is refs/tags/two      |refs/tags/two
> +       EOF
> +       git for-each-ref --format="|%(align:32,width=30)refname is %(refname)%(end)|%(refname)" >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'alignment with multiple "<width>" values' '
> +       cat >expect <<-\EOF &&
> +       |refname is refs/heads/master    |refs/heads/master
> +       |refname is refs/heads/side      |refs/heads/side
> +       |refname is refs/odd/spot        |refs/odd/spot
> +       |refname is refs/tags/double-tag |refs/tags/double-tag
> +       |refname is refs/tags/four       |refs/tags/four
> +       |refname is refs/tags/one        |refs/tags/one
> +       |refname is refs/tags/signed-tag |refs/tags/signed-tag
> +       |refname is refs/tags/three      |refs/tags/three
> +       |refname is refs/tags/two        |refs/tags/two
> +       EOF
> +       git for-each-ref --format="|%(align:width=30,32)refname is %(refname)%(end)|%(refname)" >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'alignment with multiple "<position>" values' '
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
> +       git for-each-ref --format="|%(align:width=30,position=middle,right)refname is %(refname)%(end)|%(refname)" >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'alignment with multiple "<position>" values' '
> +       cat >expect <<-\EOF &&
> +       | refname is refs/heads/master |refs/heads/master
> +       |  refname is refs/heads/side  |refs/heads/side
> +       |   refname is refs/odd/spot   |refs/odd/spot
> +       |refname is refs/tags/double-tag|refs/tags/double-tag
> +       |  refname is refs/tags/four   |refs/tags/four
> +       |   refname is refs/tags/one   |refs/tags/one
> +       |refname is refs/tags/signed-tag|refs/tags/signed-tag
> +       |  refname is refs/tags/three  |refs/tags/three
> +       |   refname is refs/tags/two   |refs/tags/two
> +       EOF
> +       git for-each-ref --format="|%(align:30,right,position=middle)refname is %(refname)%(end)|%(refname)" >actual &&
> +       test_cmp expect actual
> +'
> +
>  # Individual atoms inside %(align:...) and %(end) must not be quoted.
>
>  test_expect_success 'alignment with format quote' "
> --
> 2.6.4
>
