From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule: implement `module_name` as a builtin helper
Date: Thu,  6 Aug 2015 14:38:43 -0700
Message-ID: <1438897123-16997-1-git-send-email-sbeller@google.com>
References: <55C3BA5C.3030404@web.de>
Cc: Stefan Beller <sbeller@google.com>, Jens.Lehmann@web.de,
	git@vger.kernel.org, hvoigt@hvoigt.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 06 23:39:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNSsN-0006Yr-Ii
	for gcvg-git-2@plane.gmane.org; Thu, 06 Aug 2015 23:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754294AbbHFViz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 17:38:55 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:34698 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861AbbHFViy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 17:38:54 -0400
Received: by pdber20 with SMTP id er20so36694717pdb.1
        for <git@vger.kernel.org>; Thu, 06 Aug 2015 14:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6vLR0kBEz/6IvnpIGNCU7viDVGpQQ/N9dyIbe7eQDJ4=;
        b=lfUYdD65Yil+hgb9lPmiAO1XRSJBX5Ddsbs78TILoKYvpS1QZwpdw23kqwoiGLHS+U
         k+WG6PtQ0tC5U9Ck81OXQ5S+DN0ena/9oB7nnS/SG6P3r994EQOR6tAEOXg9coEHEvSf
         Azw2km6ifvjJtkA2dVnozuYZDRAfduXmpJ2J56fgzKSUIDWGBGF7XCprcXBoanGCU3Y/
         P5mNLq4lD0z8Q9VEfw/np/0PB2CJVyD3lAyjNMBMM59E7wcSTVHTKKgNWQ9LWr5Csxr9
         UiCmhcHb7vWOWojnN1/wBiV2RC2GjHogMBCM+llEgGttxlcJIxw2mvCx73I2b6x4nD2d
         SxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6vLR0kBEz/6IvnpIGNCU7viDVGpQQ/N9dyIbe7eQDJ4=;
        b=lIrK6Yd6mcF/99zsJ7j4jVNn5rQuCsAfX87NZdrG6vRvm1kMkbeAtPF5E3Yb4eYF/K
         X7V9zWGtVuvmFZfoCjLTSX0iEX7o1/UkzzG9nPFa7/002j93N15603TYFKIGJ4QjXs+f
         tn3Iq3NkhJQBT9WFQn8nBBTIZBxrwpCHkb5QWdxIkxE8LehytGxHLkIBjP0eTBP/zhdf
         mWLdeFdAoFtPzHWVLiq+mBgPxmpYXWQjKj9X0HRnvm7yc97KiYpLKdDtbLC2DtS15vHh
         X9XivVXzx6o1EQXX3oJyvzUcIssd+pL7FqnLeLFaBJiWZ0zRv5liLIu9dSWdfsgRlVpa
         0TKg==
X-Gm-Message-State: ALoCoQm3eeazTkuuibNaSZ8C0FVhFEDWif4DyUvTQ1tBYmUM49dn9/kf3m8VDLFuV4lsO3EbLL5G
X-Received: by 10.70.43.15 with SMTP id s15mr7602061pdl.14.1438897133870;
        Thu, 06 Aug 2015 14:38:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:8060:d893:ee2c:36a5])
        by smtp.gmail.com with ESMTPSA id pd10sm7621238pdb.66.2015.08.06.14.38.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 06 Aug 2015 14:38:53 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.239.g9728e1d.dirty
In-Reply-To: <55C3BA5C.3030404@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275446>

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

Helped-by: Jens Lehmann <Jens.Lehmann@web.de>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

This incorporates the changes from Jens fixup! commit
(which addresses all issues he pointed out).

I agree this looks much cleaner. :)

This patch advances origin/sb/submodule-helper (d2c6c09ac8,
submodule: implement `module_list` as a builtin helper)

 builtin/submodule--helper.c | 22 ++++++++++++++++++++++
 git-submodule.sh            | 32 +++++++-------------------------
 submodule.c                 | 19 ++++++++++++++-----
 submodule.h                 |  1 +
 4 files changed, 44 insertions(+), 30 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index cb18ddf..bc37b74 100644
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
@@ -98,6 +100,23 @@ static int module_list(int argc, const char **argv, const char *prefix)
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
+	if (!name)
+		die("No submodule mapping found in .gitmodules for path '%s'", argv[0]);
+
+	printf("%s\n", name);
+	return 0;
+}
+
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 {
 	if (argc < 2)
@@ -106,6 +125,9 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
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
index 15e90d1..78d7616 100644
--- a/submodule.c
+++ b/submodule.c
@@ -686,6 +686,16 @@ static void calculate_changed_submodule_paths(void)
 	initialized_fetch_ref_tips = 0;
 }
 
+const char *submodule_name_for_path(const char *path)
+{
+	struct string_list_item *item;
+	item = unsorted_string_list_lookup(&config_name_for_path, path);
+	if (!item)
+		return NULL;
+
+	return item->util;
+}
+
 int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
 			       int quiet)
@@ -693,7 +703,6 @@ int fetch_populated_submodules(const struct argv_array *options,
 	int i, result = 0;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct argv_array argv = ARGV_ARRAY_INIT;
-	struct string_list_item *name_for_path;
 	const char *work_tree = get_git_work_tree();
 	if (!work_tree)
 		goto out;
@@ -723,10 +732,10 @@ int fetch_populated_submodules(const struct argv_array *options,
 		if (!S_ISGITLINK(ce->ce_mode))
 			continue;
 
-		name = ce->name;
-		name_for_path = unsorted_string_list_lookup(&config_name_for_path, ce->name);
-		if (name_for_path)
-			name = name_for_path->util;
+		name = submodule_name_for_path(ce->name);
+		if (!name)
+			/* Not in .gitmodules, try the default name == path */
+			name = ce->name;
 
 		default_argv = "yes";
 		if (command_line_option == RECURSE_SUBMODULES_DEFAULT) {
diff --git a/submodule.h b/submodule.h
index 7beec48..fc7f8a6 100644
--- a/submodule.h
+++ b/submodule.h
@@ -41,5 +41,6 @@ int find_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_nam
 		struct string_list *needs_pushing);
 int push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name);
 void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
+const char *submodule_name_for_path(const char *path);
 
 #endif
-- 
2.5.0.239.g9728e1d.dirty
