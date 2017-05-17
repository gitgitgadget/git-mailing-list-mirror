Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B3912027B
	for <e@80x24.org>; Wed, 17 May 2017 02:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751987AbdEQC0J (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 22:26:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:53150 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751701AbdEQC0I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 22:26:08 -0400
Received: (qmail 26088 invoked by uid 109); 17 May 2017 02:26:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 May 2017 02:26:05 +0000
Received: (qmail 2701 invoked by uid 111); 17 May 2017 02:26:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 May 2017 22:26:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 May 2017 22:26:02 -0400
Date:   Tue, 16 May 2017 22:26:02 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        j6t@kdbg.org, sbeller@google.com, e@80x24.org, jrnieder@gmail.com
Subject: Re: [PATCH v6 04/11] run-command: use the async-signal-safe execv
 instead of execvp
Message-ID: <20170517022602.jj26pf7eypxp2fjm@sigill.intra.peff.net>
References: <20170418231805.61835-1-bmwill@google.com>
 <20170419231327.49895-1-bmwill@google.com>
 <20170419231327.49895-5-bmwill@google.com>
 <xmqqfug4z0s0.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfug4z0s0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 11:15:43AM +0900, Junio C Hamano wrote:

> > +		if (errno == ENOEXEC)
> > +			execv(argv.argv[0], (char *const *) argv.argv);
> 
> "/bin/sh" tries to run "/usr/bin/git" that was not executable (well,
> the one in "usr/bin/" would have +x bit, but let's pretend that we
> are trying to run one from bin-wrappers/ and somehow forgot +x bit)?
> 
> I think all of that is sensible, but there is one "huh?" I can't
> figure out.  Typically we do "sh -c git cat-file -t HEAD" but this
> lacks the "-c" (cf. the original prepare_shell_cmd()); why do we not
> need it in this case?

I think this is the same case we were discussing over in the "rebase"
thread. This isn't about running the user's command as a shell command.
Note that this kicks in even when cmd->shell_cmd isn't set.

This is about finding "/usr/bin/foo", realizing it cannot be exec'd
because it lacks a shebang line, and then pretending that it did have
"#!/bin/sh". IOW, maintaining compatibility with execvp().

So the command itself isn't a shell command, but it may execute a shell
script. If that makes sense.

-Peff
