From: Jeff King <peff@peff.net>
Subject: [PATCH 13/13] move LESS/LV pager environment to Makefile
Date: Wed, 5 Feb 2014 13:08:57 -0500
Message-ID: <20140205180857.GM15218@sigill.intra.peff.net>
References: <20140205174823.GA15070@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 05 19:09:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB6uH-000494-MN
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 19:09:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753304AbaBESJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 13:09:00 -0500
Received: from cloud.peff.net ([50.56.180.127]:45172 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752452AbaBESI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 13:08:59 -0500
Received: (qmail 8703 invoked by uid 102); 5 Feb 2014 18:08:58 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Feb 2014 12:08:58 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Feb 2014 13:08:57 -0500
Content-Disposition: inline
In-Reply-To: <20140205174823.GA15070@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241632>

We set the LESS and LV variables to sensible defaults if
they are not already set. However, the code is brittle.
There is no easy way to change the defaults at compile time,
and we have to duplicate the code in git-sh-setup and in
pager.c.

Let's turn it into a normal Makefile knob instead.

Signed-off-by: Jeff King <peff@peff.net>
---
Bits of this patch were liberally stolen from Junio's weather-balloon
patch. All bugs are mine. :)

Note that setup_pager_env in the C code still does do a little parsing,
since we need to have the name of each variable in a separate buffer to
pass to getenv().  I chose to do it this way so that we could introduce
a standard "mkcarray" helper that could be used in other places. But it
would also be easy to do all of that parsing at compile time and produce
an array of structs like:

  { "LESS", "LESS=-FRSX" },
  { "LV", "LV=-c" }

 Makefile        | 22 +++++++++++++++++++++-
 git-sh-setup.sh |  9 +++++----
 pager.c         | 34 +++++++++++++++++++++++-----------
 script/mkcarray | 25 +++++++++++++++++++++++++
 4 files changed, 74 insertions(+), 16 deletions(-)
 create mode 100644 script/mkcarray

diff --git a/Makefile b/Makefile
index ad3100d..fff8e72 100644
--- a/Makefile
+++ b/Makefile
@@ -342,6 +342,14 @@ all::
 # Define DEFAULT_HELP_FORMAT to "man", "info" or "html"
 # (defaults to "man") if you want to have a different default when
 # "git help" is called without a parameter specifying the format.
+#
+# Define PAGER_ENV to a SP separated VAR=VAL pairs to define
+# default environment variables to be passed when a pager is spawned, e.g.
+#
+#    PAGER_ENV = LESS=-FRSX LV=-c
+#
+# to say "export LESS=-FRSX (and LV=-c) if the environment variable
+# LESS (and LV) is not set, respectively".
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -1505,6 +1513,10 @@ ifeq ($(PYTHON_PATH),)
 NO_PYTHON = NoThanks
 endif
 
+ifndef PAGER_ENV
+PAGER_ENV = LESS=-FRSX LV=-c
+endif
+
 QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
 QUIET_SUBDIR1  =
 
@@ -1598,6 +1610,11 @@ MAKE/%-string.h: MAKE/% script/mkcstring
 		$(subst -,_,$*) <$< >$@+ && \
 		mv $@+ $@
 
+MAKE/%-array.h: MAKE/% script/mkcarray
+	$(QUIET_GEN)$(SHELL_PATH) script/mkcarray \
+		$(subst -,_,$*) <$< >$@+ && \
+		mv $@+ $@
+
 MAKE/%.sh: MAKE/% script/mksh
 	$(QUIET_GEN)$(SHELL_PATH) script/mksh \
 		$(subst -,_,$*) <$< >$@+ && \
@@ -1726,6 +1743,9 @@ builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
 
 version.sp version.s version.o: MAKE/VERSION-string.h MAKE/USER-AGENT-string.h
 
