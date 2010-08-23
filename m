From: Jeff King <peff@peff.net>
Subject: Re: "git -c web.browser=w3m help -w help" still kicks firefox
Date: Mon, 23 Aug 2010 15:16:00 -0400
Message-ID: <20100823191600.GA2523@coredump.intra.peff.net>
References: <7viq3119yn.fsf@alter.siamese.dyndns.org>
 <20100823183857.GA22386@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 23 21:16:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OncVA-0007fY-3z
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 21:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754364Ab0HWTQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 15:16:06 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:50637 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754331Ab0HWTQE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 15:16:04 -0400
Received: (qmail 12586 invoked by uid 111); 23 Aug 2010 19:16:02 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO coredump.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) ESMTPSA; Mon, 23 Aug 2010 19:16:02 +0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Aug 2010 15:16:00 -0400
Content-Disposition: inline
In-Reply-To: <20100823183857.GA22386@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154245>

On Mon, Aug 23, 2010 at 02:38:57PM -0400, Jeff King wrote:

> The environment is the only sensible way to pass this down, because we
> need to hit not just externals, but things like "git config" invocations
> from shell scripts. IOW, "git -c" really is about executing in a
> sub-environment that pretends that config is set. Obviously we would
> need to quote and unquote when using the environment as a transport (or
> do something horrible like making a temporary config file and pointing
> at it through the environment).

Here's a first attempt. No idea if it has any bad side effects. :)

-- >8 --
Subject: [PATCH] pass "git -c foo=bar" params through environment

Git uses the "-c foo=bar" parameters to set a config
variable for a single git invocation. We currently do this
by making a list in the current process and consulting that
list in git_config.

This works fine for built-ins, but the config changes are
silently ignored by subprocesses, including dashed externals
and invocations to "git config" from shell scripts.

This patch instead puts them in an environment variable
which we consult when looking at config (both internally and
via calls "git config").

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h  |    2 ++
 config.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 git.c    |    2 +-
 3 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index d8c0a98..b76d7b3 100644
--- a/cache.h
+++ b/cache.h
@@ -974,7 +974,9 @@ extern int update_server_info(int);
 typedef int (*config_fn_t)(const char *, const char *, void *);
 extern int git_default_config(const char *, const char *, void *);
 extern int git_config_from_file(config_fn_t fn, const char *, void *);
+extern void git_config_push_parameter(const char *text);
 extern int git_config_parse_parameter(const char *text);
+extern int git_config_parse_environment(void);
 extern int git_config_from_parameters(config_fn_t fn, void *data);
 extern int git_config(config_fn_t fn, void *);
 extern int git_parse_ulong(const char *, unsigned long *);
diff --git a/config.c b/config.c
index 7a18bc9..15eabaf 100644
--- a/config.c
+++ b/config.c
@@ -8,6 +8,7 @@
 #include "cache.h"
 #include "exec_cmd.h"
 #include "strbuf.h"
+#include "quote.h"
 
 #define MAXNAME (256)
 
@@ -34,6 +35,19 @@ static void lowercase(char *p)
 		*p = tolower(*p);
 }
 
+void git_config_push_parameter(const char *text)
+{
+	struct strbuf env = STRBUF_INIT;
+	const char *old = getenv("GIT_CONFIG_PARAMETERS");
+	if (old) {
+		strbuf_addstr(&env, old);
+		strbuf_addch(&env, ' ');
+	}
+	sq_quote_buf(&env, text);
+	setenv("GIT_CONFIG_PARAMETERS", env.buf, 1);
+	strbuf_release(&env);
+}
+
 int git_config_parse_parameter(const char *text)
 {
 	struct config_item *ct;
@@ -61,6 +75,37 @@ int git_config_parse_parameter(const char *text)
 	return 0;
 }
 
+int git_config_parse_environment(void) {
+	const char *env = getenv("GIT_CONFIG_PARAMETERS");
+	char *envw;
+	const char **argv = NULL;
+	int nr = 0, alloc = 0;
+	int i;
+
+	if (!env)
+		return 0;
+	/* sq_dequote will write over it */
+	envw = xstrdup(env);
+
+	if (sq_dequote_to_argv(envw, &argv, &nr, &alloc) < 0) {
+		free(envw);
+		return error("bogus format in GIT_CONFIG_PARAMETERS");
+	}
+
+	for (i = 0; i < nr; i++) {
+		if (git_config_parse_parameter(argv[i]) < 0) {
+			error("bogus config parameter: %s", argv[i]);
+			free(argv);
+			free(envw);
+			return -1;
+		}
+	}
+
+	free(argv);
+	free(envw);
+	return 0;
+}
+
 static int get_next_char(void)
 {
 	int c;
@@ -781,7 +826,14 @@ int git_config_global(void)
 
 int git_config_from_parameters(config_fn_t fn, void *data)
 {
+	static int loaded_environment;
 	const struct config_item *ct;
+
+	if (!loaded_environment) {
+		if (git_config_parse_environment() < 0)
+			return -1;
+		loaded_environment = 1;
+	}
 	for (ct = config_parameters; ct; ct = ct->next)
 		if (fn(ct->name, ct->value, data) < 0)
 			return -1;
@@ -820,10 +872,9 @@ int git_config(config_fn_t fn, void *data)
 	}
 	free(repo_config);
 
-	if (config_parameters) {
-		ret += git_config_from_parameters(fn, data);
+	ret += git_config_from_parameters(fn, data);
+	if (config_parameters)
 		found += 1;
-	}
 
 	if (found == 0)
 		return -1;
diff --git a/git.c b/git.c
index 8dda939..681f96c 100644
--- a/git.c
+++ b/git.c
@@ -137,7 +137,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				fprintf(stderr, "-c expects a configuration string\n" );
 				usage(git_usage_string);
 			}
-			git_config_parse_parameter((*argv)[1]);
+			git_config_push_parameter((*argv)[1]);
 			(*argv)++;
 			(*argc)--;
 		} else {
-- 
1.7.2.2.418.g55566.dirty
