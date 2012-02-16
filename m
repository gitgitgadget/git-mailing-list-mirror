From: Jeff King <peff@peff.net>
Subject: [PATCH 2/8] config: copy the return value of prefix_filename
Date: Thu, 16 Feb 2012 03:03:52 -0500
Message-ID: <20120216080352.GB11843@sigill.intra.peff.net>
References: <20120216080102.GA11793@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 16 09:04:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxwJr-0000Hi-9s
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 09:03:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755436Ab2BPIDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 03:03:55 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38571
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754784Ab2BPIDy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 03:03:54 -0500
Received: (qmail 27961 invoked by uid 107); 16 Feb 2012 08:11:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Feb 2012 03:11:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Feb 2012 03:03:52 -0500
Content-Disposition: inline
In-Reply-To: <20120216080102.GA11793@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190877>

The prefix_filename function returns a pointer to a static
buffer which may be overwritten by subsequent calls. Since
we are going to keep the result around for a while, let's be
sure to duplicate it for safety.

I don't think this can be triggered as a bug in the current
code, but it's a good idea to be defensive, as any resulting
bug would be quite subtle.

Signed-off-by: Jeff King <peff@peff.net>
---
I was tempted to simply use OPT_FILENAME to get the argument to "-f",
which would handle the prefixing for us. However, we can also get the
value from $GIT_CONFIG. That value doesn't actually run through this
code currently, but I think it should (and I fix this in patch 6).

 builtin/config.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 09bf778..5a43a3c 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -391,9 +391,10 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		config_exclusive_filename = git_pathdup("config");
 	else if (given_config_file) {
 		if (!is_absolute_path(given_config_file) && prefix)
-			config_exclusive_filename = prefix_filename(prefix,
-								    strlen(prefix),
-								    given_config_file);
+			config_exclusive_filename =
+				xstrdup(prefix_filename(prefix,
+							strlen(prefix),
+							given_config_file));
 		else
 			config_exclusive_filename = given_config_file;
 	}
-- 
1.7.9.1.4.g8ffed
