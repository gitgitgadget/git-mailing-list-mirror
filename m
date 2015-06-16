From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] trace: add GIT_TRACE_STDIN
Date: Tue, 16 Jun 2015 17:20:40 -0400
Message-ID: <20150616212039.GA11353@peff.net>
References: <20150616193102.GA15856@peff.net>
 <20150616193716.GC15931@peff.net>
 <20150616194907.GA15988@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Augie Fackler <augie@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 23:20:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4yHo-0001ia-R9
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 23:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754764AbbFPVUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 17:20:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:47091 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754157AbbFPVUn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 17:20:43 -0400
Received: (qmail 24983 invoked by uid 102); 16 Jun 2015 21:20:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Jun 2015 16:20:43 -0500
Received: (qmail 19255 invoked by uid 107); 16 Jun 2015 21:20:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Jun 2015 17:20:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Jun 2015 17:20:40 -0400
Content-Disposition: inline
In-Reply-To: <20150616194907.GA15988@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271799>

On Tue, Jun 16, 2015 at 03:49:07PM -0400, Jeff King wrote:

> Another option would be to stop trying to intercept stdin in git.c, and
> instead make this a feature of run-command.c. That is, right before we
> exec a process, tee its stdin there. That means that you cannot do:
> 
>   GIT_TRACE_STDIN=/tmp/foo.out git foo
> 
> to collect the stdin of foo. But that is not really an interesting case
> anyway. You can run "tee" yourself if you want. The interesting cases
> are the ones where git is spawning a sub-process, and you want to
> intercept the data moving between the git processes.

Hmm. I guess we do not actually have to move the stdin interception
there. We can just move the config-checking there, like the patch below.

It basically just converts trace.foo.bar into GIT_TRACE_BAR when we are
running "foo" as a git command.  This does work, but is perhaps
potentially confusing to the user, because it only kicks in when _git_
runs "foo". IOW, this works:

  git config trace.upload-pack.foo /path/to/foo.out
  git daemon

and will trace as you expect. But then running:

  git upload-pack

yourself will do nothing.

I dunno.

---
 run-command.c | 17 +++++++++++++++++
 trace.c       | 44 ++++++++++++++++++++++++++++++++++++++++++++
 trace.h       |  9 +++++++++
 3 files changed, 70 insertions(+)

diff --git a/run-command.c b/run-command.c
index 4d73e90..2febbb5 100644
--- a/run-command.c
+++ b/run-command.c
@@ -284,6 +284,23 @@ int start_command(struct child_process *cmd)
 
 	if (!cmd->argv)
 		cmd->argv = cmd->args.argv;
+	if (cmd->git_cmd) {
+		/*
+		 * Load any extra variables into env_array. But
+		 * if we weren't going to use it (in favor of "env"),
+		 * then consolidate the two. Make sure the original "env"
+		 * goes after what we add, so that it can override.
+		 *
+		 * We cannot just keep two lists, because we may hand off the
+		 * single list to a spawn() implementation.
+		 */
+		trace_config_for(cmd->argv[0], &cmd->env_array);
+		if (cmd->env_array.argc && cmd->env) {
+			for (; *cmd->env; cmd->env++)
+				argv_array_push(&cmd->env_array, *cmd->env);
+			cmd->env = NULL;
+		}
+	}
 	if (!cmd->env)
 		cmd->env = cmd->env_array.argv;
 
diff --git a/trace.c b/trace.c
index a7ec484..86c988e 100644
--- a/trace.c
+++ b/trace.c
@@ -24,6 +24,7 @@
 
 #include "cache.h"
 #include "quote.h"
+#include "argv-array.h"
 
 static size_t expand_trace_name(struct strbuf *out, const char *fmt,
 				void *data)
@@ -449,3 +450,46 @@ void trace_command_performance(const char **argv)
 	sq_quote_argv(&command_line, argv, 0);
 	command_start_time = getnanotime();
 }
+
+struct trace_config_data {
+	const char *want_cmd;
+	struct argv_array *out;
+};
+
+static int trace_config_cb(const char *var, const char *value, void *vdata)
+{
+	struct trace_config_data *data = vdata;
+	const char *have_cmd, *key;
+	int have_len;
+
+	if (!parse_config_key(var, "trace", &have_cmd, &have_len, &key) &&
+	    have_cmd &&
+	    !strncmp(data->want_cmd, have_cmd, have_len) &&
+	    data->want_cmd[have_len] == '\0') {
+		struct strbuf buf = STRBUF_INIT;
+
+		strbuf_addstr(&buf, "GIT_TRACE_");
+		while (*key)
+			strbuf_addch(&buf, toupper(*key++));
+
+		/*
+		 * Environment always takes precedence over config, so do not
+		 * override existing variables. We cannot rely on setenv()'s
+		 * overwrite flag here, because we may pass the list off to
+		 * a spawn() implementation, which always overwrites.
+		 */
+		if (!getenv(buf.buf))
+			argv_array_pushf(data->out, "%s=%s", buf.buf, value);
+
+		strbuf_release(&buf);
+	}
+	return 0;
+}
+
+void trace_config_for(const char *cmd, struct argv_array *out)
+{
+	struct trace_config_data data;
+	data.want_cmd = cmd;
+	data.out = out;
+	git_config(trace_config_cb, &data);
+}
diff --git a/trace.h b/trace.h
index 179b249..83618e9 100644
--- a/trace.h
+++ b/trace.h
@@ -4,6 +4,8 @@
 #include "git-compat-util.h"
 #include "strbuf.h"
 
+struct argv_array;
+
 struct trace_key {
 	const char * const key;
 	int fd;
@@ -20,6 +22,13 @@ extern uint64_t getnanotime(void);
 extern void trace_command_performance(const char **argv);
 extern void trace_verbatim(struct trace_key *key, const void *buf, unsigned len);
 
+/**
+ * Load any trace-related config for git command "cmd", and insert the matching
+ * environment variables into "out", which is suitable for use by run-command
+ * and friends.
+ */
+void trace_config_for(const char *cmd, struct argv_array *out);
+
 #ifndef HAVE_VARIADIC_MACROS
 
 __attribute__((format (printf, 1, 2)))
-- 
2.4.3.699.g84b4da7
