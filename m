From: Jeff King <peff@peff.net>
Subject: [PATCH 4/6] shortlog: optimize "--summary" mode
Date: Mon, 18 Jan 2016 15:02:52 -0500
Message-ID: <20160118200251.GD15836@sigill.intra.peff.net>
References: <20160118200136.GA9514@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 21:03:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLG0x-00036i-Fs
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 21:02:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbcARUCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 15:02:55 -0500
Received: from cloud.peff.net ([50.56.180.127]:55648 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932223AbcARUCz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 15:02:55 -0500
Received: (qmail 32099 invoked by uid 102); 18 Jan 2016 20:02:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jan 2016 15:02:54 -0500
Received: (qmail 13456 invoked by uid 107); 18 Jan 2016 20:03:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jan 2016 15:03:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jan 2016 15:02:52 -0500
Content-Disposition: inline
In-Reply-To: <20160118200136.GA9514@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284318>

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
index 1261ec4..973b50d 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -132,10 +132,12 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
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
2.7.0.248.g5eafd77
