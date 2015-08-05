From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule: implement `module_name` as a builtin helper
Date: Wed,  5 Aug 2015 14:08:00 -0700
Message-ID: <1438808880-9080-1-git-send-email-sbeller@google.com>
References: <CAGZ79kY=jQSjJUxkznkwwupo527-nT05P_bKXy=GO=E4QjC8tQ@mail.gmail.com>
Cc: Jens.Lehmann@web.de, hvoigt@hvoigt.net, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 05 23:08:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZN5v1-0007mr-EN
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 23:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbbHEVIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 17:08:06 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:33987 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbbHEVIE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 17:08:04 -0400
Received: by pdber20 with SMTP id er20so23034863pdb.1
        for <git@vger.kernel.org>; Wed, 05 Aug 2015 14:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XBfeimT1RdF8HKAeUBiPadGw8uX9o7D6ujn6JC98WN8=;
        b=A2wZqL5ZsYSoU8gwsdcibAhmXxh/eEHu2qXshnTOSUdTN1I/hYvTX6EfuFy5Vyd/zq
         ntlXgBOuQEAGYQVKemcIqpNfj4ejKFZv2MbYQIX5JwmhlhzSrjc0aRKOO73hCNb4MYX6
         0pKwB6qIOlXpvM5JLXErYGi5Phb7b8wB28qdxdxw80pzjk8giDj96I79OjKEaaPSI9EJ
         3PlS1pkKw8oWNDXR30OwIDBrx7yLh/N246ti8Fz5TDj/YlOOmrV1F/rbwlx4FQFBBR7h
         X85s9k9CKJqJ9lAx6GM2DyKAPr7EU2hP7l8DQEebTS3RCEa33Yx8lTFsWmIWAVHc8ZXT
         whZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XBfeimT1RdF8HKAeUBiPadGw8uX9o7D6ujn6JC98WN8=;
        b=ZoC6La0aLwa6obiz9ni2Y8SZhDo7alKokrQGgmiul+OdD2NTYIwFQAwpoQGhiIAva3
         bdLjZ+QBEP3zpGGXKtaPhOANQuWF6ydNQWwRG+t2Bb2HdmQYNMN+f5cWbPGJLNF4S/iV
         VN1Y/G3kjeI/EnYa8fkL6Iipv/joQazbi3aDDti+Z3HSxPyK7lHiHMbE2jTiWQYccGqJ
         N68pOJIvggrt+aEwf/9xdQq0J0ZaXX8rHRAM4ixjEGs7EIY5ejMgJkhhwdIYWPj/xmW1
         6snwrCltTMGfvg3vhyTmEWIQmkAkSvoeUmvSpaPq+UZxsvR8qumLWMam6G4ECd+gBMJ2
         XLOw==
X-Gm-Message-State: ALoCoQl7WUbqHYUcaaYU+uJ4lNxqosmU8f+AlbVA/zUqRa18WuHBzf9VJ5a61scA72NgDvVmLYIo
X-Received: by 10.70.108.137 with SMTP id hk9mr23354854pdb.105.1438808883643;
        Wed, 05 Aug 2015 14:08:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:b814:6c4f:72b2:33ea])
        by smtp.gmail.com with ESMTPSA id qc9sm3957750pab.18.2015.08.05.14.08.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 05 Aug 2015 14:08:03 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.236.g32a3769
In-Reply-To: <CAGZ79kY=jQSjJUxkznkwwupo527-nT05P_bKXy=GO=E4QjC8tQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275397>

This implements the helper `module_name` in C instead of shell,
yielding a nice performance boost.

Before this patch, I measured a time (best out of three):

  $ time ./t7400-submodule-basic.sh  >/dev/null
    real	0m11.066s
    user	0m3.348s
    sys	0m8.534s

With this patch applied I measured (also best out of three)

  $ time ./t7400-submodule-basic.sh  >/dev/null
    real	0m10.063s
    user	0m3.044s
    sys	0m7.487s

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Is this what you had in mind, Jens?

Jonathan pointed me to https://github.com/jlehmann/git-submod-enhancements/wiki
Does it reflect reality (i.e. as time passes code changes)?

