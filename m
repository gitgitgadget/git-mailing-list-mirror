From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v9 1/4] usage: make error functions a stack
Date: Tue, 15 Jul 2014 16:32:56 -0700
Message-ID: <1405467179-16064-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 01:33:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7CDj-0002pt-5N
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 01:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760397AbaGOXdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 19:33:10 -0400
Received: from mga02.intel.com ([134.134.136.20]:7328 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760382AbaGOXdG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 19:33:06 -0400
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP; 15 Jul 2014 16:33:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,668,1400050800"; 
   d="scan'208";a="543903091"
Received: from jekeller-desk1.jf.intel.com (HELO jekeller-desk1.amr.corp.intel.com) ([134.134.173.156])
  by orsmga001.jf.intel.com with ESMTP; 15 Jul 2014 16:33:01 -0700
X-Mailer: git-send-email 2.0.1.475.g9b8d714
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253622>

Rename set_error_routine to be push_error_routine, and add a new
pop_error_routine. This allows temporary modifications of the error
routine over a small block of code.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Renamed set_error_routine to push_error_routine in order to match the
pop_error_routine.

 git-compat-util.h |  3 ++-
 run-command.c     |  2 +-
 usage.c           | 32 ++++++++++++++++++++++++++++----
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 9de318071083..b650e3cb6cdc 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -343,7 +343,8 @@ static inline int const_error(void)
 #endif
 
 extern void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params));
-extern void set_error_routine(void (*routine)(const char *err, va_list params));
+extern void push_error_routine(void (*routine)(const char *err, va_list params));
+extern void pop_error_routine(void);
 extern void set_die_is_recursing_routine(int (*routine)(void));
 
 extern int starts_with(const char *str, const char *prefix);
diff --git a/run-command.c b/run-command.c
index be07d4ad335b..a611b819c25d 100644
--- a/run-command.c
+++ b/run-command.c
@@ -360,7 +360,7 @@ fail_pipe:
 			set_cloexec(child_err);
 		}
 		set_die_routine(die_child);
-		set_error_routine(error_child);
+		push_error_routine(error_child);
 
 		close(notify_pipe[0]);
 		set_cloexec(notify_pipe[1]);
diff --git a/usage.c b/usage.c
index ed146453cabe..3fe26771f7e6 100644
--- a/usage.c
+++ b/usage.c
@@ -57,18 +57,42 @@ static int die_is_recursing_builtin(void)
  * (ugh), so keep things static. */
 static NORETURN_PTR void (*usage_routine)(const char *err, va_list params) = usage_builtin;
 static NORETURN_PTR void (*die_routine)(const char *err, va_list params) = die_builtin;
-static void (*error_routine)(const char *err, va_list params) = error_builtin;
 static void (*warn_routine)(const char *err, va_list params) = warn_builtin;
 static int (*die_is_recursing)(void) = die_is_recursing_builtin;
 
+struct error_func_list {
+	void (*func)(const char *, va_list);
+	struct error_func_list *next;
+};
+static struct error_func_list default_error_func = { error_builtin };
+static struct error_func_list *error_funcs = &default_error_func;
+
 void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params))
 {
 	die_routine = routine;
 }
 
-void set_error_routine(void (*routine)(const char *err, va_list params))
+/* push error routine onto the error function stack */
+void push_error_routine(void (*routine)(const char *err, va_list params))
 {
-	error_routine = routine;
+	struct error_func_list *efl = xmalloc(sizeof(*efl));
+	efl->func = routine;
+	efl->next = error_funcs;
+	error_funcs = efl;
+}
+
+/* pop a single error routine off of the error function stack, thus reverting
+ * to previous error. Should always be paired with a push_error_routine */
+void pop_error_routine(void)
+{
+	struct error_func_list *efl = error_funcs;
+
+	assert(error_funcs != &default_error_func);
+
+	if (efl->next) {
+		error_funcs = efl->next;
+		free(efl);
+	}
 }
 
 void set_die_is_recursing_routine(int (*routine)(void))
@@ -144,7 +168,7 @@ int error(const char *err, ...)
 	va_list params;
 
 	va_start(params, err);
-	error_routine(err, params);
+	error_funcs->func(err, params);
 	va_end(params);
 	return -1;
 }
-- 
2.0.1.475.g9b8d714
