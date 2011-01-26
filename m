From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/3] trace: omit repository discovery report
Date: Tue, 25 Jan 2011 18:59:16 -0600
Message-ID: <20110126005916.GC11230@burratino>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
 <1290785563-15339-2-git-send-email-pclouds@gmail.com>
 <20110126004915.GA11230@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 01:59:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhtjM-0003eW-Ea
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 01:59:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673Ab1AZA7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jan 2011 19:59:23 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:33517 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435Ab1AZA7W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jan 2011 19:59:22 -0500
Received: by qyk12 with SMTP id 12so444332qyk.19
        for <git@vger.kernel.org>; Tue, 25 Jan 2011 16:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=OZn6kDa7FOdvPrh/HxhCHLECf54tA2+gj8NzbgW0ABY=;
        b=sk/QylE4HfC9SV800uVuInPsngw2P4zp8s0KBeqAsNuNHwXw8eayq9rP1liMDNf1ro
         jkLlc7KHFjSrz5Hq9ZM1I5aQYk3q6vSSx822keCS+SO1ceNcSZGxUNRW/Yzv4teUKRbg
         ZJYeCGuJeskzTAYrDkeXzHI74OlS5GZQHg+9o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fegLv3ZadRzTEXkvHvpqcCX0vuUesrpQjTBONvEUFJkEB5/10JyZM+xvXFWBPS4rYA
         iC/m9fijqe6+Ee95PKINELHO6sPmzRoLmDQhpPdnZ5Kvf0R8RBXY37j+F/0PJVIiDGbk
         KRwLqjGb6HZDonpkPxLLP5MlAxnKRMo772uEM=
Received: by 10.224.74.21 with SMTP id s21mr5983368qaj.141.1296003561921;
        Tue, 25 Jan 2011 16:59:21 -0800 (PST)
Received: from burratino (adsl-69-209-75-28.dsl.chcgil.ameritech.net [69.209.75.28])
        by mx.google.com with ESMTPS id p13sm10630726qcu.17.2011.01.25.16.59.20
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 25 Jan 2011 16:59:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110126004915.GA11230@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165493>

The run-command library advertises what process it is running through
the GIT_TRACE stream (see 575ba9d6, 2006-06-25) to provide context
during debugging for error messages that might come from the child
process.  In the same spirit, since v1.7.4-rc0~4^2~46 (builtins: print
setup info if repo is found, 2010-11-26) the repo-setup library prints
its result to GIT_TRACE, so the cwd, location of the git directory,
and so on are readily available during debug.

In practice, four extra lines of trace output per git process is too
much noise.  So stop printing repository discovery info except when
running tests.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 .gitignore            |    1 +
 Makefile              |    1 +
 git.c                 |   53 -------------------------------------------
 t/t1510-repo-setup.sh |    2 +-
 test-repo-setup.c     |   60 +++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 63 insertions(+), 54 deletions(-)
 create mode 100644 test-repo-setup.c

diff --git a/.gitignore b/.gitignore
index 3dd6ef7..e1fc557 100644
--- a/.gitignore
+++ b/.gitignore
@@ -173,6 +173,7 @@
 /test-obj-pool
 /test-parse-options
 /test-path-utils
+/test-repo-setup
 /test-run-command
 /test-sha1
 /test-sigchain
diff --git a/Makefile b/Makefile
index 775ee83..01cc5c0 100644
--- a/Makefile
+++ b/Makefile
@@ -427,6 +427,7 @@ TEST_PROGRAMS_NEED_X += test-match-trees
 TEST_PROGRAMS_NEED_X += test-obj-pool
 TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-path-utils
+TEST_PROGRAMS_NEED_X += test-repo-setup
 TEST_PROGRAMS_NEED_X += test-run-command
 TEST_PROGRAMS_NEED_X += test-sha1
 TEST_PROGRAMS_NEED_X += test-sigchain
diff --git a/git.c b/git.c
index d1b15f1..d532576 100644
--- a/git.c
+++ b/git.c
@@ -238,55 +238,6 @@ static int handle_alias(int *argcp, const char ***argv)
 	return ret;
 }
 
