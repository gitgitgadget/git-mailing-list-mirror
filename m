From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [RFC/PATCH] Add the NO_SENTINEL build variable
Date: Mon, 15 Jul 2013 18:38:22 +0100
Message-ID: <51E4338E.4090003@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 15 19:53:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uymxs-0003Ds-Ti
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 19:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753536Ab3GORxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 13:53:30 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:49047 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753516Ab3GORx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 13:53:28 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 2521C1280C8;
	Mon, 15 Jul 2013 18:53:27 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 048DB1280A8;
	Mon, 15 Jul 2013 18:53:26 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP;
	Mon, 15 Jul 2013 18:53:25 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230501>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Jeff,

One of the three gcc compilers that I use does not understand the
sentinel function attribute. (so, it spews 108 warning messages)

Is this, or something like it, too ugly for you to squash into
your patch? :-D

ATB,
Ramsay Jones


 Makefile          | 6 ++++++
 argv-array.h      | 2 +-
 builtin/revert.c  | 4 ++--
 exec_cmd.h        | 2 +-
 git-compat-util.h | 6 ++++++
 run-command.h     | 2 +-
 6 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 9c0da06..63b539c 100644
--- a/Makefile
+++ b/Makefile
@@ -224,6 +224,9 @@ all::
 # Define NO_NORETURN if using buggy versions of gcc 4.6+ and profile feedback,
 # as the compiler can crash (http://gcc.gnu.org/bugzilla/show_bug.cgi?id=49299)
 #
+# Define NO_SENTINEL if you have a compiler which does not understand the
+# sentinel function attribute.
+#
 # Define USE_NSEC below if you want git to care about sub-second file mtimes
 # and ctimes. Note that you need recent glibc (at least 2.2.4) for this, and
 # it will BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely
@@ -1232,6 +1235,9 @@ endif
 ifdef NO_NORETURN
 	BASIC_CFLAGS += -DNO_NORETURN
 endif
+ifdef NO_SENTINEL
+	BASIC_CFLAGS += -DNO_SENTINEL
+endif
 ifdef NO_NSEC
 	BASIC_CFLAGS += -DNO_NSEC
 endif
diff --git a/argv-array.h b/argv-array.h
index e805748..31bc492 100644
--- a/argv-array.h
+++ b/argv-array.h
@@ -15,7 +15,7 @@ void argv_array_init(struct argv_array *);
 void argv_array_push(struct argv_array *, const char *);
 __attribute__((format (printf,2,3)))
 void argv_array_pushf(struct argv_array *, const char *fmt, ...);
-__attribute__((sentinel))
+SENTINEL(0)
 void argv_array_pushl(struct argv_array *, ...);
 void argv_array_pop(struct argv_array *);
 void argv_array_clear(struct argv_array *);
diff --git a/builtin/revert.c b/builtin/revert.c
index b8b5174..6aedc18 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -54,7 +54,7 @@ static int option_parse_x(const struct option *opt,
 	return 0;
 }
 
-__attribute__((sentinel))
+SENTINEL(0)
 static void verify_opt_compatible(const char *me, const char *base_opt, ...)
 {
 	const char *this_opt;
@@ -71,7 +71,7 @@ static void verify_opt_compatible(const char *me, const char *base_opt, ...)
 		die(_("%s: %s cannot be used with %s"), me, this_opt, base_opt);
 }
 
-__attribute__((sentinel))
+SENTINEL(0)
 static void verify_opt_mutually_compatible(const char *me, ...)
 {
 	const char *opt1, *opt2 = NULL;
diff --git a/exec_cmd.h b/exec_cmd.h
index 307b55c..75c0a82 100644
--- a/exec_cmd.h
+++ b/exec_cmd.h
@@ -7,7 +7,7 @@ extern const char *git_exec_path(void);
 extern void setup_path(void);
 extern const char **prepare_git_cmd(const char **argv);
 extern int execv_git_cmd(const char **argv); /* NULL terminated */
-__attribute__((sentinel))
+SENTINEL(0)
 extern int execl_git_cmd(const char *cmd, ...);
 extern const char *system_path(const char *path);
 
diff --git a/git-compat-util.h b/git-compat-util.h
index 9f1eaca..e846e01 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -300,6 +300,12 @@ extern char *gitbasename(char *);
 #endif
 #endif
 
+#if defined(__GNUC__) && !defined(NO_SENTINEL)
+#define SENTINEL(n) __attribute__((sentinel(n)))
+#else
+#define SENTINEL(n)
+#endif
+
 #include "compat/bswap.h"
 
 #ifdef USE_WILDMATCH
diff --git a/run-command.h b/run-command.h
index 0a47679..8e75671 100644
--- a/run-command.h
+++ b/run-command.h
@@ -46,7 +46,7 @@ int finish_command(struct child_process *);
 int run_command(struct child_process *);
 
 extern char *find_hook(const char *name);
-__attribute__((sentinel))
+SENTINEL(0)
 extern int run_hook(const char *index_file, const char *name, ...);
 
 #define RUN_COMMAND_NO_STDIN 1
-- 
1.8.3
