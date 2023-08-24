Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA09C7EE2C
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 14:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239147AbjHXOcm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Aug 2023 10:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241634AbjHXOcU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 10:32:20 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7FD1BCE
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 07:32:14 -0700 (PDT)
Received: (qmail 13035 invoked by uid 109); 24 Aug 2023 14:32:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Aug 2023 14:32:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19410 invoked by uid 111); 24 Aug 2023 14:32:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Aug 2023 10:32:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 24 Aug 2023 10:32:11 -0400
From:   Jeff King <peff@peff.net>
To:     Reverdell Auriane <auriane.reverdell@cscs.ch>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: diff alias which used to work in version 2.27, failing from
 version 2.28 onwards
Message-ID: <20230824143211.GA3108100@coredump.intra.peff.net>
References: <31866645d2ac4cb1be17e35fae742cb2@cscs.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <31866645d2ac4cb1be17e35fae742cb2@cscs.ch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 24, 2023 at 10:19:18AM +0000, Reverdell  Auriane wrote:

> 14:38:45.275964 git.c:439               trace: built-in: git diff a2028e7b^..a2028e7b a2028e7b 
> [...]
> Is that expected behavior? if yes, how is the right/clean way to
> discard the command line argument of the alias?

Yes, that's expected. Your alias was always a little broken by adding
the extra argument, but "git diff" got a little more careful about its
input in 8bfcb3a690 (git diff: improve range handling, 2020-06-12),
which as part of v2.28.

The usual way for manipulating arguments in a shell snippet is to make a
function, like:

  [alias]
  dici = "!f() { git diff ${1:-HEAD}^..${1:-HEAD}; }; f"

Then Git ends up running "f a2028e7b", and the shell does the rest. It's
obviously a bit more verbose to write, but you're free to do even more
manipulation (e.g., using the first non-option argument as the rev and
taking the rest as options).

All that said, there is a shorthand that may make your alias obsolete.
From "git help revisions":

         <rev>^-<n>, e.g. HEAD^-, HEAD^-2
             Equivalent to <rev>^<n>..<rev>, with <n> = 1 if not given.

So just:

  git diff a2028e7b^-

does what you want.

-Peff
