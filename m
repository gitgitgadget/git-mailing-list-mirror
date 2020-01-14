Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23770C33C9E
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 22:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83012187F
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 22:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgANW2E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 17:28:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:36686 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727072AbgANW2D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 17:28:03 -0500
Received: (qmail 10690 invoked by uid 109); 14 Jan 2020 22:28:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Jan 2020 22:28:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25863 invoked by uid 111); 14 Jan 2020 22:34:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Jan 2020 17:34:18 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Jan 2020 17:28:02 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Git alias syntax help
Message-ID: <20200114222802.GC3957260@coredump.intra.peff.net>
References: <CAHMHMxWpLAnj3w8DGLMFbfy-A-pBjDxNdMeiM-fyuu-gnZyg+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHMHMxWpLAnj3w8DGLMFbfy-A-pBjDxNdMeiM-fyuu-gnZyg+Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 14, 2020 at 05:21:20PM +0200, Σταύρος Ντέντος wrote:

> I am having an issue with git-aliases - specifically, the intricacies
> involved in their syntax.
> 
> In general, the syntax is confusing to me, especially when it is
> _wise_ to use quotes inside a `!sh` alias.
> e.g. which one would be the correct one
> new = "!f() { : git log ; git log \"${1}@{1}..${1}@{0}\" \"$@\" ; } ; f"
> new = !f() { : git log ; git log "${1}@{1}..${1}@{0}" "$@" ; } ; f

Only the first one is correct. In addition to the quotes in the second
one being eaten by the config parser, the unquoted semicolon starts a
comment.

> The alias confusing me is more specifically this:
> https://git.wiki.kernel.org/index.php/Aliases#simple_diff_ignoring_line_number_changes
> 
> diffsort = !sh -c 'git diff "$@" | grep "^[+-]" | sort --key=1.2 | uniq -u -s1'
> 
> The output of:
> $  colordiff -su <(git diffsort HEAD^..HEAD) <(git diffsort HEAD^^..HEAD^)
> Files /dev/fd/63 and /dev/fd/62 are identical
> is a little unexpected, since I know for a fact that one of the
> referced commits is not a code block moved.

The issue here isn't with Git's alias mechanism, but a quirk of how "sh
-c" works.  You can run with GIT_TRACE to see what we're passing to the
shell (though note that your double-quotes don't make it through):

  $ GIT_TRACE=1 git diffsort HEAD^..HEAD
  17:22:47.644542 [pid=3959333] git.c:708           trace: exec: git-diffsort HEAD^..HEAD
  17:22:47.644648 [pid=3959333] run-command.c:663   trace: run_command: git-diffsort HEAD^..HEAD
  17:22:47.645038 [pid=3959333] run-command.c:663   trace: run_command: 'sh -c '\''git diff $@ | grep ^[+-] | sort --key=1.2 | uniq -u -s1'\''' HEAD^..HEAD
  17:22:47.650319 [pid=3959336] git.c:439           trace: built-in: git diff

The problem is that "sh -c" takes the first non-option argument as $0,
not $1. For example:

  $ sh -c 'echo 0=$0, @=$@' foo bar baz
  0=foo, @=bar baz

You can add any extra string there to become $0, like:

  diffsort = "!sh -c 'git diff \"$@\" | grep \"^[+-]\" | sort --key=1.2 | uniq -u -s1' --"

which will do what you want. You can use whatever string you like, since
you know that your "-c" snippet does not ever look at $0.

-Peff
