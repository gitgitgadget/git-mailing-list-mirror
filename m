From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] read_packed_refs: use a strbuf for reading lines
Date: Wed, 10 Dec 2014 05:40:07 -0500
Message-ID: <20141210104007.GA24514@peff.net>
References: <20141210103907.GA22186@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 11:40:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xyegt-0007Jk-2o
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 11:40:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372AbaLJKkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 05:40:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:50993 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753222AbaLJKkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 05:40:09 -0500
Received: (qmail 29556 invoked by uid 102); 10 Dec 2014 10:40:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Dec 2014 04:40:10 -0600
Received: (qmail 8242 invoked by uid 107); 10 Dec 2014 10:40:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Dec 2014 05:40:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Dec 2014 05:40:07 -0500
Content-Disposition: inline
In-Reply-To: <20141210103907.GA22186@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261206>

We currently used a fixed PATH_MAX-sized buffer for reading
packed-refs lines. This is a reasonable guess, in the sense
that git generally cannot work with refs larger than
PATH_MAX. However, there are a few cases where it is not
great:

  1. Some systems may have a low value of PATH_MAX, but can
     actually handle larger paths in practice. Fixing this
     code path probably isn't enough to make them work
     completely with long refs, but it is a step in the
     right direction.

  2. We use fgets, which will happily give us half a line on
     the first read, and then the rest of the line on the
     second. This is probably OK in practice, because our
     refline parser is careful enough to look for the
     trailing newline on the first line. The second line may
     look like a peeled line to us, but since "^" is illegal
     in refnames, it is not likely to come up.

     Still, it does not hurt to be more careful.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 5ff457e..6f31935 100644
--- a/refs.c
+++ b/refs.c
@@ -1126,16 +1126,16 @@ static const char *parse_ref_line(char *line, unsigned char *sha1)
 static void read_packed_refs(FILE *f, struct ref_dir *dir)
 {
 	struct ref_entry *last = NULL;
-	char refline[PATH_MAX];
+	struct strbuf line = STRBUF_INIT;
 	enum { PEELED_NONE, PEELED_TAGS, PEELED_FULLY } peeled = PEELED_NONE;
 
-	while (fgets(refline, sizeof(refline), f)) {
+	while (strbuf_getwholeline(&line, f, '\n') != EOF) {
 		unsigned char sha1[20];
 		const char *refname;
 		static const char header[] = "# pack-refs with:";
 
-		if (!strncmp(refline, header, sizeof(header)-1)) {
-			const char *traits = refline + sizeof(header) - 1;
+		if (!strncmp(line.buf, header, sizeof(header)-1)) {
+			const char *traits = line.buf + sizeof(header) - 1;
 			if (strstr(traits, " fully-peeled "))
 				peeled = PEELED_FULLY;
 			else if (strstr(traits, " peeled "))
@@ -1144,7 +1144,7 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 			continue;
 		}
 
-		refname = parse_ref_line(refline, sha1);
+		refname = parse_ref_line(line.buf, sha1);
 		if (refname) {
 			int flag = REF_ISPACKED;
 
@@ -1160,10 +1160,10 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 			continue;
 		}
 		if (last &&
-		    refline[0] == '^' &&
-		    strlen(refline) == PEELED_LINE_LENGTH &&
-		    refline[PEELED_LINE_LENGTH - 1] == '\n' &&
-		    !get_sha1_hex(refline + 1, sha1)) {
+		    line.buf[0] == '^' &&
+		    line.len == PEELED_LINE_LENGTH &&
+		    line.buf[PEELED_LINE_LENGTH - 1] == '\n' &&
+		    !get_sha1_hex(line.buf + 1, sha1)) {
 			hashcpy(last->u.value.peeled, sha1);
 			/*
 			 * Regardless of what the file header said,
@@ -1173,6 +1173,8 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 			last->flag |= REF_KNOWS_PEELED;
 		}
 	}
+
+	strbuf_release(&line);
 }
 
 /*
-- 
2.2.0.454.g7eca6b7
