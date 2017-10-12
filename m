Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAE6F20372
	for <e@80x24.org>; Thu, 12 Oct 2017 18:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751418AbdJLSrj (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 14:47:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:51294 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751067AbdJLSrj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 14:47:39 -0400
Received: (qmail 29120 invoked by uid 109); 12 Oct 2017 18:47:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Oct 2017 18:47:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19082 invoked by uid 111); 12 Oct 2017 18:47:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Oct 2017 14:47:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Oct 2017 14:47:36 -0400
Date:   Thu, 12 Oct 2017 14:47:36 -0400
From:   Jeff King <peff@peff.net>
To:     Mahmoud Al-Qudsi <mqudsi@neosmart.net>
Cc:     git@vger.kernel.org
Subject: Re: (Some?) control codes not escaped when using `git add -p`
Message-ID: <20171012184736.rglkbyryauwuvn2a@sigill.intra.peff.net>
References: <CACcTrKctqAWeWWrc9Q+Y7ewXGc_o+uJoeHS83LDw5O_s1-3Nug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACcTrKctqAWeWWrc9Q+Y7ewXGc_o+uJoeHS83LDw5O_s1-3Nug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 12, 2017 at 12:59:06PM -0500, Mahmoud Al-Qudsi wrote:

> Hello list,
> 
> Running git 2.7.4, I’ve run into an issue where control codes that would
> normally be escaped when using `git diff` are not similarly escaped when using
> `git add -p`.
> 
> As a concrete example, I have a text file including the following "text":
> 
> :map ^[[H <Home>
> :map ^[[5~ ^B "page up
> :map ^[[6~ ^F "page down

The diffs generated for "git diff" and "git add -p" are done by the
exact same code. And that code doesn't do any escaping or cleverness; it
will output the raw bytes of the difference.

What is likely causing the different in what you see is that "git diff".
outputs through a pager, and the snippets of "add -p" do not. The
default pager, "less", does escape some control codes (but with the -R
option, which git uses by default, it passes through colors).

Try:

  git --no-pager diff

or:

  GIT_PAGER=cat git diff

and you'll likely see output similar to what you get with "add -p".

The reason that "add -p" doesn't go through a pager by default is simply
that it would be annoying, since we show snippets and then ask for user
input.

However, since Git v2.9.0, "add -p" (and all of the interactive commands
like "checkout -p", etc) know about the interactive.diffFilter config
option. You could use that to munge the results however you like. E.g.:

  # we can't use [:cntrl:] here because we want to keep newlines.
  # likewise, we want to keep ESC for color codes
  git config interactive.diffFilter "tr '\000-\011\013-\032\034-\037' '?'"

-Peff
