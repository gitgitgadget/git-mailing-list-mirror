Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6CD320248
	for <e@80x24.org>; Fri,  1 Mar 2019 18:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387975AbfCASmK (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 13:42:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:34758 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728823AbfCASmK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 13:42:10 -0500
Received: (qmail 20489 invoked by uid 109); 1 Mar 2019 18:42:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 Mar 2019 18:42:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32627 invoked by uid 111); 1 Mar 2019 18:42:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 01 Mar 2019 13:42:25 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Mar 2019 13:42:08 -0500
Date:   Fri, 1 Mar 2019 13:42:08 -0500
From:   Jeff King <peff@peff.net>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH 0/4] name-rev: improve memory usage
Message-ID: <20190301184208.GD30847@sigill.intra.peff.net>
References: <20190301175024.17337-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190301175024.17337-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 01, 2019 at 06:50:20PM +0100, Alban Gruin wrote:

> rafasc reported on IRC that on a repository with a lot of branches,
> tags, remotes, and commits, name-rev --stdin could use a massive amount
> of memory (more than 2GB of RAM) to complete.
> 
> This patch series tries to improve name-rev’s memory usage.

Have you tried this?

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index f1cb45c227..7aaa86f1c0 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -431,6 +431,8 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
+	save_commit_buffer = 0;
+
 	init_commit_rev_name(&rev_names);
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, opts, name_rev_usage, 0);

It seems to lower heap usage of:

  git name-rev 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2

in linux.git (that commit is the final one reported by "git log", so
it's traversing all of history) from ~1GB to ~300MB.

-Peff
