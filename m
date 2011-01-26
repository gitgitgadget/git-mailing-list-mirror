From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/3] setup: do not expose tracing code
Date: Tue, 25 Jan 2011 18:55:30 -0600
Message-ID: <20110126005530.GB11230@burratino>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
 <1290785563-15339-2-git-send-email-pclouds@gmail.com>
 <20110126004915.GA11230@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 01:55:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Phtfj-0002Lp-L1
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 01:55:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307Ab1AZAzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jan 2011 19:55:37 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:60657 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702Ab1AZAzh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jan 2011 19:55:37 -0500
Received: by qyj19 with SMTP id 19so5153366qyj.19
        for <git@vger.kernel.org>; Tue, 25 Jan 2011 16:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=sN6gkESs+G+jSyYVVNWawhjryaWgd9YHTnsL4IhvBH8=;
        b=FKhonIF07fspG79NAobfjMHUhREWKRTmIRXeLpTBZ/MA+Xaaa6+b9xcNwsBbh+XFM8
         VUokvUJIBRSBFdL2auFPhM7N34B+HqAI/UGbyzl8KfWXbZ34CPtejfLP5QTO4JCHbSd3
         FIaqDjAH7FTL3ouohxpVy3Vd6uPJbHnExnMa4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VhXhEB3fKQ5j7N2WsYxbkCwPVoljEXvCrXI+NSG06H2T0y9iU+rAj0XfCbDzMz1C0S
         NqJLRBqWpHDAY1vnnMi3mERi9NM5p/qk9WTeDflYRVTR0zpJsEaunOVNnvpWE/biWhVs
         oF/pCbfuyWB5PAJH50Y89EDbFWHJ77vPZBcbE=
Received: by 10.224.19.210 with SMTP id c18mr5805686qab.343.1296003336143;
        Tue, 25 Jan 2011 16:55:36 -0800 (PST)
Received: from burratino (adsl-69-209-75-28.dsl.chcgil.ameritech.net [69.209.75.28])
        by mx.google.com with ESMTPS id l12sm10635253qcu.7.2011.01.25.16.55.34
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 25 Jan 2011 16:55:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110126004915.GA11230@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165491>

The trace_repo_setup function has only one caller (run_builtin)
which lives in git.c.  Move the code there and stop advertising
it in cache.h.

This means it is likely to remain safe to use startup_info within
trace_repo_setup, since the trace_repo_setup function is only used
when running builtins.  Do so and drop the "prefix" parameter.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 cache.h |    1 -
 git.c   |   51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 trace.c |   49 -------------------------------------------------
 3 files changed, 50 insertions(+), 51 deletions(-)

diff --git a/cache.h b/cache.h
index d83d68c..2eb3ccc 100644
--- a/cache.h
+++ b/cache.h
@@ -1067,7 +1067,6 @@ __attribute__((format (printf, 1, 2)))
 extern void trace_printf(const char *format, ...);
 __attribute__((format (printf, 2, 3)))
 extern void trace_argv_printf(const char **argv, const char *format, ...);
-extern void trace_repo_setup(const char *prefix);
 
 /* convert.c */
 /* returns 1 if *dst was used */
diff --git a/git.c b/git.c
index 68334f6..d1b15f1 100644
--- a/git.c
+++ b/git.c
@@ -238,6 +238,55 @@ static int handle_alias(int *argcp, const char ***argv)
 	return ret;
 }
 
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
 const char git_version_string[] = GIT_VERSION;
 
 #define RUN_SETUP		(1<<0)
@@ -278,7 +327,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 
 		if ((p->option & (RUN_SETUP | RUN_SETUP_GENTLY)) &&
 		    startup_info->have_repository) /* get_git_dir() may set up repo, avoid that */
-			trace_repo_setup(prefix);
+			trace_repo_setup();
 	}
 	commit_pager_choice();
 
diff --git a/trace.c b/trace.c
index 35d388d..0fb2a2c 100644
--- a/trace.c
+++ b/trace.c
@@ -127,52 +127,3 @@ void trace_argv_printf(const char **argv, const char *fmt, ...)
 	if (need_close)
 		close(fd);
 }
-
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
-/* FIXME: move prefix to startup_info struct and get rid of this arg */
-void trace_repo_setup(const char *prefix)
-{
-	const char *git_work_tree;
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
-- 
1.7.4.rc3
