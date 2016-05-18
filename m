From: Jeff King <peff@peff.net>
Subject: [PATCH 1/6] git_config_with_options: drop "found" counting
Date: Wed, 18 May 2016 18:39:02 -0400
Message-ID: <20160518223902.GA22443@sigill.intra.peff.net>
References: <20160518223712.GA18317@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 00:39:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3A7V-0007L2-EJ
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 00:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbcERWjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 18:39:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:41562 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750983AbcERWjG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 18:39:06 -0400
Received: (qmail 32372 invoked by uid 102); 18 May 2016 22:39:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 May 2016 18:39:04 -0400
Received: (qmail 27628 invoked by uid 107); 18 May 2016 22:39:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 May 2016 18:39:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 May 2016 18:39:02 -0400
Content-Disposition: inline
In-Reply-To: <20160518223712.GA18317@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295018>

Prior to 1f2baa7 (config: treat non-existent config files as
empty, 2010-10-21), we returned an error if any config files
were missing. That commit made this a non-error, but
returned the number of sources found, in case any caller
wanted to distinguish this case.

In the past 5+ years, no caller has; the only two places
which bother to check the return value care only about the
error case.  Let's drop this code, which complicates the
function. Similarly, let's drop the "found anything" return
from git_config_from_parameters, which was present only to
support this (and similarly has never had other callers care
for the past 5+ years).

Note that we do need to update a comment in one of the
callers, even though the code immediately below it doesn't
care about this case.

Signed-off-by: Jeff King <peff@peff.net>
---
This technically changes the function interface without breaking
compilation for any topics in flight. But given the history, and that
the now-unhandled case is not actually _useful_, I don't think it's
worth worrying about.

 config.c | 34 +++++++++-------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff --git a/config.c b/config.c
index 096fe03..3f8f6aa 100644
--- a/config.c
+++ b/config.c
@@ -230,7 +230,7 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 
 	free(argv);
 	free(envw);
-	return nr > 0;
+	return 0;
 }
 
 static int get_next_char(void)
@@ -1201,47 +1201,31 @@ int git_config_system(void)
 
 static int do_git_config_sequence(config_fn_t fn, void *data)
 {
-	int ret = 0, found = 0;
+	int ret = 0;
 	char *xdg_config = xdg_config_home("config");
 	char *user_config = expand_user_path("~/.gitconfig");
 	char *repo_config = git_pathdup("config");
 
-	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, 0)) {
+	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, 0))
 		ret += git_config_from_file(fn, git_etc_gitconfig(),
 					    data);
-		found += 1;
-	}
 
-	if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK)) {
+	if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK))
 		ret += git_config_from_file(fn, xdg_config, data);
-		found += 1;
-	}
 
-	if (user_config && !access_or_die(user_config, R_OK, ACCESS_EACCES_OK)) {
+	if (user_config && !access_or_die(user_config, R_OK, ACCESS_EACCES_OK))
 		ret += git_config_from_file(fn, user_config, data);
-		found += 1;
-	}
 
-	if (repo_config && !access_or_die(repo_config, R_OK, 0)) {
+	if (repo_config && !access_or_die(repo_config, R_OK, 0))
 		ret += git_config_from_file(fn, repo_config, data);
-		found += 1;
-	}
 
-	switch (git_config_from_parameters(fn, data)) {
-	case -1: /* error */
+	if (git_config_from_parameters(fn, data) < 0)
 		die(_("unable to parse command-line config"));
-		break;
-	case 0: /* found nothing */
-		break;
-	default: /* found at least one item */
-		found++;
-		break;
-	}
 
 	free(xdg_config);
 	free(user_config);
 	free(repo_config);
-	return ret == 0 ? found : ret;
+	return ret;
 }
 
 int git_config_with_options(config_fn_t fn, void *data,
@@ -1276,7 +1260,7 @@ static void git_config_raw(config_fn_t fn, void *data)
 	if (git_config_with_options(fn, data, NULL, 1) < 0)
 		/*
 		 * git_config_with_options() normally returns only
-		 * positive values, as most errors are fatal, and
+		 * zero, as most errors are fatal, and
 		 * non-fatal potential errors are guarded by "if"
 		 * statements that are entered only when no error is
 		 * possible.
-- 
2.8.2.888.gecb1fe3
