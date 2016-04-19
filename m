From: Jeff King <peff@peff.net>
Subject: [PATCH 2/5] run-command: teach async threads to ignore SIGPIPE
Date: Tue, 19 Apr 2016 18:49:41 -0400
Message-ID: <20160419224941.GB18255@sigill.intra.peff.net>
References: <20160419223945.GA18055@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 00:49:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aseSr-00010j-RQ
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 00:49:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461AbcDSWtp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 18:49:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:52439 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752377AbcDSWto (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 18:49:44 -0400
Received: (qmail 27723 invoked by uid 102); 19 Apr 2016 22:49:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Apr 2016 18:49:44 -0400
Received: (qmail 20900 invoked by uid 107); 19 Apr 2016 22:49:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Apr 2016 18:49:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Apr 2016 18:49:41 -0400
Content-Disposition: inline
In-Reply-To: <20160419223945.GA18055@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291943>

Async processes can be implemented as separate forked
processes, or as threads (depending on the NO_PTHREADS
setting). In the latter case, if an async thread gets
SIGPIPE, it takes down the whole process. This is obviously
bad if the main process was not otherwise going to die, but
even if we were going to die, it means the main process does
not have a chance to report a useful error message.

There's also the small matter that forked async processes
will not take the main process down on a signal, meaning git
will behave differently depending on the NO_PTHREADS
setting.

This patch fixes it by adding a new flag to "struct async"
to block SIGPIPE just in the async thread. In theory, this
should always be on (which makes async threads behave more
like async processes), but we would first want to make sure
that each async process we spawn is careful about checking
return codes from write() and would not spew endlessly into
a dead pipe. So let's start with it as optional, and we can
enable it for specific sites in future patches.

The natural name for this option would be "ignore_sigpipe",
since that's what it does for the threaded case. But since
that name might imply that we are ignoring it in all cases
(including the separate-process one), let's call it
"isolate_sigpipe". What we are really asking for is
isolation. I.e., not to have our main process taken down by
signals spawned by the async process. How that is
implemented is up to the run-command code.

Signed-off-by: Jeff King <peff@peff.net>
---
This is our first use of pthread_sigmask, and I think Windows will have
to come up with something for this in compat/. I don't know how SIGPIPE
works there at all, so it's possible that we can just turn this into a
noop. Worst case it could probably block SIGPIPE for the whole process.

Note also that by blocking, we may end up with a pending SIGPIPE signal
(so if were ever to unblock, it would get delivered). We can unqueue it
with sigwaitinfo(), but I _think_ it shouldn't matter. We never unblock,
but just kill the thread, and the pending signal should be killed with
it.

At least that's my understanding. This is the first time I've worked
with signals and threads.

 run-command.c | 10 ++++++++++
 run-command.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/run-command.c b/run-command.c
index 8c7115a..e4593cd 100644
--- a/run-command.c
+++ b/run-command.c
@@ -590,6 +590,16 @@ static void *run_thread(void *data)
 	struct async *async = data;
 	intptr_t ret;
 
+	if (async->isolate_sigpipe) {
+		sigset_t mask;
+		sigemptyset(&mask);
+		sigaddset(&mask, SIGPIPE);
+		if (pthread_sigmask(SIG_BLOCK, &mask, NULL) < 0) {
+			ret = error("unable to block SIGPIPE in async thread");
+			return (void *)ret;
+		}
+	}
+
 	pthread_setspecific(async_key, async);
 	ret = async->proc(async->proc_in, async->proc_out, async->data);
 	return (void *)ret;
diff --git a/run-command.h b/run-command.h
index de1727e..11f76b0 100644
--- a/run-command.h
+++ b/run-command.h
@@ -116,6 +116,7 @@ struct async {
 	int proc_in;
 	int proc_out;
 #endif
+	int isolate_sigpipe;
 };
 
 int start_async(struct async *async);
-- 
2.8.1.512.g4e0a533
