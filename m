From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH] git: submodule honor -c credential.* from command line
Date: Wed, 24 Feb 2016 12:09:19 -0800
Message-ID: <1456344559-2822-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 21:09:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYfkq-0005TJ-Jk
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 21:09:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678AbcBXUJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 15:09:44 -0500
Received: from mga03.intel.com ([134.134.136.65]:6161 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751750AbcBXUJn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 15:09:43 -0500
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP; 24 Feb 2016 12:09:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,494,1449561600"; 
   d="scan'208";a="54152176"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.65])
  by fmsmga004.fm.intel.com with ESMTP; 24 Feb 2016 12:09:20 -0800
X-Mailer: git-send-email 2.7.1.429.g45cd78e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287221>

From: Jacob Keller <jacob.keller@gmail.com>

Due to the way that the git-submodule code works, it clears all local
git environment variables before entering submodules. This is normally
a good thing since we want to clear settings such as GIT_WORKTREE and
other variables which would affect the operation of submodule commands.
However, GIT_CONFIG_PARAMETERS is special, and we actually do want to
preserve these settings. However, we do not want to preserve all
configuration as many things should be left specific to the parent
project.

Add a git submodule--helper function which can be used to sanitize the
GIT_CONFIG_PARAMETERS value to only allow certain settings. For now,
restrict this to only credential.* settings.

