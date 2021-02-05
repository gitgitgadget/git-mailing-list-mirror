Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D001C433DB
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 17:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D015764FC2
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 17:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbhBEPph (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 10:45:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:51818 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230374AbhBEPmi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 10:42:38 -0500
Received: (qmail 18834 invoked by uid 109); 5 Feb 2021 16:57:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Feb 2021 16:57:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27927 invoked by uid 111); 5 Feb 2021 16:57:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Feb 2021 11:57:21 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 5 Feb 2021 11:57:21 -0500
From:   Jeff King <peff@peff.net>
To:     SURA <surak8806@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: I've noticed the command `git --git-dir=<path> shortlog`
Message-ID: <YB148VZJqKIPC8P2@coredump.intra.peff.net>
References: <CAD6AYr-BD08FcbnVfHpOUt7ZwFH0PgoATgyegKnBQ3GOe9isdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD6AYr-BD08FcbnVfHpOUt7ZwFH0PgoATgyegKnBQ3GOe9isdA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 01, 2021 at 11:05:13AM +0800, SURA wrote:

> $ git clone --bare https://github.com/gitlabhq/gitlabhq.git
> $ git clone https://gitlab.com/gitlab-org/gitaly.git
> 
> $ git --git-dir=./gitlabhq.git shortlog --summary --email --numbered
> --committer HEAD --end-of-options | wc -l
> > 2592
> [...]
> $ cd gitaly
> $ git --git-dir=../gitlabhq.git shortlog --summary --email --numbered
> --committer HEAD --end-of-options | wc -l
> > 2587

I think what's happening is that the second command is using the
.mailmap file found in the working tree of the gitaly repository.

If the first checkout were non-bare, I would say that is the right
behavior (because --git-dir without otherwise specifying the working
tree means that the current directory becomes the working tree, and we
read ".mailmap" out of the top of the working tree). But because it was
cloned with "--bare", it should have the core.bare config set, and will
think there is no working tree at all.

So I do think there is a bug, which is: Git should avoid looking for
".mailmap" in the current directory if we do not have a working tree.
I.e., something like:

diff --git a/mailmap.c b/mailmap.c
index eb77c6e77c..3ea35a2289 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -225,7 +225,8 @@ int read_mailmap(struct string_list *map)
 	if (!git_mailmap_blob && is_bare_repository())
 		git_mailmap_blob = "HEAD:.mailmap";
 
-	err |= read_mailmap_file(map, ".mailmap");
+	if (!is_bare_repository())
+		err |= read_mailmap_file(map, ".mailmap");
 	if (startup_info->have_repository)
 		err |= read_mailmap_blob(map, git_mailmap_blob);
 	err |= read_mailmap_file(map, git_mailmap_file);

It's possible somebody is relying on this in order to read ".mailmap" in
a bare repository, but it seems rather unlikely. And the documentation
says "If the file .mailmap exists at the toplevel of the repository",
which I think pretty clearly means the top of the working tree.

-Peff
