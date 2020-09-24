Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5BCC4363D
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 22:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8006523AA9
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 22:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rtzoeller.com header.i=@rtzoeller.com header.b="WjFLjtfC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgIXWB4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 18:01:56 -0400
Received: from mail-03.mail-europe.com ([91.134.188.129]:55028 "EHLO
        mail-03.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgIXWB4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 18:01:56 -0400
X-Greylist: delayed 86559 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Sep 2020 18:01:55 EDT
Date:   Thu, 24 Sep 2020 22:01:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rtzoeller.com;
        s=protonmail; t=1600984912;
        bh=vqqqe1yNThxHNg42o5JlEExcNTULsmjQKRPiRg/zKwE=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=WjFLjtfCvFQKgoal7Rqw88AjOBHC1lLEfpffFAiMgoL6fzErCUWz1dYXnyG9RDr0x
         GtbG/71fgHklCIrjZNz34BxnWVRYMpZPmMKmzWq3VxtH7YTe6Ur0SvN76PE1QIlsb2
         Ry6nCdqbyc1MaD5kQ7tFxMuG7iNvqcI4UAo29Tvg=
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
From:   Ryan Zoeller <rtzoeller@rtzoeller.com>
Cc:     git@vger.kernel.org
Reply-To: Ryan Zoeller <rtzoeller@rtzoeller.com>
Subject: Re: [RFC 0/1] Leading whitespace as a function identification heuristic?
Message-ID: <c759b472-c889-ef85-bcf2-6d9cbc588b51@rtzoeller.com>
In-Reply-To: <20200924211725.GA3103003@coredump.intra.peff.net>
References: <20200923215859.102981-1-rtzoeller@rtzoeller.com> <xmqqzh5fhduk.fsf@gitster.c.googlers.com> <20200924211725.GA3103003@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/24/20 4:17 PM, Jeff King wrote:
>=20
>=20
> If I understand the problem correctly, I don't think a static regex can
> accomplish this, because you need context from the original line. E.g.,
> consider something like this:
>=20
>    void foo() {
> =09void bar() {
> =09=09...code 1...
> =09}
> =09...code 2...
>    }
>=20
> If we change one of the lines of code, then we find the function header
> by walking backwards up the lines, evaluating a regex for each line. But
> for "code 2", how do we know to keep walking past bar() and up to foo()?
> Or more specifically, what is different when evaluating a change from
> "code 2" that is different than when we would evaluate "code 1"?
>=20
> If the only input to the question of "is this line a function header" is
> the regex from the config, then changes to either line of code must
> produce the same answer (either bar() if we allow leading whitespace, or
> foo() if we do not).
>=20
> So I think Ryan's proposal is to give that search an extra piece of
> information: the indentation of the original changed line. Which is
> enough to differentiate the two cases.

You've explained this better than I could have. Thanks.

> If I understand the patch correctly, it is always picking the first line
> where indentation is lessened (and which matches the funcname pattern).
> That works out of the box with existing funcname patterns, which is
> nice. Though I wonder if there are cases where the funcname regex could
> use the information more flexibly (i.e., some marker in the regex that
> means "match less than this many spaces" or something).

My original intent was to work with existing funcname expressions=20
without modifications. Some of the funcname regexes are rather=20
impenetrable at first glance, and not requiring modifications seemed=20
like an easy win.

Especially for funcname patterns specified by a user, I assumed it
would be easier to set an additional configuration option than
rewrite an existing regex to handle this complexity.

> I do agree that this should not be on automatically for all languages.
> Some file formats may want to show a header that's at the same
> indentation as the change. Adding a diff.foo.funcnameIndentation config
> option would be one solution. But requiring the funcname pattern to make
> explicit use of the information is another (and would allow a format to
> match some things at one indentation level and some at another; but
> again, I'm hand-waving a bit on whether this level of flexibility is
> even useful)
If the configuration option is implemented correctly (i.e. as an enum=20
rather than a binary toggle), I think we could leave the door open for
a more flexible approach in the future, without needing to answer how=20
useful that flexibility is now. I couldn't think of any situations=20
requiring this flexibility, but that doesn't mean they don't exist.

Ryan

