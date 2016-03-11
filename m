From: Jeff King <peff@peff.net>
Subject: [PATCH v2 07/10] init: use setup.c's repo version verification
Date: Fri, 11 Mar 2016 17:37:11 -0500
Message-ID: <20160311223710.GG449@sigill.intra.peff.net>
References: <20160311223620.GA7963@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>, pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 11 23:37:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeVgN-0003w9-0w
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 23:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbcCKWhP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 17:37:15 -0500
Received: from cloud.peff.net ([50.56.180.127]:58670 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932798AbcCKWhO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 17:37:14 -0500
Received: (qmail 20995 invoked by uid 102); 11 Mar 2016 22:37:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Mar 2016 17:37:13 -0500
Received: (qmail 7540 invoked by uid 107); 11 Mar 2016 22:37:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Mar 2016 17:37:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Mar 2016 17:37:11 -0500
Content-Disposition: inline
In-Reply-To: <20160311223620.GA7963@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288714>

We check our templates to make sure they are from a
version of git we understand (otherwise we would init a
repository we cannot ourselves run in!). But our simple
integer check has fallen behind the times. Let's use the
helpers that setup.c provides to do it right.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/init-db.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index e9b2256..d9934f3 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -95,6 +95,8 @@ static void copy_templates(const char *template_dir)
 	struct strbuf path = STRBUF_INIT;
 	struct strbuf template_path = STRBUF_INIT;
 	size_t template_len;
+	struct repository_format template_format;
+	struct strbuf err = STRBUF_INIT;
 	DIR *dir;
 	char *to_free = NULL;
 
@@ -121,17 +123,18 @@ static void copy_templates(const char *template_dir)
 
 	/* Make sure that template is from the correct vintage */
 	strbuf_addstr(&template_path, "config");
-	repository_format_version = 0;
-	git_config_from_file(check_repository_format_version,
-			     template_path.buf, NULL);
+	read_repository_format(&template_format, template_path.buf);
 	strbuf_setlen(&template_path, template_len);
 
-	if (repository_format_version &&
-	    repository_format_version != GIT_REPO_VERSION) {
-		warning(_("not copying templates of "
-			"a wrong format version %d from '%s'"),
-			repository_format_version,
-			template_dir);
+	/*
+	 * No mention of version at all is OK, but anything else should be
+	 * verified.
+	 */
+	if (template_format.version >= 0 &&
+	    verify_repository_format(&template_format, &err) < 0) {
+		warning(_("not copying templates from '%s': %s"),
+			  template_dir, err.buf);
+		strbuf_release(&err);
 		goto close_free_return;
 	}
 
-- 
2.8.0.rc2.328.g39e2a47
