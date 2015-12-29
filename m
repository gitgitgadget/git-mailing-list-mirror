From: Jeff King <peff@peff.net>
Subject: [PATCH 07/14] shortlog: optimize "--summary" mode
Date: Tue, 29 Dec 2015 02:30:27 -0500
Message-ID: <20151229073027.GG8842@sigill.intra.peff.net>
References: <20151229071847.GA8726@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 08:30:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDojq-0007oc-Dr
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 08:30:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753147AbbL2Haa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 02:30:30 -0500
Received: from cloud.peff.net ([50.56.180.127]:46628 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753067AbbL2Haa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 02:30:30 -0500
Received: (qmail 18160 invoked by uid 102); 29 Dec 2015 07:30:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 01:30:30 -0600
Received: (qmail 19915 invoked by uid 107); 29 Dec 2015 07:30:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 02:30:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Dec 2015 02:30:27 -0500
Content-Disposition: inline
In-Reply-To: <20151229071847.GA8726@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283098>

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
index 10c92fa..af24d84 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -130,10 +130,12 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 		return;
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
 	strbuf_release(&author);
-- 
2.7.0.rc3.367.g09631da
