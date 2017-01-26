Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 357111F6DC
	for <e@80x24.org>; Thu, 26 Jan 2017 00:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751582AbdAZAdf (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 19:33:35 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33383 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750986AbdAZAde (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 19:33:34 -0500
Received: by mail-pg0-f44.google.com with SMTP id 204so68607327pge.0
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 16:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mqz1W3EBmPzSDQRzu9Ow4y5wmT+BoqtO5w5hTvmCvPQ=;
        b=VfDkGQDPVmVqStsbmPj4OqU+TZUkLzD0KvPqcGnCk1tCBFRmuTkqhUFqFOjkx6+hE2
         1cT6RQl9RkP1ACasD8ugfTFS1ebORR8AWUZgqFA+GnGDAfBfryz+jJSEhAt30brmhwAG
         5oxnxJ3LOWcNZBke2kszPyDkcgAMa7cg3Zt1XQB8Lrt3Hgdqn/tKIaxQqjLI9RhDXCKK
         w/fUSaIPTgNsxiLtUnuy5VW6MhhFuXUX9Qi4Su831a8IlOVMLtxceGVSYoUT85K6ZcXv
         G1EcbUhjJsZaIDMa8ZK28NbvMw4LPByCbVzNLsHNWvinj3uD+BbVr8BTJRH92FUySelZ
         w2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mqz1W3EBmPzSDQRzu9Ow4y5wmT+BoqtO5w5hTvmCvPQ=;
        b=ZA6nF9KcYsKHzLSZOwl4KtzqZxhQRlj4u9Rgy9ItYntZUOGSbXmMLSAvFiFc97ZfYS
         Mah08insZOdgcVj+bqWWckJHj4IL+IP2B0pevPW3GdPWw6myKqDLWJHtOVUwenGni7pa
         MPRmv96CSHzZ/C7VlUDOq+dbyYsQrfBXWiG+xLZsRViDvVIA9vSW7iP4PA6LyWxtrwcL
         rHxliN6cPTUqT5WWHmK7TUBGCgIEY6BS63AnU7mIz3BdmdhvvP04KY1AX3py1SUGx3+G
         udYNJ8dDc5szIr3vuzcWlU0nBqvMrulmaZUHXLcplcAm5H88PmNAPnZ9NageAajr8q6W
         BQ6A==
X-Gm-Message-State: AIkVDXIr9MPSyE9B+8LkK+Xz/a7dDqCjVuvxxa0QenbLPHRdsqEuqdc15SGfptu3ajSVXfvi
X-Received: by 10.99.65.1 with SMTP id o1mr40566pga.93.1485390813169;
        Wed, 25 Jan 2017 16:33:33 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:3993:32c0:4ba2:a648])
        by smtp.gmail.com with ESMTPSA id i10sm37269pgd.37.2017.01.25.16.33.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 25 Jan 2017 16:33:32 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, hvoigt@hvoigt.net, dborowitz@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] Revert "push: change submodule default to check when submodules exist"
Date:   Wed, 25 Jan 2017 16:33:29 -0800
Message-Id: <20170126003329.28841-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.495.g04f60290a0.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reverts commit 04a1d8b1ae5eeecb90675cfaca2850bf26269485.

In the previous commit we set push.recurseSubmodules to "check"
by default. This check is done by walking all remote refs that are known.

