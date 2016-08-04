Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D889A20191
	for <e@80x24.org>; Thu,  4 Aug 2016 05:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932968AbcHDFeM (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 01:34:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:54570 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932286AbcHDFeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 01:34:09 -0400
Received: (qmail 7167 invoked by uid 102); 4 Aug 2016 05:34:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Aug 2016 01:34:10 -0400
Received: (qmail 10123 invoked by uid 107); 4 Aug 2016 05:34:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Aug 2016 01:34:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Aug 2016 01:34:05 -0400
Date:	Thu, 4 Aug 2016 01:34:05 -0400
From:	Jeff King <peff@peff.net>
To:	Eric Wong <e@80x24.org>
Cc:	Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v3] pager: move pager-specific setup into the build
Message-ID: <20160804053405.ifjjryejgbwkkatt@sigill.intra.peff.net>
References: <20160801214937.4752-1-e@80x24.org>
 <20160801214937.4752-2-e@80x24.org>
 <20160803161911.dxucq7f2pvnoovoc@sigill.intra.peff.net>
 <xmqq4m718tay.fsf@gitster.mtv.corp.google.com>
 <20160803210821.GA17510@whir>
 <xmqqziot7dv6.fsf@gitster.mtv.corp.google.com>
 <20160804034301.GA31427@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160804034301.GA31427@starla>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 04, 2016 at 03:43:01AM +0000, Eric Wong wrote:

> +PAGER_ENV_CQ = "$(subst ",\",$(subst \,\\,$(PAGER_ENV)))"
> +PAGER_ENV_CQ_SQ = $(subst ','\'',$(PAGER_ENV_CQ))
> +BASIC_CFLAGS += -DPAGER_ENV='$(PAGER_ENV_CQ_SQ)'

Here we set up CQ_SQ, but there is no PAGER_ENV_SQ.

And then...

> @@ -1753,7 +1769,7 @@ common-cmds.h: $(wildcard Documentation/git-*.txt)
>  
>  SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
>  	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
> -	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(SANE_TEXT_GREP)
> +	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(SANE_TEXT_GREP):$(PAGER_ENV)
>  define cmd_munge_script
>  $(RM) $@ $@+ && \
>  sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
> @@ -1766,6 +1782,7 @@ sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
>      -e 's|@@GITWEBDIR@@|$(gitwebdir_SQ)|g' \
>      -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
>      -e 's|@@SANE_TEXT_GREP@@|$(SANE_TEXT_GREP)|g' \
> +    -e 's|@@PAGER_ENV@@|$(PAGER_ENV_SQ)|g' \
>      $@.sh >$@+
>  endef

Here we depend on writing PAGER_ENV_SQ, which will be blank (and
git-sh-setup is broken as a result).

> diff --git a/config.mak.uname b/config.mak.uname
> index 17fed2f..b232908 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -209,6 +209,7 @@ ifeq ($(uname_S),FreeBSD)
>  	HAVE_PATHS_H = YesPlease
>  	GMTIME_UNRELIABLE_ERRORS = UnfortunatelyYes
>  	HAVE_BSD_SYSCTL = YesPlease
> +	PAGER_ENV = LESS=FRX LV=-c MORE=FRX
>  endif

Is it worth setting up PAGER_ENV's default values before including
config.mak.*, and then using "+=" here? That avoids this line getting
out of sync with the usual defaults.

> +static void setup_pager_env(struct argv_array *env)
> +{

I know you said you don't like string parsing in C. Here is a patch (on
top of yours) that converts the parsing to shell, and generates a
pre-built array-of-struct (this is similar to the big series I posted
long ago, but just touching this one spot, not invading the whole
Makefile). Feel free to ignore it as over-engineered, but I thought I'd
throw it out there in case it appeals.

-- >8 --
diff --git a/.gitignore b/.gitignore
index 05cb58a..b0fd5ec 100644
--- a/.gitignore
+++ b/.gitignore
@@ -180,6 +180,7 @@
 /gitweb/static/gitweb.js
 /gitweb/static/gitweb.min.*
 /common-cmds.h
+/pager-env.h
 *.tar.gz
 *.dsc
 *.deb
