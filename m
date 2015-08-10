From: Jeff King <peff@peff.net>
Subject: [PATCH 15/17] find_hook: keep our own static buffer
Date: Mon, 10 Aug 2015 05:37:45 -0400
Message-ID: <20150810093744.GO30981@sigill.intra.peff.net>
References: <20150810092731.GA9027@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 11:37:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjWk-0005NJ-7v
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 11:37:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617AbbHJJhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 05:37:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:42861 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754457AbbHJJhu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 05:37:50 -0400
Received: (qmail 31070 invoked by uid 102); 10 Aug 2015 09:37:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 04:37:50 -0500
Received: (qmail 3271 invoked by uid 107); 10 Aug 2015 09:38:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 05:38:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Aug 2015 05:37:45 -0400
Content-Disposition: inline
In-Reply-To: <20150810092731.GA9027@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275581>

The find_hook function returns the results of git_path,
which is a static buffer shared by other path-related calls.
Returning such a buffer is slightly dangerous, because it
can be overwritten by seemingly unrelated functions.

Let's at least keep our _own_ static buffer, so you can
only get in trouble by calling find_hook in quick
succession, which is less likely to happen and more obvious
to notice.

While we're at it, let's add some documentation of the
function's limitations.

Signed-off-by: Jeff King <peff@peff.net>
---
 run-command.c | 10 ++++++----
 run-command.h |  5 +++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/run-command.c b/run-command.c
index 4d73e90..28e1d55 100644
--- a/run-command.c
+++ b/run-command.c
@@ -797,11 +797,13 @@ int finish_async(struct async *async)
 
 const char *find_hook(const char *name)
 {
-	const char *path = git_path("hooks/%s", name);
-	if (access(path, X_OK) < 0)
-		path = NULL;
+	static struct strbuf path = STRBUF_INIT;
 
-	return path;
+	strbuf_reset(&path);
+	strbuf_git_path(&path, "hooks/%s", name);
+	if (access(path.buf, X_OK) < 0)
+		return NULL;
+	return path.buf;
 }
 
 int run_hook_ve(const char *const *env, const char *name, va_list args)
diff --git a/run-command.h b/run-command.h
index 1103805..5b4425a 100644
--- a/run-command.h
+++ b/run-command.h
@@ -52,6 +52,11 @@ int start_command(struct child_process *);
 int finish_command(struct child_process *);
 int run_command(struct child_process *);
 
+/*
+ * Returns the path to the hook file, or NULL if the hook is missing
+ * or disabled. Note that this points to static storage that will be
+ * overwritten by further calls to find_hook and run_hook_*.
+ */
 extern const char *find_hook(const char *name);
 LAST_ARG_MUST_BE_NULL
 extern int run_hook_le(const char *const *env, const char *name, ...);
-- 
2.5.0.414.g670f2a4
