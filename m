From: Jeff King <peff@peff.net>
Subject: [PATCH 1/4] config: add include directive
Date: Thu, 26 Jan 2012 02:37:52 -0500
Message-ID: <20120126073752.GA30474@sigill.intra.peff.net>
References: <20120126073547.GA28689@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 26 08:38:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqJuE-0006lu-Qn
	for gcvg-git-2@lo.gmane.org; Thu, 26 Jan 2012 08:38:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751970Ab2AZHh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jan 2012 02:37:57 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44999
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751958Ab2AZHh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 02:37:56 -0500
Received: (qmail 23946 invoked by uid 107); 26 Jan 2012 07:44:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Jan 2012 02:44:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jan 2012 02:37:52 -0500
Content-Disposition: inline
In-Reply-To: <20120126073547.GA28689@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189141>

It can be useful to split your ~/.gitconfig across multiple
files. For example, you might have a "main" file which is
used on many machines, but a small set of per-machine
tweaks. Or you may want to make some of your config public
(e.g., clever aliases) while keeping other data back (e.g.,
your name or other identifying information). Or you may want
to include a number of config options in some subset of your
repos without copying and pasting (e.g., you want to
reference them from the .git/config of participating repos).

This patch introduces an include directive for config files.
It looks like:

  [include]
    path = /path/to/file

This is syntactically backwards-compatible with existing git
config parsers (i.e., they will see it as another config
entry and ignore it unless you are looking up include.path).

The implementation provides a "git_config_include" callback
which wraps regular config callbacks.  Callers can pass it
to git_config_from_file, and it will transparently follow
any include directives, passing all of the discovered
options to the real callback.

Include directives are turned on for regular git config
parsing (i.e., when you call git_config()), as well as for
lookups via the "git config" program. They are not turned on
in other cases, including:

  1. Parsing of other config-like files, like .gitmodules.
     There isn't a real need, and I'd rather be conservative
     and avoid unnecessary incompatibility or confusion.

  2. Writing files via "git config"; we want to treat
     include.* variables as literal items to be copied (or
     modified), and not expand them. So "git config
     --unset-all foo.bar" would operate _only_ on
     .git/config, not any of its included files (just as it
     also does not operate on ~/.gitconfig).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt     |   15 ++++++
 Documentation/git-config.txt |    5 ++
 builtin/config.c             |   29 +++++++++---
 cache.h                      |    6 +++
 config.c                     |   58 +++++++++++++++++++++++++
 t/t1305-config-include.sh    |   98 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 204 insertions(+), 7 deletions(-)
 create mode 100755 t/t1305-config-include.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index abeb82b..e55dae1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -84,6 +84,17 @@ customary UNIX fashion.
 
 Some variables may require a special value format.
 
+Includes
+~~~~~~~~
+
+You can include one config file from another by setting the special
+`include.path` variable to the name of the file to be included. The
+included file is expanded immediately, as if its contents had been
+found at the location of the include directive. If the value of the
+`include.path` variable is a relative path, the path is considered to be
+relative to the configuration file in which the include directive was
+found. See below for examples.
+
 Example
 ~~~~~~~
 
@@ -106,6 +117,10 @@ Example
 		gitProxy="ssh" for "kernel.org"
 		gitProxy=default-proxy ; for the rest
 
+	[include]
+		path = /path/to/foo.inc ; include by absolute path
+		path = foo ; expand "foo" relative to the current file
+
 Variables
 ~~~~~~~~~
 
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index e7ecf5d..aa8303b 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -178,6 +178,11 @@ See also <<FILES>>.
 	Opens an editor to modify the specified config file; either
 	'--system', '--global', or repository (default).
 
+--includes::
+--no-includes::
+	Respect `include.*` directives in config files when looking up
+	values. Defaults to on.
+
 [[FILES]]
 FILES
 -----
