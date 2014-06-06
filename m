From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 10/20] git-submodule.sh: avoid "test <cond> -a/-o <cond>"
Date: Fri,  6 Jun 2014 07:55:53 -0700
Message-ID: <1402066563-28519-11-git-send-email-gitter.spiros@gmail.com>
References: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 16:56:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsvZg-00025K-3L
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 16:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126AbaFFO4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 10:56:50 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:38218 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086AbaFFO4R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 10:56:17 -0400
Received: by mail-pd0-f175.google.com with SMTP id z10so2518523pdj.20
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 07:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fe0kGQLQpSadUM8bcy7tSShx/HIGnMW1RY6AvueGTU8=;
        b=GZC35QJHSvUt6sCqDyvDslmeN7IRDBu/GeIN5q3ivYFEiOov8+cxlBYowfk48U1Fx7
         JNNksAQ3xKTnZNhTvbLXseKs7dnX/4XHbsTlM9mJGRK7Mgci6tyAMqN37Gy+lNye0bFx
         RCHtr3U0P0NpZZOE1dswxaY6s4CZeorfIMdOoIWNY9TH5Wkss+d79OR77yVQsqdVvcg+
         orR8f1wLOnAVV5oen+ho9tWDazBGeMMabx1w3TiWfNoQUB/IN1gLOa2raLyGhg7EaC63
         S0B8Qp/GcfzTjKIVVk7J5FEiMLSomkEeR31FjGcEzQl7DX8SbrqflQIpfVGtWxgzTdCe
         WDdw==
X-Received: by 10.68.196.168 with SMTP id in8mr1599025pbc.132.1402066577155;
        Fri, 06 Jun 2014 07:56:17 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pu5sm36850769pbb.4.2014.06.06.07.56.16
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Jun 2014 07:56:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250934>

The construct is error-prone; "test" being built-in in most modern
shells, the reason to avoid "test <cond> && test <cond>" spawning
one extra process by using a single "test <cond> -a <cond>" no
longer exists.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 git-submodule.sh |   32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index b55d83a..1e3a5a6 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -396,7 +396,7 @@ cmd_add()
 			sed -e 's|/$||' -e 's|:*/*\.git$||' -e 's|.*[/:]||g')
 	fi
 
-	if test -z "$repo" -o -z "$sm_path"; then
+	if test -z "$repo" || test -z "$sm_path"; then
 		usage
 	fi
 
@@ -453,7 +453,7 @@ Use -f if you really want to add it." >&2
 	# perhaps the path exists and is already a git repo, else clone it
 	if test -e "$sm_path"
 	then
-		if test -d "$sm_path"/.git -o -f "$sm_path"/.git
+		if test -d "$sm_path"/.git || test -f "$sm_path"/.git
 		then
 			eval_gettextln "Adding existing repo at '\$sm_path' to the index"
 		else
@@ -835,7 +835,7 @@ Maybe you want to use 'update --init'?")"
 			continue
 		fi
 
-		if ! test -d "$sm_path"/.git -o -f "$sm_path"/.git
+		if ! test -d "$sm_path"/.git || test -f "$sm_path"/.git
 		then
 			module_clone "$sm_path" "$name" "$url" "$reference" "$depth" || exit
 			cloned_modules="$cloned_modules;$name"
@@ -860,11 +860,11 @@ Maybe you want to use 'update --init'?")"
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
@@ -1034,7 +1034,7 @@ cmd_summary() {
 	then
 		head=$rev
 		test $# = 0 || shift
-	elif test -z "$1" -o "$1" = "HEAD"
+	elif test -z "$1" || test "$1" = "HEAD"
 	then
 		# before the first commit: compare with an empty tree
 		head=$(git hash-object -w -t tree --stdin </dev/null)
@@ -1059,13 +1059,17 @@ cmd_summary() {
 		while read mod_src mod_dst sha1_src sha1_dst status sm_path
 		do
 			# Always show modules deleted or type-changed (blob<->module)
-			test $status = D -o $status = T && echo "$sm_path" && continue
+			case "$status" in
+			[DT])
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
@@ -1125,7 +1129,7 @@ cmd_summary() {
 		*)
 			errmsg=
 			total_commits=$(
-			if test $mod_src = 160000 -a $mod_dst = 160000
+			if test $mod_src = 160000 && test $mod_dst = 160000
 			then
 				range="$sha1_src...$sha1_dst"
 			elif test $mod_src = 160000
@@ -1162,7 +1166,7 @@ cmd_summary() {
 			# i.e. deleted or changed to blob
 			test $mod_dst = 160000 && echo "$errmsg"
 		else
-			if test $mod_src = 160000 -a $mod_dst = 160000
+			if test $mod_src = 160000 && test $mod_dst = 160000
 			then
 				limit=
 				test $summary_limit -gt 0 && limit="-$summary_limit"
@@ -1233,7 +1237,11 @@ cmd_status()
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
@@ -1402,7 +1410,7 @@ then
 fi
 
 # "--cached" is accepted only by "status" and "summary"
-if test -n "$cached" && test "$command" != status -a "$command" != summary
+if test -n "$cached" && test "$command" != status && test "$command" != summary
 then
 	usage
 fi
-- 
1.7.10.4
