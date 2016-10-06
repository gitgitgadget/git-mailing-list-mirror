Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87B52207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 19:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934833AbcJFThl (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 15:37:41 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35404 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934676AbcJFThi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 15:37:38 -0400
Received: by mail-pf0-f174.google.com with SMTP id s13so13526520pfd.2
        for <git@vger.kernel.org>; Thu, 06 Oct 2016 12:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v0pUd6Xw3ENVaI5BJi9gz87sU/Tq2jcSa11uIBZJggA=;
        b=P7d2MnqqE8qtZ50MEJnCVowVEHjLsQEj2RdPRnbeHJ5qrCiy6e2/DsSKiYgFWuV4YZ
         +93bxHT0gFIvWcEsxVYeBLKoB9a0Jj23yBHqv//nfz+A21t7ysOWyzXoPizGR5InpCE7
         5RaeYKKKG0NYeNZK1Tdx6Fr23MA88yhqWhJFKsk2MKZrInIeJ78VrlQijJ6UmrlqcTpK
         iEHsbSLacFQxBN+jKRTAkzFnb4zTc4eESAm+LYO/q6OZKoYUh8omvKrDzhLK5r1eYGO/
         nrohRT9ITapr3EjJ4QYZLFFdKmO5k1GXmzFvqhI9zyLOv1lrK0iiaJZmLQ1yRg+ldvra
         OJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v0pUd6Xw3ENVaI5BJi9gz87sU/Tq2jcSa11uIBZJggA=;
        b=cfAvjS4jcru1IQPOfXlf7h477XNDl7Jj9ycgYKBguRZ7N/rj10cQEbI64R8SMgbRCJ
         N0+DPAyH8iAwzG99llORqmksBq1+zbBribyWNTkiLWVDIaZGr9P7dVdTEXVR3kdgHgih
         GJBr6fTLkwisI0knJWS6AFvBfhZ4hVJs+3422kZ2xPZcaj/3N0WRCqi+Fn3Ik5NWCuz+
         PqJq9r0wBA+Lb536+6b61aYgWZIbDMbFYbviBEEsAulfe9B4yHLgfSIqa37jI8NeWFRr
         4tpB6ES4fteKsDPE5ahm04WMGSettt4ZHIRSBQmEMfmVP9gl3dyZskFh+tzfqeK1rjmn
         GJQw==
X-Gm-Message-State: AA6/9RkfvlvADiKIWhNwdBi3fv9NAEoERBTk71qulCDrbzhR+thKPDCh7VSd41JTvipZKXaM
X-Received: by 10.98.66.205 with SMTP id h74mr28858331pfd.92.1475782657345;
        Thu, 06 Oct 2016 12:37:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:9975:37b1:c0d3:285b])
        by smtp.gmail.com with ESMTPSA id wa9sm24783322pac.35.2016.10.06.12.37.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 06 Oct 2016 12:37:36 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, hvoigt@hvoigt.net,
        torvalds@linux-foundation.org, peff@peff.net,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 2/2] push: change submodule default to check when submodules exist
Date:   Thu,  6 Oct 2016 12:37:25 -0700
Message-Id: <20161006193725.31553-3-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.353.g1629400
In-Reply-To: <20161006193725.31553-1-sbeller@google.com>
References: <20161006193725.31553-1-sbeller@google.com>
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
based on a cheap heuristic, the existence of the .git/modules directory.
That directory doesn't exist when no submodules are used and is only
created and populated when submodules are cloned/added.

When the submodule directory doesn't exist, a user may have changed the
gitlinks via plumbing commands. Currently the default is to not check.
RECURSE_SUBMODULES_DEFAULT is effectively RECURSE_SUBMODULES_OFF currently,
though it may change in the future. When no submodules exist such a check
is pointless as it would fail anyway, so let's just turn it off.

[1] https://public-inbox.org/git/CA+55aFyos78qODyw57V=w13Ux5-8SvBqObJFAq22K+XKPWVbAA@mail.gmail.com/

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/push.c                 | 15 ++++++++++++++-
 t/t5531-deep-submodule-push.sh |  6 +++++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 3bb9d6b..683f270 100644
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
@@ -495,7 +506,8 @@ static int git_push_config(const char *k, const char *v, void *cb)
 		const char *value;
 		if (!git_config_get_value("push.recursesubmodules", &value))
 			recurse_submodules = parse_push_recurse_submodules_arg(k, value);
-	}
+	} else if (starts_with(k, "submodule.") && ends_with(k, ".url"))
+		has_submodules_configured = 1;
 
 	return git_default_config(k, v, NULL);
 }
@@ -552,6 +564,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
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

