Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69A5E206A4
	for <e@80x24.org>; Tue, 13 Dec 2016 01:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753462AbcLMBlL (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 20:41:11 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:33053 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932585AbcLMBlI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 20:41:08 -0500
Received: by mail-pg0-f48.google.com with SMTP id 3so41578155pgd.0
        for <git@vger.kernel.org>; Mon, 12 Dec 2016 17:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JCioX9EC3OC2+zJAm8S0UaPFgKV5DnLW3oNLFifITYI=;
        b=EaVaoeSUvxkXgwbeQs8f+xv+8m0AS8k2bD9gBHNzsalFxs3IKvsJT8BrPbHJsPxuc3
         n1mfxfDYN+VEu6TyBXX0Y7RbTnu5i4QVOVv2pSiER/aQSq8GSPPWrcZV2tF0Gu/w2qht
         9MPw/Nh5CzTsE+PTWer9LuJD/t8SF3GaYq5Wt5rue/thLx3tEl1B7oiyvkWuR307H1Ai
         yuYuV4wphtc2fm9zR6EIHw5tfqcGFGQoU8cEWX0jKBDji+4LheoQbI1euuLzu0kePRhK
         nkbvmoOtwKDkFOll2GKEHfDB49w0CLcCYW+Ve4rjfRClk2FOPj3Z4a6DjYwoz2TNOQ1D
         7iwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JCioX9EC3OC2+zJAm8S0UaPFgKV5DnLW3oNLFifITYI=;
        b=cnU8f3YwhwvFvdzyMm1/JPB9Ozy+qDrQ334BcJKAfQkNLXXTHF7OwKVskwoKMXJIaA
         zmzk9FHIG0anhccTw28N8OcyS8I/6jnuHpu7ZFmrA80bl/BrevOb85UN4iGXi0JwlXwb
         i+K/teANW4rG+tzkbnW97vlLZ5lbyCW7HytaxNvogHoH8F3KRC91E9c8yaoot800A95Y
         +CXyWYz0DWerj8HxERaMkdk4mCYmPMOJvcaVvIzYaMblKXrGCYS2oK2+Yd7EkMz3QmPo
         pctlqiWLBbota3u13gmr3ML/6LQqdk+hgi7dpajvPzcsB8XjLpIbwq+h8Ea6U+rGd99q
         pTNw==
X-Gm-Message-State: AKaTC02yYuOEP13OG2nkAhHaaFBiosXS70/v1G1Tx+TkL1u6qDye5frACncvEtzRAI/bqFx+
X-Received: by 10.84.197.129 with SMTP id n1mr190994683pld.30.1481593262603;
        Mon, 12 Dec 2016 17:41:02 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:642c:37a4:3709:a2b3])
        by smtp.gmail.com with ESMTPSA id t20sm78177500pfk.48.2016.12.12.17.41.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Dec 2016 17:41:02 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, David.Turner@twosigma.com, bmwill@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/6] submodule: add flags to ok_to_remove_submodule
Date:   Mon, 12 Dec 2016 17:40:52 -0800
Message-Id: <20161213014055.14268-4-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.35.g26e18c9
In-Reply-To: <20161213014055.14268-1-sbeller@google.com>
References: <20161213014055.14268-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In different contexts the question whether deleting a submodule is ok
to remove may be answered differently.

In 293ab15eea (submodule: teach rm to remove submodules unless they
contain a git directory, 2012-09-26) a case was made that we can safely
ignore ignored untracked files for removal as we explicitely ask for the
removal of the submodule.

