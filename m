Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33C0F207B9
	for <e@80x24.org>; Tue, 18 Apr 2017 21:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755918AbdDRVhx (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 17:37:53 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:33656 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755365AbdDRVhs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 17:37:48 -0400
Received: by mail-pg0-f42.google.com with SMTP id 63so2661306pgh.0
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 14:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xl1wbmNxDht3PYdm5YeE1ZBCFH4EkZkg/dtFmXQtdcA=;
        b=byL5Oqf3efFun9hVlqWvFCUyDDy8igwhV0AQIlHCsOndWYPa/QewJNIAhDPNBPzCs3
         UXkP0CyInEPShf6SoZS16OLkOY7xUWOzWDp9ktEqWFb5bS9M27Loh2bvzSZXuNOC8KxC
         d5lZKUzGAqefhbrZjssy393YFx6MgARWXZt7DQEklbjf/j4a1sf7/03NjRW0dOoBW62J
         Tjyi+iSiluLcM7ve1P1mnbWwBko0CVuxLJwCVW4Ij3h+dwg38HF4awtMiky4ZM04hxA/
         81hZsHWX8tZLyf32AEY+GVsp9A+Bt3HbOFSfVi/aEPTSrRuo2z7Y7r3c79thvk0h4Zgs
         wJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xl1wbmNxDht3PYdm5YeE1ZBCFH4EkZkg/dtFmXQtdcA=;
        b=K/YnHRxJMhGNxoh5W6Qi1/aSMAysV2fj/dc0fAOOYVgbMhF2iLYM0qNoNe2kFD6QKE
         yVWLnAZdivNSSPhkYJzBpuPhj2BBYtsKAoHRHtEsRONrcr/2NOUXwKLipfZnn2anNy4e
         kGSh5rhaNcawltOabm7EYUrRB+dRw+lbSUcOHLMkRncHPUbQJarn6THHo+N0OWCJk5AO
         1pm5wWHXLzMaSL3H8a8NPY3xZKuGjM49RsFxOTeZGjyluafK3Q56Z58IRv40ADlogLGq
         1asGWERoHbIJIMeRIxQv4q5RD/Ncul33K7mBq8loiDQL70CIzBoZH1sWhxexKSGVzKb4
         0PNQ==
X-Gm-Message-State: AN3rC/5MIyS4g68uRaDBiAjRXsOth8evVIqIPnDhPNwsbmwhu5EckuRq
        dbOb3ImA8pIvDsFG
X-Received: by 10.99.151.18 with SMTP id n18mr20664359pge.199.1492551462378;
        Tue, 18 Apr 2017 14:37:42 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c47b:4f4d:6233:ff9f])
        by smtp.gmail.com with ESMTPSA id u45sm348961pgn.7.2017.04.18.14.37.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 18 Apr 2017 14:37:41 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com,
        jonathantanmy@google.com, philipoakley@iee.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 4/4] builtin/reset: add --recurse-submodules switch
Date:   Tue, 18 Apr 2017 14:37:25 -0700
Message-Id: <20170418213725.7901-5-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.642.g1b8cc69eee.dirty
In-Reply-To: <20170418213725.7901-1-sbeller@google.com>
References: <20170418213725.7901-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-reset is yet another working tree manipulator, which should
be taught about submodules.

One use case of "git-reset" is to reset to a known good state,
and dropping commits that did not work as expected.
In that case one of the expected outcomes from a hard reset
would be to have broken submodules reset to a known good
state as well.  A test for this was added in a prior patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/reset.c            | 30 ++++++++++++++++++++++++++++++
 t/t7112-reset-submodule.sh |  8 ++++++++
 2 files changed, 38 insertions(+)

diff --git a/builtin/reset.c b/builtin/reset.c
index fc3b906c47..5ce27fcaed 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -21,6 +21,27 @@
 #include "parse-options.h"
 #include "unpack-trees.h"
 #include "cache-tree.h"
+#include "submodule.h"
+#include "submodule-config.h"
+
+static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
+
+static int option_parse_recurse_submodules(const struct option *opt,
+					   const char *arg, int unset)
+{
+	if (unset) {
+		recurse_submodules = RECURSE_SUBMODULES_OFF;
+		return 0;
+	}
+	if (arg)
+		recurse_submodules =
+			parse_update_recurse_submodules_arg(opt->long_name,
+							    arg);
+	else
+		recurse_submodules = RECURSE_SUBMODULES_ON;
+
+	return 0;
+}
 
 static const char * const git_reset_usage[] = {
 	N_("git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]"),
@@ -283,6 +304,9 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				N_("reset HEAD, index and working tree"), MERGE),
 		OPT_SET_INT(0, "keep", &reset_type,
 				N_("reset HEAD but keep local changes"), KEEP),
+		{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules,
+			    "reset", "control recursive updating of submodules",
+			    PARSE_OPT_OPTARG, option_parse_recurse_submodules },
 		OPT_BOOL('p', "patch", &patch_mode, N_("select hunks interactively")),
 		OPT_BOOL('N', "intent-to-add", &intent_to_add,
 				N_("record only the fact that removed paths will be added later")),
@@ -295,6 +319,12 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 						PARSE_OPT_KEEP_DASHDASH);
 	parse_args(&pathspec, argv, prefix, patch_mode, &rev);
 
+	if (recurse_submodules != RECURSE_SUBMODULES_DEFAULT) {
+		gitmodules_config();
+		git_config(submodule_config, NULL);
+		set_config_update_recurse_submodules(RECURSE_SUBMODULES_ON);
+	}
+
 	unborn = !strcmp(rev, "HEAD") && get_sha1("HEAD", oid.hash);
 	if (unborn) {
 		/* reset on unborn branch: treat as reset to empty tree */
diff --git a/t/t7112-reset-submodule.sh b/t/t7112-reset-submodule.sh
index 2eda6adeb1..f86ccdf215 100755
--- a/t/t7112-reset-submodule.sh
+++ b/t/t7112-reset-submodule.sh
@@ -5,6 +5,14 @@ test_description='reset can handle submodules'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
+KNOWN_FAILURE_SUBMODULE_RECURSIVE_NESTED=1
+KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS=1
+KNOWN_FAILURE_SUBMODULE_OVERWRITE_IGNORED_UNTRACKED=1
+
+test_submodule_switch_recursing "git reset --recurse-submodules --keep"
+
+test_submodule_forced_switch_recursing "git reset --hard --recurse-submodules"
+
 test_submodule_switch "git reset --keep"
 
 test_submodule_switch "git reset --merge"
-- 
2.12.2.642.g1b8cc69eee.dirty

