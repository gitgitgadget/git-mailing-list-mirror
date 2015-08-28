From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/9] submodule: implement `module_name` as a builtin helper
Date: Thu, 27 Aug 2015 18:14:48 -0700
Message-ID: <1440724495-708-3-git-send-email-sbeller@google.com>
References: <1440724495-708-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, jrnieder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 28 03:16:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZV8Gq-0001AW-Ef
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 03:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbbH1BPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 21:15:41 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33308 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbbH1BPD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2015 21:15:03 -0400
Received: by padfo6 with SMTP id fo6so4638916pad.0
        for <git@vger.kernel.org>; Thu, 27 Aug 2015 18:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jivMWXfvwKEVa5mAFi417znV262JA7LQEb5co+sGN3I=;
        b=AfwWnYDQLJELk4zLm3s2y2Vq9l48yCOCaAR2Pbcr6puAB5YAVGpQeSP+GP5wbTObnU
         MKdWyrmf9cI3nxhKnBwzJhreHeS1Nnmav9qATbAzk/qea9KBarYGZ2ujL9RQ+0n9i+Fs
         CqJb9eHAeajFN2qMJ6fl66Xk9fPuNYint/ATKPLz6rgb2IJyOGhkuAGNp0is9sXTPAHz
         aAgwNeE00BS8eobRxxsSorVRdziJhvfE9KcEi1j3Tc4Q8yh+aZNeGk7AG4VJUJZ7SFBR
         dOXKCjyb9Jqe7VP6nortcKfhDPCoJfoMyD+QvMs67lh+sUI59gov3YMOi9GiihnGczst
         FBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jivMWXfvwKEVa5mAFi417znV262JA7LQEb5co+sGN3I=;
        b=VX0LbghqoVgoIzu7vlb37IpHtBeY9oWuUxXdf0OZwtKsJ4dqhafpKJdoYFaWV55Izo
         csp+T6Z5X+vC3JUL5maqwuX7kIrUQ4Cv/tGJHmyjmrpnmT/PyPWQmSwYm/PZyrCoPiFf
         JITBmVglEMZchMGF9SM4P9VEBitOqf+InEr1ugC2jYECdopTHmx/tHpDdfmWkHHsN7DU
         I27wGowoM9tGzAQH0/V25rwJ+C87vilBhELdiDlG3fgDT9BbZK4XCOGp5bnsAcUIAvKg
         RcBFvSRpu0b9k7mv/Y7FErdDYtaF9K+ozQPyXkxbQ9xw2okytjtDnmtlZsw+JaUkAwHP
         vwvg==
X-Gm-Message-State: ALoCoQmtc8gc9+6O/s7q8xoMIKsObK35Xyrj2slkn/25fak3kFEg9G4j6qqozex39gkqs1qUbC/N
X-Received: by 10.66.158.3 with SMTP id wq3mr11497629pab.38.1440724501890;
        Thu, 27 Aug 2015 18:15:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:bce4:8b21:c71b:de7e])
        by smtp.gmail.com with ESMTPSA id nm8sm3739074pbc.20.2015.08.27.18.15.01
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Thu, 27 Aug 2015 18:15:01 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.g5e52b0d
In-Reply-To: <1440724495-708-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276700>

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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 28 +++++++++++++++++++++++++++-
 git-submodule.sh            | 32 +++++++-------------------------
 2 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index beaab7d..c8f7e0c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -5,6 +5,9 @@
 #include "pathspec.h"
 #include "dir.h"
 #include "utf8.h"
+#include "submodule.h"
+#include "submodule-config.h"
+#include "string-list.h"
 
 static const struct cache_entry **ce_entries;
 static int ce_alloc, ce_used;
@@ -101,6 +104,26 @@ static int module_list(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static int module_name(int argc, const char **argv, const char *prefix)
+{
+	const char *name;
+	const struct submodule *sub;
+
+	if (argc != 1)
+		usage("git submodule--helper module_name <path>\n");
+
+	gitmodules_config();
+	sub = submodule_from_path(null_sha1, argv[0]);
+
+	if (!sub)
+		die("No submodule mapping found in .gitmodules for path '%s'", argv[0]);
+
+	name = sub->name;
+	printf("%s\n", name);
+
+	return 0;
+}
+
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 {
 	if (argc < 2)
@@ -109,6 +132,9 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 	if (!strcmp(argv[1], "module_list"))
 		return module_list(argc - 1, argv + 1, prefix);
 
+	if (!strcmp(argv[1], "module_name"))
+		return module_name(argc - 2, argv + 2, prefix);
+
 usage:
-	usage("git submodule--helper module_list\n");
+	usage("git submodule--helper [module_list | module_name]\n");
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
-- 
2.5.0.264.g5e52b0d
