From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 2/3] submodule: implement `module-name` as a builtin helper
Date: Mon, 31 Aug 2015 17:40:28 -0700
Message-ID: <1441068029-19158-3-git-send-email-sbeller@google.com>
References: <xmqq1tejuscs.fsf@gitster.mtv.corp.google.com>
 <1441068029-19158-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>, sunshine@sunshineco.com,
	git@vger.kernel.org, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Sep 01 02:40:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWZd4-0001IO-JH
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 02:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753910AbbIAAkp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 20:40:45 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34911 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753633AbbIAAkn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 20:40:43 -0400
Received: by pacdd16 with SMTP id dd16so155796522pac.2
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 17:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o0WwXP0qpaf7mYcYoBxSjJsWxgU3m0ZZ1J71OwNFfUc=;
        b=bTJE4qyh4NFHEB6NwNypPFk8ezztAS4ljBwAXvUhGRFrns5/cTMIbkgEwoCc+tZAQf
         tSCY6TNTGlkbsqWqsu1Ql4NThoe8gzy2jKZVqysop91D8JmVdtBffrccMmIF+KUUxYZD
         az58NiIT0RPdrsHZ4m8j8+jqPrLccEAGI9e4x0iq2JDt3ZEAdSy0VI2lJAwrbFiseODe
         jakvHNspFU6yNwF2ybjovaP95zFlNs4RH5bc9eYY4KZZyx8kTAzVFmEqDVn48V123TCo
         VRdfPNMYANsaQzAoElJ9cf5yD3TZPYXfnOgVL6LVIH+F+NNADR96OPMy5nUiJtAiRZpm
         YHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o0WwXP0qpaf7mYcYoBxSjJsWxgU3m0ZZ1J71OwNFfUc=;
        b=a/iPfqdcrbH16kzA4L08xWe33eM+4ClZgAqx6qEKx+iW3bksfo87EfWpMVdLP7KaPw
         2SRN1unCbQNL7JfYdTyov8pQmygNA/d+p1lw7hV7w2MFTTPVMO2A2hXE942OVfguRBpx
         7B6DVlSKnCcpHuCaByuypShGrBej44MboaNBiGVn/QMj+M+Cvy43+bDPfea/eQKsq5KT
         vsqgbT/hQwMpPCT8+Pfx3bLLyAASqA3YA57lseVZQSvbnS+JZb3HgL9aiuqltAZe2H68
         beAQDlhGUO3hn0NdPlLCO1wRvGfnDXjvH9m6HYkakieW/n6BCCsI9S5DjbzwDLOAQNSH
         zYFQ==
X-Gm-Message-State: ALoCoQmZM3pQdG9ejNSnLQPzY1flIZRtI0wdA5AqZbNDUf2FDLxxyeB09PgsngCcpNbDWY+OOtYo
X-Received: by 10.66.141.74 with SMTP id rm10mr41252437pab.56.1441068043030;
        Mon, 31 Aug 2015 17:40:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:3828:a7a8:276e:e72a])
        by smtp.gmail.com with ESMTPSA id fl6sm15999496pab.12.2015.08.31.17.40.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 31 Aug 2015 17:40:42 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.256.gb62b30d.dirty
In-Reply-To: <1441068029-19158-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276957>

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
 builtin/submodule--helper.c | 29 +++++++++++++++++++++++++++--
 git-submodule.sh            | 32 +++++++-------------------------
 2 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 44310f5..91bd420 100644
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
@@ -102,16 +105,38 @@ static int module_list(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static int module_name(int argc, const char **argv, const char *prefix)
+{
+	const struct submodule *sub;
+
+	if (argc != 1)
+		usage("git submodule--helper module_name <path>\n");
+
+	gitmodules_config();
+	sub = submodule_from_path(null_sha1, argv[0]);
+
+	if (!sub)
+		die(N_("No submodule mapping found in .gitmodules for path '%s'"),
+		    argv[0]);
+
+	printf("%s\n", sub->name);
+
+	return 0;
+}
+
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 {
 	if (argc < 2)
 		die(N_("fatal: submodule--helper subcommand must be called with "
-		       "a subcommand, which is module-list\n"));
+		       "a subcommand, which are module-list, module-name\n"));
 
 	if (!strcmp(argv[1], "module-list"))
 		return module_list(argc - 1, argv + 1, prefix);
 
+	if (!strcmp(argv[1], "module-name"))
+		return module_name(argc - 2, argv + 2, prefix);
+
 	die(N_("fatal: '%s' is not a valid submodule--helper subcommand, "
-	       "which is module-list\n"),
+	       "which are module-list, module-name\n"),
 	    argv[1]);
 }
diff --git a/git-submodule.sh b/git-submodule.sh
index d4d710c..5f3dfc5 100755
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
+			name=$(git submodule--helper module-name "$sm_path")
 			(
 				prefix="$prefix$sm_path/"
 				clear_local_git_env
@@ -554,7 +536,7 @@ cmd_init()
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
-		name=$(module_name "$sm_path") || exit
+		name=$(git submodule--helper module-name "$sm_path") || exit
 
 		displaypath=$(relative_path "$sm_path")
 
@@ -636,7 +618,7 @@ cmd_deinit()
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
-		name=$(module_name "$sm_path") || exit
+		name=$(git submodule--helper module-name "$sm_path") || exit
 
 		displaypath=$(relative_path "$sm_path")
 
@@ -758,7 +740,7 @@ cmd_update()
 			echo >&2 "Skipping unmerged submodule $prefix$sm_path"
 			continue
 		fi
-		name=$(module_name "$sm_path") || exit
+		name=$(git submodule--helper module-name "$sm_path") || exit
 		url=$(git config submodule."$name".url)
 		branch=$(get_submodule_config "$name" branch master)
 		if ! test -z "$update"
@@ -1022,7 +1004,7 @@ cmd_summary() {
 			# Respect the ignore setting for --for-status.
 			if test -n "$for_status"
 			then
-				name=$(module_name "$sm_path")
+				name=$(git submodule--helper module-name "$sm_path")
 				ignore_config=$(get_submodule_config "$name" ignore none)
 				test $status != A && test $ignore_config = all && continue
 			fi
@@ -1184,7 +1166,7 @@ cmd_status()
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
-		name=$(module_name "$sm_path") || exit
+		name=$(git submodule--helper module-name "$sm_path") || exit
 		url=$(git config submodule."$name".url)
 		displaypath=$(relative_path "$prefix$sm_path")
 		if test "$stage" = U
@@ -1261,7 +1243,7 @@ cmd_sync()
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
-		name=$(module_name "$sm_path")
+		name=$(git submodule--helper module-name "$sm_path")
 		url=$(git config -f .gitmodules --get submodule."$name".url)
 
 		# Possibly a url relative to parent
-- 
2.5.0.256.gb62b30d.dirty
