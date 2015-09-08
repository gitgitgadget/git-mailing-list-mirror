From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv6 2/3] submodule: Reimplement `module_name` shell function in C
Date: Tue,  8 Sep 2015 11:57:44 -0700
Message-ID: <1441738665-29493-3-git-send-email-sbeller@google.com>
References: <1441738665-29493-1-git-send-email-sbeller@google.com>
Cc: sunshine@sunshineco.com, git@vger.kernel.org, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de, peff@peff.net,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Sep 08 20:58:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZO5k-0003jM-Uy
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 20:58:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbbIHS56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2015 14:57:58 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34532 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbbIHS5x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2015 14:57:53 -0400
Received: by padhy16 with SMTP id hy16so129294745pad.1
        for <git@vger.kernel.org>; Tue, 08 Sep 2015 11:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=27zQCFVh2D1je62IPG6s38gj+mxs5O0VtyqsNwgJxfk=;
        b=G7T9PAJ7YArb3SUGCfCMPGO/rr60RW574tBkeTvwhZrHcgcymCMDjGk4sZLpm6D8wj
         cRJHvowqccxDCM7gGUOZw9OKPac49EvJ/GpDBPz2NFWOiPpof+mrvTLTpPqZtMmv0r2g
         Bqc0oLTC3tYQEnptik3ggN19Glzs5/LEWhjQbSv8uZJXleDhaRisxgOTqsI48HBNknD9
         9IIrjDAtkMIOgBebVselFxBUtqQycmWRkH3I2U21N5CyHlPGrumg4Hpo5eSFOkU6khhf
         9jbzC90I2soANEJl2kgjCjoQX4WBN69pBYb+DxAEFsO110eSXwW7hA2YINuUGOvCA2ci
         7omw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=27zQCFVh2D1je62IPG6s38gj+mxs5O0VtyqsNwgJxfk=;
        b=g7ar1eFu6+sD3DXz5DwwRtmDesR+G788+TX4eg9Eu+3LgpDAfBj0clfCSaWcGaaOtV
         UU/aFfZjqNhPeEui6YGf2TRHYeyYqvr87eeRA2u70RO03rdsAXxa7ypAVLIRWr4oDIOH
         qxJje+7wSsGG7dPGXKWCEqvo7cVbGeU05Q0q4mj6BKenINTQAkBB5p81ghDWZUHY/o/Q
         I0cLglMSL6gxWUXKcGdn0cHqkr8d4lnnZaroRlpaqEUbHoN9zmcfdmY4ts2k0WgfaIgk
         OvoDlbLZhrKR+/DRISFs0aQS/UJZOj1bQhtQ85izqXPyJuWdbAaA9a5ReadTeyMusHlA
         Y7cA==
X-Gm-Message-State: ALoCoQkdZkRXMFJqfawbI9h+diW5ttG49wImkPtaO+H7Ukxx9ENdxH2GclsgamnFhE7f/V7c+xZd
X-Received: by 10.68.68.233 with SMTP id z9mr4818203pbt.132.1441738673333;
        Tue, 08 Sep 2015 11:57:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:b8c0:c175:ec61:d891])
        by smtp.gmail.com with ESMTPSA id dh1sm4267326pbd.49.2015.09.08.11.57.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 08 Sep 2015 11:57:52 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.256.g89f8063.dirty
In-Reply-To: <1441738665-29493-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277520>

This implements the helper `name` in C instead of shell,
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
index 10db4e6..bc79c41 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -5,6 +5,9 @@
 #include "pathspec.h"
 #include "dir.h"
 #include "utf8.h"
+#include "submodule.h"
+#include "submodule-config.h"
+#include "string-list.h"
 
 struct module_list {
 	const struct cache_entry **entries;
@@ -102,6 +105,24 @@ static int module_list(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static int module_name(int argc, const char **argv, const char *prefix)
+{
+	const struct submodule *sub;
+
+	if (argc != 2)
+		usage(_("git submodule--helper name <path>"));
+
+	gitmodules_config();
+	sub = submodule_from_path(null_sha1, argv[1]);
+
+	if (!sub)
+		die(_("no submodule mapping found in .gitmodules for path '%s'"),
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
