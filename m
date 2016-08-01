Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E37892018B
	for <e@80x24.org>; Mon,  1 Aug 2016 01:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbcHABGN (ORCPT <rfc822;e@80x24.org>);
	Sun, 31 Jul 2016 21:06:13 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:45844 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750997AbcHABGM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2016 21:06:12 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 643B21F955;
	Mon,  1 Aug 2016 01:06:11 +0000 (UTC)
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>, "Kyle J. McKay" <mackyle@gmail.com>,
	git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: [PATCH 1/2] pager: move pager-specific setup into the build
Date:	Mon,  1 Aug 2016 01:05:56 +0000
Message-Id: <20160801010557.22191-2-e@80x24.org>
In-Reply-To: <20160801010557.22191-1-e@80x24.org>
References: <20160801010557.22191-1-e@80x24.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Allowing PAGER_ENV to be set at build-time allows us to move
pager-specific knowledge out of our build.  Currently, this
allows us to set a better default for FreeBSD where more(1)
is the same binary as less(1).

This also prepares us for introducing a run-time config knob to
override the build-time environment in the next commit.

Originally-from:
 https://public-inbox.org/git/xmqq61piw4yf.fsf@gitster.dls.corp.google.com/

Signed-off-by: Eric Wong <e@80x24.org>
---
 Makefile         | 19 +++++++++++++++++--
 config.mak.uname |  1 +
 git-sh-setup.sh  |  8 +++++---
 pager.c          | 32 ++++++++++++++++++++++++++++----
 4 files changed, 51 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 6a13386..fe469a6 100644
--- a/Makefile
+++ b/Makefile
@@ -370,6 +370,14 @@ all::
 # Define HAVE_BSD_SYSCTL if your platform has a BSD-compatible sysctl function.
 #
 # Define HAVE_GETDELIM if your system has the getdelim() function.
+#
+# Define PAGER_ENV to a SP separated VAR=VAL pairs to define
+# default environment variables to be passed when a pager is spawned, e.g.
+#
+#    PAGER_ENV = LESS=FRX LV=-c
+#
+# to say "export LESS=FRX (and LV=-c) if the environment variable
+# LESS (and LV) is not set, respectively".
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -1500,6 +1508,10 @@ ifeq ($(PYTHON_PATH),)
 NO_PYTHON = NoThanks
 endif
 
+ifndef PAGER_ENV
+PAGER_ENV = LESS=FRX LV=-c
+endif
+
 QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
 QUIET_SUBDIR1  =
 
@@ -1579,6 +1591,7 @@ PYTHON_PATH_SQ = $(subst ','\'',$(PYTHON_PATH))
 TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
 DIFF_SQ = $(subst ','\'',$(DIFF))
 PERLLIB_EXTRA_SQ = $(subst ','\'',$(PERLLIB_EXTRA))
+PAGER_ENV_SQ = $(subst ','\'',$(PAGER_ENV))
 
 # We must filter out any object files from $(GITLIBS),
 # as it is typically used like:
@@ -1591,7 +1604,7 @@ PERLLIB_EXTRA_SQ = $(subst ','\'',$(PERLLIB_EXTRA))
 LIBS = $(filter-out %.o, $(GITLIBS)) $(EXTLIBS)
 
 BASIC_CFLAGS += -DSHA1_HEADER='$(SHA1_HEADER_SQ)' \
-	$(COMPAT_CFLAGS)
+	$(COMPAT_CFLAGS) -DPAGER_ENV='$(PAGER_ENV_SQ)'
 LIB_OBJS += $(COMPAT_OBJS)
 
 # Quote for C
@@ -1753,7 +1766,7 @@ common-cmds.h: $(wildcard Documentation/git-*.txt)
 
 SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
 	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
-	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(SANE_TEXT_GREP)
+	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(SANE_TEXT_GREP):$(PAGER_ENV)
 define cmd_munge_script
 $(RM) $@ $@+ && \
 sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
@@ -1766,6 +1779,7 @@ sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     -e 's|@@GITWEBDIR@@|$(gitwebdir_SQ)|g' \
     -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
     -e 's|@@SANE_TEXT_GREP@@|$(SANE_TEXT_GREP)|g' \
+    -e 's|@@PAGER_ENV@@|$(PAGER_ENV_SQ)|g' \
     $@.sh >$@+
 endef
 
@@ -2173,6 +2187,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@+
 	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@+
 	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@+
+	@echo PAGER_ENV=\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))'\' >>$@+
 ifdef TEST_OUTPUT_DIRECTORY
 	@echo TEST_OUTPUT_DIRECTORY=\''$(subst ','\'',$(subst ','\'',$(TEST_OUTPUT_DIRECTORY)))'\' >>$@+
 endif
diff --git a/config.mak.uname b/config.mak.uname
index 17fed2f..2484dfb 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -209,6 +209,7 @@ ifeq ($(uname_S),FreeBSD)
 	HAVE_PATHS_H = YesPlease
 	GMTIME_UNRELIABLE_ERRORS = UnfortunatelyYes
 	HAVE_BSD_SYSCTL = YesPlease
+	PAGER_ENV = LESS=FRX LV=-c MORE=-R
 endif
 ifeq ($(uname_S),OpenBSD)
 	NO_STRCASESTR = YesPlease
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 0c34aa6..0f5a56f 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -163,9 +163,11 @@ git_pager() {
 	else
 		GIT_PAGER=cat
 	fi
-	: "${LESS=-FRX}"
-	: "${LV=-c}"
-	export LESS LV
+	for vardef in @@PAGER_ENV@@
+	do
+		var=${vardef%%=*}
+		eval ": \${$vardef} && export $var"
+	done
 
 	eval "$GIT_PAGER" '"$@"'
 }
diff --git a/pager.c b/pager.c
index 4bc0481..2f2cadc 100644
--- a/pager.c
+++ b/pager.c
@@ -63,14 +63,38 @@ const char *git_pager(int stdout_is_tty)
 	return pager;
 }
 
+#define stringify_(x) #x
+#define stringify(x) stringify_(x)
+
+static void setup_pager_env(struct argv_array *env)
+{
+	const char *pager_env = stringify(PAGER_ENV);
+
+	while (*pager_env) {
+		struct strbuf buf = STRBUF_INIT;
+		const char *cp = strchrnul(pager_env, '=');
+
+		if (!*cp)
+			die("malformed build-time PAGER_ENV");
+		strbuf_add(&buf, pager_env, cp - pager_env);
+		cp = strchrnul(pager_env, ' ');
+		if (!getenv(buf.buf)) {
+			strbuf_reset(&buf);
+			strbuf_add(&buf, pager_env, cp - pager_env);
+			argv_array_push(env, strbuf_detach(&buf, NULL));
+		}
+		strbuf_reset(&buf);
+		while (*cp && *cp == ' ')
+			cp++;
+		pager_env = cp;
+	}
+}
+
 void prepare_pager_args(struct child_process *pager_process, const char *pager)
 {
 	argv_array_push(&pager_process->args, pager);
 	pager_process->use_shell = 1;
-	if (!getenv("LESS"))
-		argv_array_push(&pager_process->env_array, "LESS=FRX");
-	if (!getenv("LV"))
-		argv_array_push(&pager_process->env_array, "LV=-c");
+	setup_pager_env(&pager_process->env_array);
 }
 
 void setup_pager(void)
-- 
EW

