Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CB4C2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 23:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51D5222266
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 23:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgKQX5h (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 18:57:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:33162 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbgKQX5h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 18:57:37 -0500
Received: (qmail 19451 invoked by uid 109); 17 Nov 2020 23:57:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 17 Nov 2020 23:57:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6067 invoked by uid 111); 17 Nov 2020 23:57:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 17 Nov 2020 18:57:36 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 17 Nov 2020 18:57:36 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] config: allow specifying config entries via envvar
 pairs
Message-ID: <20201117235736.GC642410@coredump.intra.peff.net>
References: <cover.1605269465.git.ps@pks.im>
 <44e8dd50c6ea7cbcc5e4fc35c9b9057c0a52038c.1605269465.git.ps@pks.im>
 <87mtzlflw7.fsf@evledraar.gmail.com>
 <xmqqy2j1851k.fsf@gitster.c.googlers.com>
 <20201117023454.GA34754@coredump.intra.peff.net>
 <873618f4he.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <873618f4he.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 17, 2020 at 03:22:05PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > then I'd feel comfortable making it a public-facing feature. And for
> > most cases it would be pretty pleasant to use (and for the unpleasant
> > ones, I'm not sure that a little quoting is any worse than the paired
> > environment variables found here).
> 
> I wonder if something like the git config -z format wouldn't be easier,
> with the twist that we'd obviously not support \0. So we'd need an
> optional length prefix. : = unspecified.
> 
>     :user.name
>     Jeff K
>     :alias.ci
>     commit
>     :10:bin.ary
>     <10 byte string, might have a \n>
>     :other.key
>     Other Value
> 
> Maybe that's overly fragile, or maybe another format would be better.

Yeah, length-delimited strings are an alternative that some people think
is less error-prone than quoting. And we do use pkt-lines. They're also
a pain for humans to write (it's nicer if they're optional, but when you
_do_ have to start using them, now you are stuck counting things up).

> I was trying to come up with one where the common case wouldn't
> require knowing about shell quoting/unquoting, and where you could
> still do:
> 
>     GIT_CONFIG_PARAMETERS=":my.new\nvalue\n$GIT_CONFIG_PARAMETERS"
> 
> Or equivalent, and still just keep $GIT_CONFIG_PARAMETERS as-is to pass
> it along.
> 
> Your "do not require quoting" accomplishes that, and it's arguably a lot

Looks like your mail got cut off. But yeah, the goal of making the
quoting optional was to make it easier for humans to use for simple
cases. It doesn't help at all with other programs inserting values,
which can just as easily err on the side of caution.

BTW, there is another problem with GIT_CONFIG_PARAMETERS (and "git -c"
in general). The dotted config-key format:

  section.subsection.key

is unambiguous by itself, even though "subsection" can contain arbitrary
bytes, including dots. Because neither "section" nor "key" can contain
dots, we can parse from either end, and take the whole middle as a
subsection (and this is how we do it in the code).

But an assignment string like:

  section.subsection.key=value

_is_ ambiguous. We have to parse left-to-right up to the first equals
(since "value" can contain arbitrary characters, including an equals).
But "subsection" can have one, too, so we want to parse right-to-left
there. E.g., in:

  one.two=three.four=five

this could be either of:

  - section is "one", key is "two", value is "three.four=five"

  - section is "one", subsection is "two=three", key is "four", value is
    "five"

We currently always parse it as the former (which I think is least-bad
of the two, since values are more likely than subsections to contain
arbitrary text with an equals).

-Peff
