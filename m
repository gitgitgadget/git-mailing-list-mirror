From: Jeff King <peff@peff.net>
Subject: [PATCH 4/5] fix memory leak parsing core.commentchar
Date: Thu, 24 Jul 2014 00:42:39 -0400
Message-ID: <20140724044239.GD32355@peff.net>
References: <20140724043940.GA31282@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <stefanbeller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 24 06:42:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAArj-0003gG-8B
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 06:42:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934156AbaGXEmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 00:42:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:39362 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934134AbaGXEmr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 00:42:47 -0400
Received: (qmail 20695 invoked by uid 102); 24 Jul 2014 04:42:47 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Jul 2014 23:42:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jul 2014 00:42:39 -0400
Content-Disposition: inline
In-Reply-To: <20140724043940.GA31282@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254147>

When we see the core.commentchar config option, we extract
the string with git_config_string, which does two things:

  1. It complains via config_error_nonbool if there is no
     string value.

  2. It makes a copy of the string.

Since we immediately parse the string into its
single-character value, we only care about (1). And in fact
(2) is a detriment, as it means we leak the copy. Instead,
let's just check the pointer value ourselves, and parse
directly from the const string we already have.

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/config.c b/config.c
index 9767c4b..058505c 100644
--- a/config.c
+++ b/config.c
@@ -817,14 +817,12 @@ static int git_default_core_config(const char *var, const char *value)
 		return git_config_string(&editor_program, var, value);
 
 	if (!strcmp(var, "core.commentchar")) {
-		const char *comment;
-		int ret = git_config_string(&comment, var, value);
-		if (ret)
-			return ret;
-		else if (!strcasecmp(comment, "auto"))
+		if (!value)
+			return config_error_nonbool(var);
+		else if (!strcasecmp(value, "auto"))
 			auto_comment_line_char = 1;
-		else if (comment[0] && !comment[1]) {
-			comment_line_char = comment[0];
+		else if (value[0] && !value[1]) {
+			comment_line_char = value[0];
 			auto_comment_line_char = 0;
 		} else
 			return error("core.commentChar should only be one character");
-- 
2.0.0.566.gfe3e6b2
