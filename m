From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: [PATCH 4/4] config: teach "git config --file -" to read from the standard input
Date: Wed, 19 Feb 2014 00:58:55 +0200
Message-ID: <1392764335-13274-4-git-send-email-kirill@shutemov.name>
References: <1392764335-13274-1-git-send-email-kirill@shutemov.name>
Cc: Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
	"Kirill A. Shutemov" <kirill@shutemov.name>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 18 23:59:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFtdR-0007fp-1J
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 23:59:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753883AbaBRW7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 17:59:20 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:34715 "EHLO jenni1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751239AbaBRW7P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 17:59:15 -0500
Received: from node.shutemov.name (80.220.224.16) by jenni1.inet.fi (8.5.140.03)
        id 527750DA08F0365B; Wed, 19 Feb 2014 00:59:10 +0200
Received: by node.shutemov.name (Postfix, from userid 1000)
	id 20D4841237; Wed, 19 Feb 2014 00:59:08 +0200 (EET)
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1392764335-13274-1-git-send-email-kirill@shutemov.name>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242367>

The patch extends git config --file interface to allow read config from
stdin.

Editing stdin or setting value in stdin is an error.

Include by absolute path is allowed in stdin config, but not by relative
path.

Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
---
 builtin/config.c          | 11 +++++++++++
 cache.h                   |  1 +
 config.c                  | 41 +++++++++++++++++++++++++++--------------
 t/t1300-repo-config.sh    | 17 +++++++++++++++--
 t/t1305-config-include.sh | 16 +++++++++++++++-
 5 files changed, 69 insertions(+), 17 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index de41ba50e9ca..5677c942b693 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -360,6 +360,9 @@ static int get_colorbool(int print)
 
 static void check_write(void)
 {
+	if (given_config_source.use_stdin)
+		die("writing to stdin is not supported");
+
 	if (given_config_source.blob)
 		die("writing config blobs is not supported");
 }
@@ -472,6 +475,12 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 
+	if (given_config_source.file &&
+			!strcmp(given_config_source.file, "-")) {
+		given_config_source.file = NULL;
+		given_config_source.use_stdin = 1;
+	}
+
 	if (use_global_config) {
 		char *user_config = NULL;
 		char *xdg_config = NULL;
@@ -558,6 +567,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		check_argc(argc, 0, 0);
 		if (!given_config_source.file && nongit)
 			die("not in a git directory");
+		if (given_config_source.use_stdin)
+			die("editing stdin is not supported");
 		if (given_config_source.blob)
 			die("editing blobs is not supported");
 		git_config(git_default_config, NULL);
diff --git a/cache.h b/cache.h
index 9d94bd69f7db..4db19b537059 100644
--- a/cache.h
+++ b/cache.h
@@ -1147,6 +1147,7 @@ extern int update_server_info(int);
 #define CONFIG_GENERIC_ERROR 7
 
 struct git_config_source {
+	unsigned int use_stdin:1;
 	const char *file;
 	const char *blob;
 };
diff --git a/config.c b/config.c
index a21b0ddadecc..7b1febdf4af0 100644
--- a/config.c
+++ b/config.c
@@ -1031,24 +1031,35 @@ static int do_config_from(struct config_source *top, config_fn_t fn, void *data)
 	return ret;
 }
 
-int git_config_from_file(config_fn_t fn, const char *filename, void *data)
+static int do_config_from_file(config_fn_t fn,
+		const char *name, const char *path, FILE *f, void *data)
 {
-	int ret;
-	FILE *f = fopen(filename, "r");
+	struct config_source top;
 
-	ret = -1;
-	if (f) {
-		struct config_source top;
+	top.u.file = f;
+	top.name = name;
+	top.path = path;
+	top.die_on_error = 1;
+	top.do_fgetc = config_file_fgetc;
+	top.do_ungetc = config_file_ungetc;
+	top.do_ftell = config_file_ftell;
 
-		top.u.file = f;
-		top.name = top.path = filename;
-		top.die_on_error = 1;
-		top.do_fgetc = config_file_fgetc;
-		top.do_ungetc = config_file_ungetc;
-		top.do_ftell = config_file_ftell;
+	return do_config_from(&top, fn, data);
+}
 
-		ret = do_config_from(&top, fn, data);
+static int git_config_from_stdin(config_fn_t fn, void *data)
+{
+	return do_config_from_file(fn, "<stdin>", NULL, stdin, data);
+}
+
+int git_config_from_file(config_fn_t fn, const char *filename, void *data)
+{
+	int ret = -1;
+	FILE *f;
 
+	f = fopen(filename, "r");
+	if (f) {
+		ret = do_config_from_file(fn, filename, filename, f, data);
 		fclose(f);
 	}
 	return ret;
@@ -1190,7 +1201,9 @@ int git_config_with_options(config_fn_t fn, void *data,
 	 * If we have a specific filename, use it. Otherwise, follow the
 	 * regular lookup sequence.
 	 */
-	if (config_source && config_source->file)
+	if (config_source && config_source->use_stdin)
+		return git_config_from_stdin(fn, data);
+	else if (config_source && config_source->file)
 		return git_config_from_file(fn, config_source->file, data);
 	else if (config_source && config_source->blob)
 		return git_config_from_blob_ref(fn, config_source->blob, data);
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 967359344dab..c9c426c273e5 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -475,15 +475,28 @@ ein.bahn=strasse
 EOF
 
 test_expect_success 'alternative GIT_CONFIG' '
-	GIT_CONFIG=other-config git config -l >output &&
+	GIT_CONFIG=other-config git config --list >output &&
 	test_cmp expect output
 '
 
 test_expect_success 'alternative GIT_CONFIG (--file)' '
-	git config --file other-config -l > output &&
+	git config --file other-config --list >output &&
 	test_cmp expect output
 '
 
+test_expect_success 'alternative GIT_CONFIG (--file=-)' '
+	git config --file - --list <other-config >output &&
+	test_cmp expect output
+'
+
+test_expect_success 'setting a value in stdin is an error' '
+	test_must_fail git config --file - some.value foo
+'
+
+test_expect_success 'editing stdin is an error' '
+	test_must_fail git config --file - --edit
+'
+
 test_expect_success 'refer config from subdirectory' '
 	mkdir x &&
 	(
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index 6edd38b39a0b..9ba2ba11c3ca 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -113,7 +113,7 @@ test_expect_success 'missing include files are ignored' '
 test_expect_success 'absolute includes from command line work' '
 	echo "[test]one = 1" >one &&
 	echo 1 >expect &&
-	git -c include.path="$PWD/one" config test.one >actual &&
+	git -c include.path="$(pwd)/one" config test.one >actual &&
 	test_cmp expect actual
 '
 
@@ -138,6 +138,20 @@ test_expect_success 'relative includes from blobs fail' '
 	test_must_fail git config --blob=$blob test.one
 '
 
+test_expect_success 'absolute includes from stdin work' '
+	echo "[test]one = 1" >one &&
+	echo 1 >expect &&
+	echo "[include]path=\"$(pwd)/one\"" |
+	git config --file - test.one >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'relative includes from stdin line fail' '
+	echo "[test]one = 1" >one &&
+	echo "[include]path=one" |
+	test_must_fail git config --file - test.one
+'
+
 test_expect_success 'include cycles are detected' '
 	cat >.gitconfig <<-\EOF &&
 	[test]value = gitconfig
-- 
1.9.0.rc3
