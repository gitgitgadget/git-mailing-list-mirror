Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4200320953
	for <e@80x24.org>; Thu, 16 Mar 2017 22:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754612AbdCPWhx (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 18:37:53 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35711 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753909AbdCPWhd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 18:37:33 -0400
Received: by mail-pg0-f41.google.com with SMTP id b129so31612926pgc.2
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 15:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ut68bqwewiZ9j4IUvKtIlsL/SpLBY9JLzfvJB8xIzUc=;
        b=toxBuVDwowA2RVTpc9t6uFAvRfcbA/qLAMn0zaPDGzV55kEbLcMMdzoYj7hUNOJv77
         WpMv1nGHhnbF4kfdx3MdrUd1pqHy9fSoaTCf0pySpwk/lI/REr6gM/Mwt2YB53IMSog3
         RHc5LvB7kMLr8CpqXplgfhJA+M30OfppS7f67Gtfd8/lFH63qbD9NpyKSo3Ns4SjTrHE
         nak3wo9R2E/EGnx9r8/n2Zc++zeItI2yG3PMshSpF5SmqcJX/kTmHWYcll7dE/Ek7J1+
         /UJ4j/pn6wuLqzG7ZOEuhzVWZtHYGvl8tP2h3YYnR76Gy7aoElR2aDa2aZSbExb+8lny
         GP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ut68bqwewiZ9j4IUvKtIlsL/SpLBY9JLzfvJB8xIzUc=;
        b=brtRDaQXl4fWNw3MGm0/6NKsRIiXunrueelJVYFYTpNWZifgeNlWLwKyjLG5yXydPH
         3tSfOBHKYaw71sJ8zH3oZu4XXXv7cCcy26WhfCf1TDi001IrbBc9qdoPnDe7AkCgraz8
         PHV3K5SPvuKdsieeu4hhQGqWqmU9PVqEZPhyYRnsfLRjT/QlGiS2FPk6s9tIjdmsV/bP
         ROv23VldZSCMquzR2emDbZSdriiloMixnBpVuJuKFdiIIsr8JqSO8v2pypEyUQRHUnEO
         euG2UAKB+1DrdI7hy89yWXA4Yj57PbjlNxdwJ5JvrKxdtA0ljpwkOu9bB9J65oCabs/9
         HpQA==
X-Gm-Message-State: AFeK/H2+Rl75LlmuIbqlEZ53r6ZoukQ1FlP4upqWon0eaCcZEbaWUmTEDZMJH2+jcsFZiQ+M
X-Received: by 10.99.8.194 with SMTP id 185mr12392623pgi.37.1489703410639;
        Thu, 16 Mar 2017 15:30:10 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id t5sm12520946pgb.36.2017.03.16.15.30.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Mar 2017 15:30:09 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v4 08/10] clone: teach --recurse-submodules to optionally take a pathspec
Date:   Thu, 16 Mar 2017 15:29:50 -0700
Message-Id: <20170316222952.53801-9-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.367.g23dc2f6d3c-goog
In-Reply-To: <20170316222952.53801-1-bmwill@google.com>
References: <20170313214341.172676-1-bmwill@google.com>
 <20170316222952.53801-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach clone --recurse-submodules to optionally take a pathspec argument
which describes which submodules should be recursively initialized and
cloned.  If no pathspec is provided, --recurse-submodules will
recursively initialize and clone all submodules by using a default
pathspec of ".".  In order to construct more complex pathspecs,
--recurse-submodules can be given multiple times.

Additionally this configures the 'submodule.active' configuration option
to be the given pathspec, such that any future invocation of `git
submodule update` will keep up with the pathspec.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/git-clone.txt | 14 ++++++----
 builtin/clone.c             | 47 ++++++++++++++++++++++++++-----
 t/t7400-submodule-basic.sh  | 68 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 35cc34b2f..30052cce4 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
 	  [--dissociate] [--separate-git-dir <git dir>]
 	  [--depth <depth>] [--[no-]single-branch]
-	  [--recursive | --recurse-submodules] [--[no-]shallow-submodules]
+	  [--recurse-submodules] [--[no-]shallow-submodules]
 	  [--jobs <n>] [--] <repository> [<directory>]
 
 DESCRIPTION
@@ -215,10 +215,14 @@ objects from the source repository into a pack in the cloned repository.
 	branch when `--single-branch` clone was made, no remote-tracking
 	branch is created.
 
