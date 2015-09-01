From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 2/3] submodule: implement `name` as a builtin helper
Date: Tue,  1 Sep 2015 11:24:28 -0700
Message-ID: <1441131869-29474-3-git-send-email-sbeller@google.com>
References: <1441131869-29474-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de, peff@peff.net
To: sbeller@google.com, gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Tue Sep 01 20:24:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWqEs-0005wb-Hw
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 20:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024AbbIASYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 14:24:54 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34557 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752961AbbIASYq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 14:24:46 -0400
Received: by padhy1 with SMTP id hy1so3702698pad.1
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 11:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jkseqT6fndQvhbF69wZ+dS6qD5yN8uKzdNl8J1uMbrc=;
        b=Euv9WEgDsqyXWU9G53dSQWgtDQZVniXvVt8IJtTjkSnZ/9MtWjVIcRkg9Zq5ynPI2r
         cgIHpe+WwZpC8sM1nGMdVUtF7ufYVVDyjome8OIaGUBskduDLpAmjGL63PcvDel4j8sY
         4PeW9rKMciRnsc671n6gGW3Wg2fGhv5ZVT2qsNyxKuuZbZj/oINWJHYxSkLlF30wGtxt
         kjd+PmJlay7X+dBPd+C8U5S7ga+k1MWHMM/lP7TWReLMelF28/jYltbXID0Ptze5B0q0
         LEWIxEd+9nwX+1zFrUs5aYm4vwxdEuEWsOAz9awvL8ChuPQNAyAjoAG0RJYquyPAZ9d3
         9bug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jkseqT6fndQvhbF69wZ+dS6qD5yN8uKzdNl8J1uMbrc=;
        b=eNo8ogeM1nxcC8uXLNFQ8jBLjp9dCwBkxkLUeTk7mq2rol+BZOY+wwX9bvW/jyiOBN
         0pFc5BAKY/0BR3onh963OILgXzKbScv6iGfcf0ZD0YqAgtdtVaVrHKtQV+yv8BMYUZXM
         fFfuYuW+BLQyqNAUWjY6FoC41DPDOHqGrecGKyA8woUTb6ZyR8zHLEnKVAxUlnbxPTpf
         h8RpSrYRdb4CX3R+/yLfI4vjD3PLuLgTKmp1M3Z3S0sdZAqcDH1UczEvinqsvvlXAfVc
         HaUKCk5GjyQFCdeC9+Ee9OOWWBlJehjDYa7MbuSLuJ0XQmxlmx2lchrYs9d9a2GBBr55
         XGCw==
X-Gm-Message-State: ALoCoQlaaYS5ajUcVEUl5/f0g6NtFvRP0dFu6v2u8FLbB07c6QLB1PpwMnLhgPGkw1/mWZH6LKIb
X-Received: by 10.68.226.73 with SMTP id rq9mr32592478pbc.60.1441131885905;
        Tue, 01 Sep 2015 11:24:45 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:3828:a7a8:276e:e72a])
        by smtp.gmail.com with ESMTPSA id tz1sm18891851pbc.50.2015.09.01.11.24.45
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 01 Sep 2015 11:24:45 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.256.g89f8063.dirty
In-Reply-To: <1441131869-29474-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277009>

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
 builtin/submodule--helper.c | 22 ++++++++++++++++++++++
 git-submodule.sh            | 32 +++++++-------------------------
 2 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 16d9abe..f5e408a 100644
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
@@ -102,6 +105,24 @@ static int module_list(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static int module_name(int argc, const char **argv, const char *prefix)
+{
+	const struct submodule *sub;
+
+	if (argc != 2)
+		usage("git submodule--helper module_name <path>\n");
+
+	gitmodules_config();
+	sub = submodule_from_path(null_sha1, argv[1]);
+
+	if (!sub)
+		die(N_("No submodule mapping found in .gitmodules for path '%s'"),
+		    argv[1]);
+
+	printf("%s\n", sub->name);
+
+	return 0;
+}
 
 struct cmd_struct {
 	const char *cmd;
@@ -110,6 +131,7 @@ struct cmd_struct {
 
 static struct cmd_struct commands[] = {
 	{"list", module_list},
+	{"name", module_name},
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/git-submodule.sh b/git-submodule.sh
index 95c04fc..2be8da2 100755
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
+			name=$(git submodule--helper name "$sm_path")
 			(
 				prefix="$prefix$sm_path/"
 				clear_local_git_env
@@ -554,7 +536,7 @@ cmd_init()
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
-		name=$(module_name "$sm_path") || exit
+		name=$(git submodule--helper name "$sm_path") || exit
 
 		displaypath=$(relative_path "$sm_path")
 
@@ -636,7 +618,7 @@ cmd_deinit()
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
-		name=$(module_name "$sm_path") || exit
+		name=$(git submodule--helper name "$sm_path") || exit
 
 		displaypath=$(relative_path "$sm_path")
 
@@ -758,7 +740,7 @@ cmd_update()
 			echo >&2 "Skipping unmerged submodule $prefix$sm_path"
 			continue
 		fi
-		name=$(module_name "$sm_path") || exit
+		name=$(git submodule--helper name "$sm_path") || exit
 		url=$(git config submodule."$name".url)
 		branch=$(get_submodule_config "$name" branch master)
 		if ! test -z "$update"
@@ -1022,7 +1004,7 @@ cmd_summary() {
 			# Respect the ignore setting for --for-status.
 			if test -n "$for_status"
 			then
-				name=$(module_name "$sm_path")
+				name=$(git submodule--helper name "$sm_path")
 				ignore_config=$(get_submodule_config "$name" ignore none)
 				test $status != A && test $ignore_config = all && continue
 			fi
@@ -1184,7 +1166,7 @@ cmd_status()
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
-		name=$(module_name "$sm_path") || exit
+		name=$(git submodule--helper name "$sm_path") || exit
 		url=$(git config submodule."$name".url)
 		displaypath=$(relative_path "$prefix$sm_path")
 		if test "$stage" = U
@@ -1261,7 +1243,7 @@ cmd_sync()
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
-		name=$(module_name "$sm_path")
+		name=$(git submodule--helper name "$sm_path")
 		url=$(git config -f .gitmodules --get submodule."$name".url)
 
 		# Possibly a url relative to parent
-- 
2.5.0.256.g89f8063.dirty
