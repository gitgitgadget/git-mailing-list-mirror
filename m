Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BFF42013E
	for <e@80x24.org>; Fri,  3 Mar 2017 04:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751276AbdCCEZJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 23:25:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:37615 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750709AbdCCEZH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 23:25:07 -0500
Received: (qmail 31753 invoked by uid 109); 3 Mar 2017 04:24:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 04:24:24 +0000
Received: (qmail 24619 invoked by uid 111); 3 Mar 2017 04:24:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Mar 2017 23:24:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Mar 2017 23:24:22 -0500
Date:   Thu, 2 Mar 2017 23:24:22 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 3/9] setup_git_directory(): avoid changing global
 state during discovery
Message-ID: <20170303042422.s3dnbgbjszhygwqz@sigill.intra.peff.net>
References: <cover.1481211338.git.johannes.schindelin@gmx.de>
 <cover.1488506615.git.johannes.schindelin@gmx.de>
 <49f66f2b723af38a58c17bc8ae413bcee69e2a2f.1488506615.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <49f66f2b723af38a58c17bc8ae413bcee69e2a2f.1488506615.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2017 at 03:04:11AM +0100, Johannes Schindelin wrote:

> For historical reasons, Git searches for the .git/ directory (or the
> .git file) by changing the working directory successively to the parent
> directory of the current directory, until either anything was found or
> until a ceiling or a mount point is hit.

This is starting to get into the meat of changes we've been putting off
writing for ages. I'll read with my fingers crossed. :)

> Further global state may be changed, depending on the actual type of
> discovery, e.g. the global variable `repository_format_precious_objects`
> is set in the `check_repository_format_gently()` function (which is a
> bit surprising, given the function name).

It's gentle in the sense that if it does not find a valid repo, it
touches no state. I do suspect the functions you want are the ones it
builds on: read_repository_format() and verify_repository_format(),
which I added not too long ago for the exact purpose of checking repo
config without touching anything global.

> We do have a use case where we would like to find the .git/ directory
> without having any global state touched, though: when we read the early
> config e.g. for the pager or for alias expansion.
> 
> Let's just rename the function `setup_git_directory_gently_1()` to
> `discover_git_directory()` and move all code that changes any global
> state back into `setup_git_directory_gently()`.

Given the earlier paragraph, it sounds like you want to move the
global-state-changing parts out of check_repository_format_gently(). But
that wouldn't be right; it's triggered separate from the discovery
process by things like enter_repo().

However, I don't see that happening in the patch, which is good. I just
wonder if the earlier paragraph should really be complaining about how
setup_git_directory() (and its callees) touches a lot of global state,
not check_repository_format_gently(), whose use is but one of multiple
global-state modifications.

> Note: the new loop is a *little* tricky, as we have to handle the root
> directory specially: we cannot simply strip away the last component
> including the slash, as the root directory only has that slash. To remedy
> that, we introduce the `min_offset` variable that holds the minimal length
> of an absolute path, and using that to special-case the root directory,
> including an early exit before trying to find the parent of the root
> directory.

I wondered how t1509 fared with this, as it is the only test of
repositories at the root directory (and it is not run by default because
it involves a bunch of flaky and expensive chroot setup). Unfortunately
it seems to fail with your patch:

  expecting success: 
  		test_cmp_val "foo/" "$(git rev-parse --show-prefix)"
  	
  --- expected
  +++ result
  @@ -1 +1 @@
  -foo/
  +oo/
  not ok 66 - auto gitdir, foo: prefix

Could the problem be this:

> +	int ceil_offset = -1, min_offset = has_dos_drive_prefix(dir->buf) ? 3 : 1;
> [...]
> -	if (ceil_offset < 0 && has_dos_drive_prefix(cwd.buf))
> -		ceil_offset = 1;
> +	if (ceil_offset < 0)
> +		ceil_offset = min_offset - 2;

It works the same as before in the dos-drive case, but we'd get
ceil_offset = -1 otherwise.  Which seems weird, but maybe I don't
understand how ceil_offset is supposed to work.

Interestingly, I don't think this is the bug, though. We still correctly
find /.git as a repository. The problem seems to happen later, in
setup_discovered_git_dir(), which does this:

  /* Make "offset" point to past the '/', and add a '/' at the end */
  offset++;
  strbuf_addch(cwd, '/');
  return cwd->buf + offset;

Here, "offset" is the length of the working tree path. The root
directory case differs from normal in that "offset" already accounts for
the trailing slash.

So I think the bug comes from:

> -			ret = setup_discovered_git_dir(gitdirenv,
> -						       &cwd, offset,
> -						       nongit_ok);
> [...]
> +		prefix = setup_discovered_git_dir(gitdir.buf, &cwd, dir.len,
> +						  nongit_ok);

The original knew that "offset" took into account the off-by-one for the
root, but that's lost when we use dir.len. I haven't studied it enough
to know the best solution, but I suspect you will.

Other than this bug, I very much like the direction that this patch is
taking us.

-Peff
