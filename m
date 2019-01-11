Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35203211B4
	for <e@80x24.org>; Fri, 11 Jan 2019 22:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfAKWPm (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 17:15:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:34210 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725812AbfAKWPl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 17:15:41 -0500
Received: (qmail 15734 invoked by uid 109); 11 Jan 2019 22:15:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 Jan 2019 22:15:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13417 invoked by uid 111); 11 Jan 2019 22:15:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 11 Jan 2019 17:15:42 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Jan 2019 17:15:40 -0500
Date:   Fri, 11 Jan 2019 17:15:40 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/6] commit: copy saved getenv() result
Message-ID: <20190111221539.GB10188@sigill.intra.peff.net>
References: <20190111221414.GA31335@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190111221414.GA31335@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We save the result of $GIT_INDEX_FILE so that we can restore it after
setting it to a new value and running add--interactive. However, the
pointer returned by getenv() is not guaranteed to be valid after calling
setenv(). This _usually_ works fine, but can fail if libc needs to
reallocate the environment block during the setenv().

Let's just duplicate the string, so we know that it remains valid.

In the long run it may be more robust to teach interactive_add() to take
a set of environment variables to pass along to run-command when it
execs add--interactive. And then we would not have to do this
save/restore dance at all. But this is an easy fix in the meantime.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/commit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 004b816635..7d2e0b61e5 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -351,7 +351,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 		if (write_locked_index(&the_index, &index_lock, 0))
 			die(_("unable to create temporary index"));
 
-		old_index_env = getenv(INDEX_ENVIRONMENT);
+		old_index_env = xstrdup_or_null(getenv(INDEX_ENVIRONMENT));
 		setenv(INDEX_ENVIRONMENT, get_lock_file_path(&index_lock), 1);
 
 		if (interactive_add(argc, argv, prefix, patch_interactive) != 0)
@@ -361,6 +361,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 			setenv(INDEX_ENVIRONMENT, old_index_env, 1);
 		else
 			unsetenv(INDEX_ENVIRONMENT);
+		FREE_AND_NULL(old_index_env);
 
 		discard_cache();
 		read_cache_from(get_lock_file_path(&index_lock));
-- 
2.20.1.651.g2d41a78c67

