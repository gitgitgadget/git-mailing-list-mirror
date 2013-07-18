From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] Add the GIT_SENTINEL macro
Date: Thu, 18 Jul 2013 21:02:12 +0100
Message-ID: <51E849C4.7020305@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 18 22:29:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzuor-0004Ji-Er
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 22:28:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934320Ab3GRU2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 16:28:53 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:50068 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933559Ab3GRU2w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 16:28:52 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id BA77B1280B3;
	Thu, 18 Jul 2013 21:28:51 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 72C1D1280B6;
	Thu, 18 Jul 2013 21:28:50 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP;
	Thu, 18 Jul 2013 21:28:42 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230737>


The sentinel function attribute is not understood by versions of
the gcc compiler prior to v4.0. At present, for earlier versions
of gcc, the build issues 108 warnings related to the unknown
attribute. In order to suppress the warnings, we conditionally
define the GIT_SENTINEL macro to provide the sentinel attribute
for gcc v4.0 and newer.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

This was built on the next branch

ATB,
Ramsay Jones

 argv-array.h      | 2 +-
 builtin/revert.c  | 4 ++--
 exec_cmd.h        | 2 +-
 git-compat-util.h | 7 +++++++
 run-command.h     | 2 +-
 5 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/argv-array.h b/argv-array.h
index e805748..9a4c053 100644
--- a/argv-array.h
+++ b/argv-array.h
@@ -15,7 +15,7 @@ void argv_array_init(struct argv_array *);
 void argv_array_push(struct argv_array *, const char *);
 __attribute__((format (printf,2,3)))
 void argv_array_pushf(struct argv_array *, const char *fmt, ...);
-__attribute__((sentinel))
+GIT_SENTINEL(0)
 void argv_array_pushl(struct argv_array *, ...);
 void argv_array_pop(struct argv_array *);
 void argv_array_clear(struct argv_array *);
diff --git a/builtin/revert.c b/builtin/revert.c
index b8b5174..219f354 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -54,7 +54,7 @@ static int option_parse_x(const struct option *opt,
 	return 0;
 }
 
-__attribute__((sentinel))
+GIT_SENTINEL(0)
 static void verify_opt_compatible(const char *me, const char *base_opt, ...)
 {
 	const char *this_opt;
@@ -71,7 +71,7 @@ static void verify_opt_compatible(const char *me, const char *base_opt, ...)
 		die(_("%s: %s cannot be used with %s"), me, this_opt, base_opt);
 }
 
-__attribute__((sentinel))
+GIT_SENTINEL(0)
 static void verify_opt_mutually_compatible(const char *me, ...)
 {
 	const char *opt1, *opt2 = NULL;
diff --git a/exec_cmd.h b/exec_cmd.h
index 307b55c..fbbb44d 100644
--- a/exec_cmd.h
+++ b/exec_cmd.h
@@ -7,7 +7,7 @@ extern const char *git_exec_path(void);
 extern void setup_path(void);
 extern const char **prepare_git_cmd(const char **argv);
 extern int execv_git_cmd(const char **argv); /* NULL terminated */
-__attribute__((sentinel))
+GIT_SENTINEL(0)
 extern int execl_git_cmd(const char *cmd, ...);
 extern const char *system_path(const char *path);
 
diff --git a/git-compat-util.h b/git-compat-util.h
index ff193f4..cac8157 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -303,6 +303,13 @@ extern char *gitbasename(char *);
 #endif
 #endif
 
+/* The sentinel attribute is valid from gcc version 4.0 */
+#if defined(__GNUC__) && (__GNUC__ >= 4)
+#define GIT_SENTINEL(n) __attribute__((sentinel(n)))
+#else
+#define GIT_SENTINEL(n)
+#endif
+
 #include "compat/bswap.h"
 
 #ifdef USE_WILDMATCH
diff --git a/run-command.h b/run-command.h
index 0a47679..2f2b453 100644
--- a/run-command.h
+++ b/run-command.h
@@ -46,7 +46,7 @@ int finish_command(struct child_process *);
 int run_command(struct child_process *);
 
 extern char *find_hook(const char *name);
-__attribute__((sentinel))
+GIT_SENTINEL(0)
 extern int run_hook(const char *index_file, const char *name, ...);
 
 #define RUN_COMMAND_NO_STDIN 1
-- 
1.8.3
