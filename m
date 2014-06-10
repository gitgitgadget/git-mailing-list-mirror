From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH] git-submodule.sh: avoid "test <cond> -a/-o <cond>"
Date: Tue, 10 Jun 2014 05:28:33 -0700
Message-ID: <1402403313-22468-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, gitster@pobox.com,
	Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 14:28:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuLAV-000549-A9
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 14:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbaFJM2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 08:28:43 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:37232 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbaFJM2m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 08:28:42 -0400
Received: by mail-pa0-f47.google.com with SMTP id fa1so652034pad.34
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 05:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=PEpI8T9OhsPkT6efRcJyUItLex8ZjK+YPxtaYx8Hg04=;
        b=j6n5dttY0E7Ei1v/+T6BMhKzOyIfOR25j1qMjQEci1wiS4OCDBL8oXyL58TAXkNjzl
         1/cTvaj+JTmKzLAFOPLjH0D6bS3JJMnIVKEw71imUs+hMiv9L69Hi1T0VOTZRg39/kfz
         bx554zX2waOVjrwGfJWJvhDzE+Gd8ewhV3jbxJ6gPHsxwD8pR5yKNxubpuI5AuRhIJ+/
         WARk9fWcTYD7I1CfPMH4YSWvE5mgFOV+aqQtEdbZVPUwc8xkobwkBlaX/xA9ZJZGurqA
         ijBORD5WLFln6jcMinDoySmEzBGIrl6Jt4efDEqCIjBCLzdrvRCds+fzSXYbUVakTt0O
         JLpw==
X-Received: by 10.68.197.99 with SMTP id it3mr11277991pbc.37.1402403322451;
        Tue, 10 Jun 2014 05:28:42 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id gg3sm69347190pbc.34.2014.06.10.05.28.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 10 Jun 2014 05:28:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251182>

The construct is error-prone; "test" being built-in in most modern
shells, the reason to avoid "test <cond> && test <cond>" spawning
one extra process by using a single "test <cond> -a <cond>" no
longer exists.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---

This is the fourth revision of this patch.

Change based on Junio suggestions http://www.spinics.net/lists/git/msg233569.html

 git-submodule.sh |   32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index e146b83..d6a1dea 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -393,7 +393,7 @@ cmd_add()
 			sed -e 's|/$||' -e 's|:*/*\.git$||' -e 's|.*[/:]||g')
 	fi
 
-	if test -z "$repo" -o -z "$sm_path"; then
+	if test -z "$repo" || test -z "$sm_path"; then
 		usage
 	fi
 
@@ -450,7 +450,7 @@ Use -f if you really want to add it." >&2
 	# perhaps the path exists and is already a git repo, else clone it
 	if test -e "$sm_path"
 	then
-		if test -d "$sm_path"/.git -o -f "$sm_path"/.git
+		if test -d "$sm_path"/.git || test -f "$sm_path"/.git
 		then
 			eval_gettextln "Adding existing repo at '\$sm_path' to the index"
 		else
@@ -832,7 +832,7 @@ Maybe you want to use 'update --init'?")"
 			continue
 		fi
 
-		if ! test -d "$sm_path"/.git -o -f "$sm_path"/.git
+		if ! test -d "$sm_path"/.git || test -f "$sm_path"/.git
 		then
 			module_clone "$sm_path" "$name" "$url" "$reference" "$depth" || exit
 			cloned_modules="$cloned_modules;$name"
@@ -857,11 +857,11 @@ Maybe you want to use 'update --init'?")"
 			die "$(eval_gettext "Unable to find current ${remote_name}/${branch} revision in submodule path '\$sm_path'")"
 		fi
 
-		if test "$subsha1" != "$sha1" -o -n "$force"
+		if test "$subsha1" != "$sha1" || test -n "$force"
 		then
 			subforce=$force
 			# If we don't already have a -f flag and the submodule has never been checked out
-			if test -z "$subsha1" -a -z "$force"
+			if test -z "$subsha1" && test -z "$force"
 			then
 				subforce="-f"
 			fi
@@ -1031,7 +1031,7 @@ cmd_summary() {
 	then
 		head=$rev
 		test $# = 0 || shift
-	elif test -z "$1" -o "$1" = "HEAD"
+	elif test -z "$1" || test "$1" = "HEAD"
 	then
 		# before the first commit: compare with an empty tree
 		head=$(git hash-object -w -t tree --stdin </dev/null)
@@ -1056,13 +1056,17 @@ cmd_summary() {
 		while read mod_src mod_dst sha1_src sha1_dst status sm_path
 		do
 			# Always show modules deleted or type-changed (blob<->module)
-			test $status = D -o $status = T && echo "$sm_path" && continue
+			case "$status" in
+			([DT])
+				printf '%s\n' "$sm_path" &&
+				continue
+			esac
 			# Respect the ignore setting for --for-status.
 			if test -n "$for_status"
 			then
 				name=$(module_name "$sm_path")
 				ignore_config=$(get_submodule_config "$name" ignore none)
-				test $status != A -a $ignore_config = all && continue
+				test $status != A && test $ignore_config = all && continue
 			fi
 			# Also show added or modified modules which are checked out
 			GIT_DIR="$sm_path/.git" git-rev-parse --git-dir >/dev/null 2>&1 &&
@@ -1122,7 +1126,7 @@ cmd_summary() {
 		*)
 			errmsg=
 			total_commits=$(
-			if test $mod_src = 160000 -a $mod_dst = 160000
+			if test $mod_src = 160000 && test $mod_dst = 160000
 			then
 				range="$sha1_src...$sha1_dst"
 			elif test $mod_src = 160000
@@ -1159,7 +1163,7 @@ cmd_summary() {
 			# i.e. deleted or changed to blob
 			test $mod_dst = 160000 && echo "$errmsg"
 		else
-			if test $mod_src = 160000 -a $mod_dst = 160000
+			if test $mod_src = 160000 && test $mod_dst = 160000
 			then
 				limit=
 				test $summary_limit -gt 0 && limit="-$summary_limit"
@@ -1230,7 +1234,11 @@ cmd_status()
 			say "U$sha1 $displaypath"
 			continue
 		fi
-		if test -z "$url" || ! test -d "$sm_path"/.git -o -f "$sm_path"/.git
+		if test -z "$url" ||
+		{
+			! test -d "$sm_path"/.git &&
+			! test -f "$sm_path"/.git
+		}
 		then
 			say "-$sha1 $displaypath"
 			continue;
@@ -1399,7 +1407,7 @@ then
 fi
 
 # "--cached" is accepted only by "status" and "summary"
-if test -n "$cached" && test "$command" != status -a "$command" != summary
+if test -n "$cached" && test "$command" != status && test "$command" != summary
 then
 	usage
 fi
-- 
1.7.10.4
