Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335D7C4363D
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 21:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9CCB235FD
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 21:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgIXVR0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 17:17:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:40052 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgIXVR0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 17:17:26 -0400
Received: (qmail 8223 invoked by uid 109); 24 Sep 2020 21:17:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Sep 2020 21:17:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12024 invoked by uid 111); 24 Sep 2020 21:17:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Sep 2020 17:17:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 24 Sep 2020 17:17:25 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ryan Zoeller <rtzoeller@rtzoeller.com>, git@vger.kernel.org
Subject: Re: [RFC 0/1] Leading whitespace as a function identification
 heuristic?
Message-ID: <20200924211725.GA3103003@coredump.intra.peff.net>
References: <20200923215859.102981-1-rtzoeller@rtzoeller.com>
 <xmqqzh5fhduk.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzh5fhduk.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 23, 2020 at 11:45:55PM -0700, Junio C Hamano wrote:

> Ryan Zoeller <rtzoeller@rtzoeller.com> writes:
> 
> > 1. Is this indentation-aware function identification useful, and
> >     generally worth pursuing further?
> 
> I cannot shake the feeling off that this is being overly generous
> and inviting for misidentification for languages whose usual
> convention is not to nest and indent the definitions freely.
> 
> IOW, why can't the "we allow leading whitespaces" a per-language
> thing?  IOW, why do we even need any new code---shouldn't it be just
> the matter of defining xfuncname patterns for such a language with
> nested and indented definitions?

If I understand the problem correctly, I don't think a static regex can
accomplish this, because you need context from the original line. E.g.,
consider something like this:

  void foo() {
	void bar() {
		...code 1...
	}
	...code 2...
  }

If we change one of the lines of code, then we find the function header
by walking backwards up the lines, evaluating a regex for each line. But
for "code 2", how do we know to keep walking past bar() and up to foo()?
Or more specifically, what is different when evaluating a change from
"code 2" that is different than when we would evaluate "code 1"?

If the only input to the question of "is this line a function header" is
the regex from the config, then changes to either line of code must
produce the same answer (either bar() if we allow leading whitespace, or
foo() if we do not).

So I think Ryan's proposal is to give that search an extra piece of
information: the indentation of the original changed line. Which is
enough to differentiate the two cases.

If I understand the patch correctly, it is always picking the first line
where indentation is lessened (and which matches the funcname pattern).
That works out of the box with existing funcname patterns, which is
nice. Though I wonder if there are cases where the funcname regex could
use the information more flexibly (i.e., some marker in the regex that
means "match less than this many spaces" or something).

I do agree that this should not be on automatically for all languages.
Some file formats may want to show a header that's at the same
indentation as the change. Adding a diff.foo.funcnameIndentation config
option would be one solution. But requiring the funcname pattern to make
explicit use of the information is another (and would allow a format to
match some things at one indentation level and some at another; but
again, I'm hand-waving a bit on whether this level of flexibility is
even useful).

-Peff
