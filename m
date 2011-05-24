From: Jeff King <peff@peff.net>
Subject: [PATCH 3/4] config: always parse GIT_CONFIG_PARAMETERS during
 git_config
Date: Tue, 24 May 2011 18:49:55 -0400
Message-ID: <20110524224955.GC24527@sigill.intra.peff.net>
References: <20110524224903.GA16265@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 25 00:50:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QP0QO-0004Jy-NA
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 00:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170Ab1EXWt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 18:49:59 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36214
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757746Ab1EXWt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 18:49:57 -0400
Received: (qmail 22772 invoked by uid 107); 24 May 2011 22:49:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 May 2011 18:49:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 May 2011 18:49:55 -0400
Content-Disposition: inline
In-Reply-To: <20110524224903.GA16265@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174357>

Previously we parsed GIT_CONFIG_PARAMETERS lazily into a
linked list, and then checked that list during future
invocations of git_config. However, that ignores the fact
that the environment variable could change during our run
(e.g., because we parse more "-c" as part of an alias).

Instead, let's just re-parse the environment variable each
time. It's generally not very big, and it's no more work
than parsing the config files, anyway.

As a bonus, we can ditch all of the linked list storage code
entirely, making the code much simpler.

The test unfortunately still does not pass because of an
unrelated bug in handle_options.

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c               |   50 ++++++++++-------------------------------------
 t/t1300-repo-config.sh |    7 ++++++
 2 files changed, 18 insertions(+), 39 deletions(-)

diff --git a/config.c b/config.c
index fb88839..e0b3b80 100644
--- a/config.c
+++ b/config.c
@@ -20,14 +20,6 @@ static int zlib_compression_seen;
 
 const char *config_exclusive_filename = NULL;
 
-struct config_item {
-	struct config_item *next;
-	char *name;
-	char *value;
-};
-static struct config_item *config_parameters;
-static struct config_item **config_parameters_tail = &config_parameters;
-
 static void lowercase(char *p)
 {
 	for (; *p; p++)
@@ -47,9 +39,9 @@ void git_config_push_parameter(const char *text)
 	strbuf_release(&env);
 }
 
-static int git_config_parse_parameter(const char *text)
+static int git_config_parse_parameter(const char *text,
+				      config_fn_t fn, void *data)
 {
-	struct config_item *ct;
 	struct strbuf tmp = STRBUF_INIT;
 	struct strbuf **pair;
 	strbuf_addstr(&tmp, text);
@@ -59,22 +51,19 @@ static int git_config_parse_parameter(const char *text)
 	strbuf_trim(pair[0]);
 	if (!pair[0]->len) {
 		strbuf_list_free(pair);
-		return -1;
+		return error("bogus config parameter: %s", text);
 	}
-	ct = xcalloc(1, sizeof(struct config_item));
-	ct->name = strbuf_detach(pair[0], NULL);
-	if (pair[1]) {
-		strbuf_trim(pair[1]);
-		ct->value = strbuf_detach(pair[1], NULL);
+	lowercase(pair[0]->buf);
+	if (fn(pair[0]->buf, pair[1] ? pair[1]->buf : NULL, data) < 0) {
+		strbuf_list_free(pair);
+		return -1;
 	}
 	strbuf_list_free(pair);
-	lowercase(ct->name);
-	*config_parameters_tail = ct;
-	config_parameters_tail = &ct->next;
 	return 0;
 }
 
-static int git_config_parse_environment(void) {
+int git_config_from_parameters(config_fn_t fn, void *data)
+{
 	const char *env = getenv(CONFIG_DATA_ENVIRONMENT);
 	char *envw;
 	const char **argv = NULL;
@@ -92,8 +81,7 @@ static int git_config_parse_environment(void) {
 	}
 
 	for (i = 0; i < nr; i++) {
-		if (git_config_parse_parameter(argv[i]) < 0) {
-			error("bogus config parameter: %s", argv[i]);
+		if (git_config_parse_parameter(argv[i], fn, data) < 0) {
 			free(argv);
 			free(envw);
 			return -1;
@@ -102,7 +90,7 @@ static int git_config_parse_environment(void) {
 
 	free(argv);
 	free(envw);
-	return 0;
+	return nr > 0;
 }
 
 static int get_next_char(void)
@@ -837,22 +825,6 @@ int git_config_system(void)
 	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
 }
 
-int git_config_from_parameters(config_fn_t fn, void *data)
-{
-	static int loaded_environment;
-	const struct config_item *ct;
-
-	if (!loaded_environment) {
-		if (git_config_parse_environment() < 0)
-			return -1;
-		loaded_environment = 1;
-	}
-	for (ct = config_parameters; ct; ct = ct->next)
-		if (fn(ct->name, ct->value, data) < 0)
-			return -1;
-	return config_parameters != NULL;
-}
-
 int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 {
 	int ret = 0, found = 0;
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 53fb822..fe7a153 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -897,4 +897,11 @@ test_expect_success 'key sanity-checking' '
 	git config foo."ba =z".bar false
 '
 
+test_expect_failure 'git -c works with aliases of builtins' '
+	git config alias.checkconfig "-c foo.check=bar config foo.check" &&
+	echo bar >expect &&
+	git checkconfig >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.4.5.7.g2e01
