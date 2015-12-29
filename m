From: Jeff King <peff@peff.net>
Subject: [PATCH 05/14] shortlog: use strbufs to read from stdin
Date: Tue, 29 Dec 2015 02:28:03 -0500
Message-ID: <20151229072803.GE8842@sigill.intra.peff.net>
References: <20151229071847.GA8726@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 08:28:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDohs-0005we-0M
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 08:28:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752959AbbL2H21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 02:28:27 -0500
Received: from cloud.peff.net ([50.56.180.127]:46620 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752706AbbL2H2G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 02:28:06 -0500
Received: (qmail 18064 invoked by uid 102); 29 Dec 2015 07:28:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 01:28:06 -0600
Received: (qmail 19853 invoked by uid 107); 29 Dec 2015 07:28:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 02:28:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Dec 2015 02:28:03 -0500
Content-Disposition: inline
In-Reply-To: <20151229071847.GA8726@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283096>

We currently use fixed-size buffers with fgets(), which
could lead to incorrect results in the unlikely event that a
line had something like "Author:" at exactly its 1024th
character.

But it's easy to convert this to a strbuf, and because we
can reuse the same buffer through the loop, we don't even
pay the extra allocation cost.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/shortlog.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 86e277a..668cdb4 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -91,20 +91,23 @@ static void insert_one_record(struct shortlog *log,
 
 static void read_from_stdin(struct shortlog *log)
 {
-	char author[1024], oneline[1024];
+	struct strbuf author = STRBUF_INIT;
+	struct strbuf oneline = STRBUF_INIT;
 
-	while (fgets(author, sizeof(author), stdin) != NULL) {
+	while (strbuf_getline(&author, stdin, '\n') != EOF) {
 		const char *v;
-		if (!skip_prefix_icase(author, "Author: ", &v))
+		if (!skip_prefix_icase(author.buf, "Author: ", &v))
 			continue;
-		while (fgets(oneline, sizeof(oneline), stdin) &&
-		       oneline[0] != '\n')
+		while (strbuf_getline(&oneline, stdin, '\n') != EOF &&
+		       oneline.len)
 			; /* discard headers */
-		while (fgets(oneline, sizeof(oneline), stdin) &&
-		       oneline[0] == '\n')
+		while (strbuf_getline(&oneline, stdin, '\n') != EOF &&
+		       !oneline.len)
 			; /* discard blanks */
-		insert_one_record(log, v, oneline);
+		insert_one_record(log, v, oneline.buf);
 	}
+	strbuf_release(&author);
+	strbuf_release(&oneline);
 }
 
 void shortlog_add_commit(struct shortlog *log, struct commit *commit)
-- 
2.7.0.rc3.367.g09631da
