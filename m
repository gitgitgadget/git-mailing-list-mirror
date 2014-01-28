From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] handle_path_include: don't look at NULL value
Date: Mon, 27 Jan 2014 20:37:30 -0500
Message-ID: <20140128013729.GA21120@sigill.intra.peff.net>
References: <20140128013612.GA29548@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 28 02:37:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7xcO-00063R-Mw
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jan 2014 02:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446AbaA1Bhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jan 2014 20:37:32 -0500
Received: from cloud.peff.net ([50.56.180.127]:40038 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751121AbaA1Bhb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jan 2014 20:37:31 -0500
Received: (qmail 458 invoked by uid 102); 28 Jan 2014 01:37:31 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 27 Jan 2014 19:37:31 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Jan 2014 20:37:30 -0500
Content-Disposition: inline
In-Reply-To: <20140128013612.GA29548@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241177>

When we see config like:

  [include]
  path

the expand_user_path helper notices that the config value is
empty, but we then dereference NULL while printing the error
message (glibc will helpfully print "(null)" for us here,
but we cannot rely on that).

  $ git -c include.path rev-parse
  error: Could not expand include path '(null)'
  fatal: unable to parse command-line config

Instead of tweaking our message, let's actually use
config_error_nonbool to match other config variables that
expect a value:

  $ git -c include.path rev-parse
  error: Missing value for 'include.path'
  fatal: unable to parse command-line config

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index d969a5a..314d8ee 100644
--- a/config.c
+++ b/config.c
@@ -84,8 +84,12 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 {
 	int ret = 0;
 	struct strbuf buf = STRBUF_INIT;
-	char *expanded = expand_user_path(path);
+	char *expanded;
 
+	if (!path)
+		return config_error_nonbool("include.path");
+
+	expanded = expand_user_path(path);
 	if (!expanded)
 		return error("Could not expand include path '%s'", path);
 	path = expanded;
-- 
1.8.5.2.500.g8060133
