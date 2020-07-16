Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2782CC433E7
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 15:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1D11206F5
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 15:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgGPPcB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:32:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:59248 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728630AbgGPPcA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 11:32:00 -0400
Received: (qmail 24897 invoked by uid 109); 16 Jul 2020 15:32:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Jul 2020 15:32:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26120 invoked by uid 111); 16 Jul 2020 15:32:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Jul 2020 11:32:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Jul 2020 11:31:59 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?5a2Z5LiW6b6Z?= sunshilong <sunshilong369@gmail.com>
Cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org
Subject: Re: How can I search git log with ceratin keyword but without the
 other keyword?
Message-ID: <20200716153159.GA1061124@coredump.intra.peff.net>
References: <CAAvDm6Z2HcQkyinCD4hKTnqGR3gcXodhoo0YKSnbB-vDJcn3MQ@mail.gmail.com>
 <CAPUEspg=4HJL8iiNrNp9Wr9sVj5Gw_PciSezHV5iJ1w-ymdzdw@mail.gmail.com>
 <CAAvDm6avvkXrU-Q8zu7C5WFqfCbf0DN=6cPMU-rOxgmdAh1Ebw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAvDm6avvkXrU-Q8zu7C5WFqfCbf0DN=6cPMU-rOxgmdAh1Ebw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 11, 2020 at 01:48:04PM +0800, 孙世龙 sunshilong wrote:

> Thank you for taking the time to respond to me.
> 
> When I run the said shell command, this error reported:
> # git log -P --all-match --grep '12' --grep '\b(?!t123\b)\w+'
> fatal: unrecognized argument: -P
> 
> The version of git which I am currently using is 2.7.4.

Try replacing "-P" with "--perl-regexp"; the shorter name was added in
v2.14.0. You'll also need a version of Git built with libpcre support.
If it's not, you'll get a message like:

  $ git log --perl-regexp --all-match --grep=12 --grep '\b(?!t123\b)\w+'
  fatal: cannot use Perl-compatible regexes when not compiled with USE_LIBPCRE

> One more question, could you please explain '\b(?!t123\b)\w+' in
> more detail for me?
> Or suggest some related documents for me to go through?

The (?!...) block is a negative lookahead assertion in perl-compatible
regular expressions. So it's looking for a word boundary (\b) _not_
followed by t123.

I'm not sure if that solves your original problem, though. It won't
match "t123", but presumably there are other words in that commit
message.

A negative lookbehind like:

  git log --perl-regexp --grep='(?<!t)12'

might work, if the distinction between "b12" and "t123" is important. Or
if you care about "12" but not "123", then maybe just asking for a word
boundary at the end would work:

  --grep='12\b'

-Peff