Replace all the calls to clear_local_git_env with a wrapped function
that filters GIT_CONFIG_PARAMETERS using the new helper and then
restores it to the filtered subset after clearing the rest of the
environment.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
I added a test file for the submodule--helper but I am really not
certain how to perform a proper credential.helper test for submodules,
so I gave up on that for now. Help or suggestions wanted in this part
of the patch. Also suggestions on if we want other config variables
besides credential.* to be accepted would be good. I couldn't think of
any others. We could also blacklist but I agree with Junio that
a whitelist is safer.

 builtin/submodule--helper.c  | 51 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh             | 36 ++++++++++++++++++++-----------
 t/t7412-submodule--helper.sh | 25 ++++++++++++++++++++++
 3 files changed, 99 insertions(+), 13 deletions(-)
 create mode 100755 t/t7412-submodule--helper.sh

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f4c3eff179b5..8194d3b3d1d5 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -255,6 +255,56 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+int submodule_config_ok(const char *var)
+{
+	if (starts_with(var, "credential."))
+		return 1;
+	return 0;
+}
+
+int sanitize_submodule_config(const char *var, const char *value, void *data)
+{
+	struct strbuf quoted = STRBUF_INIT;
+	struct strbuf *out = data;
+
+	if (submodule_config_ok(var)) {
+		if (out->len)
+			strbuf_addch(out, ' ');
+
+		/* combined all the values before we quote them */
+		strbuf_addstr(&quoted, var);
+		strbuf_addch(&quoted, '=');
+		strbuf_addstr(&quoted, value);
+
+		/* safely quote them for shell use */
+		sq_quote_buf(out, quoted.buf);
+	}
+	return 0;
+}
+
+static int module_sanitize_config(int argc, const char **argv, const char *prefix)
+{
+	struct strbuf sanitized_config = STRBUF_INIT;
+
+	struct option module_sanitize_config_options[] = {
+		OPT_END()
+	};
+
+	const char *const git_submodule_helper_usage[] = {
+		N_("git submodule--helper sanitize-config"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, module_sanitize_config_options,
+			     git_submodule_helper_usage, 0);
+
+	git_config_from_parameters(sanitize_submodule_config, &sanitized_config);
+	if (sanitized_config.len)
+		printf("%s\n", sanitized_config.buf);
+
+	return 0;
+}
+
 struct cmd_struct {
 	const char *cmd;
 	int (*fn)(int, const char **, const char *);
@@ -264,6 +314,7 @@ static struct cmd_struct commands[] = {
 	{"list", module_list},
 	{"name", module_name},
 	{"clone", module_clone},
+	{"sanitize-config", module_sanitize_config},
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/git-submodule.sh b/git-submodule.sh
index 9bc5c5f94d1d..dd469ecb2065 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -192,6 +192,16 @@ isnumber()
 	n=$(($1 + 0)) 2>/dev/null && test "$n" = "$1"
 }
 
+# Sanitize the local git environment for use within a submodule. We
+# can't simply use clear_local_git_env since we want to preserve some
+# of the settings from GIT_CONFIG_PARAMETERS.
+sanitize_local_git_env()
+{
+	local sanitized_config = $(git submodule--helper sanitize-config)
+	clear_local_git_env
+	GIT_CONFIG_PARAMETERS=$sanitized_config
+}
+
 #
 # Add a new submodule to the working tree, .gitmodules and the index
 #
@@ -349,7 +359,7 @@ Use -f if you really want to add it." >&2
 		fi
 		git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" "$reference" "$depth" || exit
 		(
-			clear_local_git_env
+			sanitize_local_git_env
 			cd "$sm_path" &&
 			# ash fails to wordsplit ${branch:+-b "$branch"...}
 			case "$branch" in
@@ -418,7 +428,7 @@ cmd_foreach()
 			name=$(git submodule--helper name "$sm_path")
 			(
 				prefix="$prefix$sm_path/"
-				clear_local_git_env
+				sanitize_local_git_env
 				cd "$sm_path" &&
 				sm_path=$(relative_path "$sm_path") &&
 				# we make $path available to scripts ...
@@ -713,7 +723,7 @@ Maybe you want to use 'update --init'?")"
 			cloned_modules="$cloned_modules;$name"
 			subsha1=
 		else
-			subsha1=$(clear_local_git_env; cd "$sm_path" &&
+			subsha1=$(sanitize_local_git_env; cd "$sm_path" &&
 				git rev-parse --verify HEAD) ||
 			die "$(eval_gettext "Unable to find current revision in submodule path '\$displaypath'")"
 		fi
@@ -723,11 +733,11 @@ Maybe you want to use 'update --init'?")"
 			if test -z "$nofetch"
 			then
 				# Fetch remote before determining tracking $sha1
-				(clear_local_git_env; cd "$sm_path" && git-fetch) ||
+				(sanitize_local_git_env; cd "$sm_path" && git-fetch) ||
 				die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
 			fi
-			remote_name=$(clear_local_git_env; cd "$sm_path" && get_default_remote)
-			sha1=$(clear_local_git_env; cd "$sm_path" &&
+			remote_name=$(sanitize_local_git_env; cd "$sm_path" && get_default_remote)
+			sha1=$(sanitize_local_git_env; cd "$sm_path" &&
 				git rev-parse --verify "${remote_name}/${branch}") ||
 			die "$(eval_gettext "Unable to find current ${remote_name}/${branch} revision in submodule path '\$sm_path'")"
 		fi
@@ -745,7 +755,7 @@ Maybe you want to use 'update --init'?")"
 			then
 				# Run fetch only if $sha1 isn't present or it
 				# is not reachable from a ref.
-				(clear_local_git_env; cd "$sm_path" &&
+				(sanitize_local_git_env; cd "$sm_path" &&
 					( (rev=$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
 					 test -z "$rev") || git-fetch)) ||
 				die "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"
@@ -787,7 +797,7 @@ Maybe you want to use 'update --init'?")"
 				die "$(eval_gettext "Invalid update mode '$update_module' for submodule '$name'")"
 			esac
 
-			if (clear_local_git_env; cd "$sm_path" && $command "$sha1")
+			if (sanitize_local_git_env; cd "$sm_path" && $command "$sha1")
 			then
 				say "$say_msg"
 			elif test -n "$must_die_on_failure"
@@ -803,7 +813,7 @@ Maybe you want to use 'update --init'?")"
 		then
 			(
 				prefix="$prefix$sm_path/"
-				clear_local_git_env
+				sanitize_local_git_env
 				cd "$sm_path" &&
 				eval cmd_update
 			)
@@ -841,7 +851,7 @@ Maybe you want to use 'update --init'?")"
 
 set_name_rev () {
 	revname=$( (
-		clear_local_git_env
+		sanitize_local_git_env
 		cd "$1" && {
 			git describe "$2" 2>/dev/null ||
 			git describe --tags "$2" 2>/dev/null ||
@@ -1125,7 +1135,7 @@ cmd_status()
 		else
 			if test -z "$cached"
 			then
-				sha1=$(clear_local_git_env; cd "$sm_path" && git rev-parse --verify HEAD)
+				sha1=$(sanitize_local_git_env; cd "$sm_path" && git rev-parse --verify HEAD)
 			fi
 			set_name_rev "$sm_path" "$sha1"
 			say "+$sha1 $displaypath$revname"
@@ -1135,7 +1145,7 @@ cmd_status()
 		then
 			(
 				prefix="$displaypath/"
-				clear_local_git_env
+				sanitize_local_git_env
 				cd "$sm_path" &&
 				eval cmd_status
 			) ||
@@ -1209,7 +1219,7 @@ cmd_sync()
 			if test -e "$sm_path"/.git
 			then
 			(
-				clear_local_git_env
+				sanitize_local_git_env
 				cd "$sm_path"
 				remote=$(get_default_remote)
 				git config remote."$remote".url "$sub_origin_url"
diff --git a/t/t7412-submodule--helper.sh b/t/t7412-submodule--helper.sh
new file mode 100755
index 000000000000..376f58afe967
--- /dev/null
+++ b/t/t7412-submodule--helper.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+#
+# Copyright (c) 2016 Jacob Keller
+#
+
+test_description='Basic plumbing support of submodule--helper
+
+This test tries to verify the submodule--helper plumbing command used
+to implement git-submodule.
+'
+
+. ./test-lib.sh
+
+test_expect_success 'sanitize-config clears configuration' '
+	git -c user.name="Some User" submodule--helper sanitize-config >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'sanitize-config keeps credential.helper' '
+	git -c credential.helper="helper" submodule--helper sanitize-config >actual &&
+	echo "'\''credential.helper=helper'\''" >expect &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.7.1.429.g45cd78e
