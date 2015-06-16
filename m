From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] trace: add GIT_TRACE_STDIN
Date: Tue, 16 Jun 2015 15:49:08 -0400
Message-ID: <20150616194907.GA15988@peff.net>
References: <20150616193102.GA15856@peff.net>
 <20150616193716.GC15931@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Augie Fackler <augie@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 21:49:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4wrF-0006jx-1B
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 21:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752741AbbFPTtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 15:49:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:47025 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752365AbbFPTtL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 15:49:11 -0400
Received: (qmail 21022 invoked by uid 102); 16 Jun 2015 19:49:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Jun 2015 14:49:10 -0500
Received: (qmail 18377 invoked by uid 107); 16 Jun 2015 19:49:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Jun 2015 15:49:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Jun 2015 15:49:08 -0400
Content-Disposition: inline
In-Reply-To: <20150616193716.GC15931@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271792>

On Tue, Jun 16, 2015 at 03:37:16PM -0400, Jeff King wrote:

> For instance:
> 
>   GIT_TRACE=/tmp/processes.out \
>   GIT_TRACE_STDIN=/tmp/stdin.%p \
>   git daemon ...
> 
> After a fetch, processes.out will contain a line like:
> 
>   15:19:08.275493 [pid=13196] git.c:348             trace:
>   built-in: git 'pack-objects' '--revs' '--thin' '--stdout'
>   '--progress' '--delta-base-offset'
> 
> And stdin.13196 (the pid picked from the above line) will
> contain its stdin.

So this is the part that I don't like. Collecting stdin is expensive,
and the commands above would be totally inappropriate for a production
server, for two reasons:

  1. It requires restarting git-daemon to turn on debugging.

  2. It logs for _everything_. Every repo, and every process.

I mentioned before that I have a similar patch for logging pack-objects.
That is triggered via config, which solves both of these problems. What
I'd really like is to be able to do:

  git config trace.pack-objects.stdin fetches/stdin.%p

in a particular repository, collect data for a few minutes, and then
turn it back off.

The patch below implements that, but it doesn't quite work as you might
hope. The problem is that we cannot read the repository config so early
in the git.c startup; we do not even know if we have a repository yet.
Pushing the config-reading later is too late; we may already have looked
at GIT_TRACE_* and decided whether to trace (and possibly even written
trace records!).

It's possible we could hack around it by rearranging the startup
sequence, but that sequence is notoriously fragile.

Another option would be to stop trying to intercept stdin in git.c, and
instead make this a feature of run-command.c. That is, right before we
exec a process, tee its stdin there. That means that you cannot do:

  GIT_TRACE_STDIN=/tmp/foo.out git foo

to collect the stdin of foo. But that is not really an interesting case
anyway. You can run "tee" yourself if you want. The interesting cases
are the ones where git is spawning a sub-process, and you want to
intercept the data moving between the git processes.

-Peff

---
diff --git a/git.c b/git.c
index e7e58e3..cbb7e9b 100644
--- a/git.c
+++ b/git.c
@@ -675,6 +675,38 @@ static void trace_stdin(void)
 	 */
 }
 
+static int trace_config_cb(const char *var, const char *value, void *data)
+{
+	const char *want_cmd = data;
+	const char *have_cmd, *key;
+	int have_len;
+
+	if (!parse_config_key(var, "trace", &have_cmd, &have_len, &key) &&
+	    have_cmd &&
+	    !strncmp(want_cmd, have_cmd, have_len) &&
+	    want_cmd[have_len] == '\0') {
+		struct strbuf buf = STRBUF_INIT;
+		strbuf_addstr(&buf, "GIT_TRACE_");
+		while (*key)
+			strbuf_addch(&buf, toupper(*key++));
+		setenv(buf.buf, value, 0);
+		strbuf_release(&buf);
+	}
+	return 0;
+}
+
+static void load_trace_config(const char *cmd, const char **argv)
+{
+	/* XXX we don't know the cmd for sure until we parse the options */
+	if (!strcmp(cmd, "git"))
+		cmd = argv[1];
+	else
+		skip_prefix(cmd, "git-", &cmd);
+
+	if (cmd)
+		git_config(trace_config_cb, (void *)cmd);
+}
+
 int main(int argc, char **av)
 {
 	const char **argv = (const char **) av;
@@ -698,6 +730,7 @@ int main(int argc, char **av)
 
 	git_setup_gettext();
 
+	load_trace_config(cmd, argv);
 	trace_command_performance(argv);
 	trace_stdin();
 
