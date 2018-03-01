Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F8B71F404
	for <e@80x24.org>; Thu,  1 Mar 2018 15:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031689AbeCAPIi (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 10:08:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:42970 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1031666AbeCAPIh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 10:08:37 -0500
Received: (qmail 5397 invoked by uid 109); 1 Mar 2018 15:08:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 01 Mar 2018 15:08:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17729 invoked by uid 111); 1 Mar 2018 15:09:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 01 Mar 2018 10:09:27 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Mar 2018 10:08:35 -0500
Date:   Thu, 1 Mar 2018 10:08:35 -0500
From:   Jeff King <peff@peff.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'demerphq' <demerphq@gmail.com>, 'Eric Wong' <e@80x24.org>,
        'Jonathan Nieder' <jrnieder@gmail.com>,
        'Git' <git@vger.kernel.org>,
        'Joachim Schmitz' <jojo@schmitz-digital.de>,
        =?utf-8?B?J8OGdmFyIEFybmZqw7Zyw7A=?= Bjarmason' 
        <avarab@gmail.com>
Subject: Re: [Problem] test_must_fail makes possibly questionable assumptions
 about exit_code.
Message-ID: <20180301150835.GD24907@sigill.intra.peff.net>
References: <005501d3b025$c0057ce0$401076a0$@nexbridge.com>
 <20180228001616.GJ174036@aiede.svl.corp.google.com>
 <20180228040718.GA9043@whir>
 <20180228050034.GA373@sigill.intra.peff.net>
 <20180228074251.GA11673@dcvr>
 <20180228074918.GA32127@sigill.intra.peff.net>
 <000501d3b0a4$29162a80$7b427f80$@nexbridge.com>
 <CANgJU+VYkmUhJT=CHQ4HTqoV4gWhr9P4-65BfrY-RWgwJJhEUA@mail.gmail.com>
 <20180301073629.GC31079@sigill.intra.peff.net>
 <001d01d3b169$95f4b0c0$c1de1240$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <001d01d3b169$95f4b0c0$c1de1240$@nexbridge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 01, 2018 at 09:28:31AM -0500, Randall S. Becker wrote:

> > It's not clear to me though if we just want to tweak the programs run in the
> > test scripts in order to get test_must_fail to stop complaining, or if we
> > consider the unusual exit codes from our perl-based Git programs to be an
> > error that should be fixed for real use, too.
> 
> I'm living unusual exit code IRL all the time. So "fixed for real", is
> what I'm looking for. So if we were to do that, where is the best
> place to insert a fix - my original question - that would be permanent
> in the main git test code. Or perhaps this needs to be in the main
> code itself.

If it's fixed in the real world, then it needs to be in the main code
itself. It looks like git-svn already does this to some degree itself
(most of the work happens in an eval, and it calls the "fatal" function
if that throws an exception via 'die').

So I think git-send-email.perl (and maybe others) needs to learn the
same trick (by pushing the main bits of the script into an eval). Or it
needs to include the SIG{__DIE__} trickery at the beginning of the
script.

I think the SIG{__DIE__} stuff could go into Git/PredictableDie.pm or
something, and then any scripts that need it could just "use
Git::PredictableDie".

Does that make sense?

-Peff
