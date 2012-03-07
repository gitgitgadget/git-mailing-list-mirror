From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH v3 3/3] Use startup_info->prefix rather than prefix.
Date: Wed,  7 Mar 2012 17:21:27 -0500
Message-ID: <a2980b437f2eb81b6bc28ad4ebbf05429485729e.1331158240.git.jaredhance@gmail.com>
References: <cover.1331158240.git.jaredhance@gmail.com>
Cc: Jared Hance <jaredhance@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 07 23:21:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5PF1-000543-Re
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 23:21:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030554Ab2CGWVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 17:21:45 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:37079 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030404Ab2CGWVm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Mar 2012 17:21:42 -0500
Received: by mail-tul01m020-f174.google.com with SMTP id uo6so7476933obb.19
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 14:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=p2k3G8K3sfFLTDJ+xP1Q5x6B8EDxvbEeltt4Jz0h1hU=;
        b=S59F3w4qOcu5xvWETXDMe1UHTkzncibzmD1a5k6EnQQxjd5rF7tNU+zTnmrEOzuJwe
         AXYCOCEUfSG7E1JbvIiRw3LnmSlhmKEJGo96v3uPNFI/fx8S/Tf6l/iGtMW9PmzZMdpf
         49kVkqdTv9aTL93RpFtvSYP3HlxREBib4SboZdEV+olVcSSGtYAv/56Kjf4aZDusRWq7
         zAbD3dShBTxpcvRbhcyM1x5sPpXkZ1OW+ltIwvcuYT3OaFmz0lPGKDyneXA2EuLkoEEM
         KDdLWKnJJTqi0sEpDbJhehStyau57CoGNJ/+NMzC9kG03Vf68PaalpHAlE9Uxo0mKiCN
         +pFQ==
Received: by 10.60.9.232 with SMTP id d8mr1501880oeb.66.1331158902624;
        Wed, 07 Mar 2012 14:21:42 -0800 (PST)
Received: from localhost.localdomain (mail.middletownlibrary.org. [66.213.99.6])
        by mx.google.com with ESMTPS id gl4sm23853230obb.23.2012.03.07.14.21.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Mar 2012 14:21:41 -0800 (PST)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <cover.1331158240.git.jaredhance@gmail.com>
In-Reply-To: <cover.1331158240.git.jaredhance@gmail.com>
References: <cover.1331158240.git.jaredhance@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192495>

In trace_repo_setup, prefix is passed in as startup_info->prefix. But, as
indicated but a FIXME comment, trace_repo_setup has access to
startup_info. The prefix parameter has therefore been eliminated.

Signed-off-by: Jared Hance <jaredhance@gmail.com>
---
 cache.h |    2 +-
 git.c   |    2 +-
 trace.c |   10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index e5e1aa4..1113296 100644
--- a/cache.h
+++ b/cache.h
@@ -1213,7 +1213,7 @@ extern void trace_printf(const char *format, ...);
 extern void trace_vprintf(const char *key, const char *format, va_list ap);
 __attribute__((format (printf, 2, 3)))
 extern void trace_argv_printf(const char **argv, const char *format, ...);
-extern void trace_repo_setup(const char *prefix);
+extern void trace_repo_setup(void);
 extern int trace_want(const char *key);
 extern void trace_strbuf(const char *key, const struct strbuf *buf);
 
diff --git a/git.c b/git.c
index 3805616..7dcc527 100644
--- a/git.c
+++ b/git.c
@@ -296,7 +296,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 
 		if ((p->option & (RUN_SETUP | RUN_SETUP_GENTLY)) &&
 		    startup_info->have_repository) /* get_git_dir() may set up repo, avoid that */
-			trace_repo_setup(prefix);
+			trace_repo_setup();
 	}
 	commit_pager_choice();
 
diff --git a/trace.c b/trace.c
index d953416..09a470b 100644
--- a/trace.c
+++ b/trace.c
@@ -152,8 +152,7 @@ static const char *quote_crnl(const char *path)
 	return new_path;
 }
 
-/* FIXME: move prefix to startup_info struct and get rid of this arg */
-void trace_repo_setup(const char *prefix)
+void trace_repo_setup(void)
 {
 	static const char *key = "GIT_TRACE_SETUP";
 	const char *git_work_tree;
@@ -168,13 +167,14 @@ void trace_repo_setup(const char *prefix)
 	if (!(git_work_tree = get_git_work_tree()))
 		git_work_tree = "(null)";
 
-	if (!prefix)
-		prefix = "(null)";
+	if (!startup_info->prefix)
+		startup_info->prefix = "(null)";
 
 	trace_printf_key(key, "setup: git_dir: %s\n", quote_crnl(get_git_dir()));
 	trace_printf_key(key, "setup: worktree: %s\n", quote_crnl(git_work_tree));
 	trace_printf_key(key, "setup: cwd: %s\n", quote_crnl(cwd));
-	trace_printf_key(key, "setup: prefix: %s\n", quote_crnl(prefix));
+	trace_printf_key(key, "setup: prefix: %s\n",
+			 quote_crnl(startup_info->prefix));
 }
 
 int trace_want(const char *key)
-- 
1.7.3.4
