From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v5 3/3] git: submodule honor -c credential.* from command line
Date: Fri, 26 Feb 2016 16:13:20 -0800
Message-ID: <1456532000-22971-4-git-send-email-jacob.e.keller@intel.com>
References: <1456532000-22971-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 01:13:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZSW9-0007ED-Sw
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 01:13:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933580AbcB0ANZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 19:13:25 -0500
Received: from mga01.intel.com ([192.55.52.88]:38260 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752176AbcB0ANY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 19:13:24 -0500
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP; 26 Feb 2016 16:13:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,506,1449561600"; 
   d="scan'208";a="924835111"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.65])
  by fmsmga002.fm.intel.com with ESMTP; 26 Feb 2016 16:13:23 -0800
X-Mailer: git-send-email 2.7.1.429.g45cd78e
In-Reply-To: <1456532000-22971-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287648>

From: Jacob Keller <jacob.keller@gmail.com>

Due to the way that the git-submodule code works, it clears all local
git environment variables before entering submodules. This is normally
a good thing since we want to clear settings such as GIT_WORKTREE and
other variables which would affect the operation of submodule commands.
However, GIT_CONFIG_PARAMETERS is special, and we actually do want to
preserve these settings. However, we do not want to preserve all
configuration as many things should be left specific to the parent
project.

Add a git submodule--helper function, sanitize-config, which shall be
used to sanitize GIT_CONFIG_PARAMETERS, removing all key/value pairs
except a small subset that are known to be safe and necessary.

Replace all the calls to clear_local_git_env with a wrapped function
that filters GIT_CONFIG_PARAMETERS using the new helper and then
restores it to the filtered subset after clearing the rest of the
environment.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---

Notes:
    - v2
    * Clarify which paramaters are left after the sanitization, and don't seem to
      indicate it is our goal to extend the list.
    * add a comment in the submodule_config_ok function indicating the same
    
    - v3
    * Remove extraneous comments
    * add strbuf_release calls
    * rename sanitize_local_git_env
    * remove use of local
    * add C equivalent of sanitize_config
    * add a test for the credential passing
    
    - v4
    * use argc check instead of empty options check
    * fix brain-melting quotes in t7412-submodule--helper.sh
    
    - v5
    * use new sq_quote_f
    * fix test to use ${sq} style to prevent need of complex quotes or the use of
      double quotes on the test body

 builtin/submodule--helper.c  | 68 +++++++++++++++++++++++++++++++++++++++++++-
 git-submodule.sh             | 36 ++++++++++++++---------
 t/t5550-http-fetch-dumb.sh   | 17 +++++++++++
 t/t7412-submodule--helper.sh | 26 +++++++++++++++++
 4 files changed, 133 insertions(+), 14 deletions(-)
 create mode 100755 t/t7412-submodule--helper.sh

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 072d9bbd12a8..43943eef81b4 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -124,6 +124,55 @@ static int module_name(int argc, const char **argv, const char *prefix)
 
 	return 0;
 }
