Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 428931FA14
	for <e@80x24.org>; Fri, 26 May 2017 19:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S944535AbdEZTKb (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 15:10:31 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36698 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932288AbdEZTKW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 15:10:22 -0400
Received: by mail-pf0-f182.google.com with SMTP id m17so19301467pfg.3
        for <git@vger.kernel.org>; Fri, 26 May 2017 12:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x/RHYyFd6rDAT7dwXfvT/rKDxSWbN4RtMhH1mTOPC90=;
        b=MvedLL2RXkDcHaJw2zeBJGvhrSV9U+u/kn5TKCh+mIdzwp1r+olZ1PhyIWvNpSY4O9
         F1daPHLOduKLPyasptO6R/jmgD1KM6CsDUR26uk1a+bv1PWwwqTWYy5Req/1Bgtc0VBP
         Wjb9at6VzfSyS+aHMxPluJ9n420mAKcHN+jEAXwyXZxEOoLxYecEzvUcLZkj87PlIINy
         xGznrxdTTaPWW6pY0esmkUZTTIbKyYLvF/gsZSls35Zu1yeuP/alHm4YNR6frwsc18Le
         SQdTvmd4Q1Mk7MqVLD6HOF3z555suKEUJOHC6ZJJ0Wqgnf6RFK4gxabrooksNzCkg2ap
         tFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x/RHYyFd6rDAT7dwXfvT/rKDxSWbN4RtMhH1mTOPC90=;
        b=X6/WMPkU5cht7jC3qwuDhkClDnPkwagFYVjfDFIXXiuRv08jAJQyr/Yo6onGCY6ikO
         KHRPRQEzj5rlRGi5um+rErDa9gj6w0Yb36MDGS0Gb/0Wi+kTshldujXgNBy5EKNb2+wR
         0HYZv43wK/zDOFb5QhYt8kWWjJlc8FBkLSWnNaezP98kJBfU3vbuNG61Ux9vEbvoNu+p
         GrRc2ZYkYnRrOo2+GsI7XPki3Q6VAJVIl5pEykqPDwZeZ3Ey5PQViEnVOV6LViEJwYIG
         Bfaxm0LfuppwQZl7ufOfaDVy11QgcfMF0AJz+2H6ViPIZoFpv8X3igEqq4y4zWcIErn9
         EpXg==
X-Gm-Message-State: AODbwcAGI5omPkm3EY3NLQX8X318qa/EMSJb2LrUtyReXO/8aGYJsNLN
        WZa8sJmnwASYZZ/8
X-Received: by 10.99.127.73 with SMTP id p9mr4308498pgn.169.1495825822093;
        Fri, 26 May 2017 12:10:22 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:818a:1f3a:57c6:8d29])
        by smtp.gmail.com with ESMTPSA id f86sm3231917pfj.128.2017.05.26.12.10.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 26 May 2017 12:10:21 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/8] submodule recursing: do not write a config variable twice
Date:   Fri, 26 May 2017 12:10:10 -0700
Message-Id: <20170526191017.19155-2-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.17.g582985b1e4
In-Reply-To: <20170526191017.19155-1-sbeller@google.com>
References: <20170526191017.19155-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The command line option for '--recurse-submodules' is implemented
using an OPTION_CALLBACK, which takes both the callback (that sets
the file static global variable) as well as passes the same file
static global variable to the option parsing machinery to assign it.
This is fixed in this commit by passing NULL as the variable. The
callback sets it instead

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/checkout.c  | 2 +-
 builtin/read-tree.c | 2 +-
 builtin/reset.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index bfa5419f33..0fd57672cc 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1181,7 +1181,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 				N_("second guess 'git checkout <no-such-branch>'")),
 		OPT_BOOL(0, "ignore-other-worktrees", &opts.ignore_other_worktrees,
 			 N_("do not check if another worktree is holding the given ref")),
-		{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules,
+		{ OPTION_CALLBACK, 0, "recurse-submodules", NULL,
 			    "checkout", "control recursive updating of submodules",
 			    PARSE_OPT_OPTARG, option_parse_recurse_submodules },
 		OPT_BOOL(0, "progress", &opts.show_progress, N_("force progress reporting")),
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 23e212ee8c..2a1b8a530e 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -157,7 +157,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 			 N_("skip applying sparse checkout filter")),
 		OPT_BOOL(0, "debug-unpack", &opts.debug_unpack,
 			 N_("debug unpack-trees")),
-		{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules,
+		{ OPTION_CALLBACK, 0, "recurse-submodules", NULL,
 			    "checkout", "control recursive updating of submodules",
 			    PARSE_OPT_OPTARG, option_parse_recurse_submodules },
 		OPT_END()
diff --git a/builtin/reset.c b/builtin/reset.c
index 5ce27fcaed..1e5f85b1fb 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -304,7 +304,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				N_("reset HEAD, index and working tree"), MERGE),
 		OPT_SET_INT(0, "keep", &reset_type,
 				N_("reset HEAD but keep local changes"), KEEP),
-		{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules,
+		{ OPTION_CALLBACK, 0, "recurse-submodules", NULL,
 			    "reset", "control recursive updating of submodules",
 			    PARSE_OPT_OPTARG, option_parse_recurse_submodules },
 		OPT_BOOL('p', "patch", &patch_mode, N_("select hunks interactively")),
-- 
2.13.0.17.g582985b1e4

