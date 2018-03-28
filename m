Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 556381F404
	for <e@80x24.org>; Wed, 28 Mar 2018 18:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753111AbeC1Sqk (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 14:46:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:46500 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752311AbeC1Sqk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 14:46:40 -0400
Received: (qmail 16766 invoked by uid 109); 28 Mar 2018 18:46:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 28 Mar 2018 18:46:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12105 invoked by uid 111); 28 Mar 2018 18:47:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 28 Mar 2018 14:47:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Mar 2018 14:46:38 -0400
Date:   Wed, 28 Mar 2018 14:46:38 -0400
From:   Jeff King <peff@peff.net>
To:     "Erik Brady -X (brady - ROBERT HALF INTERNATIONAL INC at Cisco)" 
        <brady@cisco.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Apparent bug in credential tool running...
Message-ID: <20180328184637.GB16931@sigill.intra.peff.net>
References: <7898B9A4-D52E-41AD-9162-5B6B401A1AEA@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7898B9A4-D52E-41AD-9162-5B6B401A1AEA@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 28, 2018 at 06:26:08PM +0000, Erik Brady -X (brady - ROBERT HALF INTERNATIONAL INC at Cisco) wrote:

> The location of the problem is in credential.c, run_credential_helper()... this code:
> 
>    ...
>     fp = xfdopen(helper.in, "w");
>     credential_write(c, fp);
>     fclose(fp);
>    ..
> 
> Which I think needs to become something like this:
> 
>     fp = xfdopen(helper.in, "w");
>     sigchain_push(SIGPIPE, SIG_IGN);
>     credential_write(c, fp);
>     fclose(fp);
>     sigchain_pop(SIGPIPE);
> 
> The basics are that we wrote a credential helper in Go and, for the
> store action, it simply exits 0.  It is fast.  This is similar to the
> example here:

Yeah, that makes sense. Generally a pipe buffer would be plenty to hold
a credential, but we're racing against whether the other process exits
before we even write anything, so it's bound to fail eventually in a
racy way.

I don't think we've ever made a promise[1] about whether credential
helpers have to read their input, but it makes sense to me for Git to be
friendly and handle this case. We've done similar things for hooks.

Curiously, I have a very similar helper myself, which I did as an inline
shell snippet in my ~/.gitconfig:

  [credential "https://github.com"]
  username = peff
  helper = "!f() { test $1 = get && echo password=`pass peff/github/oauth`; }; f"

I guess I've never lost the race because of the sheer number of
sub-processes that get spawned (shell to "pass" which is itself a shell
script, which spawns gpg -- yikes!).

Do you want to send your change as a patch? There's some guidance in
Documentation/SubmittingPatches.

-Peff

[1] I know you pulled a similar example from the Pro Git book content,
    which we mirror on git-scm.com.  The quality there is usually quite
    good, but I don't consider it as authoritative as the manpages. :)