diff --git a/builtin/config.c b/builtin/config.c
index d35c06a..9105f87 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -25,6 +25,7 @@ static const char *given_config_file;
 static int actions, types;
 static const char *get_color_slot, *get_colorbool_slot;
 static int end_null;
+static int respect_includes = 1;
 
 #define ACTION_GET (1<<0)
 #define ACTION_GET_ALL (1<<1)
@@ -74,6 +75,8 @@ static struct option builtin_config_options[] = {
 	OPT_BIT(0, "path", &types, "value is a path (file or directory name)", TYPE_PATH),
 	OPT_GROUP("Other"),
 	OPT_BOOLEAN('z', "null", &end_null, "terminate values with NUL byte"),
+	OPT_BOOLEAN(0, "includes", &respect_includes,
+		    "respect include directives on lookup"),
 	OPT_END(),
 };
 
@@ -161,6 +164,9 @@ static int get_value(const char *key_, const char *regex_)
 	int ret = -1;
 	char *global = NULL, *repo_config = NULL;
 	const char *system_wide = NULL, *local;
+	struct git_config_include_data inc;
+	config_fn_t fn;
+	void *data;
 
 	local = config_exclusive_filename;
 	if (!local) {
@@ -213,19 +219,28 @@ static int get_value(const char *key_, const char *regex_)
 		}
 	}
 
+	fn = show_config;
+	data = NULL;
+	if (respect_includes) {
+		inc.fn = fn;
+		inc.data = data;
+		fn = git_config_include;
+		data = &inc;
+	}
+
 	if (do_all && system_wide)
-		git_config_from_file(show_config, system_wide, NULL);
+		git_config_from_file(fn, system_wide, data);
 	if (do_all && global)
-		git_config_from_file(show_config, global, NULL);
+		git_config_from_file(fn, global, data);
 	if (do_all)
-		git_config_from_file(show_config, local, NULL);
-	git_config_from_parameters(show_config, NULL);
+		git_config_from_file(fn, local, data);
+	git_config_from_parameters(fn, data);
 	if (!do_all && !seen)
-		git_config_from_file(show_config, local, NULL);
+		git_config_from_file(fn, local, data);
 	if (!do_all && !seen && global)
-		git_config_from_file(show_config, global, NULL);
+		git_config_from_file(fn, global, data);
 	if (!do_all && !seen && system_wide)
-		git_config_from_file(show_config, system_wide, NULL);
+		git_config_from_file(fn, system_wide, data);
 
 	free(key);
 	if (regexp) {
diff --git a/cache.h b/cache.h
index 10afd71..21bbb0a 100644
--- a/cache.h
+++ b/cache.h
@@ -1138,6 +1138,12 @@ extern const char *get_commit_output_encoding(void);
 
 extern int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
 
+struct git_config_include_data {
+	config_fn_t fn;
+	void *data;
+};
+int git_config_include(const char *name, const char *value, void *vdata);
+
 extern const char *config_exclusive_filename;
 
 #define MAX_GITNAME (1000)
diff --git a/config.c b/config.c
index 40f9c6d..a6966c1 100644
--- a/config.c
+++ b/config.c
@@ -874,10 +874,68 @@ int git_config_system(void)
 	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
 }
 
