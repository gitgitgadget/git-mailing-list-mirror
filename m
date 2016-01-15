From: Jeff King <peff@peff.net>
Subject: [PATCH 2/6] shortlog: use strbufs to read from stdin
Date: Fri, 15 Jan 2016 12:08:35 -0500
Message-ID: <20160115170835.GB21102@sigill.intra.peff.net>
References: <20160115170627.GA20983@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 18:08:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK7rd-0007FL-S1
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 18:08:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322AbcAORIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 12:08:38 -0500
Received: from cloud.peff.net ([50.56.180.127]:54467 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751396AbcAORIh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 12:08:37 -0500
Received: (qmail 2158 invoked by uid 102); 15 Jan 2016 17:08:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jan 2016 12:08:37 -0500
Received: (qmail 21360 invoked by uid 107); 15 Jan 2016 17:08:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jan 2016 12:08:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jan 2016 12:08:35 -0500
Content-Disposition: inline
In-Reply-To: <20160115170627.GA20983@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284182>

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
index fe9fa2f..bb2ee5b 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -112,20 +112,23 @@ static int match_ident_header(const char *candidate, const char *header,
 
 static void read_from_stdin(struct shortlog *log)
 {
-	char author[1024], oneline[1024];
+	struct strbuf author = STRBUF_INIT;
+	struct strbuf oneline = STRBUF_INIT;
 
-	while (fgets(author, sizeof(author), stdin) != NULL) {
+	while (strbuf_getline(&author, stdin, '\n') != EOF) {
 		const char *v;
-		if (!match_ident_header(author, "author", &v))
+		if (!match_ident_header(author.buf, "author", &v))
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
2.7.0.244.g0701a9d
