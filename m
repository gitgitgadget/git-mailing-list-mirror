Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 981981FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 22:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934729AbcLNWlQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 17:41:16 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35296 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933465AbcLNWlM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 17:41:12 -0500
Received: by mail-pg0-f52.google.com with SMTP id p66so12504854pga.2
        for <git@vger.kernel.org>; Wed, 14 Dec 2016 14:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b9BAMiRyf9pQVl7mVh4f5Ax9QHoACuEqJaeSnPusOo8=;
        b=MsXft6iofdLlZjWZbX0U2vBjVekCPcJ5KNpd1C7EIHviTQ9rj1tFbNzTbJunhGL+hT
         UkXCcxoLTgoFHFAYRlVq9kDFeNi9W+dl8cG+aZLiooWH2DwViSvfdywqbZsi6DViP3w9
         awO8D8sIa1uwhm97OxKpH8BGe3vujS+pMnqN8QIlJWzkZ8kmVc6ksbxWPpXHjhphcGiR
         ECy+rVKEN66wALUzagqahl2oV0arGMO0N3yoH1isfl2v5lvxUVCk4eKI2tqhOYfzxytx
         LIiZuzFdijSkwzaLAkhFTblqhHp4yc1Vp6ytLQ2ol15g7n6dhgAYY7GqTJWDiiuKWWuq
         nRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b9BAMiRyf9pQVl7mVh4f5Ax9QHoACuEqJaeSnPusOo8=;
        b=TSzgBGEaVW8Xg4lezBbmaeRffP1iaFF1eTSNHmyG+yAQWZQ2y75EJTsuT+bly63tlo
         i83mRuqKAh3yRPnHr4UJoXctUjuOYz9FHvCUgneErQ21VBhPbz2e1rEn9S+u4NlAkFyY
         rh24+R7uTm6N8EJ+eLZR9AadNAYl8txcPOkES5NLs1152GfZ41BOFL+CoRDbenBQc2VJ
         i2iOS/WAA3wGIasqqinF4wNmQigFXjsJzdARjDoiGdIIPzdYiFei0pR15uphD76QVwZD
         4IRu0bAmKl70rEgvhtgUyLG6y0gxfOpdAqMGOFm8gEztg90gY9+Dr8367AJBNLBNrDFM
         LKhQ==
X-Gm-Message-State: AKaTC03KzyoJSH5OcB07HjrTO9fqzhtUr1sPZxF5ztseIsCKln6cCxQMUWBRVkw1rLB0yTXU
X-Received: by 10.99.135.200 with SMTP id i191mr187814767pge.18.1481755272129;
        Wed, 14 Dec 2016 14:41:12 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:8d0f:31e2:8611:d98a])
        by smtp.gmail.com with ESMTPSA id t193sm90231327pgb.4.2016.12.14.14.41.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 14 Dec 2016 14:41:11 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, David.Turner@twosigma.com, bmwill@google.com,
        sandals@crustytoothpaste.net, Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 3/4] submodule: add flags to ok_to_remove_submodule
Date:   Wed, 14 Dec 2016 14:41:00 -0800
Message-Id: <20161214224101.6211-4-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.35.g26e18c9
In-Reply-To: <20161214224101.6211-1-sbeller@google.com>
References: <20161214224101.6211-1-sbeller@google.com>
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
2.11.0.rc2.35.g26e18c9

