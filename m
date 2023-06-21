Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812D4EB64D8
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 08:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjFUISf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 04:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbjFUIR6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 04:17:58 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BAF122
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 01:17:56 -0700 (PDT)
Received: (qmail 17644 invoked by uid 109); 21 Jun 2023 08:17:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Jun 2023 08:17:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13915 invoked by uid 111); 21 Jun 2023 08:17:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Jun 2023 04:17:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 21 Jun 2023 04:17:54 -0400
From:   Jeff King <peff@peff.net>
To:     Guido =?utf-8?B?TWFydMOtbmV6?= via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Guido =?utf-8?B?TWFydMOtbmV6?= <mtzguido@gmail.com>
Subject: Re: [PATCH] ls-files: add an --exclude-links option
Message-ID: <20230621081754.GA803861@coredump.intra.peff.net>
References: <pull.1549.git.1687327684909.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.1549.git.1687327684909.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2023 at 06:08:04AM +0000, Guido Martínez via GitGitGadget wrote:

> From: =?UTF-8?q?Guido=20Mart=C3=ADnez?= <mtzguido@gmail.com>
> 
> Add an option to exclude symlinks from the listed files. This is useful
> in case we are listing the files in order to process the contents,
> for instance to do some text replacement with `sed -i`. In that case,
> there is no point in processing the links, and it could even be
> counterproductive as some tools (like sed) will replace the link with a
> fresh regular file.
> 
> This option enables a straightforward implementation of a `git sed`:
> 
>     #!/bin/bash
>     git ls-files --exclude-links -z | xargs -0 -P $(nproc) -- sed -i -e "$@"

This invocation would likewise have a problem with gitlink entries (for
submodules). I think what you really want is not "exclude symlinks" but
"show only regular files". There is no option for that, but you can do
it by grepping modes from "-s", like:

  git ls-files -s | grep '^100[67]' | ...

You do unfortunately have to then pull the filename out of the rest of
the line, and since we didn't use "-z", it will be quoted (and using
"-z" makes it hard to use tools like grep and sed). A mild application
of perl works, though:

  git ls-files -s |
  perl -0ne 'print if s/^100(644|755).*?\t//' |
  xargs -0 ...

So I dunno. That is not exactly pretty, but if you were hiding it in a
"git sed" alias or script, it's not so bad.

If we were to add an option to ls-files, it would make more sense to me
to allow the user to include/exclude by mode or possibly naming the type
(e.g., "f" for regular files, "l" for symbolic links, etc, which matches
"find"). And then allow inclusion/exclusion similar to the way that
git-diff's --diff-filter option works.

-Peff
