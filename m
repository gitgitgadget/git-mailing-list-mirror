Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2D6B1F42D
	for <e@80x24.org>; Tue, 27 Mar 2018 06:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752484AbeC0Gbl (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 02:31:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:44270 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752480AbeC0Gbk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 02:31:40 -0400
Received: (qmail 1115 invoked by uid 109); 27 Mar 2018 06:31:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 27 Mar 2018 06:31:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26996 invoked by uid 111); 27 Mar 2018 06:32:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 27 Mar 2018 02:32:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Mar 2018 02:31:38 -0400
Date:   Tue, 27 Mar 2018 02:31:38 -0400
From:   Jeff King <peff@peff.net>
To:     Rafael Ascensao <rafa.almas@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git complains packed-refs is not a directory when used with
 GIT_DIR and GIT_WORK_TREE envvars.
Message-ID: <20180327063137.GA24044@sigill.intra.peff.net>
References: <CACUQV5_3Pw+vnyyNUL4oE4tMLG_wKVdqdVk01rg4V92ufUYHHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACUQV5_3Pw+vnyyNUL4oE4tMLG_wKVdqdVk01rg4V92ufUYHHA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 26, 2018 at 10:27:09PM +0100, Rafael Ascensao wrote:

> One of the tools that manages PKGBUILDS for Arch Linux stores PKGBUILD
> git repos inside a cache directory for reuse.
> 
> One of the repos is triggering some unexpected behaviour that can be
> reproduced in the CLI with:
> 
>   $ GIT_DIR=spotify/.git GIT_WORK_TREE=spotify git reset HEAD
>   fatal: couldn't read spotify/.git/packed-refs: Not a directory
> [...]
> The issue seems to bisect to f57f37e2e1bf11ab4cdfd221ad47e961ba9353a0
> I can't pinpoint why this particular repo is behaving differently.

I think we're getting confused by the relative paths. Here's a related
reproduction:

  $ git init repo
  $ git -C repo commit --allow-empty -m foo
  $ GIT_DIR=repo/.git GIT_WORK_TREE=repo git reset HEAD
  $ find repo/repo
  repo/repo
  repo/repo/.git
  repo/repo/.git/logs
  repo/repo/.git/logs/HEAD
  repo/repo/.git/HEAD

Er, what? It looks like we kept looking at "repo/.git" as our git
directory, even though we should have normalized it into an absolute
path after moving into the root of the work-tree.

I can also reproduce your exact error by inserting:

  git -C repo pack-refs
  echo whatever >repo/repo

before the call to "git reset" (and then we get ENOTDIR trying to read
the packed-refs file, because the file "repo" is in the way).

Looking at f57f37e2, I think the problem is that files_ref_store_create()
saves the value of get_git_dir() at that point. But later after we
chdir for the working tree, presumably it's updated, but we continue to
use the out-dated relative path.

So one "fix" is something like this:

diff --git a/refs.c b/refs.c
index 20ba82b434..449bdf2437 100644
--- a/refs.c
+++ b/refs.c
@@ -1643,11 +1643,14 @@ static struct ref_store *ref_store_init(const char *gitdir,
 	const char *be_name = "files";
 	struct ref_storage_be *be = find_ref_storage_backend(be_name);
 	struct ref_store *refs;
+	char *abs_gitdir;
 
 	if (!be)
 		die("BUG: reference backend %s is unknown", be_name);
 
-	refs = be->init(gitdir, flags);
+	abs_gitdir = absolute_pathdup(gitdir);
+	refs = be->init(abs_gitdir, flags);
+	free(abs_gitdir);
 	return refs;
 }
 

But that really feels like we're papering over the problem. It's not
clear to me exactly what f57f37e2 is trying to accomplish, and whether
it would work for it to look call get_git_dir() whenever it needed the
path.

-Peff
