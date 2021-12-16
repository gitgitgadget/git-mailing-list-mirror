Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AABC433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 20:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241108AbhLPUDA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 15:03:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:53506 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230172AbhLPUC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 15:02:59 -0500
Received: (qmail 22314 invoked by uid 109); 16 Dec 2021 20:02:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Dec 2021 20:02:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21882 invoked by uid 111); 16 Dec 2021 20:02:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Dec 2021 15:02:59 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Dec 2021 15:02:58 -0500
From:   Jeff King <peff@peff.net>
To:     Erik Cervin Edin <erik@cervined.in>
Cc:     git@vger.kernel.org
Subject: Re: bug: git-add --patch any negative pathspec fails
Message-ID: <YbubciQn0eKq4iKc@coredump.intra.peff.net>
References: <CA+JQ7M_Q2bgHWt_SFWdMCHkqqJr2K2VEqDfK4en_eXhs0o5JgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+JQ7M_Q2bgHWt_SFWdMCHkqqJr2K2VEqDfK4en_eXhs0o5JgQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 16, 2021 at 08:09:24PM +0100, Erik Cervin Edin wrote:

> Steps to reproduce:
> git-add -p -- ':!foo'
> 
> Expected:
> Add everything that doesn't match the pathspec.
> 
> Actual:
> fatal: empty string is not a valid pathspec. please use . instead if
> you meant to match all paths

Hmm. This is a regression from 728c573803 (Merge branch
'ex/deprecate-empty-pathspec-as-match-all', 2017-11-06). But I think the
fault is really in the earlier 859b7f1d0e (pathspec: don't error out on
all-exclusionary pathspec patterns, 2017-02-07).

It works by adding an extra "match everything" pathspec internally, but
it just passes the empty string as the "original" string to
init_pathspec_item(). And "git add -p" works by iterating over the
parsed pathspec list and adding the result to the helper script's argv.

So either:

  - it should instead make sure to pass the true original set of
    pathspecs we got (so just the exclusion, not the "match everything"
    one). This would work because those pathspecs are then interpreted
    by further Git programs anyway (so they'd have their own "match
    everything" logic internally).

  - we should pass something better for the "match everything" pathspec.
    The patch below does that, though I didn't think too hard on whether
    the choice of "something better" would always be correct (e.g., if
    we change directory internally, do we need to adjust "." to match
    original cwd)?

    It does fix your case, and it passes the test suite, but I have a
    feeling this area is not very well tested (I doubt we even look at
    the "original" string all that often).

diff --git a/pathspec.c b/pathspec.c
index ddeeba7911..5a0e083229 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -628,8 +628,16 @@ void parse_pathspec(struct pathspec *pathspec,
 	 * that matches everything. We allocated an extra one for this.
 	 */
 	if (nr_exclude == n) {
-		int plen = (!(flags & PATHSPEC_PREFER_CWD)) ? 0 : prefixlen;
-		init_pathspec_item(item + n, 0, prefix, plen, "");
+		int plen;
+		const char *orig;
+		if (flags & PATHSPEC_PREFER_CWD) {
+			plen = prefixlen;
+			orig = ".";
+		} else {
+			plen = 0;
+			orig = ":/";
+		}
+		init_pathspec_item(item + n, 0, prefix, plen, orig);
 		pathspec->nr++;
 	}
 
