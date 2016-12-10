Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F5A4203EA
	for <e@80x24.org>; Sat, 10 Dec 2016 09:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751400AbcLJJNj (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 04:13:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:54588 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751194AbcLJJNh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 04:13:37 -0500
Received: (qmail 2493 invoked by uid 109); 10 Dec 2016 09:13:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Dec 2016 09:13:36 +0000
Received: (qmail 25233 invoked by uid 111); 10 Dec 2016 09:14:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Dec 2016 04:14:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Dec 2016 04:13:34 -0500
Date:   Sat, 10 Dec 2016 04:13:34 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, git@vger.kernel.org
Subject: Re: [RFC PATCH] send-email: allow a custom hook to prevent sending
 email
Message-ID: <20161210091333.rhssskrvzjqnzelb@sigill.intra.peff.net>
References: <20161209203449.17940-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161209203449.17940-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 09, 2016 at 12:34:49PM -0800, Stefan Beller wrote:

> My first perl contribution to Git. :)

Yes, I have some style suggestions below. :)

> Marked as RFC to gauge general interest before writing tests and
> documentation.

It's hard to evaluate without seeing an example of what you'd actually
want to put into a hook.

> diff --git a/git-send-email.perl b/git-send-email.perl
> index da81be40cb..d3ebf666c3 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -815,6 +815,15 @@ if (!$force) {
>  				. "Pass --force if you really want to send.\n";
>  		}
>  	}
> +	my @hook = ( $ENV{GIT_DIR}.'hooks/send-email', $f )

It's awkward to use a list here, when you just end up accessing
$hook[0]. You can form the list on the fly when you call system(). You
also probably are missing a trailing "/".

I'm not sure that $GIT_DIR is consistently set; you probably want to
look at "git rev-parse --git-dir" here. But I think we make a Git
repository object earlier, and you can just do:

  my $hook = join('/', $repo->repo_path(), 'hooks/send-email');

Or you can just do string concatenation:

  my $hook = $repo->repo_path() . '/hooks/send-email';

If I were writing repo_path myself, I'd probably allow:

  my $hook = $repo->repo_path('hooks/send-email');

like we do with git_path() in the C code. It wouldn't be hard to add.

> +	if( -x $hook[0] ) {

Funny whitespace. I think:

  if (-x $hook)

would be more usual for us.

> +		unless( system( @hook ) == 0 )
> +		{
> +			die "Refusing to send because the patch\n\t$f\n"
> +				. "was refused by the send-email hook."
> +				. "Pass --force if you really want to send.\n";
> +		}

I like "unless" as a trailing one-liner conditional for edge cases,
like:

   do_this($foo) unless $foo < 5;

but I think here it just makes things more Perl-ish than our code base
usually goes for. Probably:

  if (system($hook, $f) != 0) {
        die ...
  }

would be more usual for us (in a more Perl-ish code base I'd probably
write "system(...) and die ...").

-Peff
