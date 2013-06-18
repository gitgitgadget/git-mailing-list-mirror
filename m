From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 6/7] rebase: write better reflog messages
Date: Wed, 19 Jun 2013 00:25:36 +0530
Message-ID: <1371581737-10013-7-git-send-email-artagnon@gmail.com>
References: <1371581737-10013-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 20:59:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up17W-0002gV-OC
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 20:59:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933059Ab3FRS7D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 14:59:03 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:58771 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933351Ab3FRS67 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 14:58:59 -0400
Received: by mail-pb0-f42.google.com with SMTP id un1so4210418pbc.1
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 11:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=0hGq7nhVHt9OhJqvwluof0ESqsb1qZJNDraufUs49WI=;
        b=uJynbmaYQ7L67EBB6UdmovOJrEqRAZ95KF7889oUC6HOywT2jJGxUXviNHk0ZJJEnK
         JG5Veg1m1RhxEaYN7l2tEt+5GrfHMcjm+nfBAe/P5N/60AAoE6TQlJV6N6yf9sCt14Av
         klclUnfBJPMIR/hiW1vMUdulrxC3UPVvLgT/CKXQm8JJ+Q9IUclSKf7Da5eSFXw1QptU
         h1c2cdfKPrXISOEWv6ngirGhDctnKrkFPAFGv7e3EZHY78v/ix8Jo5gKLn33z+H0in+Y
         zFMdTn11Ek6qRSS76FLoCxFNHYpGl4qDVoN138PgpRy94YBvX7cdEuKCb0Y0nqoToDjw
         CBXw==
X-Received: by 10.66.232.9 with SMTP id tk9mr3324864pac.20.1371581939307;
        Tue, 18 Jun 2013 11:58:59 -0700 (PDT)
Received: from localhost.localdomain ([122.164.211.22])
        by mx.google.com with ESMTPSA id ag4sm19432751pbc.20.2013.06.18.11.58.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Jun 2013 11:58:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.455.g5932b31
In-Reply-To: <1371581737-10013-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228302>

Now that the "checkout" invoked internally from "rebase" knows to honor
GIT_REFLOG_ACTION, we can start to use it to write a better reflog
message when "rebase anotherbranch", "rebase --onto branch",
etc. internally checks out the new fork point.  We will write:

  rebase: checkout master

instead of the old

  rebase

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-am.sh         |  4 +++-
 git-rebase--am.sh |  5 +++++
 git-rebase.sh     | 13 +++++++++++--
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 1cf3d1d..74ef9ca 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -46,6 +46,8 @@ set_reflog_action am
 require_work_tree
 cd_to_toplevel
 
+base_reflog_action="$GIT_REFLOG_ACTION"
+
 git var GIT_COMMITTER_IDENT >/dev/null ||
 	die "$(gettext "You need to set your committer info first")"
 
@@ -884,7 +886,7 @@ did you forget to use 'git add'?"
 		fi &&
 		git commit-tree $tree ${parent:+-p} $parent <"$dotest/final-commit"
 	) &&
-	git update-ref -m "$GIT_REFLOG_ACTION: $FIRSTLINE" HEAD $commit $parent ||
+	git update-ref -m "$base_reflog_action: $FIRSTLINE" HEAD $commit $parent ||
 	stop_here $this
 
 	if test -f "$dotest/original-commit"; then
diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index 34e3102..69fae7a 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -5,11 +5,13 @@
 
 case "$action" in
 continue)
+	GIT_REFLOG_ACTION="$base_reflog_action"
 	git am --resolved --resolvemsg="$resolvemsg" &&
 	move_to_original_branch
 	return
 	;;
 skip)
+	GIT_REFLOG_ACTION="$base_reflog_action"
 	git am --skip --resolvemsg="$resolvemsg" &&
 	move_to_original_branch
 	return
@@ -40,9 +42,11 @@ else
 		rm -f "$GIT_DIR/rebased-patches"
 		case "$head_name" in
 		refs/heads/*)
+			GIT_REFLOG_ACTION="$base_reflog_action: checkout $head_name"
 			git checkout -q "$head_name"
 			;;
 		*)
+			GIT_REFLOG_ACTION="$base_reflog_action: checkout $orig_head"
 			git checkout -q "$orig_head"
 			;;
 		esac
@@ -59,6 +63,7 @@ else
 		return $?
 	fi
 
+	GIT_REFLOG_ACTION="$base_reflog_action"
 	git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" <"$GIT_DIR/rebased-patches"
 	ret=$?
 
diff --git a/git-rebase.sh b/git-rebase.sh
index d0c11a9..1c72120 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -47,6 +47,8 @@ set_reflog_action rebase
 require_work_tree_exists
 cd_to_toplevel
 
+base_reflog_action="$GIT_REFLOG_ACTION"
+
 LF='
 '
 ok_to_skip_pre_rebase=
@@ -336,7 +338,8 @@ then
 	# Only interactive rebase uses detailed reflog messages
 	if test "$type" = interactive && test "$GIT_REFLOG_ACTION" = rebase
 	then
-		GIT_REFLOG_ACTION="rebase -i ($action)"
+		GIT_REFLOG_ACTION="rebase -i ($1)"
+		base_reflog_action="$GIT_REFLOG_ACTION"
 		export GIT_REFLOG_ACTION
 	fi
 fi
@@ -543,7 +546,11 @@ then
 	if test -z "$force_rebase"
 	then
 		# Lazily switch to the target branch if needed...
-		test -z "$switch_to" || git checkout "$switch_to" --
+		if test -n "$switch_to"
+		then
+			GIT_REFLOG_ACTION="$base_reflog_action: checkout $switch_to"
+			git checkout "$switch_to" --
+		fi
 		say "$(eval_gettext "Current branch \$branch_name is up to date.")"
 		exit 0
 	else
@@ -568,6 +575,8 @@ test "$type" = interactive && run_specific_rebase
 
 # Detach HEAD and reset the tree
 say "$(gettext "First, rewinding head to replay your work on top of it...")"
+
+GIT_REFLOG_ACTION="$base_reflog_action: checkout $onto_name"
 git checkout -q "$onto^0" || die "could not detach HEAD"
 git update-ref ORIG_HEAD $orig_head
 
-- 
1.8.3.1.455.g5932b31
