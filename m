From: Jeff King <peff@peff.net>
Subject: [PATCH 1/6] test-sha1: add a binary output mode
Date: Fri, 23 Aug 2013 20:01:57 -0400
Message-ID: <20130824000157.GA25833@sigill.intra.peff.net>
References: <20130824000111.GA20255@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 24 02:02:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VD1Is-0000xx-QI
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 02:02:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754682Ab3HXACB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 20:02:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:41480 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754492Ab3HXACA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 20:02:00 -0400
Received: (qmail 30003 invoked by uid 102); 24 Aug 2013 00:02:00 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 Aug 2013 19:02:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Aug 2013 20:01:57 -0400
Content-Disposition: inline
In-Reply-To: <20130824000111.GA20255@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232843>

The test-sha1 helper program will run our internal sha1
routines over its input and output the 40-byte hex sha1.
Sometimes, however, it is useful to have the binary 20-byte
sha1 (and it's a pain to convert back in the shell). Let's
add a "-b" option to output the binary version.

Signed-off-by: Jeff King <peff@peff.net>
Acked-by: Nicolas Pitre <nico@fluxnic.net>
---
 test-sha1.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/test-sha1.c b/test-sha1.c
index 80daba9..e57eae1 100644
--- a/test-sha1.c
+++ b/test-sha1.c
@@ -5,10 +5,15 @@ int main(int ac, char **av)
 	git_SHA_CTX ctx;
 	unsigned char sha1[20];
 	unsigned bufsz = 8192;
+	int binary = 0;
 	char *buffer;
 
-	if (ac == 2)
-		bufsz = strtoul(av[1], NULL, 10) * 1024 * 1024;
+	if (ac == 2) {
+		if (!strcmp(av[1], "-b"))
+			binary = 1;
+		else
+			bufsz = strtoul(av[1], NULL, 10) * 1024 * 1024;
+	}
 
 	if (!bufsz)
 		bufsz = 8192;
@@ -42,6 +47,10 @@ int main(int ac, char **av)
 		git_SHA1_Update(&ctx, buffer, this_sz);
 	}
 	git_SHA1_Final(sha1, &ctx);
-	puts(sha1_to_hex(sha1));
+
+	if (binary)
+		fwrite(sha1, 1, 20, stdout);
+	else
+		puts(sha1_to_hex(sha1));
 	exit(0);
 }
-- 
1.8.4.rc2.28.g6bb5f3f