+
+/*
+ * Rules to sanitize configuration variables that are Ok to be passed into
+ * submodule operations from the parent project using "-c". Should only
+ * include keys which are both (a) safe and (b) necessary for proper
+ * operation.
+ */
+static int submodule_config_ok(const char *var)
+{
+	if (starts_with(var, "credential."))
+		return 1;
+	return 0;
+}
+
+static int sanitize_submodule_config(const char *var, const char *value, void *data)
+{
+	struct strbuf quoted = STRBUF_INIT;
+	struct strbuf *out = data;
+
+	if (submodule_config_ok(var)) {
+		if (out->len)
+			strbuf_addch(out, ' ');
+
+		sq_quotef(out, "%s=%s", var, value);
+	}
+
+	strbuf_release(&quoted);
+
+	return 0;
+}
+
+static void prepare_submodule_repo_env(struct argv_array *out)
+{
+	const char * const *var;
+
+	for (var = local_repo_env; *var; var++) {
+		if (!strcmp(*var, CONFIG_DATA_ENVIRONMENT)) {
+			struct strbuf sanitized_config = STRBUF_INIT;
+			git_config_from_parameters(sanitize_submodule_config,
+						   &sanitized_config);
+			argv_array_pushf(out, "%s=%s", *var, sanitized_config.buf);
+			strbuf_release(&sanitized_config);
+		} else {
+			argv_array_push(out, *var);
+		}
+	}
+
+}
+
 static int clone_submodule(const char *path, const char *gitdir, const char *url,
 			   const char *depth, const char *reference, int quiet)
 {
@@ -145,7 +194,7 @@ static int clone_submodule(const char *path, const char *gitdir, const char *url
 	argv_array_push(&cp.args, path);
 
 	cp.git_cmd = 1;
-	cp.env = local_repo_env;
+	prepare_submodule_repo_env(&cp.env_array);
 	cp.no_stdin = 1;
 
 	return run_command(&cp);
@@ -258,6 +307,22 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static int module_sanitize_config(int argc, const char **argv, const char *prefix)
+{
+	struct strbuf sanitized_config = STRBUF_INIT;
+
+	if (argc > 1)
+		usage(_("git submodule--helper sanitize-config"));
+
+	git_config_from_parameters(sanitize_submodule_config, &sanitized_config);
+	if (sanitized_config.len)
+		printf("%s\n", sanitized_config.buf);
+
+	strbuf_release(&sanitized_config);
+
+	return 0;
+}
+
 struct cmd_struct {
 	const char *cmd;
 	int (*fn)(int, const char **, const char *);
@@ -267,6 +332,7 @@ static struct cmd_struct commands[] = {
 	{"list", module_list},
 	{"name", module_name},
 	{"clone", module_clone},
+	{"sanitize-config", module_sanitize_config},
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/git-submodule.sh b/git-submodule.sh
index 2dd29b3df0e6..1f132b489b81 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -192,6 +192,16 @@ isnumber()
 	n=$(($1 + 0)) 2>/dev/null && test "$n" = "$1"
 }
 
+# Sanitize the local git environment for use within a submodule. We
+# can't simply use clear_local_git_env since we want to preserve some
+# of the settings from GIT_CONFIG_PARAMETERS.
+sanitize_submodule_env()
+{
+	sanitized_config=$(git submodule--helper sanitize-config)
+	clear_local_git_env
+	GIT_CONFIG_PARAMETERS=$sanitized_config
+}
+
 #
 # Add a new submodule to the working tree, .gitmodules and the index
 #
@@ -349,7 +359,7 @@ Use -f if you really want to add it." >&2
 		fi
 		git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" ${reference:+"$reference"} ${depth:+"$depth"} || exit
 		(
-			clear_local_git_env
+			sanitize_submodule_env
 			cd "$sm_path" &&
 			# ash fails to wordsplit ${branch:+-b "$branch"...}
 			case "$branch" in
@@ -418,7 +428,7 @@ cmd_foreach()
 			name=$(git submodule--helper name "$sm_path")
 			(
 				prefix="$prefix$sm_path/"
-				clear_local_git_env
+				sanitize_submodule_env
 				cd "$sm_path" &&
 				sm_path=$(relative_path "$sm_path") &&
 				# we make $path available to scripts ...
@@ -713,7 +723,7 @@ Maybe you want to use 'update --init'?")"
 			cloned_modules="$cloned_modules;$name"
 			subsha1=
 		else
-			subsha1=$(clear_local_git_env; cd "$sm_path" &&
+			subsha1=$(sanitize_submodule_env; cd "$sm_path" &&
 				git rev-parse --verify HEAD) ||
 			die "$(eval_gettext "Unable to find current revision in submodule path '\$displaypath'")"
 		fi
@@ -723,11 +733,11 @@ Maybe you want to use 'update --init'?")"
 			if test -z "$nofetch"
 			then
 				# Fetch remote before determining tracking $sha1
-				(clear_local_git_env; cd "$sm_path" && git-fetch) ||
+				(sanitize_submodule_env; cd "$sm_path" && git-fetch) ||
 				die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
 			fi
-			remote_name=$(clear_local_git_env; cd "$sm_path" && get_default_remote)
-			sha1=$(clear_local_git_env; cd "$sm_path" &&
+			remote_name=$(sanitize_submodule_env; cd "$sm_path" && get_default_remote)
+			sha1=$(sanitize_submodule_env; cd "$sm_path" &&
 				git rev-parse --verify "${remote_name}/${branch}") ||
 			die "$(eval_gettext "Unable to find current ${remote_name}/${branch} revision in submodule path '\$sm_path'")"
 		fi
@@ -745,7 +755,7 @@ Maybe you want to use 'update --init'?")"
 			then
 				# Run fetch only if $sha1 isn't present or it
 				# is not reachable from a ref.
-				(clear_local_git_env; cd "$sm_path" &&
+				(sanitize_submodule_env; cd "$sm_path" &&
 					( (rev=$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
 					 test -z "$rev") || git-fetch)) ||
 				die "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"
@@ -787,7 +797,7 @@ Maybe you want to use 'update --init'?")"
 				die "$(eval_gettext "Invalid update mode '$update_module' for submodule '$name'")"
 			esac
 
-			if (clear_local_git_env; cd "$sm_path" && $command "$sha1")
+			if (sanitize_submodule_env; cd "$sm_path" && $command "$sha1")
 			then
 				say "$say_msg"
 			elif test -n "$must_die_on_failure"
@@ -803,7 +813,7 @@ Maybe you want to use 'update --init'?")"
 		then
 			(
 				prefix="$prefix$sm_path/"
-				clear_local_git_env
+				sanitize_submodule_env
 				cd "$sm_path" &&
 				eval cmd_update
 			)
@@ -841,7 +851,7 @@ Maybe you want to use 'update --init'?")"
 
 set_name_rev () {
 	revname=$( (
-		clear_local_git_env
+		sanitize_submodule_env
 		cd "$1" && {
 			git describe "$2" 2>/dev/null ||
 			git describe --tags "$2" 2>/dev/null ||
@@ -1125,7 +1135,7 @@ cmd_status()
 		else
 			if test -z "$cached"
 			then
-				sha1=$(clear_local_git_env; cd "$sm_path" && git rev-parse --verify HEAD)
+				sha1=$(sanitize_submodule_env; cd "$sm_path" && git rev-parse --verify HEAD)
 			fi
 			set_name_rev "$sm_path" "$sha1"
 			say "+$sha1 $displaypath$revname"
@@ -1135,7 +1145,7 @@ cmd_status()
 		then
 			(
 				prefix="$displaypath/"
-				clear_local_git_env
+				sanitize_submodule_env
 				cd "$sm_path" &&
 				eval cmd_status
 			) ||
@@ -1209,7 +1219,7 @@ cmd_sync()
 			if test -e "$sm_path"/.git
 			then
 			(
-				clear_local_git_env
+				sanitize_submodule_env
 				cd "$sm_path"
 				remote=$(get_default_remote)
 				git config remote."$remote".url "$sub_origin_url"
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 64146352ae20..48e2ab62da7a 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -91,6 +91,23 @@ test_expect_success 'configured username does not override URL' '
 	expect_askpass pass user@host
 '
 
+test_expect_success 'cmdline credential config passes into submodules' '
+	git init super &&
+	set_askpass user@host pass@host &&
+	(
+		cd super &&
+		git submodule add "$HTTPD_URL/auth/dumb/repo.git" sub &&
+		git commit -m "add submodule"
+	) &&
+	set_askpass wrong pass@host &&
+	test_must_fail git clone --recursive super super-clone &&
+	rm -rf super-clone &&
+	set_askpass wrong pass@host &&
+	git -c "credential.$HTTP_URL.username=user@host" \
+		clone --recursive super super-clone &&
+	expect_askpass pass user@host
+'
+
 test_expect_success 'fetch changes via http' '
 	echo content >>file &&
 	git commit -a -m two &&
diff --git a/t/t7412-submodule--helper.sh b/t/t7412-submodule--helper.sh
new file mode 100755
index 000000000000..149d42864f29
--- /dev/null
+++ b/t/t7412-submodule--helper.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+#
+# Copyright (c) 2016 Jacob Keller
+#
+
+test_description='Basic plumbing support of submodule--helper
+
+This test verifies the submodule--helper plumbing command used to implement
+git-submodule.
+'
+
+. ./test-lib.sh
+
+test_expect_success 'sanitize-config clears configuration' '
+	git -c user.name="Some User" submodule--helper sanitize-config >actual &&
+	test_must_be_empty actual
+'
+
+sq="'"
+test_expect_success 'sanitize-config keeps credential.helper' '
+	git -c credential.helper=helper submodule--helper sanitize-config >actual &&
+	echo "${sq}credential.helper=helper${sq}" >expect &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.7.1.429.g45cd78e
