From: Hitoshi Mitake <h.mitake@gmail.com>
Subject: [PATCH v0 2/2] git-less: git side support for git-less
Date: Fri, 23 Mar 2012 03:42:24 +0900
Message-ID: <1332441744-5142-3-git-send-email-h.mitake@gmail.com>
References: <1332441744-5142-1-git-send-email-h.mitake@gmail.com>
Cc: git@vger.kernel.org, Hitoshi Mitake <h.mitake@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 22 19:43:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAmya-0008Qp-P3
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 19:43:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758786Ab2CVSnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 14:43:01 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47559 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757089Ab2CVSm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 14:42:59 -0400
Received: by mail-pb0-f46.google.com with SMTP id un15so1796657pbc.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 11:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=sOuy/slijAdFjuVetkSCNLAH5a2+IIpdfxB8AZvVozs=;
        b=P/VmHz6J1HfZv1f9IQOBZABHtRTd3XJRf8K3AQ3akoLjefefYT3P8C4l6PIsT5w6eB
         nLo0PuQkn57v9rV27jGTjVh7x1U0SqQqmR9CkobERSVSeEVGMxb8hlPNUkQMQKxaFyVg
         ldu5D7MO6beFjTYNmNLMBokel3Fsx3GtYZfBpNz2mjpvmlgaXuB2alz9AjKQRns4xH7Q
         qGjpesHwuY71PmmBw0Nw60im9F73daFPEdcYpzD8TSa4/dx7tFFAnpzL977PZEXC/lGF
         aV2dT3/e9Wh2MQuK065WtXTWOarLkzYvK6T4gdRMVa3zC4PdMNLCW1qW0TWYYmW4Wlvk
         Mb0A==
Received: by 10.68.74.74 with SMTP id r10mr23012101pbv.83.1332441779697;
        Thu, 22 Mar 2012 11:42:59 -0700 (PDT)
Received: from localhost.localdomain (FL1-122-135-76-206.tky.mesh.ad.jp. [122.135.76.206])
        by mx.google.com with ESMTPS id b4sm4255081pbc.7.2012.03.22.11.42.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Mar 2012 11:42:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc1.29.g2a42
In-Reply-To: <1332441744-5142-1-git-send-email-h.mitake@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193678>

This patch modifies three parts of git.
1. git-log ... insert ETX(0x03) between each commit for the detection the boarder
   of commits by git-less.
2. pager selection ... current git uses single pager program for every command.
   I designed git-less for git-log so it is not suitable for other commands like
   git-grep, etc.
3. new configuration parameter for specifying git-less as a pager of git-log

(I think these three changes are one logical unit.)

The most important commit is 2. As described above, current git supports only
one pager and this is not good for git-less because git-less only assumes
git-log. So I modified setup_pager() in pager.c to separate pager selection
mechanism and pager setup mechanism.

As described in 3, git-log specific pager can be specified with the new string
typed parameter "log.pager". git-less can be set as the pager like this config:
[log]
	pager = git-less

The description of this new parameter is also added in the help of git-log.

Signed-off-by: Hitoshi Mitake <h.mitake@gmail.com>
---
 Documentation/git-log.txt |    6 +++++-
 builtin/log.c             |   32 ++++++++++++++++++++++++++++++++
 cache.h                   |    1 +
 pager.c                   |    9 ++++++---
 4 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 249fc87..f2e07f4 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -177,7 +177,11 @@ notes.displayRef::
 	or 'GIT_NOTES_REF', to read notes from when showing commit
 	messages with the 'log' family of commands.  See
 	linkgit:git-notes[1].
-+
+
+log.pager::
+       Pager program for git-log. Currently this option only assumes
+       "git-less".
+
 May be an unabbreviated ref name or a glob and may be specified
 multiple times.  A warning will be issued for refs that do not exist,
 but a glob that does not match any refs is silently ignored.
diff --git a/builtin/log.c b/builtin/log.c
index 8a47012..2ef3ada 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -88,6 +88,22 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 		rev->date_mode = parse_date_format(default_date_mode);
 }
 
+static int use_git_less;
+
+static int setup_log_pager(const char *myname)
+{
+	if (strcmp(myname, "log")) {
+		use_git_less = 0;
+		return 0;
+	}
+
+	if (!use_git_less)
+		return 0;
+
+	__setup_pager("git-less");
+	return 1;
+}
+
 static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 			 struct rev_info *rev, struct setup_revision_opt *opt)
 {
@@ -149,6 +165,10 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 		rev->show_decorations = 1;
 		load_ref_decorations(decoration_style);
 	}
+
+	if (setup_log_pager(argv[0]))
+		return;
+
 	setup_pager();
 }
 
@@ -314,6 +334,9 @@ static int cmd_log_walk(struct rev_info *rev)
 			saved_nrl = rev->diffopt.needed_rename_limit;
 		if (rev->diffopt.degraded_cc_to_c)
 			saved_dcctc = 1;
+
+		if (use_git_less)
+			printf("\003");
 	}
 	rev->diffopt.degraded_cc_to_c = saved_dcctc;
 	rev->diffopt.needed_rename_limit = saved_nrl;
@@ -349,6 +372,15 @@ static int git_log_config(const char *var, const char *value, void *cb)
 	}
 	if (!prefixcmp(var, "color.decorate."))
 		return parse_decorate_color_config(var, 15, value);
+	if (!strcmp(var, "log.pager")) {
+		if (!strcmp(value, "git-less")) {
+			use_git_less = 1;
+			return 0;
+		} else {
+			fprintf(stderr, "unknown pager for git-log: %s\n", value);
+			return -1;
+		}
+	}
 
 	return git_diff_ui_config(var, value, cb);
 }
diff --git a/cache.h b/cache.h
index e5e1aa4..e5e57ff 100644
--- a/cache.h
+++ b/cache.h
@@ -1185,6 +1185,7 @@ static inline ssize_t write_str_in_full(int fd, const char *str)
 
 /* pager.c */
 extern void setup_pager(void);
+extern void __setup_pager(const char *pager);
 extern const char *pager_program;
 extern int pager_in_use(void);
 extern int pager_use_color;
diff --git a/pager.c b/pager.c
index 05584de..45fe9ea 100644
--- a/pager.c
+++ b/pager.c
@@ -69,10 +69,8 @@ const char *git_pager(int stdout_is_tty)
 	return pager;
 }
 
-void setup_pager(void)
+void __setup_pager(const char *pager)
 {
-	const char *pager = git_pager(isatty(1));
-
 	if (!pager)
 		return;
 
@@ -110,6 +108,11 @@ void setup_pager(void)
 	atexit(wait_for_pager);
 }
 
+void setup_pager(void)
+{
+	__setup_pager(git_pager(isatty(1)));
+}
+
 int pager_in_use(void)
 {
 	const char *env;
-- 
1.7.10.rc1.33.g64ff3.dirty
