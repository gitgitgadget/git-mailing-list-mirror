From: Jeff King <peff@peff.net>
Subject: [PATCH v2 3/6] record_author_info: use find_commit_header
Date: Wed, 27 Aug 2014 03:56:55 -0400
Message-ID: <20140827075654.GC26384@peff.net>
References: <20140827075503.GA19521@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 27 09:57:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMY6H-0002P9-NX
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 09:57:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754305AbaH0H45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 03:56:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:59890 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752264AbaH0H44 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 03:56:56 -0400
Received: (qmail 14657 invoked by uid 102); 27 Aug 2014 07:56:57 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Aug 2014 02:56:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Aug 2014 03:56:55 -0400
Content-Disposition: inline
In-Reply-To: <20140827075503.GA19521@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255985>

This saves us some manual parsing and makes the code more
readable.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/commit.c b/commit.c
index 4ff8c66..9416d84 100644
--- a/commit.c
+++ b/commit.c
@@ -584,25 +584,19 @@ define_commit_slab(author_date_slab, unsigned long);
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
-		if (!skip_prefix(buf, "author ", &ident_line)) {
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
2.1.0.346.ga0367b9