diff --git a/Makefile b/Makefile
index 0b36b5e..2e009cd 100644
--- a/Makefile
+++ b/Makefile
@@ -680,6 +680,7 @@ XDIFF_LIB = xdiff/lib.a
 VCSSVN_LIB = vcs-svn/lib.a
 
 GENERATED_H += common-cmds.h
+GENERATED_H += pager-env.h
 
 LIB_H = $(shell $(FIND) . \
 	-name .git -prune -o \
@@ -1641,9 +1642,7 @@ ifdef DEFAULT_HELP_FORMAT
 BASIC_CFLAGS += -DDEFAULT_HELP_FORMAT='"$(DEFAULT_HELP_FORMAT)"'
 endif
 
-PAGER_ENV_CQ = "$(subst ",\",$(subst \,\\,$(PAGER_ENV)))"
-PAGER_ENV_CQ_SQ = $(subst ','\'',$(PAGER_ENV_CQ))
-BASIC_CFLAGS += -DPAGER_ENV='$(PAGER_ENV_CQ_SQ)'
+PAGER_ENV_SQ = $(subst ','\'',$(PAGER_ENV))
 
 ALL_CFLAGS += $(BASIC_CFLAGS)
 ALL_LDFLAGS += $(BASIC_LDFLAGS)
@@ -1767,6 +1766,10 @@ common-cmds.h: generate-cmdlist.sh command-list.txt
 common-cmds.h: $(wildcard Documentation/git-*.txt)
 	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh command-list.txt >$@+ && mv $@+ $@
 
+pager-env.h: generate-pager-env.sh GIT-BUILD-OPTIONS
+	$(QUIET_GEN)$(SHELL_PATH) ./generate-pager-env.sh '$(PAGER_ENV_SQ)' >$@+ && \
+	mv $@+ $@
+
 SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
 	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
 	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(SANE_TEXT_GREP):$(PAGER_ENV)
diff --git a/generate-pager-env.sh b/generate-pager-env.sh
new file mode 100644
index 0000000..5b67b59
--- /dev/null
+++ b/generate-pager-env.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+
+c_quote () {
+	printf '%s' "$@" | sed 's/\\/\\\\/g; s/"/\\"/g;'
+}
+
+cat <<\EOF &&
+#ifndef PAGER_ENV_H
+#define PAGER_ENV_H
+
+static struct pager_env {
+	const char *key;
+	const char *value;
+} pager_env[] = {
+EOF
+
+# $* does whitespace splitting
+for i in $*; do
+	key=${i%%=*}
+	value=${i#*=}
+	printf '\t{ "%s", "%s" },\n' "$(c_quote "$key")" "$(c_quote "$value")"
+done &&
+
+cat <<\EOF
+};
+
+#endif /* PAGER_ENV */
+EOF
diff --git a/pager.c b/pager.c
index 6470b81..03c1a4a 100644
--- a/pager.c
+++ b/pager.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "run-command.h"
 #include "sigchain.h"
+#include "pager-env.h"
 
 #ifndef DEFAULT_PAGER
 #define DEFAULT_PAGER "less"
@@ -65,29 +66,12 @@ const char *git_pager(int stdout_is_tty)
 
 static void setup_pager_env(struct argv_array *env)
 {
-	const char **argv;
 	int i;
-	char *pager_env = xstrdup(PAGER_ENV);
-	int n = split_cmdline(pager_env, &argv);
-
-	if (n < 0)
-		die("malformed build-time PAGER_ENV: %s",
-			split_cmdline_strerror(n));
-
-	for (i = 0; i < n; i++) {
-		char *cp = strchr(argv[i], '=');
-
-		if (!cp)
-			die("malformed build-time PAGER_ENV");
-
-		*cp = '\0';
-		if (!getenv(argv[i])) {
-			*cp = '=';
-			argv_array_push(env, argv[i]);
-		}
+	for (i = 0; i < ARRAY_SIZE(pager_env); i++) {
+		struct pager_env *p = &pager_env[i];
+		if (!getenv(p->key))
+			argv_array_pushf(env, "%s=%s", p->key, p->value);
 	}
-	free(pager_env);
-	free(argv);
 }
 
 void prepare_pager_args(struct child_process *pager_process, const char *pager)
