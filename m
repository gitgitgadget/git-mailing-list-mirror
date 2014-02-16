From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: [PATCH] config: teach "git config --file -" to read from the standard input
Date: Sun, 16 Feb 2014 14:13:01 +0200
Message-ID: <1392552781-23275-1-git-send-email-kirill@shutemov.name>
References: <CAPig+cSRgpABwzC36FoBst52hCOPieMBTvsTx9CPFoHifHG9yg@mail.gmail.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
To: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Feb 16 13:13:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WF0b4-0003fy-7Y
	for gcvg-git-2@plane.gmane.org; Sun, 16 Feb 2014 13:13:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742AbaBPMNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Feb 2014 07:13:13 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:38857 "EHLO jenni1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477AbaBPMNM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Feb 2014 07:13:12 -0500
Received: from node.shutemov.name (80.220.224.16) by jenni1.inet.fi (8.5.140.03)
        id 527750DA08B6A18E; Sun, 16 Feb 2014 14:13:08 +0200
Received: by node.shutemov.name (Postfix, from userid 1000)
	id AEC334076E; Sun, 16 Feb 2014 14:13:06 +0200 (EET)
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <CAPig+cSRgpABwzC36FoBst52hCOPieMBTvsTx9CPFoHifHG9yg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242220>

The patch extends git config --file interface to allow read config from
stdin.

Editing stdin or setting value in stdin is an error.

Include by absolute path is allowed in stdin config, but not by relative
path.

Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
---
 builtin/config.c          | 11 +++++++++
 cache.h                   |  1 +
 config.c                  | 58 ++++++++++++++++++++++++++++++++---------------
 t/t1300-repo-config.sh    | 17 ++++++++++++--
 t/t1305-config-include.sh | 16 ++++++++++++-
 5 files changed, 82 insertions(+), 21 deletions(-)

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
index 6269da907964..7b42608f5c89 100644
--- a/config.c
+++ b/config.c
@@ -443,10 +443,20 @@ static int git_parse_source(config_fn_t fn, void *data)
 		if (get_value(fn, data, var) < 0)
 			break;
 	}
-	if (cf->die_on_error)
-		die("bad config file line %d in %s", cf->linenr, cf->name);
-	else
-		return error("bad config file line %d in %s", cf->linenr, cf->name);
+	if (cf->die_on_error) {
+		if (cf->name)
+			die("bad config file line %d in %s",
+					cf->linenr, cf->name);
+		else
+			die("bad config file line %d", cf->linenr);
+
+	} else {
+		if (cf->name)
+			return error("bad config file line %d in %s",
+					cf->linenr, cf->name);
+		else
+			return error("bad config file line %d", cf->linenr);
+	}
 }
 
 static int parse_unit_factor(const char *end, uintmax_t *val)
@@ -1030,24 +1040,34 @@ static int do_config_from(struct config_source *top, config_fn_t fn, void *data)
 	return ret;
 }
 
-int git_config_from_file(config_fn_t fn, const char *filename, void *data)
+static int do_config_from_file(config_fn_t fn, const char *filename, FILE *f,
+			       void *data)
 {
-	int ret;
-	FILE *f = fopen(filename, "r");
+	struct config_source top;
 
-	ret = -1;
-	if (f) {
-		struct config_source top;
+	top.u.file = f;
+	top.name = filename;
+	top.die_on_error = 1;
+	top.do_fgetc = config_file_fgetc;
+	top.do_ungetc = config_file_ungetc;
+	top.do_ftell = config_file_ftell;
 
-		top.u.file = f;
-		top.name = filename;
-		top.die_on_error = 1;
-		top.do_fgetc = config_file_fgetc;
-		top.do_ungetc = config_file_ungetc;
-		top.do_ftell = config_file_ftell;
+	return do_config_from(&top, fn, data);
+}
+
+static int git_config_from_stdin(config_fn_t fn, void *data)
+{
+	return do_config_from_file(fn, NULL, stdin, data);
+}
 
-		ret = do_config_from(&top, fn, data);
+int git_config_from_file(config_fn_t fn, const char *filename, void *data)
+{
+	int ret = -1;
+	FILE *f;
 
+	f = fopen(filename, "r");
+	if (f) {
+		ret = do_config_from_file(fn, filename, f, data);
 		fclose(f);
 	}
 	return ret;
@@ -1188,7 +1208,9 @@ int git_config_with_options(config_fn_t fn, void *data,
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
index a70707620f14..01e50c5882d0 100755
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
 
@@ -122,6 +122,20 @@ test_expect_success 'relative includes from command line fail' '
 	test_must_fail git -c include.path=one config test.one
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
1.8.5.2
