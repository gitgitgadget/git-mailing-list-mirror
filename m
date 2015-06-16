From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] pkt-line: support tracing verbatim pack contents
Date: Tue, 16 Jun 2015 13:10:06 -0400
Message-ID: <20150616171005.GB18667@peff.net>
References: <20150612212526.GA25447@peff.net>
 <20150612212827.GC25757@peff.net>
 <CAHcr6HYvVR4uTmtegWHK0h+v_aVs4JVLsSwvjthGY3pb=-Q0yQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Augie Fackler <augie@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 19:10:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4uNL-0002S8-1x
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 19:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbbFPRKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 13:10:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:46872 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750806AbbFPRKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 13:10:09 -0400
Received: (qmail 14116 invoked by uid 102); 16 Jun 2015 17:10:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Jun 2015 12:10:08 -0500
Received: (qmail 16684 invoked by uid 107); 16 Jun 2015 17:10:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Jun 2015 13:10:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Jun 2015 13:10:06 -0400
Content-Disposition: inline
In-Reply-To: <CAHcr6HYvVR4uTmtegWHK0h+v_aVs4JVLsSwvjthGY3pb=-Q0yQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271780>

On Tue, Jun 16, 2015 at 11:38:41AM -0400, Augie Fackler wrote:

> > We already have a GIT_TRACE_PACKET mechanism for tracing
> > packets. Let's extend it with GIT_TRACE_PACK to dump the
> > verbatim packfile.
> 
> FWIW, this also works for me - I have no preference between my patches
> and Jeff's. I suspect yours are much better given that you have a clue
> about git internals ;).

I like mine better than yours, if only because it hooks into the
existing tracing mechanism. But I am sad that neither of our proposals
works for tracing pushed packs (something that is useful for the
opposite situation: you have a sane git server, and some unknown
misbehaving _client_ is sending you bogus packs).

Here's a rough cut at the "trace stdin" idea I mentioned earlier (which
is essentially an internal "tee"). You can collect the incoming pack
like:

  GIT_TRACE=1 \
  GIT_TRACE_STDIN=/tmp/foo.pack \
  GIT_TRACE_STDIN_FOR=index-pack \
  git fetch ...

The "STDIN_FOR" hack is there because otherwise you get the stdin for
multiple processes intermingled. I think a cleaner way to do it would be
to allow something like:

  GIT_TRACE_STDIN=/tmp/stdin.%p

and replace "%p" with the PID of the tracing process.

I like this approach because it works everywhere (for pushed packs, but
also for any other git commands you may want to debug).  The downside
versus the other patches is that to replay the index-pack command, you
need to collect both its stdin and its arguments (which you can get from
the GIT_TRACE output). On the other hand, it gives you a more realistic
replay of what happened (e.g., if there is a bug triggered by the
--pack-header code).

Here is the patch:

---
diff --git a/git.c b/git.c
index 44374b1..d58866e 100644
--- a/git.c
+++ b/git.c
@@ -616,6 +616,80 @@ static void restore_sigpipe_to_default(void)
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
+static int trace_stdin_for(const char *cmd)
+{
+	int ret = 1;
+	const char *x = getenv("GIT_TRACE_STDIN_FOR");
+
+	if (x) {
+		struct string_list items = STRING_LIST_INIT_DUP;
+		string_list_split(&items, x, ':', -1);
+		ret = unsorted_string_list_has_string(&items, cmd);
+		string_list_clear(&items, 0);
+	}
+
+	return ret;
+}
+
+static void trace_stdin(const char *cmd)
+{
+	static struct trace_key key = TRACE_KEY_INIT(STDIN);
+	static struct async async;
+
+	if (!trace_stdin_for(cmd) || !trace_want(&key))
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
@@ -674,6 +748,8 @@ int main(int argc, char **av)
 	}
 	cmd = argv[0];
 
+	trace_stdin(cmd);
+
 	/*
 	 * We use PATH to find git commands, but we prepend some higher
 	 * precedence paths: the "--exec-path" option, the GIT_EXEC_PATH
