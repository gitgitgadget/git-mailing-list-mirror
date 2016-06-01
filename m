From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule: remove bashism from shell script
Date: Tue, 31 May 2016 17:27:59 -0700
Message-ID: <20160601002759.11592-1-sbeller@google.com>
References: <xmqq1t4h3jxo.fsf@gitster.mtv.corp.google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 01 02:28:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7u17-0007HJ-PQ
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 02:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788AbcFAA2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 20:28:07 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33506 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbcFAA2G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 20:28:06 -0400
Received: by mail-pf0-f182.google.com with SMTP id b124so2761699pfb.0
        for <git@vger.kernel.org>; Tue, 31 May 2016 17:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vZCc2YyLkmTHO8z87MWMIVa6Csq3ov1O3djWGkOtafc=;
        b=BBKvbIl6+VWL/p2Gdrku400jcpIprfVCLZQIAzYWz9qgqpAL7tgYa9w0VcdJ0DBmvS
         j3YHWR4LCjiucHSXGp2JiH/3wx7nv+HoQ0p4j0ldNewDT6RI/0+ZT59PkCfnlWlutPRF
         Ot8MNCrxFIiKg+dJA+n4CvtFOhL/4cxq0YhNOaj7DgmtUFTIgc8Dy00aMUjge4L3X3Hz
         lrIYmAYplp8pYpWYRanr/w9Do0r0lPE3tMVSxMQKYj8Mz55qT09gWyiOlusi5baX+3cp
         5L0EyatkgsFBnuarTOATOsZeLBJ6MDRAVGMR+AC1PCcQr00d1ToMlrQV0D8/hAw6lLs5
         oTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vZCc2YyLkmTHO8z87MWMIVa6Csq3ov1O3djWGkOtafc=;
        b=EMgd73YBkF+XRyvMejBf6hKPzNHMmOFFIEj5GZ0Wug2ZWHUcb5BU8DQmnOdN3rhu41
         c5LKD4bCBdkBmSKzVCjBwIJiTprTv4D/DkcQevg+4Y0gNruJ/YB+XZRosR/4dBsHMERl
         U1Oro3/xZqAaHegSA53ZAVA0kkG6QL0BlKxWQ+Oxdf+r7JXKSccPn/k/i/nk2GVMC6i0
         4HEydwh4hjom/36LGO90Ua+B9lJ2Yn5u5JXtoa9dYFiz0/ca5rBFeerBZgCifFrjx/2R
         rawnOI8mFxncMfmZL+DWBvmJEerYov1chEn6FLPLVK6ovfF4ENL7+loDN7g0dB+wyoBJ
         OlWQ==
X-Gm-Message-State: ALyK8tJkn37vQ7swLZo2iTUl2dLFuYTn5oI3PQzPrZGDIwod/CGiWaIrH+5alewTaICMO/Ak
X-Received: by 10.98.35.129 with SMTP id q1mr2041194pfj.48.1464740884370;
        Tue, 31 May 2016 17:28:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:9063:1a72:5a8e:8f65])
        by smtp.gmail.com with ESMTPSA id s131sm39134311pfs.45.2016.05.31.17.28.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 31 May 2016 17:28:03 -0700 (PDT)
X-Mailer: git-send-email 2.9.0.rc1.2.ge49d2c8.dirty
In-Reply-To: <xmqq1t4h3jxo.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296044>

Junio pointed out `relative_path` was using bashisms via the
local variables. As the longer term goal is to rewrite most of the
submodule code in C, do it now.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

* developed on top of origin/master + "[PATCH] submodule--helper: offer a
  consistent API" which I just sent.
* This fix looks amazingly simple (it even worked on the first try),
  so I temporarily did a s|printf("%s", relative_path(argv[1], argv[2], &sb));|printf("bogus");|
  to ensure we actually catch failures in the display path. And we do!
  
Thanks,
Stefan

 builtin/submodule--helper.c | 12 +++++++++++
 git-submodule.sh            | 51 +++++++--------------------------------------
 2 files changed, 20 insertions(+), 43 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f0b2c4f..926d205 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -831,6 +831,17 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static int resolve_relative_path(int argc, const char **argv, const char *prefix)
