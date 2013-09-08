From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] upload-pack: bump keepalive default to 5 seconds
Date: Sun, 8 Sep 2013 05:02:06 -0400
Message-ID: <20130908090206.GB17060@sigill.intra.peff.net>
References: <20130908085915.GA4097@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 08 11:02:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIaso-0003qd-99
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 11:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051Ab3IHJCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 05:02:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:43960 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751837Ab3IHJCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 05:02:09 -0400
Received: (qmail 12976 invoked by uid 102); 8 Sep 2013 09:02:09 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 08 Sep 2013 04:02:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Sep 2013 05:02:06 -0400
Content-Disposition: inline
In-Reply-To: <20130908085915.GA4097@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234230>

From: Jeff King <peff@peff.net>

There is no reason not to turn on keepalives by default.
They take very little bandwidth, and significantly less than
the progress reporting they are replacing. And in the case
that progress reporting is on, we should never need to send
a keepalive anyway, as we will constantly be showing
progress and resetting the keepalive timer.

We do not necessarily know what the client's idea of a
reasonable timeout is, so let's keep this on the low side of
5 seconds. That is high enough that we will always prefer
our normal 1-second progress reports to sending a keepalive
packet, but low enough that no sane client should consider
the connection hung.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt | 2 +-
 upload-pack.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5d748f7..6b35578 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2225,7 +2225,7 @@ uploadpack.keepalive::
 	the server to be hung and give up. Setting this option instructs
 	`upload-pack` to send an empty keepalive packet every
 	`uploadpack.keepalive` seconds. Setting this option to 0
-	disables keepalive packets entirely. The default is 0.
+	disables keepalive packets entirely. The default is 5 seconds.
 
 url.<base>.insteadOf::
 	Any URL that starts with this value will be rewritten to
diff --git a/upload-pack.c b/upload-pack.c
index c3e4a20..04a8707 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -40,7 +40,7 @@ static unsigned int timeout;
 static struct object_array want_obj;
 static struct object_array extra_edge_obj;
 static unsigned int timeout;
-static int keepalive = -1;
+static int keepalive = 5;
 /* 0 for no sideband,
  * otherwise maximum packet size (up to 65520 bytes).
  */
-- 
1.8.4.2.g87d4a77
