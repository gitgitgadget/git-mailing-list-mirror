From: Jeff King <peff@peff.net>
Subject: [PATCH 8/8] git-config: use git_config_with_options
Date: Tue, 23 Oct 2012 18:41:19 -0400
Message-ID: <20121023224119.GH17392@sigill.intra.peff.net>
References: <20121023223502.GA23194@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 00:41:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQnAF-0003bt-2e
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 00:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933802Ab2JWWlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 18:41:23 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51705 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933719Ab2JWWlX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 18:41:23 -0400
Received: (qmail 23446 invoked by uid 107); 23 Oct 2012 22:42:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 23 Oct 2012 18:42:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Oct 2012 18:41:19 -0400
Content-Disposition: inline
In-Reply-To: <20121023223502.GA23194@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208269>

The git-config command has always implemented its own file
lookup and parsing order. This was necessary because its
duplicate-entry handling did not match the way git's
internal callbacks worked. Now that this is no longer the
case, we are free to reuse the existing parsing code.

This saves us a few lines of code, but most importantly, it
means that the logic for which files are examined is
contained only in one place and cannot diverge.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/config.c | 44 ++------------------------------------------
 1 file changed, 2 insertions(+), 42 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 77efa69..f881053 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -165,22 +165,9 @@ static int get_value(const char *key_, const char *regex_)
 static int get_value(const char *key_, const char *regex_)
 {
 	int ret = CONFIG_GENERIC_ERROR;
-	char *global = NULL, *xdg = NULL, *repo_config = NULL;
-	const char *system_wide = NULL, *local;
-	struct config_include_data inc = CONFIG_INCLUDE_INIT;
-	config_fn_t fn;
-	void *data;
 	struct strbuf_list values = {0};
 	int i;
 
-	local = given_config_file;
-	if (!local) {
-		local = repo_config = git_pathdup("config");
-		if (git_config_system())
-			system_wide = git_etc_gitconfig();
-		home_config_paths(&global, &xdg, "config");
-	}
-
 	if (use_key_regexp) {
 		char *tl;
 
@@ -229,32 +216,8 @@ static int get_value(const char *key_, const char *regex_)
 		}
 	}
 
-	fn = collect_config;
-	data = &values;
-	if (respect_includes) {
-		inc.fn = fn;
-		inc.data = data;
-		fn = git_config_include;
-		data = &inc;
-	}
-
-	if (do_all && system_wide)
-		git_config_from_file(fn, system_wide, data);
-	if (do_all && xdg)
-		git_config_from_file(fn, xdg, data);
-	if (do_all && global)
-		git_config_from_file(fn, global, data);
-	if (do_all)
-		git_config_from_file(fn, local, data);
-	git_config_from_parameters(fn, data);
-	if (!do_all && !values.nr)
-		git_config_from_file(fn, local, data);
-	if (!do_all && !values.nr && global)
-		git_config_from_file(fn, global, data);
-	if (!do_all && !values.nr && xdg)
-		git_config_from_file(fn, xdg, data);
-	if (!do_all && !values.nr && system_wide)
-		git_config_from_file(fn, system_wide, data);
+	git_config_with_options(collect_config, &values,
+				given_config_file, respect_includes);
 
 	ret = !values.nr;
 
@@ -267,9 +230,6 @@ free_strings:
 	free(values.items);
 
 free_strings:
-	free(repo_config);
-	free(global);
-	free(xdg);
 	free(key);
 	if (key_regexp) {
 		regfree(key_regexp);
-- 
1.8.0.3.g3456896
