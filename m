From: Jeff King <peff@peff.net>
Subject: [PATCH 5/8] git-config: fix regexp memory leaks on error conditions
Date: Tue, 23 Oct 2012 18:38:55 -0400
Message-ID: <20121023223855.GE17392@sigill.intra.peff.net>
References: <20121023223502.GA23194@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 00:39:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQn7v-0001ws-HN
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 00:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933618Ab2JWWi7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 18:38:59 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51688 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933274Ab2JWWi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 18:38:58 -0400
Received: (qmail 23346 invoked by uid 107); 23 Oct 2012 22:39:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 23 Oct 2012 18:39:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Oct 2012 18:38:55 -0400
Content-Disposition: inline
In-Reply-To: <20121023223502.GA23194@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208266>

The get_value function has a goto label for cleaning up on
errors, but it only cleans up half of what the function
might allocate. Let's also clean up the key and regexp
variables there.

Note that we need to take special care when compiling the
regex fails to clean it up ourselves, since it is in a
half-constructed state (we would want to free it, but not
regfree it).

Similarly, we fix git_config_parse_key to return NULL when it
fails, not a pointer to some already-freed memory.

Signed-off-by: Jeff King <peff@peff.net>
---
The diff is annoying in an interesting way: what I actually did was move
the regex cleanup code down, but it shows it as moving the bottom bits
up. I think it is just one of those ambiguous cases where either way is
equally valid and minimal.

 builtin/config.c | 23 +++++++++++++----------
 config.c         |  1 +
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index e660d48..60d36e7 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -195,7 +195,8 @@ static int get_value(const char *key_, const char *regex_)
 		key_regexp = (regex_t*)xmalloc(sizeof(regex_t));
 		if (regcomp(key_regexp, key, REG_EXTENDED)) {
 			fprintf(stderr, "Invalid key pattern: %s\n", key_);
-			free(key);
+			free(key_regexp);
+			key_regexp = NULL;
 			ret = CONFIG_INVALID_PATTERN;
 			goto free_strings;
 		}
@@ -215,6 +216,8 @@ static int get_value(const char *key_, const char *regex_)
 		regexp = (regex_t*)xmalloc(sizeof(regex_t));
 		if (regcomp(regexp, regex_, REG_EXTENDED)) {
 			fprintf(stderr, "Invalid pattern: %s\n", regex_);
+			free(regexp);
+			regexp = NULL;
 			ret = CONFIG_INVALID_PATTERN;
 			goto free_strings;
 		}
@@ -247,6 +250,15 @@ static int get_value(const char *key_, const char *regex_)
 	if (!do_all && !seen && system_wide)
 		git_config_from_file(fn, system_wide, data);
 
+	if (do_all)
+		ret = !seen;
+	else
+		ret = (seen == 1) ? 0 : seen > 1 ? 2 : 1;
+
+free_strings:
+	free(repo_config);
+	free(global);
+	free(xdg);
 	free(key);
 	if (key_regexp) {
 		regfree(key_regexp);
@@ -257,15 +269,6 @@ static int get_value(const char *key_, const char *regex_)
 		free(regexp);
 	}
 
-	if (do_all)
-		ret = !seen;
-	else
-		ret = (seen == 1) ? 0 : seen > 1 ? 2 : 1;
-
-free_strings:
-	free(repo_config);
-	free(global);
-	free(xdg);
 	return ret;
 }
 
diff --git a/config.c b/config.c
index 08e47e2..2fbe634 100644
--- a/config.c
+++ b/config.c
@@ -1280,6 +1280,7 @@ out_free_ret_1:
 
 out_free_ret_1:
 	free(*store_key);
+	*store_key = NULL;
 	return -CONFIG_INVALID_KEY;
 }
 
-- 
1.8.0.3.g3456896
