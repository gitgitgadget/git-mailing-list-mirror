From: Jeff King <peff@peff.net>
Subject: [PATCH 3/7] record_author_info: use find_commit_header
Date: Wed, 18 Jun 2014 16:29:27 -0400
Message-ID: <20140618202927.GC23896@sigill.intra.peff.net>
References: <20140618201944.GA23238@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 22:29:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxMU9-0007Dy-Fi
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 22:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755394AbaFRU33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 16:29:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:47005 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755202AbaFRU33 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 16:29:29 -0400
Received: (qmail 657 invoked by uid 102); 18 Jun 2014 20:29:29 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jun 2014 15:29:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jun 2014 16:29:27 -0400
Content-Disposition: inline
In-Reply-To: <20140618201944.GA23238@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252058>

This saves us some manual parsing and makes the code more
readable.

Signed-off-by: Jeff King <peff@peff.net>
---
I suspect there are other sites which could use this helper, too; I
didn't do an exhaustive search.

 commit.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/commit.c b/commit.c
index 0c40cfa..c33431c 100644
--- a/commit.c
+++ b/commit.c
@@ -606,26 +606,19 @@ define_commit_slab(author_date_slab, unsigned long);
 static void record_author_date(struct author_date_slab *author_date,
 			       struct commit *commit)
 {
-	const char *buf, *line_end, *ident_line;
 	const char *buffer = get_commit_buffer(commit, NULL);
 	struct ident_split ident;
+	const char *ident_line;
+	size_t ident_len;
 	char *date_end;
 	unsigned long date;
 
-	for (buf = buffer; buf; buf = line_end + 1) {
-		line_end = strchrnul(buf, '\n');
-		ident_line = skip_prefix(buf, "author ");
-		if (!ident_line) {
-			if (!line_end[0] || line_end[1] == '\n')
-				goto fail_exit; /* end of header */
-			continue;
-		}
-		if (split_ident_line(&ident,
-				     ident_line, line_end - ident_line) ||
-		    !ident.date_begin || !ident.date_end)
-			goto fail_exit; /* malformed "author" line */
-		break;
-	}
+	ident_line = find_commit_header(buffer, "author", &ident_len);
+	if (!ident_line)
+		goto fail_exit; /* no author line */
+	if (split_ident_line(&ident, ident_line, ident_len) ||
+	    !ident.date_begin || !ident.date_end)
+		goto fail_exit; /* malformed "author" line */
 
 	date = strtoul(ident.date_begin, &date_end, 10);
 	if (date_end != ident.date_end)
-- 
2.0.0.566.gfe3e6b2
