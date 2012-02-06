From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] tag: die when listing missing or corrupt objects
Date: Mon, 6 Feb 2012 03:13:42 -0500
Message-ID: <20120206081342.GB3966@sigill.intra.peff.net>
References: <20120206081119.GA3939@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	jasampler@gmail.com
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 09:13:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuJht-0007aQ-5W
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 09:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133Ab2BFINp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 03:13:45 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58680
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753135Ab2BFINo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 03:13:44 -0500
Received: (qmail 25124 invoked by uid 107); 6 Feb 2012 08:20:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Feb 2012 03:20:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Feb 2012 03:13:42 -0500
Content-Disposition: inline
In-Reply-To: <20120206081119.GA3939@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190043>

We don't usually bother looking at tagged objects at all
when listing. However, if "-n" is specified, we open the
objects to read the annotations of the tags.  If we fail to
read an object, or if the object has zero length, we simply
silently return.

The first case is an indication of a broken or corrupt repo,
and we should notify the user of the error.

The second case is OK to silently ignore; however, the
existing code leaked the buffer returned by read_sha1_file.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/tag.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 2250915..1bb42a4 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -92,8 +92,12 @@ static void show_tag_lines(const unsigned char *sha1, int lines)
 	size_t len;
 
 	buf = read_sha1_file(sha1, &type, &size);
-	if (!buf || !size)
+	if (!buf)
+		die_errno("unable to read object %s", sha1_to_hex(sha1));
+	if (!size) {
+		free(buf);
 		return;
+	}
 
 	/* skip header */
 	sp = strstr(buf, "\n\n");
-- 
1.7.9.rc1.29.g43677
