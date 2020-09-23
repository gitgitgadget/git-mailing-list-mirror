Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550EBC4363D
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 21:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3097212CC
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 21:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rtzoeller.com header.i=@rtzoeller.com header.b="nuj751e8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgIWV7T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 17:59:19 -0400
Received: from mail-41104.protonmail.ch ([185.70.41.104]:53616 "EHLO
        mail-41104.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIWV7T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 17:59:19 -0400
Received: from mail-03.mail-europe.com (mail-03.mail-europe.com [91.134.188.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41104.protonmail.ch (Postfix) with ESMTPS id 32797200870A
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 21:59:17 +0000 (UTC)
Authentication-Results: mail-41104.protonmail.ch;
        dkim=pass (1024-bit key) header.d=rtzoeller.com header.i=@rtzoeller.com header.b="nuj751e8"
Date:   Wed, 23 Sep 2020 21:59:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rtzoeller.com;
        s=protonmail; t=1600898354;
        bh=FMs1oN/lrRyupYyBr8uWAr3z9aLuafx5fnPtrS/R4fU=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=nuj751e8PCXKXMcQLeVRZLI9phayeZVkWar9Cj4aVX4TNNE5S44sQS2hF6kWEHZ/e
         hTgHdnnaHw8TPdd3lEY87umym4fF9Vgs+oIIIHNEGnnYuz+FiS81FCWxxS95ELGf5u
         tZ8q1Ex1YQjsx3aqisLJ3l6kfeBRUaw1zbIvbREo=
To:     git@vger.kernel.org
From:   Ryan Zoeller <rtzoeller@rtzoeller.com>
Cc:     Ryan Zoeller <rtzoeller@rtzoeller.com>
Reply-To: Ryan Zoeller <rtzoeller@rtzoeller.com>
Subject: [RFC 0/1] Leading whitespace as a function identification heuristic?
Message-ID: <20200923215859.102981-1-rtzoeller@rtzoeller.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've recently been annoyed by git's choice of lines when invoking
`git diff --function-context`. git isn't doing a _bad_ job per se,
given that it's using regular expressions to parse nonregular languages,
but in my opinion it could do better.

The issue I'm seeing is that constructs like nested functions cause
`git diff --function-context` to stop taking lines prematurely; a line
containing a function declaration has been reached, but it's not the one
I'm expecting git to stop at. This results in some of the function being
omitted from the output of `git diff --function-context`, and also
manifests itself as the incorrect function being listed in the hunk header
in general.

A trivial example: in a Python file containing the following contents,
modifying the indicated line will result in git picking `bar()` for the
function header, rather than `foo()`. This is obviously worse for longer
functions, or code with multiple inner functions or classes.

```
def foo(xs, i):
    def bar(x):
        return x + i

    # Intentionally not using a lambda,
    # because the issue occurs for inner functions.
    # Making this comment extra long so the function name
    # doesn't get automatically included in the context.

    return map(bar, xs) # Modify this line
```

Even without properly parsing the file as code, git could use
indentation as a heuristic to determine which lines containing functions
are relevant. I've used Python as an example here, but I think the
issue and heuristic apply to many languages.

This patch implements a proof of concept for this heuristic: only
lines which are indented less than the hunk are considered eligible
to contain function definitions. It only supports `git diff`,
ignoring things like `git grep` for simplicity (and introducing
`-1`s to the diff in leiu of handling them).

While I welcome feedback on the existing implementation, I'm really
requesting commentary on the following:

1. Is this indentation-aware function identification useful, and
    generally worth pursuing further?
2. What level of granularity would be desirable for enabling this?
    Something akin to xfuncname in .gitattributes, where it can be
    enabled per path?
3. How do we handle files with a mix of tabs and spaces?

Best,
Ryan

Ryan Zoeller (1):
  xdiff: use leading whitespace in function heuristic

 grep.c            |  2 +-
 line-range.c      |  2 +-
 xdiff-interface.c | 14 +++++++++++++-
 xdiff/xdiff.h     |  2 +-
 xdiff/xemit.c     | 23 +++++++++++++++++------
 5 files changed, 33 insertions(+), 10 deletions(-)

--=20
2.28.0.586.g47c91ef7fe