I also noticed that you have made quite some changes to submodules on different
branches which are not upstream. Soem changes look familiar (as in "I believe
this is upstream alreaday?" while others look new and exciting to me).
I could not quite get the order yet, though.

 builtin/submodule--helper.c | 23 +++++++++++++++++++++++
 git-submodule.sh            | 32 +++++++-------------------------
 submodule.c                 | 18 +++++++++++++-----
 submodule.h                 |  1 +
 4 files changed, 44 insertions(+), 30 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index cb18ddf..3713c4c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -5,6 +5,8 @@
 #include "pathspec.h"
 #include "dir.h"
 #include "utf8.h"
+#include "submodule.h"
+#include "string-list.h"
 
 static char *ps_matched;
 static const struct cache_entry **ce_entries;
@@ -98,6 +100,24 @@ static int module_list(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static int module_name(int argc, const char **argv, const char *prefix)
+{
+	const char *name;
+
+	if (argc != 1)
+		usage("git submodule--helper module_name <path>\n");
+
+	gitmodules_config();
+	name = submodule_name_for_path(argv[0]);
+
+	if (name)
+		printf("%s\n", name);
+	else
+		die("No submodule mapping found in .gitmodules for path '%s'", argv[0]);
+
+	return 0;
+}
+
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 {
 	if (argc < 2)
@@ -106,6 +126,9 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 	if (!strcmp(argv[1], "module_list"))
 		return module_list(argc - 1, argv + 1, prefix);
 
+	if (!strcmp(argv[1], "module_name"))
+		return module_name(argc - 2, argv + 2, prefix);
+
 usage:
 	usage("git submodule--helper module_list\n");
 }
diff --git a/git-submodule.sh b/git-submodule.sh
index af9ecef..e6ff38d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -178,24 +178,6 @@ get_submodule_config () {
 	printf '%s' "${value:-$default}"
 }
 
-
-#
-# Map submodule path to submodule name
-#
-# $1 = path
-#
-module_name()
-{
-	# Do we have "submodule.<something>.path = $1" defined in .gitmodules file?
-	sm_path="$1"
-	re=$(printf '%s\n' "$1" | sed -e 's/[].[^$\\*]/\\&/g')
-	name=$( git config -f .gitmodules --get-regexp '^submodule\..*\.path$' |
-		sed -n -e 's|^submodule\.\(.*\)\.path '"$re"'$|\1|p' )
-	test -z "$name" &&
-	die "$(eval_gettext "No submodule mapping found in .gitmodules for path '\$sm_path'")"
-	printf '%s\n' "$name"
-}
-
 #
 # Clone a submodule
 #
@@ -498,7 +480,7 @@ cmd_foreach()
 		then
 			displaypath=$(relative_path "$sm_path")
 			say "$(eval_gettext "Entering '\$prefix\$displaypath'")"
-			name=$(module_name "$sm_path")
+			name=$(git submodule--helper module_name "$sm_path")
 			(
 				prefix="$prefix$sm_path/"
 				clear_local_git_env
@@ -554,7 +536,7 @@ cmd_init()
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
-		name=$(module_name "$sm_path") || exit
+		name=$(git submodule--helper module_name "$sm_path") || exit
 
 		displaypath=$(relative_path "$sm_path")
 
@@ -636,7 +618,7 @@ cmd_deinit()
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
-		name=$(module_name "$sm_path") || exit
+		name=$(git submodule--helper module_name "$sm_path") || exit
 
 		displaypath=$(relative_path "$sm_path")
 
@@ -758,7 +740,7 @@ cmd_update()
 			echo >&2 "Skipping unmerged submodule $prefix$sm_path"
 			continue
 		fi
-		name=$(module_name "$sm_path") || exit
+		name=$(git submodule--helper module_name "$sm_path") || exit
 		url=$(git config submodule."$name".url)
 		branch=$(get_submodule_config "$name" branch master)
 		if ! test -z "$update"
@@ -1022,7 +1004,7 @@ cmd_summary() {
 			# Respect the ignore setting for --for-status.
 			if test -n "$for_status"
 			then
-				name=$(module_name "$sm_path")
+				name=$(git submodule--helper module_name "$sm_path")
 				ignore_config=$(get_submodule_config "$name" ignore none)
 				test $status != A && test $ignore_config = all && continue
 			fi
@@ -1184,7 +1166,7 @@ cmd_status()
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
-		name=$(module_name "$sm_path") || exit
+		name=$(git submodule--helper module_name "$sm_path") || exit
 		url=$(git config submodule."$name".url)
 		displaypath=$(relative_path "$prefix$sm_path")
 		if test "$stage" = U
@@ -1261,7 +1243,7 @@ cmd_sync()
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
-		name=$(module_name "$sm_path")
+		name=$(git submodule--helper module_name "$sm_path")
 		url=$(git config -f .gitmodules --get submodule."$name".url)
 
 		# Possibly a url relative to parent
diff --git a/submodule.c b/submodule.c
index 700bbf4..dd8dcb0 100644
--- a/submodule.c
+++ b/submodule.c
@@ -686,6 +686,16 @@ static void calculate_changed_submodule_paths(void)
 	initialized_fetch_ref_tips = 0;
 }
 
+const char* submodule_name_for_path(const char* path)
+{
+	struct string_list_item *item;
+	item = unsorted_string_list_lookup(&config_name_for_path, path);
+	if (item)
+		return item->util;
+	else
+		return NULL;
+}
+
 int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
 			       int quiet)
@@ -693,7 +703,7 @@ int fetch_populated_submodules(const struct argv_array *options,
 	int i, result = 0;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct argv_array argv = ARGV_ARRAY_INIT;
-	struct string_list_item *name_for_path;
+	const char *name_for_path;
 	const char *work_tree = get_git_work_tree();
 	if (!work_tree)
 		goto out;
@@ -723,10 +733,8 @@ int fetch_populated_submodules(const struct argv_array *options,
 		if (!S_ISGITLINK(ce->ce_mode))
 			continue;
 
-		name = ce->name;
-		name_for_path = unsorted_string_list_lookup(&config_name_for_path, ce->name);
-		if (name_for_path)
-			name = name_for_path->util;
+		name_for_path = submodule_name_for_path(ce->name);
+		name =  name_for_path ? name_for_path : ce->name;
 
 		default_argv = "yes";
 		if (command_line_option == RECURSE_SUBMODULES_DEFAULT) {
diff --git a/submodule.h b/submodule.h
index 7beec48..e3dd854 100644
--- a/submodule.h
+++ b/submodule.h
@@ -41,5 +41,6 @@ int find_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_nam
 		struct string_list *needs_pushing);
 int push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name);
 void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
+const char* submodule_name_for_path(const char* path);
 
 #endif
-- 
2.5.0.236.g32a3769
