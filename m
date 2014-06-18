From: Jeff King <peff@peff.net>
Subject: [PATCH 16/16] use skip_prefix to avoid repeated calculations
Date: Wed, 18 Jun 2014 15:57:17 -0400
Message-ID: <20140618195717.GP22622@sigill.intra.peff.net>
References: <20140618194117.GA22269@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 21:57:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxLz2-0004vC-2q
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 21:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755067AbaFRT5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 15:57:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:46972 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754723AbaFRT5T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 15:57:19 -0400
Received: (qmail 30837 invoked by uid 102); 18 Jun 2014 19:57:18 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jun 2014 14:57:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jun 2014 15:57:17 -0400
Content-Disposition: inline
In-Reply-To: <20140618194117.GA22269@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252049>

In some cases, we use starts_with to check for a prefix, and
then use an already-calculated prefix length to advance a
pointer past the prefix. There are no magic numbers or
duplicated strings here, but we can still make the code
simpler and more obvious by using skip_prefix.

Signed-off-by: Jeff King <peff@peff.net>
---
 help.c | 11 +++++------
 http.c |  3 +--
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/help.c b/help.c
index 79e8007..f31f29a 100644
--- a/help.c
+++ b/help.c
@@ -129,7 +129,6 @@ static void list_commands_in_dir(struct cmdnames *cmds,
 					 const char *path,
 					 const char *prefix)
 {
-	int prefix_len;
 	DIR *dir = opendir(path);
 	struct dirent *de;
 	struct strbuf buf = STRBUF_INIT;
@@ -139,15 +138,15 @@ static void list_commands_in_dir(struct cmdnames *cmds,
 		return;
 	if (!prefix)
 		prefix = "git-";
-	prefix_len = strlen(prefix);
 
 	strbuf_addf(&buf, "%s/", path);
 	len = buf.len;
 
 	while ((de = readdir(dir)) != NULL) {
+		const char *ent;
 		int entlen;
 
-		if (!starts_with(de->d_name, prefix))
+		if (!skip_prefix(de->d_name, prefix, &ent))
 			continue;
 
 		strbuf_setlen(&buf, len);
@@ -155,11 +154,11 @@ static void list_commands_in_dir(struct cmdnames *cmds,
 		if (!is_executable(buf.buf))
 			continue;
 
-		entlen = strlen(de->d_name) - prefix_len;
-		if (has_extension(de->d_name, ".exe"))
+		entlen = strlen(ent);
+		if (has_extension(ent, ".exe"))
 			entlen -= 4;
 
-		add_cmdname(cmds, de->d_name + prefix_len, entlen);
+		add_cmdname(cmds, ent, entlen);
 	}
 	closedir(dir);
 	strbuf_release(&buf);
diff --git a/http.c b/http.c
index 2b4f6a3..f04621e 100644
--- a/http.c
+++ b/http.c
@@ -1087,11 +1087,10 @@ static int update_url_from_redirect(struct strbuf *base,
 	if (!strcmp(asked, got->buf))
 		return 0;
 
-	if (!starts_with(asked, base->buf))
+	if (!skip_prefix(asked, base->buf, &tail))
 		die("BUG: update_url_from_redirect: %s is not a superset of %s",
 		    asked, base->buf);
 
-	tail = asked + base->len;
 	tail_len = strlen(tail);
 
 	if (got->len < tail_len ||
-- 
2.0.0.566.gfe3e6b2