+$(eval $(call make-var,PAGER-ENV,pager environment,$(PAGER_ENV)))
+pager.sp pager.s pager.o: MAKE/PAGER-ENV-array.h
+
 $(BUILT_INS): git$X
 	$(QUIET_BUILT_IN)$(RM) $@ && \
 	ln $< $@ 2>/dev/null || \
@@ -1776,7 +1796,7 @@ $(SCRIPT_LIB) : % : %.sh MAKE/SCRIPT-DEFINES
 	$(QUIET_GEN)$(cmd_munge_script) && \
 	mv $@+ $@
 
-git-sh-setup: MAKE/DIFF.sh
+git-sh-setup: MAKE/DIFF.sh MAKE/PAGER-ENV.sh
 
 git.res: git.rc GIT-VERSION-FILE
 	$(QUIET_RC)$(RC) \
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 627d289..be4a58a 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -158,10 +158,11 @@ git_pager() {
 	else
 		GIT_PAGER=cat
 	fi
-	: ${LESS=-FRSX}
-	: ${LV=-c}
-	export LESS LV
-
+	for vardef in $MAKE_PAGER_ENV
+	do
+		var=${vardef%%=*}
+		eval ": \${$vardef} && export $var"
+	done
 	eval "$GIT_PAGER" '"$@"'
 }
 
diff --git a/pager.c b/pager.c
index 0cc75a8..6db84c6 100644
--- a/pager.c
+++ b/pager.c
@@ -1,6 +1,8 @@
 #include "cache.h"
 #include "run-command.h"
 #include "sigchain.h"
+#include "argv-array.h"
+#include "MAKE/PAGER-ENV-array.h"
 
 #ifndef DEFAULT_PAGER
 #define DEFAULT_PAGER "less"
@@ -60,9 +62,26 @@ const char *git_pager(int stdout_is_tty)
 	return pager;
 }
 
+static void setup_pager_env(struct argv_array *env)
+{
+	int i;
+
+	for (i = 0; MAKE_PAGER_ENV[i]; i++) {
+		struct strbuf buf = STRBUF_INIT;
+		const char *p = MAKE_PAGER_ENV[i];
+		const char *eq = strchrnul(p, '=');
+
+		strbuf_add(&buf, p, eq - p);
+		if (!getenv(buf.buf))
+			argv_array_push(env, p);
+		strbuf_release(&buf);
+	}
+}
+
 void setup_pager(void)
 {
 	const char *pager = git_pager(isatty(1));
+	struct argv_array env = ARGV_ARRAY_INIT;
 
 	if (!pager || pager_in_use())
 		return;
@@ -80,17 +99,10 @@ void setup_pager(void)
 	pager_process.use_shell = 1;
 	pager_process.argv = pager_argv;
 	pager_process.in = -1;
-	if (!getenv("LESS") || !getenv("LV")) {
-		static const char *env[3];
-		int i = 0;
-
-		if (!getenv("LESS"))
-			env[i++] = "LESS=FRSX";
-		if (!getenv("LV"))
-			env[i++] = "LV=-c";
-		env[i] = NULL;
-		pager_process.env = env;
-	}
+
+	setup_pager_env(&env);
+	pager_process.env = argv_array_detach(&env, NULL);
+
 	if (start_command(&pager_process))
 		return;
 
diff --git a/script/mkcarray b/script/mkcarray
new file mode 100644
index 0000000..ed980ab
--- /dev/null
+++ b/script/mkcarray
@@ -0,0 +1,25 @@
+#!/bin/sh
+
+name=$1; shift
+
+quote() {
+	echo "$1" | sed 's/\\/\\\\/g; s/"/\\"/'
+}
+
+cat <<-EOF
+#ifndef ${name}_H
+#define ${name}_H
+
+static const char *MAKE_${name}[] = {
+EOF
+
+for i in $(cat); do
+	printf '\t"%s",\n' "$(quote "$i")"
+done
+
+cat <<EOF
+	NULL
+};
+
+#endif /* ${name}_H */
+EOF
-- 
1.8.5.2.500.g8060133
