From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] use "sentinel" function attribute for variadic lists
Date: Tue, 9 Jul 2013 20:19:12 -0400
Message-ID: <20130710001911.GB19423@sigill.intra.peff.net>
References: <20130710001659.GA11643@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Wed Jul 10 02:19:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwi7s-00060T-Pd
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 02:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753874Ab3GJATR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 20:19:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:43266 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753732Ab3GJATQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 20:19:16 -0400
Received: (qmail 25787 invoked by uid 102); 10 Jul 2013 00:20:32 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 09 Jul 2013 19:20:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Jul 2013 20:19:12 -0400
Content-Disposition: inline
In-Reply-To: <20130710001659.GA11643@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230018>

This attribute can help gcc notice when callers forget to
add a NULL sentinel to the end of the function. This is our
first use of the sentinel attribute, but we shouldn't need
to #ifdef for other compilers, as __attribute__ is already a
no-op on non-gcc-compatible compilers.

Suggested-by: Bert Wesarg <bert.wesarg@googlemail.com>
More-Spots-Found-By: Matt Kraai <kraai@ftbfs.org>
Signed-off-by: Jeff King <peff@peff.net>
---
 argv-array.h     | 1 +
 builtin/revert.c | 2 ++
 exec_cmd.h       | 1 +
 run-command.h    | 1 +
 4 files changed, 5 insertions(+)

diff --git a/argv-array.h b/argv-array.h
index 40248d4..e805748 100644
--- a/argv-array.h
+++ b/argv-array.h
@@ -15,6 +15,7 @@ void argv_array_pushf(struct argv_array *, const char *fmt, ...);
 void argv_array_push(struct argv_array *, const char *);
 __attribute__((format (printf,2,3)))
 void argv_array_pushf(struct argv_array *, const char *fmt, ...);
+__attribute__((sentinel))
 void argv_array_pushl(struct argv_array *, ...);
 void argv_array_pop(struct argv_array *);
 void argv_array_clear(struct argv_array *);
diff --git a/builtin/revert.c b/builtin/revert.c
index 0401fdb..b8b5174 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -54,6 +54,7 @@ static int option_parse_x(const struct option *opt,
 	return 0;
 }
 
+__attribute__((sentinel))
 static void verify_opt_compatible(const char *me, const char *base_opt, ...)
 {
 	const char *this_opt;
@@ -70,6 +71,7 @@ static void verify_opt_compatible(const char *me, const char *base_opt, ...)
 		die(_("%s: %s cannot be used with %s"), me, this_opt, base_opt);
 }
 
+__attribute__((sentinel))
 static void verify_opt_mutually_compatible(const char *me, ...)
 {
 	const char *opt1, *opt2 = NULL;
diff --git a/exec_cmd.h b/exec_cmd.h
index e2b546b..307b55c 100644
--- a/exec_cmd.h
+++ b/exec_cmd.h
@@ -7,6 +7,7 @@ extern int execv_git_cmd(const char **argv); /* NULL terminated */
 extern void setup_path(void);
 extern const char **prepare_git_cmd(const char **argv);
 extern int execv_git_cmd(const char **argv); /* NULL terminated */
+__attribute__((sentinel))
 extern int execl_git_cmd(const char *cmd, ...);
 extern const char *system_path(const char *path);
 
diff --git a/run-command.h b/run-command.h
index 221ce33..0a47679 100644
--- a/run-command.h
+++ b/run-command.h
@@ -46,6 +46,7 @@ extern char *find_hook(const char *name);
 int run_command(struct child_process *);
 
 extern char *find_hook(const char *name);
+__attribute__((sentinel))
 extern int run_hook(const char *index_file, const char *name, ...);
 
 #define RUN_COMMAND_NO_STDIN 1
-- 
1.8.3.rc3.24.gec82cb9