-static const char *quote_crnl(const char *path)
-{
-	static char new_path[PATH_MAX];
-	const char *p2 = path;
-	char *p1 = new_path;
-
-	if (!path)
-		return NULL;
-
-	while (*p2) {
-		switch (*p2) {
-		case '\\': *p1++ = '\\'; *p1++ = '\\'; break;
-		case '\n': *p1++ = '\\'; *p1++ = 'n'; break;
-		case '\r': *p1++ = '\\'; *p1++ = 'r'; break;
-		default:
-			*p1++ = *p2;
-		}
-		p2++;
-	}
-	*p1 = '\0';
-	return new_path;
-}
-
-static void trace_repo_setup(void)
-{
-	const char *git_work_tree;
-	const char *prefix = startup_info->prefix;
-	char cwd[PATH_MAX];
-	char *trace = getenv("GIT_TRACE");
-
-	if (!trace || !strcmp(trace, "") ||
-	    !strcmp(trace, "0") || !strcasecmp(trace, "false"))
-		return;
-
-	if (!getcwd(cwd, PATH_MAX))
-		die("Unable to get current working directory");
-
-	if (!(git_work_tree = get_git_work_tree()))
-		git_work_tree = "(null)";
-
-	if (!prefix)
-		prefix = "(null)";
-
-	trace_printf("setup: git_dir: %s\n", quote_crnl(get_git_dir()));
-	trace_printf("setup: worktree: %s\n", quote_crnl(git_work_tree));
-	trace_printf("setup: cwd: %s\n", quote_crnl(cwd));
-	trace_printf("setup: prefix: %s\n", quote_crnl(prefix));
-}
-
 const char git_version_string[] = GIT_VERSION;
 
 #define RUN_SETUP		(1<<0)
@@ -324,10 +275,6 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 			use_pager = check_pager_config(p->cmd);
 		if (use_pager == -1 && p->option & USE_PAGER)
 			use_pager = 1;
-
-		if ((p->option & (RUN_SETUP | RUN_SETUP_GENTLY)) &&
-		    startup_info->have_repository) /* get_git_dir() may set up repo, avoid that */
-			trace_repo_setup();
 	}
 	commit_pager_choice();
 
diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 15101d5..c2edf6f 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -57,7 +57,7 @@ test_repo () {
 			export GIT_WORK_TREE
 		fi &&
 		rm -f trace &&
-		GIT_TRACE="$(pwd)/trace" git symbolic-ref HEAD >/dev/null &&
+		GIT_TRACE="$(pwd)/trace" test-repo-setup &&
 		grep '^setup: ' trace >result &&
 		test_cmp expected result
 	)
diff --git a/test-repo-setup.c b/test-repo-setup.c
new file mode 100644
index 0000000..3b66237
--- /dev/null
+++ b/test-repo-setup.c
@@ -0,0 +1,60 @@
+#include "cache.h"
+
+static const char *quote_crnl(const char *path)
+{
+	static char new_path[PATH_MAX];
+	const char *p2 = path;
+	char *p1 = new_path;
+
+	if (!path)
+		return NULL;
+
+	while (*p2) {
+		switch (*p2) {
+		case '\\': *p1++ = '\\'; *p1++ = '\\'; break;
+		case '\n': *p1++ = '\\'; *p1++ = 'n'; break;
+		case '\r': *p1++ = '\\'; *p1++ = 'r'; break;
+		default:
+			*p1++ = *p2;
+		}
+		p2++;
+	}
+	*p1 = '\0';
+	return new_path;
+}
+
+static void trace_repo_setup(void)
+{
+	const char *git_work_tree;
+	const char *prefix = startup_info->prefix;
+	char cwd[PATH_MAX];
+	char *trace = getenv("GIT_TRACE");
+
+	if (!trace || !strcmp(trace, "") ||
+	    !strcmp(trace, "0") || !strcasecmp(trace, "false"))
+		return;
+
+	if (!getcwd(cwd, PATH_MAX))
+		die("Unable to get current working directory");
+
+	if (!(git_work_tree = get_git_work_tree()))
+		git_work_tree = "(null)";
+
+	if (!prefix)
+		prefix = "(null)";
+
+	trace_printf("setup: git_dir: %s\n", quote_crnl(get_git_dir()));
+	trace_printf("setup: worktree: %s\n", quote_crnl(git_work_tree));
+	trace_printf("setup: cwd: %s\n", quote_crnl(cwd));
+	trace_printf("setup: prefix: %s\n", quote_crnl(prefix));
+}
+
+int main(int argc, char **argv)
+{
+	static struct startup_info test_startup_info;
+
+	startup_info = &test_startup_info;
+	setup_git_directory();
+	trace_repo_setup();
+	return 0;
+}
-- 
1.7.4.rc3
