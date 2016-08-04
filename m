Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C470720193
	for <e@80x24.org>; Thu,  4 Aug 2016 03:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023AbcHDDnE (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 23:43:04 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:56750 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933171AbcHDDnC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 23:43:02 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6548420191;
	Thu,  4 Aug 2016 03:43:01 +0000 (UTC)
Date:	Thu, 4 Aug 2016 03:43:01 +0000
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>, "Kyle J. McKay" <mackyle@gmail.com>,
	git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: [PATCH v3] pager: move pager-specific setup into the build
Message-ID: <20160804034301.GA31427@starla>
References: <20160801214937.4752-1-e@80x24.org>
 <20160801214937.4752-2-e@80x24.org>
 <20160803161911.dxucq7f2pvnoovoc@sigill.intra.peff.net>
 <xmqq4m718tay.fsf@gitster.mtv.corp.google.com>
 <20160803210821.GA17510@whir>
 <xmqqziot7dv6.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqziot7dv6.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Allowing PAGER_ENV to be set at build-time allows us to move
pager-specific knowledge out of our build.  This allows us to
set a better default for FreeBSD more(1), which misbehaves if
MORE environment variable is left empty, but accepts the same
variables as less(1)

Originally-from:
 https://public-inbox.org/git/xmqq61piw4yf.fsf@gitster.dls.corp.google.com/

Signed-off-by: Eric Wong <e@80x24.org>
---
  v3 changes (from v2, d3aed319c9abac006060bc81e865c93ff8363066)
  - Squashed git-sh-setup quoting fix from Junio
  - set MORE=FRX on FreeBSD to match LESS
  - simplify setup_pager_env to avoid leaks using split_cmdline

  The following changes since commit f8f7adce9fc50a11a764d57815602dcb818d1816:

    Sync with maint (2016-07-28 14:21:18 -0700)

  are available in the git repository at:

    git://bogomips.org/git-svn.git pager-env-v3

  for you to fetch changes up to 18c69fb16d866f42b53242142229de4801964d37:

    pager: move pager-specific setup into the build (2016-08-04 03:17:16 +0000)

  ----------------------------------------------------------------
  Junio C Hamano (1):
        pager: move pager-specific setup into the build

   Makefile         | 20 +++++++++++++++++++-
   config.mak.uname |  1 +
   git-sh-setup.sh  |  8 +++++---
   pager.c          | 32 ++++++++++++++++++++++++++++----
   4 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 6a13386..0b36b5e 100644
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
 
@@ -1629,6 +1641,10 @@ ifdef DEFAULT_HELP_FORMAT
 BASIC_CFLAGS += -DDEFAULT_HELP_FORMAT='"$(DEFAULT_HELP_FORMAT)"'
 endif
 
+PAGER_ENV_CQ = "$(subst ",\",$(subst \,\\,$(PAGER_ENV)))"
+PAGER_ENV_CQ_SQ = $(subst ','\'',$(PAGER_ENV_CQ))
+BASIC_CFLAGS += -DPAGER_ENV='$(PAGER_ENV_CQ_SQ)'
+
 ALL_CFLAGS += $(BASIC_CFLAGS)
 ALL_LDFLAGS += $(BASIC_LDFLAGS)
 
@@ -1753,7 +1769,7 @@ common-cmds.h: $(wildcard Documentation/git-*.txt)
 
 SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
 	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
-	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(SANE_TEXT_GREP)
+	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(SANE_TEXT_GREP):$(PAGER_ENV)
 define cmd_munge_script
 $(RM) $@ $@+ && \
 sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
@@ -1766,6 +1782,7 @@ sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     -e 's|@@GITWEBDIR@@|$(gitwebdir_SQ)|g' \
     -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
     -e 's|@@SANE_TEXT_GREP@@|$(SANE_TEXT_GREP)|g' \
+    -e 's|@@PAGER_ENV@@|$(PAGER_ENV_SQ)|g' \
     $@.sh >$@+
 endef
 
@@ -2173,6 +2190,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@+
 	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@+
 	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@+
+	@echo PAGER_ENV=\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))'\' >>$@+
 ifdef TEST_OUTPUT_DIRECTORY
 	@echo TEST_OUTPUT_DIRECTORY=\''$(subst ','\'',$(subst ','\'',$(TEST_OUTPUT_DIRECTORY)))'\' >>$@+
 endif
diff --git a/config.mak.uname b/config.mak.uname
index 17fed2f..b232908 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -209,6 +209,7 @@ ifeq ($(uname_S),FreeBSD)
 	HAVE_PATHS_H = YesPlease
 	GMTIME_UNRELIABLE_ERRORS = UnfortunatelyYes
 	HAVE_BSD_SYSCTL = YesPlease
+	PAGER_ENV = LESS=FRX LV=-c MORE=FRX
 endif
 ifeq ($(uname_S),OpenBSD)
 	NO_STRCASESTR = YesPlease
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 0c34aa6..a8a4576 100644
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
+		eval ": \"\${$vardef}\" && export $var"
+	done
 
 	eval "$GIT_PAGER" '"$@"'
 }
diff --git a/pager.c b/pager.c
index 4bc0481..6470b81 100644
--- a/pager.c
+++ b/pager.c
@@ -63,14 +63,38 @@ const char *git_pager(int stdout_is_tty)
 	return pager;
 }
 
+static void setup_pager_env(struct argv_array *env)
+{
+	const char **argv;
+	int i;
+	char *pager_env = xstrdup(PAGER_ENV);
+	int n = split_cmdline(pager_env, &argv);
+
+	if (n < 0)
+		die("malformed build-time PAGER_ENV: %s",
+			split_cmdline_strerror(n));
+
+	for (i = 0; i < n; i++) {
+		char *cp = strchr(argv[i], '=');
+
+		if (!cp)
+			die("malformed build-time PAGER_ENV");
+
+		*cp = '\0';
+		if (!getenv(argv[i])) {
+			*cp = '=';
+			argv_array_push(env, argv[i]);
+		}
+	}
+	free(pager_env);
+	free(argv);
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
