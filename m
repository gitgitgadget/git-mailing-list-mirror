From: Jeff King <peff@peff.net>
Subject: [PATCH 2/6] shortlog: use strbufs to read from stdin
Date: Mon, 18 Jan 2016 15:02:44 -0500
Message-ID: <20160118200244.GB15836@sigill.intra.peff.net>
References: <20160118200136.GA9514@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 21:02:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLG0p-00031h-8A
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 21:02:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbcARUCr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 15:02:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:55638 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756395AbcARUCq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 15:02:46 -0500
Received: (qmail 32037 invoked by uid 102); 18 Jan 2016 20:02:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jan 2016 15:02:46 -0500
Received: (qmail 13420 invoked by uid 107); 18 Jan 2016 20:03:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jan 2016 15:03:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jan 2016 15:02:44 -0500
Content-Disposition: inline
In-Reply-To: <20160118200136.GA9514@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284316>

We currently use fixed-size buffers with fgets(), which
could lead to incorrect results in the unlikely event that a
line had something like "Author:" at exactly its 1024th
character.

But it's easy to convert this to a strbuf, and because we
can reuse the same buffer through the loop, we don't even
pay the extra allocation cost.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/shortlog.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index ab25b44..6c0a72e 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -91,21 +91,24 @@ static void insert_one_record(struct shortlog *log,
 
 static void read_from_stdin(struct shortlog *log)
 {
-	char author[1024], oneline[1024];
+	struct strbuf author = STRBUF_INIT;
+	struct strbuf oneline = STRBUF_INIT;
 
-	while (fgets(author, sizeof(author), stdin) != NULL) {
+	while (strbuf_getline(&author, stdin, '\n') != EOF) {
 		const char *v;
-		if (!skip_prefix(author, "Author: ", &v) &&
-		    !skip_prefix(author, "author ", &v))
+		if (!skip_prefix(author.buf, "Author: ", &v) &&
+		    !skip_prefix(author.buf, "author ", &v))
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
2.7.0.248.g5eafd77
