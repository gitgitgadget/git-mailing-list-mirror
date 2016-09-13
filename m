Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9030207DF
	for <e@80x24.org>; Tue, 13 Sep 2016 03:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754653AbcIMDXt (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 23:23:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:42289 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754555AbcIMDXr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 23:23:47 -0400
Received: (qmail 20328 invoked by uid 109); 13 Sep 2016 03:23:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Sep 2016 03:23:48 +0000
Received: (qmail 18459 invoked by uid 111); 13 Sep 2016 03:23:57 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Sep 2016 23:23:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Sep 2016 20:23:44 -0700
Date:   Mon, 12 Sep 2016 20:23:44 -0700
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 08/16] pager: stop loading git_default_config()
Message-ID: <20160913032344.srp2canqre44rsl5@sigill.intra.peff.net>
References: <20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In git_pager(), we really only care about getting the value
of core.pager. But to do so, we use the git_default_config()
callback, which loads many other values. Ordinarily it
isn't a big deal to load this config an extra time, as it
simply overwrites the values from the previous run. But it's
a bad idea here, for two reasons:

  1. The pager setup may be called very early in the
     program, before we have found the git repository. As a
     result, we may fail to read the correct repo-level
     config file.  This is a problem for core.pager, too,
     but we should at least try to minimize the pollution to
     other configured values.

  2. Because we call setup_pager() from git.c, basically
     every builtin command _may_ end up reading this config
     and getting an implicit git_default_config() setup.

     Which doesn't sound like a terrible thing, except that
     we don't do it consistently; it triggers only when
     stdout is a tty. So if a command forgets to load the
     default config itself (but depends on it anyway), it
     may appear to work, and then mysteriously fail when the
     pager is not in use.

We can improve this by loading _just_ the core.pager config
from git_pager().

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c | 3 ---
 pager.c  | 9 ++++++++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index 0dfed68..8b28447 100644
--- a/config.c
+++ b/config.c
@@ -927,9 +927,6 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
-	if (!strcmp(var, "core.pager"))
-		return git_config_string(&pager_program, var, value);
-
 	if (!strcmp(var, "core.editor"))
 		return git_config_string(&editor_program, var, value);
 
diff --git a/pager.c b/pager.c
index ae46da9..d747f50 100644
--- a/pager.c
+++ b/pager.c
@@ -35,6 +35,13 @@ static void wait_for_pager_signal(int signo)
 	raise(signo);
 }
 
+static int core_pager_config(const char *var, const char *value, void *data)
+{
+	if (!strcmp(var, "core.pager"))
+		return git_config_string(&pager_program, var, value);
+	return 0;
+}
+
 const char *git_pager(int stdout_is_tty)
 {
 	const char *pager;
@@ -45,7 +52,7 @@ const char *git_pager(int stdout_is_tty)
 	pager = getenv("GIT_PAGER");
 	if (!pager) {
 		if (!pager_program)
-			git_config(git_default_config, NULL);
+			git_config(core_pager_config, NULL);
 		pager = pager_program;
 	}
 	if (!pager)
-- 
2.10.0.230.g6f8d04b

