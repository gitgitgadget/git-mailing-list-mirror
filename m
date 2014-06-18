From: Jeff King <peff@peff.net>
Subject: [PATCH 11/16] daemon: use skip_prefix to avoid magic numbers
Date: Wed, 18 Jun 2014 15:49:44 -0400
Message-ID: <20140618194944.GK22622@sigill.intra.peff.net>
References: <20140618194117.GA22269@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 21:49:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxLrj-0005ML-GV
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 21:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755044AbaFRTtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 15:49:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:46958 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755033AbaFRTtp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 15:49:45 -0400
Received: (qmail 30379 invoked by uid 102); 18 Jun 2014 19:49:45 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jun 2014 14:49:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jun 2014 15:49:44 -0400
Content-Disposition: inline
In-Reply-To: <20140618194117.GA22269@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252043>

Like earlier cases, we can use skip_prefix to avoid magic
numbers that must match the length of starts_with prefixes.
However, the numbers are a little more complicated here, as
we keep parsing past the prefix. We can solve it by keeping
a running pointer as we parse; its final value is the
location we want.

Signed-off-by: Jeff King <peff@peff.net>
---
 daemon.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/daemon.c b/daemon.c
index 6d25828..1eb6631 100644
--- a/daemon.c
+++ b/daemon.c
@@ -626,15 +626,16 @@ static int execute(void)
 
 	for (i = 0; i < ARRAY_SIZE(daemon_service); i++) {
 		struct daemon_service *s = &(daemon_service[i]);
-		int namelen = strlen(s->name);
-		if (starts_with(line, "git-") &&
-		    !strncmp(s->name, line + 4, namelen) &&
-		    line[namelen + 4] == ' ') {
+		const char *arg;
+
+		if (skip_prefix(line, "git-", &arg) &&
+		    skip_prefix(arg, s->name, &arg) &&
+		    *arg++ == ' ') {
 			/*
 			 * Note: The directory here is probably context sensitive,
 			 * and might depend on the actual service being performed.
 			 */
-			return run_service(line + namelen + 5, s);
+			return run_service(arg, s);
 		}
 	}
 
-- 
2.0.0.566.gfe3e6b2
