Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9674020323
	for <e@80x24.org>; Thu, 16 Mar 2017 17:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751960AbdCPR7E (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 13:59:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:45236 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751838AbdCPR7E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 13:59:04 -0400
Received: (qmail 18220 invoked by uid 109); 16 Mar 2017 17:59:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 17:59:00 +0000
Received: (qmail 1746 invoked by uid 111); 16 Mar 2017 17:59:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 13:59:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Mar 2017 13:58:57 -0400
Date:   Thu, 16 Mar 2017 13:58:57 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Devin Lehmacher <lehmacdj@gmail.com>, git@vger.kernel.org
Subject: Re: [GSoC][PATCH v4 4/4] credential-cache: add tests for XDG
 functionality
Message-ID: <20170316175857.77tftld54gqqm22c@sigill.intra.peff.net>
References: <20170314003246.71586-4-lehmacdj@gmail.com>
 <20170316051827.97198-1-lehmacdj@gmail.com>
 <20170316051827.97198-5-lehmacdj@gmail.com>
 <xmqq8to5chh5.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8to5chh5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 16, 2017 at 09:29:58AM -0700, Junio C Hamano wrote:

> Devin Lehmacher <lehmacdj@gmail.com> writes:
> 
> > @@ -20,4 +21,67 @@ helper_test_timeout cache --timeout=1
> >  # our socket, leaving us with no way to access the daemon.
> >  git credential-cache exit
> >  
> > +# we need to use rm -rf here since sometimes the daemon hasn't finished
> > +# cleaning up after itself and rmdir fails
> 
> Hmmmm.  Peff, do you have ideas on better ways to do this (or
> explanation why this is the best we could do)?

If you call "git credential-cache exit", that should be deterministic.
The client program won't exit until the other side closes the
descriptor, which it won't do until it has cleaned up the socket. See
the comment at line 130 of credential-cache--daemon.c.

So here:

> > +test_expect_success 'credential-cache --socket option overrides default location' '
> > +	test_when_finished "rm -rf \"$HOME\"/dir/" &&
> > +	check approve "cache --socket \"$HOME/dir/socket\"" <<-\EOF &&
> > +	protocol=https
> > +	host=example.com
> > +	username=store-user
> > +	password=store-pass
> > +	EOF
> > +	test -S "$HOME/dir/socket" &&
> > +	git credential-cache exit
> > +'

This is almost right, except:

  - the "exit" needs to be told which socket to use

  - we should do the "exit" even when the test fails early (so in
    test_when_finished)

  - the test_when_finished block will interpolate $HOME when setting up
    the block, which will break if it contains double-quotes or other
    special characters. It should use \$HOME.

    I suspect the "check" invocation needs to do so as well, though it
    is even trickier (we shove it into a single-quoted "-c" argument).

    I think you could get by in both cases with relative paths.

So all together, probably:

  test_when_finished "
	git credential-cache --socket dir/socket &&
	rmdir dir
  " &&
  check approve "cache --socket dir/socket" <<-\EOF &&
  ...
  EOF
  test -S dir/socket

The final "test -S" should be OK in practice. We're assuming that the
cache-daemon is still running, but it has a 900 second timeout by
default (and besides, all the other tests have exact same race).

-Peff
