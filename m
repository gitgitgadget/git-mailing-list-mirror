From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] setup_pager: set MORE=R
Date: Fri, 17 Jan 2014 15:42:32 -0800
Message-ID: <xmqq61piw4yf.fsf@gitster.dls.corp.google.com>
References: <20140117041430.GB19551@sigill.intra.peff.net>
	<20140117042153.GB23443@sigill.intra.peff.net>
	<xmqqvbxiwh8y.fsf@gitster.dls.corp.google.com>
	<xmqqiotiwfdk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Yuri <yuri@rawbw.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 18 00:42:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4J3i-0007iq-C9
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jan 2014 00:42:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753613AbaAQXmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 18:42:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57050 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751897AbaAQXmh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 18:42:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A898562A45;
	Fri, 17 Jan 2014 18:42:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=07Ctg0nOV641459LXXk1F9yr9Co=; b=SlShDC
	6O1XP8CjKjeAMTLV5ELps2Vr6WKbiE+1N3uErViYtnCwYFhP8J9KuUVKtImfwLSt
	pAvw6hke//MVzrkzqs1z9HbL4hlkGib3qbf67meN089RUY4iFp7XTLEi9M2qVVLt
	TKKrXOo8wMxcHGvqb8h+PtAxb5EPjrPwQXaXk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F2/+sOcM4oUAdW11maJCE0TVyZvcKg1y
	3BNo82MnzfzGLPHCUx3bfZlZhXNUFUNBZI3M/4h79O2nzjTyUGhSC4L8AJBj9wjT
	dye8ebBbpEY05lCIqs+y+R4RPFzXLsYspY9Jl3tuCkFpWuekC+tEiqMcEwdXcW0x
	x3CmA0Kp5S0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C30C62A44;
	Fri, 17 Jan 2014 18:42:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D747B62A40;
	Fri, 17 Jan 2014 18:42:35 -0500 (EST)
In-Reply-To: <xmqqiotiwfdk.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 17 Jan 2014 11:57:27 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0AE4A71A-7FD1-11E3-91C9-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240637>

Junio C Hamano <gitster@pobox.com> writes:

> Perhaps we can start it like this.  Then pager.c can iterate over
> the PAGER_ENV string, parse out LESS=, LV=, etc., and do its thing.
>
> We would also need to muck with git-sh-setup.sh but that file is
> already preprocessed in the Makefile, so we should be able to do
> something similar to "# @@BROKEN_PATH_FIX@@" there.

And here is such an attempt.  There may be some missing dependencies
that need to be covered with a mechanism like GIT-BUILD-OPTIONS,
though.

 Makefile         | 18 ++++++++++++++++--
 config.mak.uname |  1 +
 git-sh-setup.sh  |  9 +++++----
 pager.c          | 44 +++++++++++++++++++++++++++++++++-----------
 4 files changed, 55 insertions(+), 17 deletions(-)

diff --git a/Makefile b/Makefile
index b4af1e2..690f4c6 100644
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
@@ -1506,6 +1514,10 @@ ifeq ($(PYTHON_PATH),)
 NO_PYTHON = NoThanks
 endif
 
+ifndef PAGER_ENV
+PAGER_ENV = LESS=-FRSX LV=-c
+endif
+
 QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
 QUIET_SUBDIR1  =
 
@@ -1585,11 +1597,12 @@ PYTHON_PATH_SQ = $(subst ','\'',$(PYTHON_PATH))
 TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
 DIFF_SQ = $(subst ','\'',$(DIFF))
 PERLLIB_EXTRA_SQ = $(subst ','\'',$(PERLLIB_EXTRA))
+PAGER_ENV_SQ = $(subst ','\'',$(PAGER_ENV))
 
 LIBS = $(GITLIBS) $(EXTLIBS)
 
 BASIC_CFLAGS += -DSHA1_HEADER='$(SHA1_HEADER_SQ)' \
-	$(COMPAT_CFLAGS)
+	$(COMPAT_CFLAGS) -DPAGER_ENV='$(PAGER_ENV)'
 LIB_OBJS += $(COMPAT_OBJS)
 
 # Quote for C
@@ -1739,7 +1752,7 @@ common-cmds.h: $(wildcard Documentation/git-*.txt)
 
 SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
 	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
-	$(gitwebdir_SQ):$(PERL_PATH_SQ)
+	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(PAGER_ENV)
 define cmd_munge_script
 $(RM) $@ $@+ && \
 sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
@@ -1751,6 +1764,7 @@ sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     -e $(BROKEN_PATH_FIX) \
     -e 's|@@GITWEBDIR@@|$(gitwebdir_SQ)|g' \
     -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
+    -e 's|@@PAGER_ENV@@|$(PAGER_ENV_SQ)|g' \
     $@.sh >$@+
 endef
 
diff --git a/config.mak.uname b/config.mak.uname
index 7d31fad..8aea8a6 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -188,6 +188,7 @@ ifeq ($(uname_S),FreeBSD)
 	endif
 	PYTHON_PATH = /usr/local/bin/python
 	HAVE_PATHS_H = YesPlease
+	PAGER_ENV = LESS=-FRSX LV=-c MORE=-R
 endif
 ifeq ($(uname_S),OpenBSD)
 	NO_STRCASESTR = YesPlease
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index fffa3c7..8fc1bbd 100644
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
+	for vardef in @@PAGER_ENV@@
+	do
+		var=${vardef%%=*}
+		eval ": \${$vardef} && export $var"
+	done
 	eval "$GIT_PAGER" '"$@"'
 }
 
diff --git a/pager.c b/pager.c
index 0cc75a8..81a8af7 100644
--- a/pager.c
+++ b/pager.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "run-command.h"
 #include "sigchain.h"
+#include "argv-array.h"
 
 #ifndef DEFAULT_PAGER
 #define DEFAULT_PAGER "less"
@@ -60,9 +61,37 @@ const char *git_pager(int stdout_is_tty)
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
 void setup_pager(void)
 {
 	const char *pager = git_pager(isatty(1));
+	struct argv_array env = ARGV_ARRAY_INIT;
 
 	if (!pager || pager_in_use())
 		return;
@@ -80,17 +109,10 @@ void setup_pager(void)
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
 
