Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D01C9209B5
	for <e@80x24.org>; Tue, 13 Dec 2016 20:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941138AbcLMU5k (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 15:57:40 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35505 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935220AbcLMU5f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 15:57:35 -0500
Received: by mail-pg0-f46.google.com with SMTP id p66so51341112pga.2
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 12:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b9BAMiRyf9pQVl7mVh4f5Ax9QHoACuEqJaeSnPusOo8=;
        b=gGpUZz//vy3yVgz+Q/bQfp3nwPEB40C7CFkxJLfHpup5tOKuC6sYqcJWt3r8Fl9alh
         vWVWFv11plpJtiV8gABhAqOE5pX6StJBpMB17Q3RkO6h10KlDWcgXwzr6v0LlFfTenTz
         Mxip2Qf4faYBYavsA2p+02bhPKk4DIz9UM9XonNqWknONV2sh1RWTjDA8P94uAeBs3ME
         Al2ff51FfXkm9O6i7Mw6suT1Dvju4yUPJL6Yi3h31JXjYo/n+mabssMDafXLmgCKZjZt
         OmjPGFcnzQUzBhRV6+gotMNQQmnYXaDYL2sGyeN5075SFLr/qM2rOAjHZtzexF5GILLj
         DhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b9BAMiRyf9pQVl7mVh4f5Ax9QHoACuEqJaeSnPusOo8=;
        b=NC4rICzJxNs9f4D8IIw05d4vnaBJ4Do+nDQLE4OfDE2y239gJm3iYwU/NXItvVJSm2
         PcmJecgXlmNKXpXpOToH1FTAKXQS0ATkLYYYOh7FUHJNT/F3um0Y/tDDPE04vgk225PG
         Idl30bEFOB+2RgKQG/BoH8LqVbMUnVk1zm1di0KL5Yrmwzh4dlws1GUPlc8WiJfok3TW
         QX5mVKGWUT5uM//HhAr/251dD9KStYMD3REFnLAH6/6uoWb1ql/AyoAQaamFPiKsbJKd
         aj1CUWj91Px8oOMW8xA2Xst/yjK3cHpCEJ/eTkJyc9fkKuSOhfHI54XGEbvlF68rLZ21
         q3aA==
X-Gm-Message-State: AKaTC031vZGi2T8Pe4VF3RlJwoPXcSI2Jw/+brdu5HwQxt0c2rW7bu0hCmD5jmzC2yVHG/uq
X-Received: by 10.84.211.144 with SMTP id c16mr200881785pli.37.1481662593620;
        Tue, 13 Dec 2016 12:56:33 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:5b5:8785:ab45:d22f])
        by smtp.gmail.com with ESMTPSA id m5sm82392371pgn.42.2016.12.13.12.56.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Dec 2016 12:56:33 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, David.Turner@twosigma.com, bmwill@google.com,
        sandals@crustytoothpaste.net, Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 3/5] submodule: add flags to ok_to_remove_submodule
Date:   Tue, 13 Dec 2016 12:56:20 -0800
Message-Id: <20161213205622.841-4-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.35.g26e18c9
In-Reply-To: <20161213205622.841-1-sbeller@google.com>
References: <20161213205622.841-1-sbeller@google.com>
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

