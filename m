From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] mv: allow moving nested submodules
Date: Mon, 18 Apr 2016 09:54:49 -0700
Message-ID: <1460998489-2155-1-git-send-email-sbeller@google.com>
Cc: Jens.Lehmann@web.de, gmane@otterhall.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 18 18:55:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asCS0-00018z-Bv
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 18:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753290AbcDRQy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 12:54:56 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35106 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753057AbcDRQyz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 12:54:55 -0400
Received: by mail-pa0-f43.google.com with SMTP id fs9so61876797pac.2
        for <git@vger.kernel.org>; Mon, 18 Apr 2016 09:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=oUNwFfSdy/8mH4zBciQ1bpKw6fLDYdeYwa0LFJayyE8=;
        b=mRCxBFIYN9ipCon8OaSZvq3SN/viRCWnylfJxskWBdjFRo4drDzeRTKJHNRYmQ1ls9
         HUVAukcgz2BQOpWzjS2rcE6n6NS52A/kVx/Hx9ToISq+gtLeavI2bMU1dd6Wh9SodkS/
         6Q1EqCjOWFkI8ZBuRVdfSJAefaQ4zZUgTI/DRlavitBl6X+2n6jIvXViDjkLwtWnNg8h
         aZJhrNawDnEq6Gi5wrMN78V6EMWxEjYzE/z8UmAtgPw02c2Z3WuSeY70zf3bzux9Lzn4
         Vx/i0tR3XUhUXyQxXl0fA0c1Q4cvtaTnm7k/VaGOlAHu3Gsq4H/UQkanaJTuhAlzDEm8
         11NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oUNwFfSdy/8mH4zBciQ1bpKw6fLDYdeYwa0LFJayyE8=;
        b=mf8/ktELEIQixKjhcFSUsY5WljotI9Nv55GMQmgL1aww4XO4XbG95yRIZvRR8ZvUNL
         9hgtPbJ0eOZca9x7hyWwWX0pl0deFLc7Y0E01dEV0S/huFsx7FuvTWiW3OcVMAF+M/V5
         WPhJzrn5KP2p49s1Kw4tjPeihsbpIo6xe29NZmq+BmAHXM3x+GNVgfDR9XPa/G6Iha0Q
         Y2jqtqnXMJX4zwewDDOnn4ZmM2z0E1l1F1rS6+UZGay6guuI3g5UBtCk1eAbA1ez1h0L
         58rXsR7jP6mPvZTmh9qbK++UcYfzXIiGDH1NXQMpH7M1bjSH1AyvCimumtJz98iMt0g1
         7SMA==
X-Gm-Message-State: AOPr4FWbT5XS1k9DnSN6mdP6kr94igSygCIddsn4yum9pMj3KEXswokj42Gz+sjFi0M2XxRq
X-Received: by 10.66.72.198 with SMTP id f6mr33006082pav.60.1460998494398;
        Mon, 18 Apr 2016 09:54:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:6869:43f:e72f:2f19])
        by smtp.gmail.com with ESMTPSA id s63sm29195239pfb.71.2016.04.18.09.54.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 18 Apr 2016 09:54:53 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.26.gba39a1b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291810>

When directories are moved using `git mv` all files in the directory
have been just moved, but no further action was taken on them. This
was done by assigning the mode = WORKING_DIRECTORY to the files
inside a moved directory.

submodules however need to update their link to the git directory as
well as updates to the .gitmodules file. By removing the condition of
`mode != INDEX` (the remaining modes are BOTH and WORKING_DIRECTORY) for
the required submodule actions, we perform these for submodules in a
moved directory.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/mv.c  |  7 +++++--
 t/t7001-mv.sh | 16 ++++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index aeae855..65fff11 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -252,9 +252,12 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		int pos;
 		if (show_only || verbose)
 			printf(_("Renaming %s to %s\n"), src, dst);
-		if (!show_only && mode != INDEX) {
-			if (rename(src, dst) < 0 && !ignore_errors)
+		if (!show_only) {
+			if (mode != INDEX &&
+			    rename(src, dst) < 0 &&
+			    !ignore_errors)
 				die_errno(_("renaming '%s' failed"), src);
+
 			if (submodule_gitfile[i]) {
 				if (submodule_gitfile[i] != SUBMODULE_WITH_GITDIR)
 					connect_work_tree_and_git_dir(dst, submodule_gitfile[i]);
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 4008fae..4a2570e 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -292,6 +292,9 @@ test_expect_success 'setup submodule' '
 	echo content >file &&
 	git add file &&
 	git commit -m "added sub and file" &&
+	mkdir -p deep/directory/hierachy &&
+	git submodule add ./. deep/directory/hierachy/sub &&
+	git commit -m "added another submodule" &&
 	git branch submodule
 '
 
@@ -475,4 +478,17 @@ test_expect_success 'mv -k does not accidentally destroy submodules' '
 	git checkout .
 '
 
+test_expect_success 'moving a submodule in nested directories' '
+	(
+		cd deep &&
+		git mv directory ../ &&
+		# git status would fail if the update of linking git dir to
+		# work dir of the submodule failed.
+		git status &&
+		git config -f ../.gitmodules submodule.deep/directory/hierachy/sub.path >../actual &&
+		echo "directory/hierachy/sub" >../expect
+	) &&
+	test_cmp actual expect
+'
+
 test_done
-- 
2.8.0.26.gba39a1b.dirty
