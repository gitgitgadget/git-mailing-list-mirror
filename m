Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85B72207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 23:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756038AbcJFXlF (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 19:41:05 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33818 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752415AbcJFXlE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 19:41:04 -0400
Received: by mail-pf0-f171.google.com with SMTP id e6so15800819pfk.1
        for <git@vger.kernel.org>; Thu, 06 Oct 2016 16:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=286rRboX59AhhN55N76gVSbtXbfHM3Lsnc9s5EIvXf8=;
        b=ivXKlGfBmaGni2fphWjklCJANskVwasJQbnQbyw4E8sB4E4UhwQl+PMlKHCghh1/4g
         +3CteseJJApVQwbIoGDJijoaw+EGK0wv1WPXzG1x0BgPqGykpVO5qVVTgnb5VByOxiSQ
         rMJxhho/6hhX7qdwAkMaoRokvWkqYpYxVoq5w4HqgpguDnGKtP77w65WCBfqLCoj3ZBi
         BRrC+lejdSoeMYdKysWs+uhMVv/Wgchzvqqqw3SDKn5s9tc2xxXKRpecQQjaGjEFR5HJ
         R89ZFP7EvJCRtR5q5fSaJXH65HsWllbT8b1KoqkTY/QLEfwA4d+DdLlh6YhKt0eQAwSE
         6bPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=286rRboX59AhhN55N76gVSbtXbfHM3Lsnc9s5EIvXf8=;
        b=Zjjw9gEgiQHB5LhGXQqGDZ9o30aboUepZKdK4s2AYmC0OQhENvWlJ+QwUY0RqYFht/
         eDEhf7ERf969Y4VVBxBfcNHV7Cpd/Yd5Cc/e3A4ydFhUcSUa83LGF4zA4upQUxeMgI4B
         rld+XpA4+wQnmtL5hgYWSyZ03cXcXcmoRJRB/m4Ju4i2codtM+epMjDhrrSImSOWg5lt
         yHSb1te8W9txhtiMTOfw6/aw5/IAnzKgFPe8xQ36vpWSPOzUPRPSZ5GQoWkUBUAOXjWW
         UuKILCfaEYsb5/PzTT/S+6ocncMmqOmOZQM88E++h3fCZEPn+TTGO/vDB270BZyothEV
         1Wtg==
X-Gm-Message-State: AA6/9Rk9vu9TuEXrlCfTZOOzjx2sc/CGRyPnaWI2wYntWFyV6KoS90YNkUFmrs6xsnXmJ1K2
X-Received: by 10.98.80.78 with SMTP id e75mr23654441pfb.131.1475797263431;
        Thu, 06 Oct 2016 16:41:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:9975:37b1:c0d3:285b])
        by smtp.gmail.com with ESMTPSA id q78sm8477742pfj.33.2016.10.06.16.41.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 06 Oct 2016 16:41:02 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, hvoigt@hvoigt.net,
        torvalds@linux-foundation.org, peff@peff.net,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv5] push: change submodule default to check when submodules exist
Date:   Thu,  6 Oct 2016 16:41:00 -0700
Message-Id: <20161006234100.8979-1-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.353.g1629400
In-Reply-To: <xmqqoa2xi5rd.fsf@gitster.mtv.corp.google.com>
References: <xmqqoa2xi5rd.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When working with submodules, it is easy to forget to push the submodules.
The setting 'check', which checks if any existing submodule is present on
at least one remote of the submodule remotes, is designed to prevent this
mistake.

Flipping the default to check for submodules is safer than the current
default of ignoring submodules while pushing.

However checking for submodules requires additional work[1], which annoys
users that do not use submodules, so we turn on the check for submodules
based on a cheap heuristic, the existence of
* any initialized submodules via checking submodule.<name>.url.
* the .git/modules directory. That directory doesn't exist when no
  submodules are used and is only created and populated when submodules
  are cloned/added.
* the existence of the .gitmodules file.

When the submodule directory doesn't exist, a user may have changed the
gitlinks via plumbing commands. Currently the default is to not check.
RECURSE_SUBMODULES_DEFAULT is effectively RECURSE_SUBMODULES_OFF currently,
though it may change in the future. When no submodules exist such a check
is pointless as it would fail anyway, so let's just turn it off.

[1] https://public-inbox.org/git/CA+55aFyos78qODyw57V=w13Ux5-8SvBqObJFAq22K+XKPWVbAA@mail.gmail.com/

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 * Reworded the commit message
 * added comment on why we only check submodule.<name>.url

 The first patch of the series is still good, so please use
 https://public-inbox.org/git/20161006193725.31553-2-sbeller@google.com/
 first and then build this on top.
 
 Thanks,
 Stefan 

 builtin/push.c                 | 16 +++++++++++++++-
 t/t5531-deep-submodule-push.sh |  6 +++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 3bb9d6b..9e0b8db 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -3,6 +3,7 @@
  */
 #include "cache.h"
 #include "refs.h"
+#include "dir.h"
 #include "run-command.h"
 #include "builtin.h"
 #include "remote.h"
@@ -22,6 +23,7 @@ static int deleterefs;
 static const char *receivepack;
 static int verbosity;
 static int progress = -1;
+static int has_submodules_configured;
 static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static enum transport_family family;
 
@@ -31,6 +33,15 @@ static const char **refspec;
 static int refspec_nr;
 static int refspec_alloc;
 
+static void preset_submodule_default(void)
+{
+	if (has_submodules_configured || file_exists(git_path("modules")) ||
+	    (!is_bare_repository() && file_exists(".gitmodules")))
+		recurse_submodules = RECURSE_SUBMODULES_CHECK;
+	else
+		recurse_submodules = RECURSE_SUBMODULES_OFF;
+}
+
 static void add_refspec(const char *ref)
 {
 	refspec_nr++;
@@ -495,7 +506,9 @@ static int git_push_config(const char *k, const char *v, void *cb)
 		const char *value;
 		if (!git_config_get_value("push.recursesubmodules", &value))
 			recurse_submodules = parse_push_recurse_submodules_arg(k, value);
-	}
+	} else if (starts_with(k, "submodule.") && ends_with(k, ".url"))
+		/* The submodule.<name>.url is used as a bit to indicate existence */
+		has_submodules_configured = 1;
 
 	return git_default_config(k, v, NULL);
 }
@@ -552,6 +565,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	};
 
 	packet_trace_identity("push");
+	preset_submodule_default();
 	git_config(git_push_config, &flags);
 	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
 	set_push_cert_flags(&flags, push_cert);
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index 198ce84..e690749 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -65,7 +65,11 @@ test_expect_success 'push fails if submodule commit not on remote' '
 		git add gar/bage &&
 		git commit -m "Third commit for gar/bage" &&
 		# the push should fail with --recurse-submodules=check
-		# on the command line...
+		# on the command line. "check" is the default for repos in
+		# which submodules are detected by existence of config,
+		# .gitmodules file or an internal .git/modules/<submodule-repo>
+		git submodule add -f ../submodule.git gar/bage &&
+		test_must_fail git push ../pub.git master &&
 		test_must_fail git push --recurse-submodules=check ../pub.git master &&
 
 		# ...or if specified in the configuration..
-- 
2.10.1.353.g1629400

