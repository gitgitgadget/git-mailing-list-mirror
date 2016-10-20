Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37B8620986
	for <e@80x24.org>; Thu, 20 Oct 2016 06:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754819AbcJTGYe (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 02:24:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:59874 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754778AbcJTGYd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 02:24:33 -0400
Received: (qmail 18920 invoked by uid 109); 20 Oct 2016 06:24:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 06:24:33 +0000
Received: (qmail 21121 invoked by uid 111); 20 Oct 2016 06:24:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 02:24:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Oct 2016 02:24:31 -0400
Date:   Thu, 20 Oct 2016 02:24:31 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 7/7] setup_git_env: avoid blind fall-back to ".git"
Message-ID: <20161020062430.rxupwheaeydtcvf3@sigill.intra.peff.net>
References: <20161020061536.6fqh23xb2nhxodpa@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161020061536.6fqh23xb2nhxodpa@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we default to ".git" without having done any kind of
repository setup, the results quite often do what the user
expects.  But this has also historically been the cause of
some poorly behaved corner cases. These cases can be hard to
find, because they happen at the conjunction of two
relatively rare circumstances:

  1. We are running some code which assumes there's a
     repository present, but there isn't necessarily one
     (e.g., low-level diff code triggered by "git diff
     --no-index" might try to look at some repository data).

  2. We have an unusual setup, like being in a subdirectory
     of the working tree, or we have a .git file (rather
     than a directory), or we are running a tool like "init"
     or "clone" which may operate on a repository in a
     different directory.

Our test scripts often cover (1), but miss doing (2) at the
same time, and so the fallback appears to work but has
lurking bugs. We can flush these bugs out by refusing to do
the fallback entirely., This makes potential problems a lot
more obvious by complaining even for "usual" setups.

This passes the test suite (after the adjustments in the
previous patches), but there's a risk of regression for any
cases where the fallback usually works fine but the code
isn't exercised by the test suite.  So by itself, this
commit is a potential step backward, but lets us take two
steps forward once we've identified and fixed any such
instances.

Signed-off-by: Jeff King <peff@peff.net>
---
 environment.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/environment.c b/environment.c
index cd5aa57..b1743e6 100644
--- a/environment.c
+++ b/environment.c
@@ -164,8 +164,11 @@ static void setup_git_env(void)
 	const char *replace_ref_base;
 
 	git_dir = getenv(GIT_DIR_ENVIRONMENT);
-	if (!git_dir)
+	if (!git_dir) {
+		if (!startup_info->have_repository)
+			die("BUG: setup_git_env called without repository");
 		git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
+	}
 	gitfile = read_gitfile(git_dir);
 	git_dir = xstrdup(gitfile ? gitfile : git_dir);
 	if (get_common_dir(&sb, git_dir))
-- 
2.10.1.619.g16351a7
