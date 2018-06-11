Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79A7F1F403
	for <e@80x24.org>; Mon, 11 Jun 2018 09:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932743AbeFKJYn (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 05:24:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:41236 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932700AbeFKJYm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 05:24:42 -0400
Received: (qmail 13313 invoked by uid 109); 11 Jun 2018 09:24:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Jun 2018 09:24:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14444 invoked by uid 111); 11 Jun 2018 09:24:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 11 Jun 2018 05:24:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jun 2018 05:24:40 -0400
Date:   Mon, 11 Jun 2018 05:24:40 -0400
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
Message-ID: <20180611092440.GC16414@sigill.intra.peff.net>
References: <20180602212749.21324-1-max@max630.net>
 <20180602212749.21324-3-max@max630.net>
 <20180604044408.GD14451@sigill.intra.peff.net>
 <20180604221807.GC27650@jessie.local>
 <20180611091813.GB16414@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180611091813.GB16414@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 11, 2018 at 05:18:13AM -0400, Jeff King wrote:

> > >> +sleep 1; # is interrupted by SIGCHLD
> > >> +if (!$exited) {
> > >> +        close($out);
> > >> +        die "Command did not exit after reading whole body";
> > >> +}
> > 
> > > Also, do we need to protect ourselves against other signals being
> > > delivered? E.g., if I resize my xterm and this process gets SIGWINCH, is
> > > it going to erroneously end the sleep and say "nope, no exited signal"?
> > 
> > I'll check, but what could I do? Should I add blocking other
> > signals there?
> 
> I think a more robust check may be to waitpid() on the child for up to N
> seconds. Something like this:
> 
>   $SIG{ALRM} = sub {
> 	  kill(9, $pid);
> 	  die "command did not exit after reading whole body"
>   };
>   alarm(60);
>   waitpid($pid, 0);
>   alarm(0);
> 
> That should exit immediately if $pid does, and otherwise die after
> exactly 60 seconds. Perl's waitpid implementation will restart
> automatically if it gets another signal.

I tried your original, delivering some signals to it. I think it
actually is OK, too, because perl's sleep() implementation will also
restart for something like SIGWINCH.

E.g., stracing looks like this:

  nanosleep({tv_sec=60, tv_nsec=0}, {tv_sec=57, tv_nsec=791891377}) = ? ERESTART_RESTARTBLOCK (Interrupted by signal)
  --- SIGWINCH {si_signo=SIGWINCH, si_code=SI_KERNEL} ---
  restart_syscall(<... resuming interrupted nanosleep ...>

-Peff
