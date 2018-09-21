Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF7C81F453
	for <e@80x24.org>; Fri, 21 Sep 2018 22:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbeIVEql (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 00:46:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:55680 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725750AbeIVEql (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 00:46:41 -0400
Received: (qmail 6495 invoked by uid 109); 21 Sep 2018 22:55:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 21 Sep 2018 22:55:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9537 invoked by uid 111); 21 Sep 2018 22:55:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 21 Sep 2018 18:55:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Sep 2018 18:55:39 -0400
Date:   Fri, 21 Sep 2018 18:55:39 -0400
From:   Jeff King <peff@peff.net>
To:     "Zych, David M" <dmrz@illinois.edu>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: credential.<url>.helper with partial url path
Message-ID: <20180921225539.GF11177@sigill.intra.peff.net>
References: <c3147945-2b5c-68f8-91e7-6edc78a05801@illinois.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c3147945-2b5c-68f8-91e7-6edc78a05801@illinois.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 21, 2018 at 04:56:20PM +0000, Zych, David M wrote:

> Suppose I need to use different credential.helper values for different 
> repositories on the same HTTPS host.  Ideally I would like to be able to 
> write this logic using a partial URL path prefix, for example in 
> ~/.gitconfig
> 
> [credential "https://example.com/prefix1/foo.git"]
>          helper = !ZZZ
> [credential "https://example.com/prefix1/"]
>          helper = !YYY
> [credential "https://example.com/"]
>          useHttpPath = true
>          helper = !XXX
> [...]
> $ git config --get-urlmatch credential https://example.com/prefix1/bar.git
> credential.helper !YYY
> credential.usehttppath true
> 
> Is this discrepancy intended?

Sort of. The matching done by the credential code predates the config
code learning about url matching, so it uses a much more basic system.
It walks through the config in order for a particular request, throwing
away any entries whose subsections don't match, and then applying (in
the order it finds them) any entries which do. The matching for paths is
done using the whole path, not a prefix match.

There's something else going on, too: credential.helper is a
multi-valued variable, so it's going to try each matching helper in
turn. Whereas "git config --get" (and "--get-urlmatch") assume you're
looking for a single value, and use the last-one-wins rule that most
variables use.

Normally you'd want to use "--get-all" for that, though I don't know if
there's a way to combine it with url matching.

So what you're seeing is the code working as designed, but I agree the
result kind of sucks. I wouldn't be sad to see the credential code moved
over to use the same url-matching as http.* uses. It would technically
be backwards-incompatible in a few cases, but I think the new behavior
would almost always be what the person intended in the first place.

With the current code, you'd have to teach your helper to be more clever
about matching the path. E.g., by wrapping your existing helper with
something like:

-- >8 --
#!/usr/bin/perl

my %input = map { /(.*?)=(.*)/ } <STDIN>;
my $helper =
  $input{path} =~ m{^prefix1/foo\.git} ? 'ZZZ' :
  $input{path} =~ m{^prefix1/} ? 'YYY' :
  'XXX';

my $pid = open(my $out, '|-', $helper, @ARGV);
print $out "$_=$input{$_}\n" for keys(%input);
close($out);
waitpid $pid, 0;
-- >8 --

I know that's pretty nasty for your simple use case, but I think it's
the best you can do with the current system.

> If indeed the current behavior of git-credential is as intended, I think 
> it would be helpful for that manpage to explicitly mention it (i.e. that 
> you may specify a URL path component but that it must match exactly). 
> Right now the only example given is one in which 'the "pattern" URL does 
> not care about the path component at all.'

Yes, I think this could be more clear in the "credential contexts"
section of gitcredentials(7). Do you want to try to make a patch?

-Peff
