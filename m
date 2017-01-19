Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7733A20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 19:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754419AbdASTa3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 14:30:29 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35689 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754320AbdASTa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 14:30:28 -0500
Received: by mail-pf0-f169.google.com with SMTP id f144so15725317pfa.2
        for <git@vger.kernel.org>; Thu, 19 Jan 2017 11:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jjRnWYFsmy1BJTNwwNcJDkIEf+0CLx//wB3HX0kPRtU=;
        b=hsw4chctT2rfAcJknO2Ij65PQxJnIB+6S608O1C3FqCCaLuWA6hOhYszjkK2K+WWuP
         3qqDJ7NAPBoB6UZp1Zl3p1DB8YqHhiqDKqlhwfsX2B9Z0BdaqEPLk6ZzPUILZ/UGHmEu
         04PnNxWL+wuwvwOmoUrISgPHGey27SvypChzj56xsU1G6viAOvb3IS0M+hPDqwF71I27
         Db4lk8GIsLc1d3/Ae5M3QmXJlt95SCpRb6vPonJgd8U9gKaLXOvftUgCCZVaGk/7dhj4
         eBc0e7gwCwoXHj199Y+bWSGfzPswh9mH0BllIYcdyvIq8w+ZGofWlCJWjCuolnIHp6Kw
         aAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jjRnWYFsmy1BJTNwwNcJDkIEf+0CLx//wB3HX0kPRtU=;
        b=rxOc+R0Ljx+i1TrTyBziUP7wsjRcmG1ynqomc+UB1DSR6TvkgIVXxqz+pDVKgVJ9+D
         vaHIQcDhaM/OBlHR4qbx6gvXxvO8sGXOUhsSHf/CdWGN5Vb4G0n+Rg/TbwNKxSOXyl6k
         f/Y9Qexbi4/44WQX+PrXxm37chHN8GteoGtgPPso96AAVyfjM6IB1bR8yzJ8sBb5pyGK
         0sQt3FWheuw/ipOd1UuOh1X4RjHx1BfO4jqUMutRJh2zljd7NwVp4tOxxoMtDg2kvV29
         jd3/5orHSYLtqb9xSfKBvOsINPRTNv3yKkIPBZce67EhsOHIrSMQatioD5UzKo3yat38
         iCww==
X-Gm-Message-State: AIkVDXLZK2vUMjvHYf8EDbGCNuyRmjgiO/MNoYOBZ94L2Hpzy5opw91DOaWfr/oHPWeIeE5a
X-Received: by 10.84.179.194 with SMTP id b60mr15729812plc.147.1484854227159;
        Thu, 19 Jan 2017 11:30:27 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:40e0:b9ca:546a:a0ec])
        by smtp.gmail.com with ESMTPSA id e189sm10696780pfg.64.2017.01.19.11.30.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 19 Jan 2017 11:30:26 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH] Disallow commands from within unpopulated submodules.
Date:   Thu, 19 Jan 2017 11:30:23 -0800
Message-Id: <20170119193023.26837-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.299.g762782ba8a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Consider you have a submodule at path "sub". What should happen in case
you run a command such as "git -C sub add ." ?

Here is what currently happens:
1) The submodule is populated, i.e. there is a .git (file/dir) inside
   "sub". This is equivalent of running "git add ." in the submodule and
   it behaves as you would expect, adding all files to the index.
