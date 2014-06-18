From: Jeff King <peff@peff.net>
Subject: [PATCH 06/16] fast-import: fix read of uninitialized argv memory
Date: Wed, 18 Jun 2014 15:46:15 -0400
Message-ID: <20140618194615.GF22622@sigill.intra.peff.net>
References: <20140618194117.GA22269@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 21:46:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxLoL-0001lP-6Y
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 21:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754867AbaFRTqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 15:46:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:46947 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754256AbaFRTqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 15:46:16 -0400
Received: (qmail 30176 invoked by uid 102); 18 Jun 2014 19:46:16 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jun 2014 14:46:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jun 2014 15:46:15 -0400
Content-Disposition: inline
In-Reply-To: <20140618194117.GA22269@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252038>

Fast-import shares code between its command-line parser and
the "option" command. To do so, it strips the "--" from any
command-line options and passes them to the option parser.
However, it does not confirm that the option even begins
with "--" before blindly passing "arg + 2".

It does confirm that the option starts with "-", so the only
affected case was:

  git fast-import -

which would read uninitialized memory after the argument. We
can fix it by using skip_prefix and checking the result. As
a bonus, this gets rid of some magic numbers.

Signed-off-by: Jeff King <peff@peff.net>
---
 fast-import.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 6707a66..b2030cc 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3342,18 +3342,21 @@ static void parse_argv(void)
 		if (*a != '-' || !strcmp(a, "--"))
 			break;
 
-		if (parse_one_option(a + 2))
+		if (!skip_prefix(a, "--", &a))
+			die("unknown option %s", a);
+
+		if (parse_one_option(a))
 			continue;
 
-		if (parse_one_feature(a + 2, 0))
+		if (parse_one_feature(a, 0))
 			continue;
 
-		if (starts_with(a + 2, "cat-blob-fd=")) {
-			option_cat_blob_fd(a + 2 + strlen("cat-blob-fd="));
+		if (skip_prefix(a, "cat-blob-fd=", &a)) {
+			option_cat_blob_fd(a);
 			continue;
 		}
 
-		die("unknown option %s", a);
+		die("unknown option --%s", a);
 	}
 	if (i != global_argc)
 		usage(fast_import_usage);
-- 
2.0.0.566.gfe3e6b2
