From: Jeff King <peff@peff.net>
Subject: [PATCH 4/6] shortlog: optimize "--summary" mode
Date: Fri, 15 Jan 2016 12:09:33 -0500
Message-ID: <20160115170933.GD21102@sigill.intra.peff.net>
References: <20160115170627.GA20983@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 18:09:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK7sZ-00082z-Uo
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 18:09:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753910AbcAORJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 12:09:36 -0500
Received: from cloud.peff.net ([50.56.180.127]:54473 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753873AbcAORJg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 12:09:36 -0500
Received: (qmail 2204 invoked by uid 102); 15 Jan 2016 17:09:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jan 2016 12:09:35 -0500
Received: (qmail 21394 invoked by uid 107); 15 Jan 2016 17:09:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jan 2016 12:09:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jan 2016 12:09:33 -0500
Content-Disposition: inline
In-Reply-To: <20160115170627.GA20983@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284184>

If the user asked us only to show counts for each author,
rather than the individual summary lines, then there is no
point in us generating the summaries only to throw them
away. With this patch, I measured the following speedup for
"git shortlog -ns HEAD" on linux.git (best-of-five):

  [before]
  real    0m5.644s
  user    0m5.472s
  sys     0m0.176s

  [after]
  real    0m5.257s
  user    0m5.104s
  sys     0m0.156s

That's only ~7%, but it's so easy to do, there's no good
reason not to. We don't have to touch any downstream code,
since we already fill in the magic string "<none>" to handle
commits without a message.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/shortlog.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 256b868..3e1e0d6 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -152,10 +152,12 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 		goto out;
 	}
 
-	if (log->user_format)
-		pretty_print_commit(&ctx, commit, &oneline);
-	else
-		format_commit_message(commit, "%s", &oneline, &ctx);
+	if (!log->summary) {
+		if (log->user_format)
+			pretty_print_commit(&ctx, commit, &oneline);
+		else
+			format_commit_message(commit, "%s", &oneline, &ctx);
+	}
 
 	insert_one_record(log, author.buf, oneline.len ? oneline.buf : "<none>");
 
-- 
2.7.0.244.g0701a9d