+{
+	struct strbuf sb = STRBUF_INIT;
+	if (argc != 3)
+		die("submodule--helper relative_path takes exactly 2 arguments, got %d", argc);
+
+	printf("%s", relative_path(argv[1], argv[2], &sb));
+	strbuf_release(&sb);
+	return 0;
+}
+
 struct cmd_struct {
 	const char *cmd;
 	int (*fn)(int, const char **, const char *);
@@ -841,6 +852,7 @@ static struct cmd_struct commands[] = {
 	{"name", module_name},
 	{"clone", module_clone},
 	{"update-clone", update_clone},
+	{"relative-path", resolve_relative_path},
 	{"resolve-relative-url", resolve_relative_url},
 	{"resolve-relative-url-test", resolve_relative_url_test},
 	{"init", module_init}
diff --git a/git-submodule.sh b/git-submodule.sh
index fadbe5d..7fe8a51 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -46,41 +46,6 @@ prefix=
 custom_name=
 depth=
 
-# Resolve a path to be relative to another path.  This is intended for
-# converting submodule paths when git-submodule is run in a subdirectory
-# and only handles paths where the directory separator is '/'.
-#
-# The output is the first argument as a path relative to the second argument,
-# which defaults to $wt_prefix if it is omitted.
-relative_path ()
-{
-	local target curdir result
-	target=$1
-	curdir=${2-$wt_prefix}
-	curdir=${curdir%/}
-	result=
-
-	while test -n "$curdir"
-	do
-		case "$target" in
-		"$curdir/"*)
-			target=${target#"$curdir"/}
-			break
-			;;
-		esac
-
-		result="${result}../"
-		if test "$curdir" = "${curdir%/*}"
-		then
-			curdir=
-		else
-			curdir="${curdir%/*}"
-		fi
-	done
-
-	echo "$result$target"
-}
-
 die_if_unmatched ()
 {
 	if test "$1" = "#unmatched"
@@ -354,14 +319,14 @@ cmd_foreach()
 		die_if_unmatched "$mode"
 		if test -e "$sm_path"/.git
 		then
-			displaypath=$(relative_path "$prefix$sm_path")
+			displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
 			say "$(eval_gettext "Entering '\$displaypath'")"
 			name=$(git submodule--helper name "$sm_path")
 			(
 				prefix="$prefix$sm_path/"
 				sanitize_submodule_env
 				cd "$sm_path" &&
-				sm_path=$(relative_path "$sm_path") &&
+				sm_path=$(git submodule--helper relative-path "$sm_path" "$wt_prefix") &&
 				# we make $path available to scripts ...
 				path=$sm_path &&
 				if test $# -eq 1
@@ -465,7 +430,7 @@ cmd_deinit()
 		die_if_unmatched "$mode"
 		name=$(git submodule--helper name "$sm_path") || exit
 
-		displaypath=$(relative_path "$sm_path")
+		displaypath=$(git submodule--helper relative-path "$sm_path" "$wt_prefix")
 
 		# Remove the submodule work tree (unless the user already did it)
 		if test -d "$sm_path"
@@ -629,7 +594,7 @@ cmd_update()
 			fi
 		fi
 
-		displaypath=$(relative_path "$prefix$sm_path")
+		displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
 
 		if test $just_cloned -eq 1
 		then
@@ -723,7 +688,7 @@ cmd_update()
 		if test -n "$recursive"
 		then
 			(
-				prefix=$(relative_path "$prefix$sm_path/")
+				prefix=$(git submodule--helper relative-path "$prefix$sm_path/" "$wt_prefix")
 				wt_prefix=
 				sanitize_submodule_env
 				cd "$sm_path" &&
@@ -907,7 +872,7 @@ cmd_summary() {
 		! GIT_DIR="$name/.git" git-rev-parse -q --verify $sha1_dst^0 >/dev/null &&
 		missing_dst=t
 
-		display_name=$(relative_path "$name")
+		display_name=$(git submodule--helper relative-path "$name" "$wt_prefix")
 
 		total_commits=
 		case "$missing_src,$missing_dst" in
@@ -1028,7 +993,7 @@ cmd_status()
 		die_if_unmatched "$mode"
 		name=$(git submodule--helper name "$sm_path") || exit
 		url=$(git config submodule."$name".url)
-		displaypath=$(relative_path "$prefix$sm_path")
+		displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
 		if test "$stage" = U
 		then
 			say "U$sha1 $displaypath"
@@ -1131,7 +1096,7 @@ cmd_sync()
 
 		if git config "submodule.$name.url" >/dev/null 2>/dev/null
 		then
-			displaypath=$(relative_path "$prefix$sm_path")
+			displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
 			say "$(eval_gettext "Synchronizing submodule url for '\$displaypath'")"
 			git config submodule."$name".url "$super_config_url"
 
-- 
2.9.0.rc1.2.ge49d2c8.dirty