2) The submodule is not populated or even not initialized.
   For quite some time we got
   $ git -C sub add .
   git: pathspec.c:317: prefix_pathspec: Assertion `item->nowildcard_len <= item->len && item->prefix <= item->len' failed.
   Aborted (core dumped)
   (This is fixed by another patch in flight to not assert,
    but rather die with a better message instead; but that patch is
    merely a fix of a corner case in the pathspec code.)

While 1) is rather uncontroversial, there are multiple things the user
may have intended with this command in 2):
 * add the submodule to the superproject
 * add all files inside the sub/ directory to the submodule or
   superproject.
It is unclear what the user intended, so rather error out instead.

Now let's ask the same question for "git -C sub status ." (which is a
command that is only reading and not writing to the repository)

1) If the submodule is populated, the user clearly intended to know
   more about the submodules status
2) It is unclear if the user wanted to learn about the submodules state
   (So ideally: "The submodule 'sub' is not initialized. To init ...")
   or the status check should be applied to the superproject instead.

Avoid the confusion in 2) as well and just error out for now. Later on
we may want to add another flag to git.c to allow commands to be run
inside unpopulated submodules and each command reacts appropriately.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

This is the next logical step after sb/pathspec-errors (pathspec:
give better message for submodule related pathspec error). If you are in
a path that is clearly a submodules, I would expect that most users would
expect the git operation to apply to the submodule.  In case of unpopulated
submodules, this is not the case though, but we apply the operation to the
superproject, which may be wrong or confusing.  Hence just error out for now.
Later we may want to add a flag that allows specific commands to run in such
a setup (e.g. git status could give a fancier message than a die(..)).

I marked this as RFC
* to request for comments if this is a good idea from a UI-perspective
* because I did not adapt any test for this patch. (A lot of submodule tests
  seem to break with this; From a cursory read of those tests, I'd rather
  blame the tests for being sloppy than this patch damaging user expectations)

Thanks,
Stefan

 git.c       |  3 +++
 submodule.c | 36 ++++++++++++++++++++++++++++++++++++
 submodule.h |  1 +
 3 files changed, 40 insertions(+)

diff --git a/git.c b/git.c
index bbaa949e9c..ca53b61474 100644
--- a/git.c
+++ b/git.c
@@ -2,6 +2,7 @@
 #include "exec_cmd.h"
 #include "help.h"
 #include "run-command.h"
+#include "submodule.h"
 
 const char git_usage_string[] =
 	"git [--version] [--help] [-C <path>] [-c name=value]\n"
@@ -364,6 +365,8 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 		if (prefix)
 			die("can't use --super-prefix from a subdirectory");
 	}
+	if (prefix)
+		check_prefix_inside_submodule(prefix);
 
 	if (!help && p->option & NEED_WORK_TREE)
 		setup_work_tree();
diff --git a/submodule.c b/submodule.c
index 73521cdbb2..357a22b804 100644
--- a/submodule.c
+++ b/submodule.c
@@ -495,6 +495,42 @@ void set_config_fetch_recurse_submodules(int value)
 	config_fetch_recurse_submodules = value;
 }
 
+/* check if the given prefix is inside an uninitialized submodule */
+void check_prefix_inside_submodule(const char *prefix)
+{
+	const char *work_tree = get_git_work_tree();
+	if (work_tree) {
+		int pos;
+		const struct cache_entry *in_submodule = NULL;
+
+		if (read_cache() < 0)
+			die("index file corrupt");
+		pos = cache_name_pos(prefix, strlen(prefix));
+		/*
+		 * gitlinks are recored with no ending '/' in the index,
+		 * but the prefix has an ending '/', so we will never find
+		 * an exact match, but always the position where we'd
+		 * insert the prefix.
+		 */
+		if (pos < 0) {
+			const struct cache_entry *ce;
+			int len = strlen(prefix);
+			/* Check the previous position */
+			pos = (-1 - pos) - 1;
+			ce = active_cache[pos];
+			if (ce->ce_namelen < len)
+				len = ce->ce_namelen;
+			if (!memcmp(ce->name, prefix, len))
+				in_submodule = ce;
+		} else
+			/* This case cannot happen because */
+			die("BUG: prefixes end with '/', but we do not record ending slashes in the index");
+
+		if (in_submodule)
+			die(_("command from inside unpopulated submodule '%s' not supported."), in_submodule->name);
+	}
+}
+
 static int has_remote(const char *refname, const struct object_id *oid,
 		      int flags, void *cb_data)
 {
diff --git a/submodule.h b/submodule.h
index b7576d6f43..6b30542822 100644
--- a/submodule.h
+++ b/submodule.h
@@ -30,6 +30,7 @@ struct submodule_update_strategy {
 };
 #define SUBMODULE_UPDATE_STRATEGY_INIT {SM_UPDATE_UNSPECIFIED, NULL}
 
+extern void check_prefix_inside_submodule(const char *prefix);
 int is_staging_gitmodules_ok(void);
 int update_path_in_gitmodules(const char *oldpath, const char *newpath);
 int remove_path_from_gitmodules(const char *path);
-- 
2.11.0.299.g762782ba8a

