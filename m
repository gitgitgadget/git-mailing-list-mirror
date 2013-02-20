From: Jeff King <peff@peff.net>
Subject: [PATCH v3 05/19] send-pack: prefer prefixcmp over memcmp in
 receive_status
Date: Wed, 20 Feb 2013 15:00:43 -0500
Message-ID: <20130220200043.GE25647@sigill.intra.peff.net>
References: <20130220195147.GA25332@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 20 21:01:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8Fqp-0003kZ-1L
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 21:01:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935006Ab3BTUAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 15:00:46 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54572 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934523Ab3BTUAp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 15:00:45 -0500
Received: (qmail 17658 invoked by uid 107); 20 Feb 2013 20:02:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Feb 2013 15:02:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Feb 2013 15:00:43 -0500
Content-Disposition: inline
In-Reply-To: <20130220195147.GA25332@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216719>

This code predates prefixcmp, so it used memcmp along with
static sizes. Replacing these memcmps with prefixcmp makes
the code much more readable, and the lack of static sizes
will make refactoring it in future patches simpler.

Note that we used to be unnecessarily liberal in parsing the
"unpack" status line, and would accept "unpack ok\njunk". No
version of git has ever produced that, and it violates the
BNF in Documentation/technical/pack-protocol.txt. Let's take
this opportunity to tighten the check by converting the
prefix comparison into a strcmp.

While we're in the area, let's also fix a vague error
message that does not follow our usual conventions (it
writes directly to stderr and does not use the "error:"
prefix).

Signed-off-by: Jeff King <peff@peff.net>
---
 send-pack.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 97ab336..e91cbe2 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -109,9 +109,9 @@ static int receive_status(int in, struct ref *refs)
 	char line[1000];
 	int ret = 0;
 	int len = packet_read_line(in, line, sizeof(line));
-	if (len < 10 || memcmp(line, "unpack ", 7))
+	if (prefixcmp(line, "unpack "))
 		return error("did not receive remote status");
-	if (memcmp(line, "unpack ok\n", 10)) {
+	if (strcmp(line, "unpack ok\n")) {
 		char *p = line + strlen(line) - 1;
 		if (*p == '\n')
 			*p = '\0';
@@ -125,9 +125,8 @@ static int receive_status(int in, struct ref *refs)
 		len = packet_read_line(in, line, sizeof(line));
 		if (!len)
 			break;
-		if (len < 3 ||
-		    (memcmp(line, "ok ", 3) && memcmp(line, "ng ", 3))) {
-			fprintf(stderr, "protocol error: %s\n", line);
+		if (prefixcmp(line, "ok ") && prefixcmp(line, "ng ")) {
+			error("invalid ref status from remote: %s", line);
 			ret = -1;
 			break;
 		}
-- 
1.8.2.rc0.9.g352092c
