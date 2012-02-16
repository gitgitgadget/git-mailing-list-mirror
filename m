From: Jeff King <peff@peff.net>
Subject: [PATCH 8/8] config: do not respect includes for single-file --list
Date: Thu, 16 Feb 2012 03:10:01 -0500
Message-ID: <20120216081001.GH11843@sigill.intra.peff.net>
References: <20120216080102.GA11793@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 16 09:10:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxwPo-0004TP-QB
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 09:10:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754744Ab2BPIKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 03:10:04 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38600
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752278Ab2BPIKD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 03:10:03 -0500
Received: (qmail 28148 invoked by uid 107); 16 Feb 2012 08:17:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Feb 2012 03:17:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Feb 2012 03:10:01 -0500
Content-Disposition: inline
In-Reply-To: <20120216080102.GA11793@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190883>

The original include implementation tried not to impact
calls to "git config" that look at a single file. However,
since we called into git_config in a few places (e.g.,
--list), our respect_includes flag was not supported.

This patch teaches git_config_with_options a flag to
respect includes (instead of doing so by default), and
teaches git-config to use it.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/config.c          |    7 ++++---
 cache.h                   |    3 ++-
 config.c                  |   14 ++++++++------
 t/t1305-config-include.sh |    8 ++++++++
 4 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 8901dd9..d41a9bf 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -316,7 +316,7 @@ static void get_color(const char *def_color)
 	get_color_found = 0;
 	parsed_color[0] = '\0';
 	git_config_with_options(git_get_color_config, NULL,
-				given_config_file);
+				given_config_file, respect_includes);
 
 	if (!get_color_found && def_color)
 		color_parse(def_color, "command line", parsed_color);
@@ -344,7 +344,7 @@ static int get_colorbool(int print)
 	get_colorbool_found = -1;
 	get_diff_color_found = -1;
 	git_config_with_options(git_get_colorbool_config, NULL,
-				given_config_file);
+				given_config_file, respect_includes);
 
 	if (get_colorbool_found < 0) {
 		if (!strcmp(get_colorbool_slot, "color.diff"))
@@ -441,7 +441,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	if (actions == ACTION_LIST) {
 		check_argc(argc, 0, 0);
 		if (git_config_with_options(show_all_config, NULL,
-					    given_config_file) < 0) {
+					    given_config_file,
+					    respect_includes) < 0) {
 			if (given_config_file)
 				die_errno("unable to read config file '%s'",
 					  given_config_file);
diff --git a/cache.h b/cache.h
index 411c60d..ff54d6f 100644
--- a/cache.h
+++ b/cache.h
@@ -1115,7 +1115,8 @@ extern int git_config_from_file(config_fn_t fn, const char *, void *);
 extern void git_config_push_parameter(const char *text);
 extern int git_config_from_parameters(config_fn_t fn, void *data);
 extern int git_config(config_fn_t fn, void *);
-extern int git_config_with_options(config_fn_t fn, void *, const char *filename);
+extern int git_config_with_options(config_fn_t fn, void *,
+				   const char *filename, int respect_includes);
 extern int git_config_early(config_fn_t fn, void *, const char *repo_config);
 extern int git_parse_ulong(const char *, unsigned long *);
 extern int git_config_int(const char *, const char *);
diff --git a/config.c b/config.c
index e1d6857..ad03908 100644
--- a/config.c
+++ b/config.c
@@ -976,16 +976,18 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 }
 
 int git_config_with_options(config_fn_t fn, void *data,
-			    const char *filename)
+			    const char *filename, int respect_includes)
 {
 	char *repo_config = NULL;
 	int ret;
 	struct config_include_data inc = CONFIG_INCLUDE_INIT;
 
-	inc.fn = fn;
-	inc.data = data;
-	fn = git_config_include;
-	data = &inc;
+	if (respect_includes) {
+		inc.fn = fn;
+		inc.data = data;
+		fn = git_config_include;
+		data = &inc;
+	}
 
 	/*
 	 * If we have a specific filename, use it. Otherwise, follow the
@@ -1003,7 +1005,7 @@ int git_config_with_options(config_fn_t fn, void *data,
 
 int git_config(config_fn_t fn, void *data)
 {
-	return git_config_with_options(fn, data, NULL);
+	return git_config_with_options(fn, data, NULL, 1);
 }
 
 /*
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index 0a27ec4..f3e03a0 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -59,6 +59,14 @@ test_expect_success 'single file lookup does not expand includes by default' '
 	test_cmp expect actual
 '
 
+test_expect_success 'single file list does not expand includes by default' '
+	echo "[test]one = 1" >one &&
+	echo "[include]path = one" >.gitconfig &&
+	echo "include.path=one" >expect &&
+	git config -f .gitconfig --list >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'writing config file does not expand includes' '
 	echo "[test]one = 1" >one &&
 	echo "[include]path = one" >.gitconfig &&
-- 
1.7.9.1.4.g8ffed
