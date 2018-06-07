Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 804CF1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 19:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751956AbeFGTWO (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 15:22:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52216 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751231AbeFGTWN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 15:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JZluJnUL6OU6pCr4FPfkb56beVREvslkZMaWJFs+71I=; b=Ioac2osBahg2qkIQdXwNcMOQ/r
        pqX96Hns7qsgGWROR/XlR2uriDJnC86AwALpUUt2koLk3bcJTCrtpTktgNmSvrriAMjvWyc62PTxR
        3iBomJS6FvZwFAfMzOOg32W11eK3EjiJ4Y/w9FRwTvKDCZgpJIW4F2PyxPSz4zGwVyt/MczpOcvti
        LAmUoKYG7OugbUK0PfZhY+PX6f0UQgkMFqGtC3CGya6Btl966EhyWJks5vAt1Te1TNwLCXvHmg2Rs
        Bgf0B2WkZcgtsw1kGZNpGEM+UF3S6gMLJcEz8+jMmj0Fv+39FNgVijl0U49HB3dzkrS19fNIUH59Z
        VaQm7gWA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fR0U9-0004zP-7T; Thu, 07 Jun 2018 19:22:13 +0000
Date:   Thu, 7 Jun 2018 12:22:13 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git grep with leading inverted bracket expression
Message-ID: <20180607192213.GB24370@bombadil.infradead.org>
References: <20180607152711.GA27079@bombadil.infradead.org>
 <87602uza56.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87602uza56.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 07, 2018 at 09:09:25PM +0200, Ævar Arnfjörð Bjarmason wrote:
> On Thu, Jun 07 2018, Matthew Wilcox wrote:
> > If the first atom of a regex is a bracket expression with an inverted range,
> > git grep is very slow.
> 
> I have some WIP patches to fix all of this, which I'll hopefully submit
> before 2.19 is out the door.
> 
> What you've discovered here is how shitty your libc regex engine is,
> because unless you provide -P and compile with a reasonably up-to-date
> libpcre (preferably v2) with JIT that's what you'll get.

I'm using Debian's build, and it is linked against a recent libpcre2:
$ ldd /usr/lib/git-core/git
	libpcre2-8.so.0 => /usr/lib/x86_64-linux-gnu/libpcre2-8.so.0 (0x00007f59ad5f2000)
$ dpkg --status libpcre2-8-0
Version: 10.31-3

But I wasn't using -P.  If I do, then I see the performance numbers you do:

$ time git grep -P '[^t]truct_size' >/dev/null
real	0m0.354s
user	0m0.340s
sys	0m0.639s
$ time git grep -P 'struct_size' >/dev/null
real	0m0.336s
user	0m0.552s
sys	0m0.457s
$ time git grep 'struct_size' >/dev/null
real	0m0.335s
user	0m0.535s
sys	0m0.474s

> So you need to just use an up-to-date libpcre2 & -P and performance
> won't suck.

I don't tend to use terribly advanced regexps, so I'll just set
grep.patternType to 'perl' and then it'll automatically be fast for me
without your patches ;-)

> My WIP patches will make us use PCRE for all grep modes, using an API it
> has to convert basic & extended regexp syntax to its own syntax, so
> we'll be able to do that transparently.

That's clearly the right answer.  Thanks!
