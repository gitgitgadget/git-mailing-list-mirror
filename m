From: Jeff King <peff@peff.net>
Subject: [PATCH 2/6] git_config_parse_parameter: refactor cleanup code
Date: Wed, 18 May 2016 18:39:49 -0400
Message-ID: <20160518223949.GB22443@sigill.intra.peff.net>
References: <20160518223712.GA18317@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 00:40:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3A8H-0007pb-Ut
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 00:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbcERWjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 18:39:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:41565 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751836AbcERWjw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 18:39:52 -0400
Received: (qmail 32414 invoked by uid 102); 18 May 2016 22:39:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 May 2016 18:39:52 -0400
Received: (qmail 27646 invoked by uid 107); 18 May 2016 22:39:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 May 2016 18:39:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 May 2016 18:39:49 -0400
Content-Disposition: inline
In-Reply-To: <20160518223712.GA18317@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295019>

We have several exits from the function, each of which has
to do some cleanup. Let's consolidate these in an "out"
label we can jump to. This doesn't save us much now, but it
will help as we add more things that need cleanup.

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/config.c b/config.c
index 3f8f6aa..eb1e268 100644
--- a/config.c
+++ b/config.c
@@ -205,6 +205,7 @@ int git_config_parse_parameter(const char *text,
 int git_config_from_parameters(config_fn_t fn, void *data)
 {
 	const char *env = getenv(CONFIG_DATA_ENVIRONMENT);
+	int ret = 0;
 	char *envw;
 	const char **argv = NULL;
 	int nr = 0, alloc = 0;
@@ -216,21 +217,21 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 	envw = xstrdup(env);
 
 	if (sq_dequote_to_argv(envw, &argv, &nr, &alloc) < 0) {
-		free(envw);
-		return error("bogus format in " CONFIG_DATA_ENVIRONMENT);
+		ret = error("bogus format in " CONFIG_DATA_ENVIRONMENT);
+		goto out;
 	}
 
 	for (i = 0; i < nr; i++) {
 		if (git_config_parse_parameter(argv[i], fn, data) < 0) {
-			free(argv);
-			free(envw);
-			return -1;
+			ret = -1;
+			goto out;
 		}
 	}
 
+out:
 	free(argv);
 	free(envw);
-	return 0;
+	return ret;
 }
 
 static int get_next_char(void)
-- 
2.8.2.888.gecb1fe3
