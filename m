Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECA272055E
	for <e@80x24.org>; Fri,  3 Nov 2017 01:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934684AbdKCBDD (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 21:03:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:44942 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932398AbdKCBDD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 21:03:03 -0400
Received: (qmail 22117 invoked by uid 109); 3 Nov 2017 01:03:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 03 Nov 2017 01:03:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29990 invoked by uid 111); 3 Nov 2017 01:03:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 02 Nov 2017 21:03:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Nov 2017 21:03:01 -0400
Date:   Thu, 2 Nov 2017 21:03:01 -0400
From:   Jeff King <peff@peff.net>
To:     Andrew Baumann <Andrew.Baumann@microsoft.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git tries to stat //HEAD when searching for a repo, leading to
 huge delays on Cygwin
Message-ID: <20171103010300.3jwme4d6nbxnj6od@sigill.intra.peff.net>
References: <MWHPR21MB0159089DB91A30E5E5CFCB479E5C0@MWHPR21MB0159.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MWHPR21MB0159089DB91A30E5E5CFCB479E5C0@MWHPR21MB0159.namprd21.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 02, 2017 at 11:45:55PM +0000, Andrew Baumann wrote:

> I have a workaround for this, but someone on stack overflow [1]
> suggested reporting it upstream, so here you go:
> 
> I have a fancy shell prompt that executes "git rev-parse
> --is-inside-work-tree" to determine whether we're currently inside a
> working directory. This causes git to walk up the directory hierarchy
> looking for a containing git repo. For example, when invoked from my
> home directory, it stats the following paths, in order:
> 
> /home/me/.git
> /home/me/.git/HEAD
> /home/me/HEAD
> /home
> /home/.git
> /home/.git/HEAD
> /home/HEAD
> /
> /.git
> /.git/HEAD
> //HEAD
> 
> The last name (//HEAD) interacts badly with Cygwin, which interprets
> it as a UNC file share, and so demand-loads a bunch of extra DLLs and
> attempts to resolve/contact the server named HEAD. This obviously
> doesn't work too well, especially over a slow network link.
> 
> I've tested with the latest Cygwin git (2.15.0); this was also present
> in a prior version.

Interesting. I can reproduce on Linux (but of course "//HEAD" is cheap
to look at there). It bisects to ce9b8aab5d (setup_git_directory_1():
avoid changing global state, 2017-03-13). Before that, the end of the
strace for "git rev-parse --git-dir" looks like:

  chdir("..")                             = 0
  stat(".git", 0x7fffba398e00)            = -1 ENOENT (No such file or directory)
  lstat(".git/HEAD", 0x7fffba398dd0)      = -1 ENOENT (No such file or directory)
  lstat("./HEAD", 0x7fffba398dd0)         = -1 ENOENT (No such file or directory)
  write(2, "fatal: Not a git repository (or "..., 69) = 69

and after:

  stat("/.git", 0x7ffdb28b7eb0)           = -1 ENOENT (No such file or directory)
  lstat("/.git/HEAD", 0x7ffdb28b7e80)     = -1 ENOENT (No such file or directory)
  lstat("//HEAD", 0x7ffdb28b7e80)         = -1 ENOENT (No such file or directory)
  write(2, "fatal: Not a git repository (or "..., 69) = 69

Switching to using absolute paths rather than chdir-ing around is
intentional for that commit, but it looks like we just need to
special-case the construction of the root path.

Like this, perhaps:

diff --git a/setup.c b/setup.c
index 27a31de33f..5d0b6a88e3 100644
--- a/setup.c
+++ b/setup.c
@@ -283,7 +283,9 @@ int is_git_directory(const char *suspect)
 	size_t len;
 
 	/* Check worktree-related signatures */
-	strbuf_addf(&path, "%s/HEAD", suspect);
+	strbuf_addstr(&path, suspect);
+	strbuf_complete(&path, '/');
+	strbuf_addstr(&path, "HEAD");
 	if (validate_headref(path.buf))
 		goto done;
 

-Peff
