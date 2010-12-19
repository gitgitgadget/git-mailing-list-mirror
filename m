From: Jeff King <peff@peff.net>
Subject: [PATCH] handle arbitrary ints in git_config_maybe_bool
Date: Sat, 18 Dec 2010 22:36:41 -0500
Message-ID: <20101219033640.GA6889@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 19 04:36:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUA4o-0008QY-U2
	for gcvg-git-2@lo.gmane.org; Sun, 19 Dec 2010 04:36:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756442Ab0LSDgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 22:36:45 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:58249 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752652Ab0LSDgo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 22:36:44 -0500
Received: (qmail 18398 invoked by uid 111); 19 Dec 2010 03:36:43 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 19 Dec 2010 03:36:43 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 18 Dec 2010 22:36:41 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163951>

This function recently gained the ability to recognize the
documented "0" and "1" values as false/true. However, unlike
regular git_config_bool, it did not treat arbitrary numbers
as true. While this is undocumented and probably ridiculous
for somebody to rely on, it is safer to behave exactly as
git_config_bool would. Because git_config_maybe_bool can be
used to retrofit new non-bool values onto existing bool
options, not behaving in exactly the same way is technically
a regression.

Signed-off-by: Jeff King <peff@peff.net>
---
This was posted earlier as part of the command-specific pager topic; you
ended up splitting part of that out into jk/maint-decorate-01-bool. This
should logically go on top of that (b2be2f6).

It probably doesn't make a difference in the real world, but I think it
is safer (as described above), and the code is a little cleaner. I
should have just done it this way in the first place.

 config.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/config.c b/config.c
index 32c0b2c..d73b090 100644
--- a/config.c
+++ b/config.c
@@ -429,13 +429,11 @@ static int git_config_maybe_bool_text(const char *name, const char *value)
 
 int git_config_maybe_bool(const char *name, const char *value)
 {
-	int v = git_config_maybe_bool_text(name, value);
+	long v = git_config_maybe_bool_text(name, value);
 	if (0 <= v)
 		return v;
-	if (!strcmp(value, "0"))
-		return 0;
-	if (!strcmp(value, "1"))
-		return 1;
+	if (git_parse_long(value, &v))
+		return !!v;
 	return -1;
 }
 
-- 
1.7.3.4.761.g98ad5
