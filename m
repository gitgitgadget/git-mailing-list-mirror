From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 1/4] replace: refactor command-mode determination
Date: Thu, 6 Mar 2014 12:49:05 -0500
Message-ID: <20140306174904.GA30691@sigill.intra.peff.net>
References: <20140306174803.GA30486@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 06 18:49:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLcQ0-0000m2-MI
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 18:49:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243AbaCFRtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 12:49:09 -0500
Received: from cloud.peff.net ([50.56.180.127]:34179 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751645AbaCFRtH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 12:49:07 -0500
Received: (qmail 20769 invoked by uid 102); 6 Mar 2014 17:49:07 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 06 Mar 2014 11:49:07 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Mar 2014 12:49:05 -0500
Content-Disposition: inline
In-Reply-To: <20140306174803.GA30486@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243525>

The git-replace command has three modes: listing, deleting,
and replacing. The first two are selected explicitly. If
none is selected, we fallback to listing when there are no
arguments, and replacing otherwise.

Let's figure out up front which operation we are going to
do, before getting into the application logic. That lets us
simplify our option checks (e.g., we currently have to check
whether a useless "--force" is given both along with an
explicit list, as well as with an implicit one).

This saves some lines, makes the logic easier to follow, and
will facilitate further cleanups.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/replace.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 2336325..6a0e8bd 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -182,12 +182,16 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, git_replace_usage, 0);
 
+	if (!list && !delete)
+		if (!argc)
+			list = 1;
+
 	if (list && delete)
 		usage_msg_opt("-l and -d cannot be used together",
 			      git_replace_usage, options);
 
-	if (format && delete)
-		usage_msg_opt("--format and -d cannot be used together",
+	if (format && !list)
+		usage_msg_opt("--format cannot be used when not listing",
 			      git_replace_usage, options);
 
 	if (force && (list || delete))
@@ -207,9 +211,6 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 		if (argc != 2)
 			usage_msg_opt("bad number of arguments",
 				      git_replace_usage, options);
-		if (format)
-			usage_msg_opt("--format cannot be used when not listing",
-				      git_replace_usage, options);
 		return replace_object(argv[0], argv[1], force);
 	}
 
@@ -217,9 +218,6 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 	if (argc > 1)
 		usage_msg_opt("only one pattern can be given with -l",
 			      git_replace_usage, options);
-	if (force)
-		usage_msg_opt("-f needs some arguments",
-			      git_replace_usage, options);
 
 	return list_replace_refs(argv[0], format);
 }
-- 
1.8.5.2.500.g8060133
