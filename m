Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B871C433EF
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 10:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343867AbiFUKHm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 06:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242917AbiFUKHl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 06:07:41 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6444027FEB
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 03:07:36 -0700 (PDT)
Received: (qmail 31181 invoked by uid 109); 21 Jun 2022 10:07:35 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Jun 2022 10:07:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Date:   Tue, 21 Jun 2022 06:07:34 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>, rsbecker@nexbridge.com,
        'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
        avarab@gmail.com
Subject: Re: [PATCH v2] t5510: replace 'origin' with URL more carefully (was
 Re: Test Failure t5510,t5562 - was RE: [ANNOUNCE] Git v2.37.0-rc1)
Message-ID: <YrGYZieKgm4z3mZh@coredump.intra.peff.net>
References: <00a401d884d0$32885890$979909b0$@nexbridge.com>
 <8d2a0a36-1d2f-c723-db1e-8978e5d03d1d@github.com>
 <00b501d884d7$d8ed1200$8ac73600$@nexbridge.com>
 <495bd957-43dc-f252-657d-2969bb7ad5f3@github.com>
 <484a330e-0902-6e1b-8189-63c72dcea494@github.com>
 <YrFwcL2dRS/v7xAw@coredump.intra.peff.net>
 <20220621092915.GD1689@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220621092915.GD1689@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 21, 2022 at 11:29:15AM +0200, SZEDER Gábor wrote:

> > So perhaps something like:
> > 
> >   perl -e '
> >     my ($cmdline, $url) = @ARGV;
> >     $cmdline =~ s[origin(?!/)][quotemeta($url)]ge;
> 
> I don't like this "(?!/)" magic, because I haven't got the slightest
> idea of what it might do by merely looking at it, and these characters
> are not exactly easy to search for.

Yeah, I hadn't really dug into the rest of the thread and didn't
understand what that part was trying to do. So I left it untouched in my
examples as an exercise for the reader. :)

> The good old "add a space prefix and suffix" trick can help to easily
> match the "origin" word even when it stands alone, but, alas, the
> result is still not as simple as I'd like with the \s and the string
> concatenation:
> 
>   perl -e '
>     new_cmdline=$(perl -e '
>             my ($cmdline, $url) = @ARGV;
>             $cmdline =~ s[\sorigin\s][" " . quotemeta($url) . " "]ge;
>             print $cmdline;
>     ' -- " $cmdline " "$remote_url")

If you do:

  $url = quotemeta($url);

then you can drop the "e" from the regex, which gets rid of the gross
concatenation:

  $cmdline =~ s[\sorigin\s][ $url ];

I think "\b" for a word boundary would avoid the whitespace
prefix/suffix hackery, but it also matches non-alphabetics (like "/").
You could use alternation, though, like:

  $ cmdline='origin notorigin origin originnot origin/foo origin'
  $ remote_url=real_url
  $ perl -e '
      my ($cmdline, $url) = @ARGV;
      $url = quotemeta($url);
      $cmdline =~ s/(\s|^)origin(\s|$)/$1$url$2/g;
      print $cmdline;
    ' "$cmdline" "$remote_url"
  real_url notorigin real_url originnot origin/foo real_url

Negative lookbehind and lookahead get rid of the "$1" and "$2", but they
are magical-looking, as you noted above. Possibly "/x" and some
whitespace would make the whole thing more readable.

-Peff
