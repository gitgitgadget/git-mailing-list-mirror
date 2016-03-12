From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/RFC/GSoC 09/17] rebase-common: implement cache_has_unstaged_changes()
Date: Sat, 12 Mar 2016 18:46:29 +0800
Message-ID: <1457779597-6918-10-git-send-email-pyokagan@gmail.com>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>, sam.halliday@gmail.com,
	Paul Tan <pyokagan@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 12 11:47:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeh55-0005yz-HA
	for gcvg-git-2@plane.gmane.org; Sat, 12 Mar 2016 11:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752572AbcCLKra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2016 05:47:30 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35078 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752541AbcCLKrY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2016 05:47:24 -0500
Received: by mail-pa0-f51.google.com with SMTP id td3so92368883pab.2
        for <git@vger.kernel.org>; Sat, 12 Mar 2016 02:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8UaoHIi1SAzeQN2lpesNMAvuToL3gB3mv9LMGM14qSk=;
        b=ztl6UiOWPhXkAqB8DS40xJBcQe/t/CfTd1r5MTdMi/CY8SmgUif73SZu8500FtQLf0
         SA/zbLxiJ0nG3S+dezfpNXV4h0NlUNq4AVaA1tkQmqQQ1W2U6fO4ubtvPwFGHVoHMQfG
         4TOpFwHqaO3eUkEAi2iaT76H/V/wrxVTFnkXZjf18rycnYRQWMUXo5NTz7tcBqTPoKoL
         e16gTiX4VDmpbOSI23dXpoTclvv+FOIJ2/Hoz2qpGbLi509l1A0ug8U1wbxw+SJIeqQS
         IKXqAkhk4rTUX1667WZoiHLP8wvQx0kHOrh4BcRJS73TagpbgwRQxcepjQMRpNVX76H1
         GWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8UaoHIi1SAzeQN2lpesNMAvuToL3gB3mv9LMGM14qSk=;
        b=VuytEndobZysWZkS9k9X3VhOidqmZfz6jBrjMLNm+viCU6B/YHjbsDG/haQswrzNF4
         RSm7BYhw96g9H2UvM+MoIFaOTpyaYYEcv6FpO8rKXA7WiHXFOmKe/f9wjijurJ1Za/kq
         +6toYfRxSh2BRRsUiL5cv+8iFwy9Ra6Ip/AE4/qh1xfCicFDuG3Iz6arcMFe6VtOA17P
         5d8hHS0YsDwpEdFICnn3Wv9Sr3EJpFbUTwFZ6eGitN7gHZs68kB80XmzFIWBCIiVvqJk
         JcIXqgny6R+UxnMeC7moBUIInDINw/KwqsnZwVovo6THp2d1PpD5YOa5Q46xxyyAqyGW
         mqaA==
X-Gm-Message-State: AD7BkJJ9JhnlXjL61AKIoXtc3cOJ6wr5IfzJryBW8Yr4LY7dAPyE4AtRFAIjFVKavvjKng==
X-Received: by 10.66.90.136 with SMTP id bw8mr22776694pab.52.1457779643035;
        Sat, 12 Mar 2016 02:47:23 -0800 (PST)
Received: from yoshi.chippynet.com ([116.86.77.230])
        by smtp.gmail.com with ESMTPSA id tb10sm18983519pab.22.2016.03.12.02.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 12 Mar 2016 02:47:21 -0800 (PST)
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288739>

In the upcoming git-rebase-to-C rewrite, it is a common operation to
check if the worktree has unstaged changes, so that it can complain that
the worktree is dirty.

builtin/pull.c already implements this function. Move it to
rebase-common.c so that it can be shared between all rebase backends and
git-pull.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/pull.c  | 19 ++-----------------
 rebase-common.c | 14 ++++++++++++++
 rebase-common.h |  5 +++++
 3 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 10eff03..9e65dc9 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -17,6 +17,7 @@
 #include "revision.h"
 #include "tempfile.h"
 #include "lockfile.h"
+#include "rebase-common.h"
 
 enum rebase_type {
 	REBASE_INVALID = -1,
@@ -306,22 +307,6 @@ static enum rebase_type config_get_rebase(void)
 }
 
 /**
- * Returns 1 if there are unstaged changes, 0 otherwise.
- */
-static int has_unstaged_changes(const char *prefix)
-{
-	struct rev_info rev_info;
-	int result;
-
-	init_revisions(&rev_info, prefix);
-	DIFF_OPT_SET(&rev_info.diffopt, IGNORE_SUBMODULES);
-	DIFF_OPT_SET(&rev_info.diffopt, QUICK);
-	diff_setup_done(&rev_info.diffopt);
-	result = run_diff_files(&rev_info, 0);
-	return diff_result_code(&rev_info.diffopt, result);
-}
-
-/**
  * Returns 1 if there are uncommitted changes, 0 otherwise.
  */
 static int has_uncommitted_changes(const char *prefix)
@@ -355,7 +340,7 @@ static void die_on_unclean_work_tree(const char *prefix)
 	update_index_if_able(&the_index, lock_file);
 	rollback_lock_file(lock_file);
 
-	if (has_unstaged_changes(prefix)) {
+	if (cache_has_unstaged_changes()) {
 		error(_("Cannot pull with rebase: You have unstaged changes."));
 		do_die = 1;
 	}
diff --git a/rebase-common.c b/rebase-common.c
index 97b0687..61be8f1 100644
--- a/rebase-common.c
+++ b/rebase-common.c
@@ -4,6 +4,7 @@
 #include "run-command.h"
 #include "refs.h"
 #include "lockfile.h"
+#include "revision.h"
 
 void refresh_and_write_cache(unsigned int flags)
 {
@@ -15,6 +16,19 @@ void refresh_and_write_cache(unsigned int flags)
 		die(_("unable to write index file"));
 }
 
+int cache_has_unstaged_changes(void)
+{
+	struct rev_info rev_info;
+	int result;
+
+	init_revisions(&rev_info, NULL);
+	DIFF_OPT_SET(&rev_info.diffopt, IGNORE_SUBMODULES);
+	DIFF_OPT_SET(&rev_info.diffopt, QUICK);
+	diff_setup_done(&rev_info.diffopt);
+	result = run_diff_files(&rev_info, 0);
+	return diff_result_code(&rev_info.diffopt, result);
+}
+
 void rebase_options_init(struct rebase_options *opts)
 {
 	oidclr(&opts->onto);
diff --git a/rebase-common.h b/rebase-common.h
index 4586f03..9d14e25 100644
--- a/rebase-common.h
+++ b/rebase-common.h
@@ -6,6 +6,11 @@
  */
 void refresh_and_write_cache(unsigned int);
 
+/**
+ * Returns 1 if there are unstaged changes, 0 otherwise.
+ */
+int cache_has_unstaged_changes(void);
+
 /* common rebase backend options */
 struct rebase_options {
 	struct object_id onto;
-- 
2.7.0
