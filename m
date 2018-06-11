Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8777B1F403
	for <e@80x24.org>; Mon, 11 Jun 2018 09:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754140AbeFKJSQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 05:18:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:41224 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754010AbeFKJSP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 05:18:15 -0400
Received: (qmail 13087 invoked by uid 109); 11 Jun 2018 09:18:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Jun 2018 09:18:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14414 invoked by uid 111); 11 Jun 2018 09:18:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 11 Jun 2018 05:18:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jun 2018 05:18:13 -0400
Date:   Mon, 11 Jun 2018 05:18:13 -0400
From:   Jeff King <peff@peff.net>
To:     Max Kirillov <max@max630.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v7 2/2] http-backend: respect CONTENT_LENGTH for
 receive-pack
Message-ID: <20180611091813.GB16414@sigill.intra.peff.net>
References: <20180602212749.21324-1-max@max630.net>
 <20180602212749.21324-3-max@max630.net>
 <20180604044408.GD14451@sigill.intra.peff.net>
 <20180604221807.GC27650@jessie.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180604221807.GC27650@jessie.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 05, 2018 at 01:18:08AM +0300, Max Kirillov wrote:

> > On Sun, Jun 03, 2018 at 12:27:49AM +0300, Max Kirillov wrote:
> > Since this is slightly less efficient, and because it only matters if
> > the web server does not already close the pipe, should this have a
> > run-time configuration knob, even if it defaults to
> > safe-but-slightly-slower?
> 
> Personally, I of course don't want this. Also, I don't think
> the difference is much noticeable. But you can never be sure
> without trying. I'll try to measure some numbers.

I don't know if it will matter or not. I just wonder if we want to leave
an escape hatch for people who might. I could take or leave it.

> Actually, it is already 3rd same error in this file. Maybe
> deserve some refactoring. I will change the message also.

Thanks, that kind of related cleanup is very welcome.

> > We generally prefer to have all commands, even ones we don't expect to
> > fail, inside test_expect blocks (e.g., with a "setup" description).
> 
> Will the defined variables get to the next test? I'll try to
> do as you describe.

Yes, the tests are all run as evals. So as long as you don't open a
subshell yourself, any changes you make to process state will persist.

> >> +test_expect_success 'fetch plain truncated' '
> >> +	test_http_env upload \
> >> +		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl fetch_body.trunc git http-backend >act.out 2>act.err &&
> >> +	test_must_fail verify_http_result "200 OK"
> >> +'
> > 
> > Usually test_must_fail on a checking function like this is a sign that
> > the check is not as robust as we'd like. If the function checks two
> > things "A && B", then checking test_must_fail will only let us know
> > "!A || !B", but you probably want to check both.
> 
> Well here I just want to know that the request has failed,
> and we already know that it can fail in different ways,
> but the test is not going to differentiate those ways.

OK, looking over your verify_http_result function, I _think_ we are OK
here, because the only && is against a printf, which we wouldn't really
expect to fail.

> >> +sleep 1; # is interrupted by SIGCHLD
> >> +if (!$exited) {
> >> +        close($out);
> >> +        die "Command did not exit after reading whole body";
> >> +}
> 
> > Also, do we need to protect ourselves against other signals being
> > delivered? E.g., if I resize my xterm and this process gets SIGWINCH, is
> > it going to erroneously end the sleep and say "nope, no exited signal"?
> 
> I'll check, but what could I do? Should I add blocking other
> signals there?

I think a more robust check may be to waitpid() on the child for up to N
seconds. Something like this:

  $SIG{ALRM} = sub {
	  kill(9, $pid);
	  die "command did not exit after reading whole body"
  };
  alarm(60);
  waitpid($pid, 0);
  alarm(0);

That should exit immediately if $pid does, and otherwise die after
exactly 60 seconds. Perl's waitpid implementation will restart
automatically if it gets another signal.

-Peff
