From: Jeff King <peff@peff.net>
Subject: [PATCH 57/67] receive-pack: simplify keep_arg computation
Date: Tue, 15 Sep 2015 12:10:50 -0400
Message-ID: <20150915161050.GE29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 18:11:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zbsp1-0004mJ-KC
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 18:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753874AbbIOQK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 12:10:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:59455 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753580AbbIOQKw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 12:10:52 -0400
Received: (qmail 14432 invoked by uid 102); 15 Sep 2015 16:10:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:10:52 -0500
Received: (qmail 7909 invoked by uid 107); 15 Sep 2015 16:11:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 12:11:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 12:10:50 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277962>

To generate "--keep=receive-pack $pid on $host", we write
progressively into a single buffer, which requires keeping
track of how much we've written so far. But since the result
is destined to go into our argv array, we can simply use
argv_array_pushf.

Unfortunately we still have to have a static buffer for the
gethostname() call, but at least it now doesn't involve any
extra size computation. And as a bonus, we drop an sprintf
and a strcpy call.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/receive-pack.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 8b50e48..2c82274 100644
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
2.6.0.rc2.408.ga2926b9
