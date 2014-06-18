From: Jeff King <peff@peff.net>
Subject: [PATCH 14/16] fetch-pack: refactor parsing in get_ack
Date: Wed, 18 Jun 2014 15:56:03 -0400
Message-ID: <20140618195603.GN22622@sigill.intra.peff.net>
References: <20140618194117.GA22269@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 21:56:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxLxq-0003cW-V9
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 21:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754594AbaFRT4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 15:56:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:46967 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754109AbaFRT4F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 15:56:05 -0400
Received: (qmail 30746 invoked by uid 102); 18 Jun 2014 19:56:04 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jun 2014 14:56:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jun 2014 15:56:03 -0400
Content-Disposition: inline
In-Reply-To: <20140618194117.GA22269@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252047>

There are several uses of the magic number "line+45" when
parsing ACK lines from the server, and it's rather unclear
why 45 is the correct number. We can make this more clear by
keeping a running pointer as we parse, using skip_prefix to
jump past the first "ACK ", then adding 40 to jump past
get_sha1_hex (which is still magical, but hopefully 40 is
less magical to readers of git code).

Note that this actually puts us at line+44. The original
required some character between the sha1 and further ACK
flags (it is supposed to be a space, but we never enforced
that). We start our search for flags at line+44, which
meanas we are slightly more liberal than the old code.

Signed-off-by: Jeff King <peff@peff.net>
---
I actually think we could tighten this even more and drop the strstrs,
too, like:

  arg += 40;
  if (*arg++ != ' ')
	return ACK;
  if (!strcmp(arg, "continue"))
	return ACK_continue;

and so on. But I wasn't sure if there was a reason for the use of
strstr. According to pack-protocol.txt, we would only get one at a time,
and always with a single space between them.

 fetch-pack.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 3de3bd5..72ec520 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -189,20 +189,23 @@ static enum ack_type get_ack(int fd, unsigned char *result_sha1)
 {
 	int len;
 	char *line = packet_read_line(fd, &len);
+	const char *arg;
 
 	if (!len)
 		die("git fetch-pack: expected ACK/NAK, got EOF");
 	if (!strcmp(line, "NAK"))
 		return NAK;
-	if (starts_with(line, "ACK ")) {
-		if (!get_sha1_hex(line+4, result_sha1)) {
-			if (len < 45)
+	if (skip_prefix(line, "ACK ", &arg)) {
+		if (!get_sha1_hex(arg, result_sha1)) {
+			arg += 40;
+			len -= arg - line;
+			if (len < 1)
 				return ACK;
-			if (strstr(line+45, "continue"))
+			if (strstr(arg, "continue"))
 				return ACK_continue;
-			if (strstr(line+45, "common"))
+			if (strstr(arg, "common"))
 				return ACK_common;
-			if (strstr(line+45, "ready"))
+			if (strstr(arg, "ready"))
 				return ACK_ready;
 			return ACK;
 		}
-- 
2.0.0.566.gfe3e6b2
