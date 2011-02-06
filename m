From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2 05/31] rebase: improve detection of rebase in progress
Date: Sun,  6 Feb 2011 13:43:34 -0500
Message-ID: <1297017841-20678-6-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 06 19:46:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm9cf-0004j0-Ag
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 19:46:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753572Ab1BFSpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 13:45:55 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:58927 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551Ab1BFSpx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 13:45:53 -0500
Received: by mail-qy0-f181.google.com with SMTP id 12so3422584qyk.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 10:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=Rx6HCncTtWS2w3p8VYoD1AgCBTDwbiXENUsfkYzT1Fc=;
        b=FkiynF1+JLq33xq50k9JN1KP8ylWljRZE4AtAtm7dhyIlTaBvWH0K7w7aPLCwjGFUA
         zzTjpFtcE6795gKGzHrdxNYoSZb7GSkFBeU1e35Fh1quRGAiOIvDeW2vmh/GVq98PqVn
         GSLWTD60y7iYgW7THsYvCT/g3QVYhCY13Zhuo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=orXoKkgJCs9B0FaMcxc7Zwy1Z19deCpKFG1JZ5XHaL+8mrWkBaRT1/AFxMwhhr0K2k
         RQaRDJuBgndWZzG24AuLIJ9p+H8KfcoZ14TX7i5W/6iuq8UThbv+ocab0s4kpLVoD6Yu
         6Uhd37Lr1Hwks36hzktIoNDU699Q/mVMl6Vc8=
Received: by 10.229.241.196 with SMTP id lf4mr12040149qcb.284.1297017953008;
        Sun, 06 Feb 2011 10:45:53 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id h20sm2174330qck.24.2011.02.06.10.45.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Feb 2011 10:45:51 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
In-Reply-To: <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166165>

Detect early on if a rebase is in progress and what type of rebase it
is (interactive, merge-based or am-based). This prepares for further
refactoring where am-based rebase will be dispatched to
git-rebase--am.sh and merge-based rebase will be dispatched to
git-rebase--merge.sh.

The idea is to use the same variables whether the type of rebase was
detected from rebase-apply/ or rebase-merge/ directories or from the
command line options. This will make the code more readable and will
later also make it easier to dispatch to the type-specific scripts.

Also show a consistent error message independent of the type of rebase
that was in progress and remove the obsolete wording about being in
the middle of a 'patch application', since that (an existing
"$GIT_DIR"/rebase-apply/applying) aborts 'git rebase' at an earlier
stage.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
Currently, the existence of rebase-merge/ is tested with 'test -d',
while the existence of rebase-apply/ is tested by creating the
directory and then deleting it again. Any good reason for this?

There were some discussions on the above subject in the first round,
but nothing conclusive, so I have left it the way it was for now.

 git-rebase.sh |   80 +++++++++++++++++++++++++++++---------------------------
 1 files changed, 41 insertions(+), 39 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 8c1c4ed..1d34d43 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -56,16 +56,19 @@ git_am_opt=
 rebase_root=
 force_rebase=
 allow_rerere_autoupdate=
+# Non-empty if a rebase was in progress when 'git rebase' was invoked
+in_progress=
+# One of {am, merge, interactive}
+type=
+# One of {"$GIT_DIR"/rebase-apply, "$GIT_DIR"/rebase-merge}
+state_dir=
 
 read_state () {
-	if test -d "$merge_dir"
+	if test "$type" = merge
 	then
-		state_dir="$merge_dir"
-		onto_name=$(cat "$merge_dir"/onto_name) &&
-		end=$(cat "$merge_dir"/end) &&
-		msgnum=$(cat "$merge_dir"/msgnum)
-	else
-		state_dir="$apply_dir"
+		onto_name=$(cat "$state_dir"/onto_name) &&
+		end=$(cat "$state_dir"/end) &&
+		msgnum=$(cat "$state_dir"/msgnum)
 	fi &&
 	head_name=$(cat "$state_dir"/head-name) &&
 	onto=$(cat "$state_dir"/onto) &&
@@ -207,6 +210,23 @@ test -f "$apply_dir"/applying &&
 
 is_interactive "$@" && exec git-rebase--interactive "$@"
 
+if test -d "$apply_dir"
+then
+	type=am
+	state_dir="$apply_dir"
+elif test -d "$merge_dir"
+then
+	if test -f "$merge_dir"/interactive
+	then
+		type=interactive
+		interactive_rebase=explicit
+	else
+		type=merge
+	fi
+	state_dir="$merge_dir"
+fi
+test -n "$type" && in_progress=t
+
 while test $# != 0
 do
 	case "$1" in
@@ -217,8 +237,7 @@ do
 		OK_TO_SKIP_PRE_REBASE=
 		;;
 	--continue)
-		test -d "$merge_dir" -o -d "$apply_dir" ||
-			die "No rebase in progress?"
+		test -z "$in_progress" && die "No rebase in progress?"
 
 		git update-index --ignore-submodules --refresh &&
 		git diff-files --quiet --ignore-submodules || {
@@ -243,8 +262,7 @@ do
 		exit
 		;;
 	--skip)
-		test -d "$merge_dir" -o -d "$apply_dir" ||
-			die "No rebase in progress?"
+		test -z "$in_progress" && die "No rebase in progress?"
 
 		git reset --hard HEAD || exit $?
 		read_state
@@ -265,8 +283,7 @@ do
 		exit
 		;;
 	--abort)
-		test -d "$merge_dir" -o -d "$apply_dir" ||
-			die "No rebase in progress?"
+		test -z "$in_progress" && die "No rebase in progress?"
 
 		git rerere clear
 		read_state
@@ -374,37 +391,22 @@ do
 done
 test $# -gt 2 && usage
 
-if test $# -eq 0 && test -z "$rebase_root"
+# Make sure no rebase is in progress
+if test -n "$in_progress"
 then
-	test -d "$merge_dir" -o -d "$apply_dir" || usage
-	test -d "$merge_dir" -o -f "$apply_dir"/rebasing &&
-		die 'A rebase is in progress, try --continue, --skip or --abort.'
-fi
-
-# Make sure we do not have $apply_dir or $merge_dir
-if test -z "$do_merge"
-then
-	if mkdir "$apply_dir" 2>/dev/null
-	then
-		rmdir "$apply_dir"
-	else
-		echo >&2 '
-It seems that I cannot create a rebase-apply directory, and
-I wonder if you are in the middle of patch application or another
-rebase.  If that is not the case, please
-	rm -fr '"$apply_dir"'
+	die '
+It seems that there is already a '"${state_dir##*/}"' directory, and
+I wonder if you are in the middle of another rebase.  If that is the
+case, please try
+	git rebase (--continue | --abort | --skip)
+If that is not the case, please
+	rm -fr '"$state_dir"'
 and run me again.  I am stopping in case you still have something
 valuable there.'
-		exit 1
-	fi
-else
-	if test -d "$merge_dir"
-	then
-		die "previous rebase directory $merge_dir still exists." \
-			'Try git rebase (--continue | --abort | --skip)'
-	fi
 fi
 
+test $# -eq 0 && test -z "$rebase_root" && usage
+
 require_clean_work_tree "rebase" "Please commit or stash them."
 
 if test -z "$rebase_root"
-- 
1.7.4.rc2.33.g8a14f
