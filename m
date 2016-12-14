Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E440A1FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 14:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756195AbcLNOot (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 09:44:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:56408 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755912AbcLNOos (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 09:44:48 -0500
Received: (qmail 32265 invoked by uid 109); 14 Dec 2016 14:44:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 14:44:46 +0000
Received: (qmail 25400 invoked by uid 111); 14 Dec 2016 14:45:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 09:45:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Dec 2016 09:44:44 -0500
Date:   Wed, 14 Dec 2016 09:44:44 -0500
From:   Jeff King <peff@peff.net>
To:     Jonas Hartmann <jh@ht-studios.de>
Cc:     git@vger.kernel.org
Subject: Re: git stash filename - stashing single files.
Message-ID: <20161214144444.k4v64accedl6xvho@sigill.intra.peff.net>
References: <b528e23b-c763-846e-4040-504a58b690fd@ht-studios.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b528e23b-c763-846e-4040-504a58b690fd@ht-studios.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 14, 2016 at 02:53:20PM +0100, Jonas Hartmann wrote:

> http://stackoverflow.com/questions/3040833/stash-only-one-file-out-of-multiple-files-that-have-changed-with-git#comment32451416_3040833
> 
> Could it be possible to have "git stash [filename][filename]...", to
> stash only single files?
> There seems to be a broad community desire.

I think this would be useful.  You can pick and choose with "git stash
-p", but I have still often wanted "git stash -p [filename]".

There is one problem, though: any non-option arguments to "git stash
save" are interpreted as the stash message. So just:

  git stash save file

would break backwards compatibility. Annoyingly, so would:

  git stash save -- file

which uses the "--" to let you have a message which starts with a dash.

Personally, I think this is a pretty terrible interface. Besides the
fact that I have never written a stash message in all my years of using
git, it's totally inconsistent with the rest of git (which would use
"-m" for the message, and treat arguments as pathspecs).

So it might be worth changing, but we'd probably have to deal with the
backwards compatibility fallout, have a deprecation period, etc.

As for "git stash" without "save", there is magic to rewrite:

  git stash [opts]

into

  git stash save [opts]

but it explicitly does not allow non-option arguments. So:

  git stash foo

is an error (and not unreasonably, since "git stash list" creates an
ambiguity problem). Perhaps:

  git stash -- foo

could be allowed to treat "foo" as a filename. There wouldn't be any
backwards compatibility problems, though it would be weird and
inconsistent to be able to specify filenames via the "shortcut"
invocation, but not with "git stash save".

-Peff