For remotes we only store the refs/heads/* (and tags), which doesn't
include all commits. In e.g. Gerrit commits often end up at refs/changes/*
(that we do not store) when pushing to refs/for/master (which we also do
not store). So a workflow such as the following still fails:

    $ git -C <submodule> push origin HEAD:refs/for/master
    $ git push origin HEAD:refs/for/master
    The following submodule paths contain changes that can
    not be found on any remote:
      submodule

    Please try

        git push --recurse-submodules=on-demand

    or cd to the path and use

        git push

    to push them to a remote.

Trying to push with --recurse-submodules={on-demand,check}
would run into the same problem, yielding the same error message.

So changing the default to check for submodules is clearly not working
as intended for Gerrit users. We need another option that works for them.
For now just revert the change of the default.

A future patch to address this problem would be add another option that
treats the submodules differently:

  1) check if the submodule needs pushing (as currently done in "check")
  2) for those submodules that need pushing we run a command, e.g.
     git push with the refspec passed down exactly as is. This would
     work for the Gerrit case, as HEAD:refs/for/master is correct
     for both the superproject and the submodule.
  3) Unlike in "on-demand", we would not check again after performing
     step 2), as we would not find the newly pushed things at Gerrit.

Once we have such an option, we can default to "check" again, and the
error message would mention both on-demand as well as this new option.
I'd imagine "on-demand" is what works in branch driven code review
systems such as github; for Gerrit which is based on changes the option
outlined above would work.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

  After some thought, my opinion on
  sb/push-make-submodule-check-the-default
  change. We should not merge it down to master
  until we found a good solution.
  
  This applies on top of sb/push-make-submodule-check-the-default
  unbreaking existing Gerrit users, explaining why this was a bad idea.
  
  Feel free to either apply this patch or just eject said branch from
  next.
  
  Thanks,
  Stefan  

 builtin/push.c                 | 16 +---------------
 t/t5531-deep-submodule-push.sh |  6 +-----
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 9e0b8dba9a..3bb9d6b7e6 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -3,7 +3,6 @@
  */
 #include "cache.h"
 #include "refs.h"
-#include "dir.h"
 #include "run-command.h"
 #include "builtin.h"
 #include "remote.h"
@@ -23,7 +22,6 @@ static int deleterefs;
 static const char *receivepack;
 static int verbosity;
 static int progress = -1;
-static int has_submodules_configured;
 static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static enum transport_family family;
 
@@ -33,15 +31,6 @@ static const char **refspec;
 static int refspec_nr;
 static int refspec_alloc;
 
-static void preset_submodule_default(void)
-{
-	if (has_submodules_configured || file_exists(git_path("modules")) ||
-	    (!is_bare_repository() && file_exists(".gitmodules")))
-		recurse_submodules = RECURSE_SUBMODULES_CHECK;
-	else
-		recurse_submodules = RECURSE_SUBMODULES_OFF;
-}
-
 static void add_refspec(const char *ref)
 {
 	refspec_nr++;
@@ -506,9 +495,7 @@ static int git_push_config(const char *k, const char *v, void *cb)
 		const char *value;
 		if (!git_config_get_value("push.recursesubmodules", &value))
 			recurse_submodules = parse_push_recurse_submodules_arg(k, value);
-	} else if (starts_with(k, "submodule.") && ends_with(k, ".url"))
-		/* The submodule.<name>.url is used as a bit to indicate existence */
-		has_submodules_configured = 1;
+	}
 
 	return git_default_config(k, v, NULL);
 }
@@ -565,7 +552,6 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	};
 
 	packet_trace_identity("push");
-	preset_submodule_default();
 	git_config(git_push_config, &flags);
 	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
 	set_push_cert_flags(&flags, push_cert);
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index e690749e8a..198ce84754 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -65,11 +65,7 @@ test_expect_success 'push fails if submodule commit not on remote' '
 		git add gar/bage &&
 		git commit -m "Third commit for gar/bage" &&
 		# the push should fail with --recurse-submodules=check
-		# on the command line. "check" is the default for repos in
-		# which submodules are detected by existence of config,
-		# .gitmodules file or an internal .git/modules/<submodule-repo>
-		git submodule add -f ../submodule.git gar/bage &&
-		test_must_fail git push ../pub.git master &&
+		# on the command line...
 		test_must_fail git push --recurse-submodules=check ../pub.git master &&
 
 		# ...or if specified in the configuration..
-- 
2.11.0.495.g04f60290a0.dirty

