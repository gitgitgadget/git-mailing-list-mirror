From: Jeff King <peff@peff.net>
Subject: [PATCH 58/68] receive-pack: simplify keep_arg computation
Date: Thu, 24 Sep 2015 17:08:14 -0400
Message-ID: <20150924210814.GC30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:08:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDkj-00028o-O8
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:08:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754101AbbIXVIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:08:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:36030 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754400AbbIXVIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:08:16 -0400
Received: (qmail 12142 invoked by uid 102); 24 Sep 2015 21:08:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:08:16 -0500
Received: (qmail 29516 invoked by uid 107); 24 Sep 2015 21:08:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:08:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:08:14 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278605>

To generate "--keep=receive-pack $pid on $host", we write
progressively into a single buffer, which requires keeping
track of how much we've written so far. But since the result
is destined to go into our argv array, we can simply use
argv_array_pushf.

Unfortunately we still have to have a fixed-size buffer for
the gethostname() call, but at least it now doesn't involve
any extra size computation. And as a bonus, we drop an
sprintf and a strcpy call.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/receive-pack.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 39eb064..bcb624b 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1524,15 +1524,18 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		if (status)
 			return "unpack-objects abnormal exit";
 	} else {
-		int s;
-		char keep_arg[256];
-
-		s = sprintf(keep_arg, "--keep=receive-pack %"PRIuMAX" on ", (uintmax_t) getpid());
-		if (gethostname(keep_arg + s, sizeof(keep_arg) - s))
-			strcpy(keep_arg + s, "localhost");
+		char hostname[256];
 
 		argv_array_pushl(&child.args, "index-pack",
-				 "--stdin", hdr_arg, keep_arg, NULL);
+				 "--stdin", hdr_arg, NULL);
+
+		if (gethostname(hostname, sizeof(hostname)))
+			xsnprintf(hostname, sizeof(hostname), "localhost");
+		argv_array_pushf(&child.args,
+				 "--keep=receive-pack %"PRIuMAX" on %s",
+				 (uintmax_t)getpid(),
+				 hostname);
+
 		if (fsck_objects)
 			argv_array_pushf(&child.args, "--strict%s",
 				fsck_msg_types.buf);
-- 
2.6.0.rc3.454.g204ad51