---recursive::
---recurse-submodules::
-	After the clone is created, initialize all submodules within,
-	using their default settings. This is equivalent to running
+--recurse-submodules[=<pathspec]::
+	After the clone is created, initialize and clone submodules
+	within based on the provided pathspec.  If no pathspec is
+	provided, all submodules are initialized and cloned.
+	Submodules are initialized and cloned using their default
+	settings.  The resulting clone has `submodule.active` set to
+	the provided pathspec, or "." (meaning all submodules) if no
+	pathspec is provided.  This is equivalent to running
 	`git submodule update --init --recursive` immediately after
 	the clone is finished. This option is ignored if the cloned
 	repository does not have a worktree/checkout (i.e. if any of
diff --git a/builtin/clone.c b/builtin/clone.c
index 3f63edbbf..3dc8faac5 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -39,7 +39,7 @@ static const char * const builtin_clone_usage[] = {
 };
 
 static int option_no_checkout, option_bare, option_mirror, option_single_branch = -1;
-static int option_local = -1, option_no_hardlinks, option_shared, option_recursive;
+static int option_local = -1, option_no_hardlinks, option_shared;
 static int option_shallow_submodules;
 static int deepen;
 static char *option_template, *option_depth, *option_since;
@@ -56,6 +56,22 @@ static struct string_list option_required_reference = STRING_LIST_INIT_NODUP;
 static struct string_list option_optional_reference = STRING_LIST_INIT_NODUP;
 static int option_dissociate;
 static int max_jobs = -1;
+static struct string_list option_recurse_submodules = STRING_LIST_INIT_NODUP;
+
+static int recurse_submodules_cb(const struct option *opt,
+				 const char *arg, int unset)
+{
+	if (unset)
+		return -1;
+
+	if (arg)
+		string_list_append((struct string_list *)opt->value, arg);
+	else
+		string_list_append((struct string_list *)opt->value,
+				   (const char *)opt->defval);
+
+	return 0;
+}
 
 static struct option builtin_clone_options[] = {
 	OPT__VERBOSITY(&option_verbosity),
@@ -74,10 +90,13 @@ static struct option builtin_clone_options[] = {
 		    N_("don't use local hardlinks, always copy")),
 	OPT_BOOL('s', "shared", &option_shared,
 		    N_("setup as shared repository")),
-	OPT_BOOL(0, "recursive", &option_recursive,
-		    N_("initialize submodules in the clone")),
-	OPT_BOOL(0, "recurse-submodules", &option_recursive,
-		    N_("initialize submodules in the clone")),
+	{ OPTION_CALLBACK, 0, "recursive", &option_recurse_submodules,
+	  N_("pathspec"), N_("initialize submodules in the clone"),
+	  PARSE_OPT_OPTARG | PARSE_OPT_HIDDEN, recurse_submodules_cb,
+	  (intptr_t)"." },
+	{ OPTION_CALLBACK, 0, "recurse-submodules", &option_recurse_submodules,
+	  N_("pathspec"), N_("initialize submodules in the clone"),
+	  PARSE_OPT_OPTARG, recurse_submodules_cb, (intptr_t)"." },
 	OPT_INTEGER('j', "jobs", &max_jobs,
 		    N_("number of submodules cloned in parallel")),
 	OPT_STRING(0, "template", &option_template, N_("template-directory"),
@@ -733,7 +752,7 @@ static int checkout(int submodule_progress)
 	err |= run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1),
 			   sha1_to_hex(sha1), "1", NULL);
 
-	if (!err && option_recursive) {
+	if (!err && (option_recurse_submodules.nr > 0)) {
 		struct argv_array args = ARGV_ARRAY_INIT;
 		argv_array_pushl(&args, "submodule", "update", "--init", "--recursive", NULL);
 
@@ -957,7 +976,21 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			fprintf(stderr, _("Cloning into '%s'...\n"), dir);
 	}
 
-	if (option_recursive) {
+	if (option_recurse_submodules.nr > 0) {
+		struct string_list_item *item;
+		struct strbuf sb = STRBUF_INIT;
+
+		/* remove duplicates */
+		string_list_sort(&option_recurse_submodules);
+		string_list_remove_duplicates(&option_recurse_submodules, 0);
+
+		for_each_string_list_item(item, &option_recurse_submodules) {
+			strbuf_addf(&sb, "submodule.active=%s",
+				    item->string);
+			string_list_append(&option_config,
+					   strbuf_detach(&sb, NULL));
+		}
+
 		if (option_required_reference.nr &&
 		    option_optional_reference.nr)
 			die(_("clone --recursive is not compatible with "
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index fbbe932d1..3af1c00ff 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1188,4 +1188,72 @@ test_expect_success 'submodule update and setting submodule.<name>.active' '
 	test_cmp expect actual
 '
 
+test_expect_success 'clone --recurse-submodules with a pathspec works' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	cat >expected <<-\EOF &&
+	 sub0 (test2)
+	-sub1
+	-sub2
+	-sub3
+	EOF
+
+	git clone --recurse-submodules="sub0" multisuper multisuper_clone &&
+	git -C multisuper_clone submodule status |cut -c1,43- >actual &&
+	test_cmp actual expected
+'
+
+test_expect_success 'clone with multiple --recurse-submodules options' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	cat >expect <<-\EOF &&
+	-sub0
+	 sub1 (test2)
+	-sub2
+	 sub3 (test2)
+	EOF
+
+	git clone --recurse-submodules="." \
+		  --recurse-submodules=":(exclude)sub0" \
+		  --recurse-submodules=":(exclude)sub2" \
+		  multisuper multisuper_clone &&
+	git -C multisuper_clone submodule status |cut -c1,43- >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'clone and subsequent updates correctly auto-initialize submodules' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	cat <<-\EOF >expect &&
+	-sub0
+	 sub1 (test2)
+	-sub2
+	 sub3 (test2)
+	EOF
+
+	cat <<-\EOF >expect2 &&
+	-sub0
+	 sub1 (test2)
+	-sub2
+	 sub3 (test2)
+	-sub4
+	 sub5 (test2)
+	EOF
+
+	git clone --recurse-submodules="." \
+		  --recurse-submodules=":(exclude)sub0" \
+		  --recurse-submodules=":(exclude)sub2" \
+		  --recurse-submodules=":(exclude)sub4" \
+		  multisuper multisuper_clone &&
+
+	git -C multisuper_clone submodule status |cut -c1,43- >actual &&
+	test_cmp expect actual &&
+
+	git -C multisuper submodule add ../sub1 sub4 &&
+	git -C multisuper submodule add ../sub1 sub5 &&
+	git -C multisuper commit -m "add more submodules" &&
+	# obtain the new superproject
+	git -C multisuper_clone pull &&
+	git -C multisuper_clone submodule update --init &&
+	git -C multisuper_clone submodule status |cut -c1,43- >actual &&
+	test_cmp expect2 actual
+'
+
 test_done
-- 
2.12.0.367.g23dc2f6d3c-goog

