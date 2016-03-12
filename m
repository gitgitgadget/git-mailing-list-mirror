From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/RFC/GSoC 10/17] rebase-common: implement cache_has_uncommitted_changes()
Date: Sat, 12 Mar 2016 18:46:30 +0800
Message-ID: <1457779597-6918-11-git-send-email-pyokagan@gmail.com>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>, sam.halliday@gmail.com,
	Paul Tan <pyokagan@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 12 11:47:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeh5I-0006B3-Um
	for gcvg-git-2@plane.gmane.org; Sat, 12 Mar 2016 11:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634AbcCLKrh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2016 05:47:37 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33147 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752541AbcCLKrc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2016 05:47:32 -0500
Received: by mail-pa0-f53.google.com with SMTP id fl4so118964638pad.0
        for <git@vger.kernel.org>; Sat, 12 Mar 2016 02:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wZ6pbQ1/uNQJUWdb6QxO5xt5Y1KNCPf+4QiWKOi8VrY=;
        b=rT9AIef6hLZdRP3Sw3O3YYM8Q7Wz6aQCLsvKoGG2TsVg2HqhBGZhq3+oOI8AEF4uvh
         VSrvVe0GY5qFScbQVCiAcrMjBcmYPm+hcODvGbZJnKphcmsNtxL3UfgLrSUOx/3A64io
         EA0ijk3MHm37gd+JE10ls9/7udMBxOAEKWMKrjR8s9YGOUvWVtVzRXvwFL7ZOhCp3pXi
         c0KbgwZWocyvUERwsF851UnsmzevPgvyPiWIiwZhSWx0RoATM0fiSYpUHvdYTluxdvAG
         v5OOmvQfSta2YbwQ+a/2ci08UbyFXAHwPV/RbGPnmz0plmROFlfb1UJkkkEkWE81MtQg
         pU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wZ6pbQ1/uNQJUWdb6QxO5xt5Y1KNCPf+4QiWKOi8VrY=;
        b=BfM6EMf947QAIXFnPQXUMTP3zdlwP4KnhMwJwFmG4IGRyZQvxJ0MR4iLRxdzJDjwE0
         +Jmd1gkfCuDY48Ne+FM4VoWi3gGuB3pP6fGpKTOxU/gOIb6sfeqIQ1vbp5m7t8L7DZr3
         IQS30c0eHmzBnsJbY9/q37na3FdNAwfN10sGu2io5xgTC3U50odfB+jNe+ODh64oRWFe
         cwXyFLKUnh6P75AVbMlzsDZVHPepYlnz/Nj6iyox1NWLrpS0UitCtV1V8l1RTW5V0Sei
         AAyGITdUeHNO7hIt5p5asxuH/uTzGGAOzE5KFsiD0sLQ1DDx5K+wu1OFv7CyPbkseGQq
         GD8w==
X-Gm-Message-State: AD7BkJLcILgS9lzbXehrT2f18D+N85dFb3vEASboqVf8fd152NR9VOW1chSkVhc99OpHkw==
X-Received: by 10.66.221.167 with SMTP id qf7mr22701263pac.94.1457779646009;
        Sat, 12 Mar 2016 02:47:26 -0800 (PST)
Received: from yoshi.chippynet.com ([116.86.77.230])
        by smtp.gmail.com with ESMTPSA id tb10sm18983519pab.22.2016.03.12.02.47.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 12 Mar 2016 02:47:25 -0800 (PST)
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288742>

In the upcoming git-rebase-to-C rewrite, it is a common opertation to
check if the index has uncommitted changes, so that rebase can complain
that the index is dirty, or commit the uncommitted changes in the index.

builtin/pull.c already implements the function we want. Move it to
rebase-common.c so that it can be shared between all rebase backends and
git-pull.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/pull.c  | 22 +---------------------
 rebase-common.c | 17 +++++++++++++++++
 rebase-common.h |  5 +++++
 3 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 9e65dc9..6be4213 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -307,26 +307,6 @@ static enum rebase_type config_get_rebase(void)
 }
 
 /**
- * Returns 1 if there are uncommitted changes, 0 otherwise.
- */
-static int has_uncommitted_changes(const char *prefix)
-{
-	struct rev_info rev_info;
-	int result;
-
-	if (is_cache_unborn())
-		return 0;
-
-	init_revisions(&rev_info, prefix);
-	DIFF_OPT_SET(&rev_info.diffopt, IGNORE_SUBMODULES);
-	DIFF_OPT_SET(&rev_info.diffopt, QUICK);
-	add_head_to_pending(&rev_info);
-	diff_setup_done(&rev_info.diffopt);
-	result = run_diff_index(&rev_info, 1);
-	return diff_result_code(&rev_info.diffopt, result);
-}
-
-/**
  * If the work tree has unstaged or uncommitted changes, dies with the
  * appropriate message.
  */
@@ -345,7 +325,7 @@ static void die_on_unclean_work_tree(const char *prefix)
 		do_die = 1;
 	}
 
-	if (has_uncommitted_changes(prefix)) {
+	if (cache_has_uncommitted_changes()) {
 		if (do_die)
 			error(_("Additionally, your index contains uncommitted changes."));
 		else
diff --git a/rebase-common.c b/rebase-common.c
index 61be8f1..94783a9 100644
--- a/rebase-common.c
+++ b/rebase-common.c
@@ -29,6 +29,23 @@ int cache_has_unstaged_changes(void)
 	return diff_result_code(&rev_info.diffopt, result);
 }
 
+int cache_has_uncommitted_changes(void)
+{
+	struct rev_info rev_info;
+	int result;
+
+	if (is_cache_unborn())
+		return 0;
+
+	init_revisions(&rev_info, NULL);
+	DIFF_OPT_SET(&rev_info.diffopt, IGNORE_SUBMODULES);
+	DIFF_OPT_SET(&rev_info.diffopt, QUICK);
+	add_head_to_pending(&rev_info);
+	diff_setup_done(&rev_info.diffopt);
+	result = run_diff_index(&rev_info, 1);
+	return diff_result_code(&rev_info.diffopt, result);
+}
+
 void rebase_options_init(struct rebase_options *opts)
 {
 	oidclr(&opts->onto);
diff --git a/rebase-common.h b/rebase-common.h
index 9d14e25..97d9a5b 100644
--- a/rebase-common.h
+++ b/rebase-common.h
@@ -11,6 +11,11 @@ void refresh_and_write_cache(unsigned int);
  */
 int cache_has_unstaged_changes(void);
 
+/**
+ * Returns 1 if there are uncommitted changes, 0 otherwise.
+ */
+int cache_has_uncommitted_changes(void);
+
 /* common rebase backend options */
 struct rebase_options {
 	struct object_id onto;
-- 
2.7.0
