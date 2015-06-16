From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] trace: add GIT_TRACE_STDIN
Date: Tue, 16 Jun 2015 15:37:16 -0400
Message-ID: <20150616193716.GC15931@peff.net>
References: <20150616193102.GA15856@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Augie Fackler <augie@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 21:37:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4wfp-0003lv-KS
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 21:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752944AbbFPThV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 15:37:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:47010 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752588AbbFPThT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 15:37:19 -0400
Received: (qmail 20424 invoked by uid 102); 16 Jun 2015 19:37:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Jun 2015 14:37:19 -0500
Received: (qmail 18284 invoked by uid 107); 16 Jun 2015 19:37:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Jun 2015 15:37:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Jun 2015 15:37:16 -0400
Content-Disposition: inline
In-Reply-To: <20150616193102.GA15856@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271791>

Sometimes tracing the invocation of git programs with
GIT_TRACE is not quite enough to replay a situation; the
interesting input to the program often comes over its
standard input. For instance, if you want to replay a
particular fetch (e.g., for performance analysis or
debugging), you would want both the arguments and stdin sent
to pack-objects.

This patch lets you capture the stdin of any git process.
For instance:

  GIT_TRACE=/tmp/processes.out \
  GIT_TRACE_STDIN=/tmp/stdin.%p \
  git daemon ...

After a fetch, processes.out will contain a line like:

  15:19:08.275493 [pid=13196] git.c:348             trace:
  built-in: git 'pack-objects' '--revs' '--thin' '--stdout'
  '--progress' '--delta-base-offset'

And stdin.13196 (the pid picked from the above line) will
contain its stdin.

Signed-off-by: Jeff King <peff@peff.net>
---
 git.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/git.c b/git.c
index 44374b1..e7e58e3 100644
--- a/git.c
+++ b/git.c
@@ -616,6 +616,65 @@ static void restore_sigpipe_to_default(void)
 	signal(SIGPIPE, SIG_DFL);
 }
 
+static int copy_stdin(int in, int out, void *data)
+{
+	struct trace_key *key = data;
+	while (1) {
+		char buf[8192];
+		ssize_t len = xread(in, buf, sizeof(buf));
+		if (!len)
+			break;
+		if (len < 0) {
+			warning("error reading stdin trace: %s",
+				strerror(errno));
+			break;
+		}
+
+		trace_verbatim(key, buf, len);
+		if (write_in_full(out, buf, len) < 0) {
+			warning("error writing stdin trace: %s",
+				strerror(errno));
+			break;
+		}
+	}
+	close(in);
+	close(out);
+	return 0;
+}
+
+static void trace_stdin(void)
+{
+	static struct trace_key key = TRACE_KEY_INIT(STDIN);
+	static struct async async;
+
+	if (!trace_want(&key))
+		return;
+
+	memset(&async, 0, sizeof(async));
+	async.proc = copy_stdin;
+	async.data = &key;
+	async.in = dup(0);
+	async.out = -1;
+
+	if (async.in < 0 || start_async(&async) < 0) {
+		warning("unable to trace stdin: %s", strerror(errno));
+		return ;
+	}
+
+	/*
+	 * At this point we've handed stdin off to the async process,
+	 * so there we are past the point of no return.
+	 */
+	if (dup2(async.out, 0))
+		die_errno("unable to redirect stdin from async process");
+	close(async.out);
+
+	/*
+	 * leak async; we would know to finish_async() only when we are
+	 * exiting, and there is no point then
+	 */
+}
+
 int main(int argc, char **av)
 {
 	const char **argv = (const char **) av;
@@ -640,6 +699,7 @@ int main(int argc, char **av)
 	git_setup_gettext();
 
 	trace_command_performance(argv);
+	trace_stdin();
 
 	/*
 	 * "git-xxxx" is the same as "git xxxx", but we obviously:
-- 
2.4.3.699.g84b4da7
