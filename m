From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v8 1/4] usage: make error functions a stack
Date: Tue, 15 Jul 2014 14:29:11 -0700
Message-ID: <1405459754-4220-2-git-send-email-jacob.e.keller@intel.com>
References: <1405459754-4220-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 15 23:29:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7AI1-0001kn-Qz
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 23:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754690AbaGOV3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 17:29:24 -0400
Received: from mga02.intel.com ([134.134.136.20]:55381 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752284AbaGOV3V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 17:29:21 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP; 15 Jul 2014 14:29:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,668,1400050800"; 
   d="scan'208";a="573664229"
Received: from jekeller-desk1.jf.intel.com (HELO jekeller-desk1.amr.corp.intel.com) ([134.134.173.156])
  by orsmga002.jf.intel.com with ESMTP; 15 Jul 2014 14:29:20 -0700
X-Mailer: git-send-email 2.0.1.475.g9b8d714
In-Reply-To: <1405459754-4220-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253605>

Let error routine be a stack of error functions so that callers can
temporarily override the error_routine and then pop their modification
off the stack. This enables customizing error for a small code segment.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
This is a modification of Peff's original idea for handling multiple error
routines. I simplified it by not having the collect and other routines. I only
modify set_error_routine to be a "push" operation, with pop_error_routine being
its opposite. I don't let pop_error_routine remove all the error routines,
instead only doing one with an assert check that we never call it too many times.

This enables temporarily modifying the error routine and then popping back to
the previous value.

 git-compat-util.h |  1 +
 usage.c           | 29 ++++++++++++++++++++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 9de318071083..6d0416c90ad8 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -344,6 +344,7 @@ static inline int const_error(void)
 
 extern void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params));
 extern void set_error_routine(void (*routine)(const char *err, va_list params));
+extern void pop_error_routine(void);
 extern void set_die_is_recursing_routine(int (*routine)(void));
 
 extern int starts_with(const char *str, const char *prefix);
diff --git a/usage.c b/usage.c
index ed146453cabe..fd9126a7ca0b 100644
--- a/usage.c
+++ b/usage.c
@@ -57,18 +57,41 @@ static int die_is_recursing_builtin(void)
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
 
+/* push error routine onto the error function stack */
 void set_error_routine(void (*routine)(const char *err, va_list params))
 {
-	error_routine = routine;
+	struct error_func_list *efl = xmalloc(sizeof(*efl));
+	efl->func = routine;
+	efl->next = error_funcs;
+	error_funcs = efl;
+}
+
+/* pop a single error routine off of the error function stack, thus reverting
+ * to previous error. Should always be paired with a set_error_routine */
+void pop_error_routine(void)
+{
+	assert(error_funcs != &default_error_func);
+
+	struct error_func_list *efl = error_funcs;
+	if (efl->next) {
+		error_funcs = efl->next;
+		free(efl);
+	}
 }
 
 void set_die_is_recursing_routine(int (*routine)(void))
@@ -144,7 +167,7 @@ int error(const char *err, ...)
 	va_list params;
 
 	va_start(params, err);
-	error_routine(err, params);
+	error_funcs->func(err, params);
 	va_end(params);
 	return -1;
 }
-- 
2.0.1.475.g9b8d714
