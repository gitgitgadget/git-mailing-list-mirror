From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] read_packed_refs: pass strbuf to parse_ref_line
Date: Wed, 10 Dec 2014 05:40:19 -0500
Message-ID: <20141210104019.GB24514@peff.net>
References: <20141210103907.GA22186@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 11:40:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xyeh3-0007QY-Nv
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 11:40:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755192AbaLJKkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 05:40:23 -0500
Received: from cloud.peff.net ([50.56.180.127]:50999 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753222AbaLJKkW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 05:40:22 -0500
Received: (qmail 29571 invoked by uid 102); 10 Dec 2014 10:40:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Dec 2014 04:40:22 -0600
Received: (qmail 8262 invoked by uid 107); 10 Dec 2014 10:40:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Dec 2014 05:40:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Dec 2014 05:40:19 -0500
Content-Disposition: inline
In-Reply-To: <20141210103907.GA22186@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261207>

Now that we have a strbuf in read_packed_refs, we can pass
it straight to the line parser, which saves us an extra
strlen.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index 6f31935..10f8247 100644
--- a/refs.c
+++ b/refs.c
@@ -1068,8 +1068,10 @@ static const char PACKED_REFS_HEADER[] =
  * Return a pointer to the refname within the line (null-terminated),
  * or NULL if there was a problem.
  */
-static const char *parse_ref_line(char *line, unsigned char *sha1)
+static const char *parse_ref_line(struct strbuf *line, unsigned char *sha1)
 {
+	const char *ref;
+
 	/*
 	 * 42: the answer to everything.
 	 *
@@ -1078,22 +1080,23 @@ static const char *parse_ref_line(char *line, unsigned char *sha1)
 	 *  +1 (space in between hex and name)
 	 *  +1 (newline at the end of the line)
 	 */
-	int len = strlen(line) - 42;
-
-	if (len <= 0)
+	if (line->len <= 42)
 		return NULL;
-	if (get_sha1_hex(line, sha1) < 0)
+
+	if (get_sha1_hex(line->buf, sha1) < 0)
 		return NULL;
-	if (!isspace(line[40]))
+	if (!isspace(line->buf[40]))
 		return NULL;
-	line += 41;
-	if (isspace(*line))
+
+	ref = line->buf + 41;
+	if (isspace(*ref))
 		return NULL;
-	if (line[len] != '\n')
+
+	if (line->buf[line->len - 1] != '\n')
 		return NULL;
-	line[len] = 0;
+	line->buf[--line->len] = 0;
 
-	return line;
+	return ref;
 }
 
 /*
@@ -1144,7 +1147,7 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 			continue;
 		}
 
-		refname = parse_ref_line(line.buf, sha1);
+		refname = parse_ref_line(&line, sha1);
 		if (refname) {
 			int flag = REF_ISPACKED;
 
-- 
2.2.0.454.g7eca6b7
