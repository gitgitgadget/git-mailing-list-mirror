Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 653C520D0A
	for <e@80x24.org>; Tue, 30 May 2017 05:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750839AbdE3FLZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 01:11:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:59596 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750767AbdE3FLY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 01:11:24 -0400
Received: (qmail 12491 invoked by uid 109); 30 May 2017 05:11:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 May 2017 05:11:25 +0000
Received: (qmail 20781 invoked by uid 111); 30 May 2017 05:12:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 May 2017 01:12:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 May 2017 01:11:23 -0400
Date:   Tue, 30 May 2017 01:11:23 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Zero King <l2dy@macports.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/8] am: handle "-h" argument earlier
Message-ID: <20170530051122.u6uu3dohtilkk7ia@sigill.intra.peff.net>
References: <20170530050949.dkgu3u26qj6ycusy@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170530050949.dkgu3u26qj6ycusy@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the user provides "-h" on the command line, then our
parse_options() invocation will show a usage message and
quit. But if "-h" is the only argument, the git wrapper
behaves specially: it ignores our RUN_SETUP flag and calls
cmd_am() without having done repository setup at all.  This
is due to 99caeed05 (Let 'git <command> -h' show usage
without a git dir, 2009-11-09).

Before cmd_am() calls parse_options(), though, it runs a few
other setup functions. One of these is am_state_init(),
which uses git_pathdup() to set up the default rebase-apply
path. But calling git_pathdup() when we haven't done
repository setup will fall back to using ".git". That's
mostly harmless (since we won't use the value anyway), but
is forbidden since b1ef400eec ("setup_git_env: avoid blind
fall-back to ".git"", 2016-10-20), and we now BUG().

We can't easily move that setup to after the parse_options()
call; the point is to set up defaults that are overwritten
by the option parsing. Instead, we'll detect the "-h" case
early and show the usage then. This matches the behavior of
other builtins which have a similar setup-ordering issue
(e.g., git-branch).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/am.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 0f63dcab1..5ee146bfb 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2311,6 +2311,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(usage, options);
+
 	git_config(git_am_config, NULL);
 
 	am_state_init(&state);
-- 
2.13.0.613.g11c956365