In a later patch we want to remove submodules even when the user doesn't
explicitly ask for it (e.g. checking out a tree-ish in which the submodule
doesn't exist).  In that case we want to be more careful when it comes
to deletion of untracked files. As of this patch it is unclear how this
will be implemented exactly, so we'll offer flags in which the caller
can specify how the different untracked files ought to be handled.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/rm.c |  3 ++-
 submodule.c  | 23 +++++++++++++++++++----
 submodule.h  |  5 ++++-
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 3f3e24eb36..fdd7183f61 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -187,7 +187,8 @@ static int check_local_mod(struct object_id *head, int index_only)
 		 */
 		if (ce_match_stat(ce, &st, 0) ||
 		    (S_ISGITLINK(ce->ce_mode) &&
-		     !ok_to_remove_submodule(ce->name)))
+		     !ok_to_remove_submodule(ce->name,
+				SUBMODULE_REMOVAL_IGNORE_IGNORED_UNTRACKED)))
 			local_changes = 1;
 
 		/*
diff --git a/submodule.c b/submodule.c
index 9f0b544ebe..2d13744b06 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1019,7 +1019,7 @@ int submodule_uses_gitfile(const char *path)
 	return 1;
 }
 
-int ok_to_remove_submodule(const char *path)
+int ok_to_remove_submodule(const char *path, unsigned flags)
 {
 	ssize_t len;
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -1032,15 +1032,27 @@ int ok_to_remove_submodule(const char *path)
 	if (!submodule_uses_gitfile(path))
 		return 0;
 
-	argv_array_pushl(&cp.args, "status", "--porcelain", "-u",
+	argv_array_pushl(&cp.args, "status", "--porcelain",
 				   "--ignore-submodules=none", NULL);
+
+	if (flags & SUBMODULE_REMOVAL_IGNORE_UNTRACKED)
+		argv_array_push(&cp.args, "-uno");
+	else
+		argv_array_push(&cp.args, "-uall");
+
+	if (!(flags & SUBMODULE_REMOVAL_IGNORE_IGNORED_UNTRACKED))
+		argv_array_push(&cp.args, "--ignored");
+
 	prepare_submodule_repo_env(&cp.env_array);
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
 	cp.out = -1;
 	cp.dir = path;
 	if (start_command(&cp))
-		die(_("could not run 'git status --porcelain -u --ignore-submodules=none' in submodule %s"), path);
+		die(_("could not run 'git status --porcelain --ignore-submodules=none %s %s' in submodule '%s'"),
+			(flags & SUBMODULE_REMOVAL_IGNORE_UNTRACKED) ? "-uno" : "-uall",
+			(!(flags & SUBMODULE_REMOVAL_IGNORE_IGNORED_UNTRACKED)) ? "--ignored" : "",
+			path);
 
 	len = strbuf_read(&buf, cp.out, 1024);
 	if (len > 2)
@@ -1048,7 +1060,10 @@ int ok_to_remove_submodule(const char *path)
 	close(cp.out);
 
 	if (finish_command(&cp))
-		die(_("'git status --porcelain -u --ignore-submodules=none' failed in submodule %s"), path);
+		die(_("'git status --porcelain --ignore-submodules=none %s %s' failed in submodule '%s'"),
+			(flags & SUBMODULE_REMOVAL_IGNORE_UNTRACKED) ? "-uno" : "-uall",
+			(!(flags & SUBMODULE_REMOVAL_IGNORE_IGNORED_UNTRACKED)) ? "--ignored" : "",
+			path);
 
 	strbuf_release(&buf);
 	return ok_to_remove;
diff --git a/submodule.h b/submodule.h
index 61fb610749..3ed3aa479a 100644
--- a/submodule.h
+++ b/submodule.h
@@ -59,7 +59,10 @@ extern int fetch_populated_submodules(const struct argv_array *options,
 			       int quiet, int max_parallel_jobs);
 extern unsigned is_submodule_modified(const char *path, int ignore_untracked);
 extern int submodule_uses_gitfile(const char *path);
-extern int ok_to_remove_submodule(const char *path);
+
+#define SUBMODULE_REMOVAL_IGNORE_UNTRACKED (1<<0)
+#define SUBMODULE_REMOVAL_IGNORE_IGNORED_UNTRACKED (1<<1)
+extern int ok_to_remove_submodule(const char *path, unsigned flags);
 extern int merge_submodule(unsigned char result[20], const char *path,
 			   const unsigned char base[20],
 			   const unsigned char a[20],
-- 
2.11.0.rc2.35.g7af3268

