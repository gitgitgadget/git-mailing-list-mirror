From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 6/7] rebase: write better reflog messages
Date: Wed, 19 Jun 2013 13:34:48 +0530
Message-ID: <1371629089-27008-7-git-send-email-artagnon@gmail.com>
References: <1371629089-27008-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 19 10:08:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpDRe-0002M0-UL
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 10:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756680Ab3FSIIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 04:08:40 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33514 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756606Ab3FSIIM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 04:08:12 -0400
Received: by mail-pa0-f44.google.com with SMTP id lj1so4915979pab.3
        for <git@vger.kernel.org>; Wed, 19 Jun 2013 01:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=cigAe7tX99I44r4Ukn+p+/e3laTN0dDgkrNOw8D3m6A=;
        b=ZBKDZa70Y5lLUWx3RcdW4mjy4sw7cv04HVjW2fJ+yRSpFLBX7YLsIMp3r+92RACfNn
         0z4X+vCDyfSXqWq93Oy9AzjkGtEYedoqE0avRL+U0ensD7Hhs0ijJk/kROI6EMvXMnma
         BS6ra2b4YNTVlfy+u8o9aJLP5XICnspn2bwuyUsJ7n6WA0hy+rW8vOWaRm/rAMsKJOJq
         8FGhemA+FftDJXBUP1tANuZloFUEsN+VlxRNBkngTbx6ywaVUEAVT42ATl15IDQ0WSLx
         8U1lJTLqU5CZ07yRmDAXQ5Z4luGYO/nNNS6o0X5ZKuHjp9vmSD5t+Et9Xaay3l/BnlRx
         mUrA==
X-Received: by 10.66.87.5 with SMTP id t5mr5700682paz.169.1371629291706;
        Wed, 19 Jun 2013 01:08:11 -0700 (PDT)
Received: from localhost.localdomain ([122.164.211.22])
        by mx.google.com with ESMTPSA id vz8sm23663400pac.20.2013.06.19.01.08.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 19 Jun 2013 01:08:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.449.g41b32a4.dirty
In-Reply-To: <1371629089-27008-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228377>

Now that the "checkout" invoked internally from "rebase" knows to honor
GIT_REFLOG_ACTION, we can start to use it to write a better reflog
message when "rebase anotherbranch", "rebase --onto branch",
etc. internally checks out the new fork point.  We will write:

  rebase: checkout master

instead of the old

  rebase

The usage semantics of GIT_REFLOG_ACTION have changed; by appending to
GIT_REFLOG_ACTION directly, we risk appending to a prebuilt string like
"rebase: checkout mool" from a previous append, when we really intended
to append to the string "rebase".  Solve this problem by introducing a
base_reflog_action variable that is different from GIT_REFLOG_ACTION.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-am.sh         |  4 +++-
 git-rebase--am.sh |  7 +++++++
 git-rebase.sh     | 18 ++++++++++++++++--
 3 files changed, 26 insertions(+), 3 deletions(-)

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
index 34e3102..7fbeb35 100644
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
@@ -59,6 +63,9 @@ else
 		return $?
 	fi
 
+	# always reset GIT_REFLOG_ACTION before calling any external
+	# scripts; they have no idea about our base_reflog_action
+	GIT_REFLOG_ACTION="$base_reflog_action"
 	git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" <"$GIT_DIR/rebased-patches"
 	ret=$?
 
diff --git a/git-rebase.sh b/git-rebase.sh
index d0c11a9..6cdf9f8 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -47,6 +47,13 @@ set_reflog_action rebase
 require_work_tree_exists
 cd_to_toplevel
 
+# Should contain a base string like "rebase" (or "rebase -i (start)")
+# to which a more information like ": checkout foom" can be appended
+# to set the final GIT_REFLOG_ACTION.  If you append to
+# GIT_REFLOG_ACTION directly, you risk appending to a prebuilt string
+# like "rebase: checkout mool" from a previous append.
+base_reflog_action="$GIT_REFLOG_ACTION"
+
 LF='
 '
 ok_to_skip_pre_rebase=
@@ -336,7 +343,8 @@ then
 	# Only interactive rebase uses detailed reflog messages
 	if test "$type" = interactive && test "$GIT_REFLOG_ACTION" = rebase
 	then
-		GIT_REFLOG_ACTION="rebase -i ($action)"
+		GIT_REFLOG_ACTION="rebase -i ($1)"
+		base_reflog_action="$GIT_REFLOG_ACTION"
 		export GIT_REFLOG_ACTION
 	fi
 fi
@@ -543,7 +551,11 @@ then
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
@@ -568,6 +580,8 @@ test "$type" = interactive && run_specific_rebase
 
 # Detach HEAD and reset the tree
 say "$(gettext "First, rewinding head to replay your work on top of it...")"
+
+GIT_REFLOG_ACTION="$base_reflog_action: checkout $onto_name"
 git checkout -q "$onto^0" || die "could not detach HEAD"
 git update-ref ORIG_HEAD $orig_head
 
-- 
1.8.3.1.449.g41b32a4.dirty
