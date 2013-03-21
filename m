From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH] Run git status in the background.
Date: Thu, 21 Mar 2013 13:29:28 +0100
Message-ID: <1363868968-19553-1-git-send-email-iveqy@iveqy.com>
Cc: artagnon@gmail.com, git@vger.kernel.org, peff@peff.net,
	pclouds@gmail.com, iveqy@iveqy.com
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Mar 21 13:28:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIebu-0005P7-Ru
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 13:28:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757902Ab3CUM2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 08:28:20 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:41685 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755580Ab3CUM2T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 08:28:19 -0400
Received: by mail-la0-f47.google.com with SMTP id fj20so5052497lab.34
        for <git@vger.kernel.org>; Thu, 21 Mar 2013 05:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=b8MuCDXqMEMFdDu017GukmXwnH4rbs8R1ibdt2KvtV4=;
        b=e+QxUUOJWp9JQl5cBgEH7/AF+wIuwxMGIRlPNZFR5z8+U260NXSKwZa8Cqzf+NtcIB
         OrOl2OAsh2No4woOAeEdeJCRv7MKERZkVxc5D2yrpr4xGdBSixckOZz3VFIhFfiG8L1w
         BRmXIdEr6r3B9Nmw1eGNjKdpm9aFjBY7VFbk58rmqhIPMSWvcOSCSAy4ji1439gvGws5
         agS0EiTQHXEIzdy4jsNimLqMcbPQSvJV5IhbePtaIVugZ723ujJsX2sXnaBf5i5r/7Ap
         6uiJNGZ6fFaXddtC5oUnw85ggKurUQfugRzWShadJ2pEHlfqUL1ojh5y4PF2auT7eXYT
         oPlQ==
X-Received: by 10.112.88.9 with SMTP id bc9mr11610546lbb.22.1363868893888;
        Thu, 21 Mar 2013 05:28:13 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPS id fq10sm1992150lbb.14.2013.03.21.05.28.12
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 21 Mar 2013 05:28:12 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UIecf-00055w-SK; Thu, 21 Mar 2013 13:29:33 +0100
X-Mailer: git-send-email 1.8.1.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218717>

If core.preload is set to a non-zero value, every time a git command is
executed, git status will be runned in the background if the value of
core.preload is lower than the number of seconds since last run.

Please see this thread:
http://article.gmane.org/gmane.comp.version-control.git/218587

This solution solves many of the problems discussed there, but
introduces new ones. For example, it does have a bigger impact.

With this solution beeing functional but a bit gross, it's not sure that
it should be placed here at all. However, it's a good place to place it
for all git-tools to be able to use it without knowing about it. (It
would speed up all git wrappers and not just bash-prompt like the
previous solution).

There's a few more things to address before shipping this if this is
considered a good approach. Such as:
	* Don't run if a "git status"-like git command has been runned. Or a
	  non-repo git command (lite git status or git help) is runned.
	* Better names for settings and files.
	* Better(?) invokation of git status (a forked internal call instead
	  of a system call?).

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
---
 git.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/git.c b/git.c
index 39ba6b1..829aa9c 100644
--- a/git.c
+++ b/git.c
@@ -231,6 +231,14 @@ static int handle_alias(int *argcp, const char ***argv)
 	return ret;
 }
 
+static int preload_rate = 0;
+static int preload_cb(const char *k, const char *v, void *cb)
+{
+	if (strcmp(k, "core.preload") == 0)
+		preload_rate = git_config_int(k, v);
+	return 0;
+}
+
 #define RUN_SETUP		(1<<0)
 #define RUN_SETUP_GENTLY	(1<<1)
 #define USE_PAGER		(1<<2)
@@ -278,6 +286,28 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 
 	trace_argv_printf(argv, "trace: built-in: git");
 
+	/* Check if we shall run git status in the background */
+	git_config(preload_cb, NULL);
+	if (preload_rate > 0) {
+		const char * git_dir = get_git_dir();
+		char lastrun[512];
+		strcpy(lastrun, git_dir);
+		strcat(lastrun, "/lastrun");
+
+		struct stat * lr = malloc(sizeof(struct stat));
+		stat(lastrun, lr);
+
+		if ((time(NULL) - lr->st_mtime) > preload_rate) {
+			system("git status > /dev/null 2>&1 &");
+			printf("RUN\n");
+		}
+
+		// This should be done for a few other commands as well.
+		// So that we don't spawn git-status if the user just runned that command.
+		FILE * touch = fopen(lastrun, "w");
+		fclose(touch);
+	}
+
 	status = p->fn(argc, argv, prefix);
 	if (status)
 		return status;
-- 
1.8.1.5