+static int handle_path_include(const char *path, void *data)
+{
+	int ret = 0;
+	struct strbuf buf = STRBUF_INIT;
+
+	/*
+	 * Use an absolute value as-is, but interpret relative paths
+	 * based on the including config file.
+	 */
+	if (!is_absolute_path(path)) {
+		char *slash;
+		if (!cf)
+			return error("relative config includes must come from files");
+		strbuf_addstr(&buf, absolute_path(cf->name));
+		slash = find_last_dir_sep(buf.buf);
+		if (!slash)
+			die("BUG: no directory separator in an absolute path?");
+		strbuf_setlen(&buf, slash - buf.buf + 1);
+		strbuf_addf(&buf, "%s", path);
+		path = buf.buf;
+	}
+
+	if (!access(path, R_OK))
+		ret = git_config_from_file(git_config_include, path, data);
+	strbuf_release(&buf);
+	return ret;
+}
+
+int git_config_include(const char *name, const char *value, void *vdata)
+{
+	const struct git_config_include_data *data = vdata;
+	const char *type;
+	int ret;
+
+	/*
+	 * Pass along all values, including "include" directives; this makes it
+	 * possible to query information on the includes themselves.
+	 */
+	ret = data->fn(name, value, data->data);
+	if (ret < 0)
+		return ret;
+
+	if (prefixcmp(name, "include."))
+		return ret;
+	type = strrchr(name, '.') + 1;
+
+	if (!strcmp(type, "path"))
+		ret = handle_path_include(value, vdata);
+
+	return ret;
+}
+
 int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 {
 	int ret = 0, found = 0;
 	const char *home = NULL;
+	struct git_config_include_data inc;
+
+	inc.fn = fn;
+	inc.data = data;
+	fn = git_config_include;
+	data = &inc;
 
 	/* Setting $GIT_CONFIG makes git read _only_ the given config file. */
 	if (config_exclusive_filename)
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
new file mode 100755
index 0000000..4db3091
--- /dev/null
+++ b/t/t1305-config-include.sh
@@ -0,0 +1,98 @@
+#!/bin/sh
+
+test_description='test config file include directives'
+. ./test-lib.sh
+
+test_expect_success 'include file by absolute path' '
+	echo "[test]one = 1" >one &&
+	echo "[include]path = \"$PWD/one\"" >base &&
+	echo 1 >expect &&
+	git config -f base test.one >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'include file by relative path' '
+	echo "[test]one = 1" >one &&
+	echo "[include]path = one" >base &&
+	echo 1 >expect &&
+	git config -f base test.one >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'recursive relative paths' '
+	mkdir subdir &&
+	echo "[test]three = 3" >subdir/three &&
+	echo "[include]path = three" >subdir/two &&
+	echo "[include]path = subdir/two" >base &&
+	echo 3 >expect &&
+	git config -f base test.three >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'include options can still be examined' '
+	echo "[test]one = 1" >one &&
+	echo "[include]path = one" >base &&
+	echo one >expect &&
+	git config -f base include.path >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'listing includes option and expansion' '
+	echo "[test]one = 1" >one &&
+	echo "[include]path = one" >base &&
+	cat >expect <<-\EOF &&
+	include.path=one
+	test.one=1
+	EOF
+	git config -f base --list >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'writing config file does not expand includes' '
+	echo "[test]one = 1" >one &&
+	echo "[include]path = one" >base &&
+	git config -f base test.two 2 &&
+	echo 2 >expect &&
+	git config -f base --no-includes test.two >actual &&
+	test_cmp expect actual &&
+	test_must_fail git config -f base --no-includes test.one
+'
+
+test_expect_success 'config modification does not affect includes' '
+	echo "[test]one = 1" >one &&
+	echo "[include]path = one" >base &&
+	git config -f base test.one 2 &&
+	echo 1 >expect &&
+	git config -f one test.one >actual &&
+	test_cmp expect actual &&
+	cat >expect <<-\EOF &&
+	1
+	2
+	EOF
+	git config -f base --get-all test.one >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'missing include files are ignored' '
+	cat >base <<-\EOF &&
+	[include]path = foo
+	[test]value = yes
+	EOF
+	echo yes >expect &&
+	git config -f base test.value >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'absolute includes from command line work' '
+	echo "[test]one = 1" >one &&
+	echo 1 >expect &&
+	git -c include.path="$PWD/one" config test.one >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'relative includes from command line fail' '
+	echo "[test]one = 1" >one &&
+	test_must_fail git -c include.path=one config test.one
+'
+
+test_done
-- 
1.7.9.rc2.293.gaae2
