Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380B4C433FE
	for <git@archiver.kernel.org>; Fri, 24 Dec 2021 19:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344251AbhLXTmd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 14:42:33 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53185 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239476AbhLXTmd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 14:42:33 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7F37C172958;
        Fri, 24 Dec 2021 14:42:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Qn8CELElqBCr
        PbhjC797fdCO/LMaKKZN65UMomXI6+0=; b=FDemfeXDhqbMHiM54MZdyzM67ziJ
        ws44UKmBokNdqA3fb/tWvIYAHbvL7RXiZCp9WlH1Up6tF8q/ObQutf1sTlDgMV4f
        6UDJmFxFPM9ii+wJA+9q/qEoUTZudtNWYpJPnUXRAu/uFQguR/Dn5bziki5rp+lN
        rX0HnQ6LhkWCjIQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 77C31172957;
        Fri, 24 Dec 2021 14:42:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DABFE172956;
        Fri, 24 Dec 2021 14:42:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     John Cai <jcai@gitlab.com>
Cc:     Erik Cervin Edin <erik@cervined.in>, git@vger.kernel.org
Subject: Re: bug: git name-rev --stdin --no-undefined on detached head
References: <CA+JQ7M-ORVCj6teGjVy01SF=f0=PdKKYdHNU9ruK9XUAX9F8Ag@mail.gmail.com>
        <DA9B4728-C45D-4CA0-A40D-4A81665AB0E6@gitlab.com>
Date:   Fri, 24 Dec 2021 11:42:27 -0800
In-Reply-To: <DA9B4728-C45D-4CA0-A40D-4A81665AB0E6@gitlab.com> (John Cai's
        message of "Thu, 23 Dec 2021 10:39:23 -0800")
Message-ID: <xmqqk0ft3i3g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A0C98F1C-64F1-11EC-8D26-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Cai <jcai@gitlab.com> writes:

> It seems like this bug can be generalized to =E2=80=9Cgit name-rev
> --stdin=E2=80=9D does not work with --no-undefined nor --name-only
>
> The --name-only case seems clear to me that we should fix
> it. It=E2=80=99s misleading to return the sha instead of =E2=80=9Cundef=
ined=E2=80=9D
> for a rev without a symbolic name, as a sha could be a symbolic
> name.
>
> I think we can also make the argument that --no-undefined should
> also die in --stdin mode when given a rev without any symbolic
> names.

Hmph, the manual page documents:

    --stdin::
            Transform stdin by substituting all the 40-character SHA-1
            hexes (say $hex) with "$hex ($rev_name)".  When used with
            --name-only, substitute with "$rev_name", omitting $hex
            altogether.  Intended for the scripter's use.

It is unfortunate that the way this option works is confusingly a
bit different from what we learned to expect from the --stdin option
other subcommands like "git pack-objects --stdin" takes.  In short,
these are not equivalent:

	git name-rev [<options>] $string
        printf "%s" "$string" | xargs git name-rev [<options>]
        printf "%s" "$string" | git name-rev --stdin [<options>]

The first two are supposed to be the equivalent, but the third one
is different by design.  Its `--stdin` mode is expected to read
something like this [*]:

	$ cat sample.txt
        A revision that exists 2ae0a9cb82 is shown here,
        and its full name is 2ae0a9cb8298185a94e5998086f380a355dd8907
        while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
        which probably is undescribable hexdigits.

and its designed use is to annotate its input into a more reader
friendly from with refnames where possible.  Here is what we get:

        $ git name-rev --stdin <sample.txt
        A revision that exists 2ae0a9cb82 is shown here,
        and its full name is 2ae0a9cb8298185a94e5998086f380a355dd8907 (ma=
ster)
        while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
        which probably is undescribable hexdigits.

I notice a few things.

 * An abbreviated commit object name is not affected;

 * A 40-digit string that cannot be described with a reference is
   left alone, without "undefined".

It might be debatable that the latter may want to be annotated with
"undefined", but as the command does not molest other noise strings
like "its" "full" name" in the input, I think the current behaviour
is preferred over appending "(undefined)" after a string we do not
recognize that happens to be 40-hex.

When used with --name-only, we see this:

	$ git name-rev --name-only --stdin <sample.txt
        A revision that exists 2ae0a9cb82 is shown here,
        and its full name is master
        while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
        which probably is undescribable hexdigits.

So, as far as I can see, it is working as described.  If there is
any bug in the things I saw and shown here, it is that it is
misleading to claim that this behaviour is intended for scripter's
use.  It clearly is not scripter friendly when you want to run
"name-rev" on unbounded number of object names you have, which may
not fit on the command line, as that is not how it was designed to
be used.

Two possible things we can do to improve are

 * Fix the documentation; it is not for scripters but for annotating
   text with object names.

 * Possibly add --names-from-standard-input option that would behave
   more like "we cannot afford to stuff all object names on the
   command line, so we feed them one by one from the standard input"
   mode the "--stdin" option of other subcommands use.

I do not think the latter is so important, as it is perfectly OK to
use xargs to split the large input into multiple invocations of
name-rev.  This is unlike "pack-objects --stdin" where the command
needs to see _all_ input in a single invocation.


[Footnote]

* The sample input was produced with

        $ cat >sample.txt <<EOF
        A revision that exists $(git rev-parse --short HEAD) is shown her=
e,
        and its full name is $(git rev-parse HEAD)
        while its tree object is $(git rev-parse HEAD:)
        which probably is undescribable hexdigits.
        EOF

if you want to try it at home ;-)
