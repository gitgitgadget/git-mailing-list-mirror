From: David Turner <dturner@twopensource.com>
Subject: [PATCH 7/9] am/rebase: update pseudorefs by writing files
Date: Fri, 24 Jul 2015 00:45:27 -0400
Message-ID: <1437713129-19373-8-git-send-email-dturner@twopensource.com>
References: <1437713129-19373-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Jul 24 06:46:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIUsG-00043b-0E
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 06:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752401AbbGXEqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 00:46:13 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:36226 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbbGXEp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 00:45:57 -0400
Received: by qkdv3 with SMTP id v3so8126034qkd.3
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 21:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=25NJs+AfduR8yxAp7TbUdL/rxvMm8keVemLGJDu/gws=;
        b=I9D5MbUN3e/3DqGNzKjo4d5YBvemdvSziaiYS9r/oXGXlYRcQELNAiYgbdTNGShPKm
         f8ouZ/W/flsUOiQlKu5hVhZWGxOK2xHIW1SdcsA5cHCz17360W+sQC8Kc5OiDEUM0/Jn
         0hH7shgrpCpUsj9mcPFD1pVEjMgnE7cWqOIjnkVWJxrrcjObqGM9Iy+AjtoQDSAMiuSr
         fenaxQjccPUEOOLCMxa0/xhnk0BZuDGhlElKl/CxZEhKYS/KNOieM46NEJGOY1ZsU62P
         2R/k+bHaBq3mU2A1YjKnl5r1NFl/JlHbJXLk0W4+X+2m+pWD1Sv6a2Z/mTl5mJ8/tQzH
         jhSQ==
X-Gm-Message-State: ALoCoQng/CewEfwBoV8jI5OdFvctR99fBtdu9BlfxBR9d2XYIGGtNGnaitayxS8sEviN9bIl+3ke
X-Received: by 10.140.201.79 with SMTP id w76mr15228116qha.65.1437713156508;
        Thu, 23 Jul 2015 21:45:56 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id p74sm3541579qkp.11.2015.07.23.21.45.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Jul 2015 21:45:55 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1437713129-19373-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274552>

git update-ref can no longer be used to update pseudorefs, so in
git-am and git-rebase, we just directly edit the files.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 builtin/am.c               | 6 +++---
 contrib/examples/git-am.sh | 4 ++--
 git-rebase--interactive.sh | 2 +-
 git-rebase.sh              | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 3f0fc75..ff3eeee 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1049,12 +1049,12 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 	if (!get_sha1("HEAD", curr_head)) {
 		write_file(am_path(state, "abort-safety"), 1, "%s", sha1_to_hex(curr_head));
 		if (!state->rebasing)
-			update_ref("am", "ORIG_HEAD", curr_head, NULL, 0,
-					UPDATE_REFS_DIE_ON_ERR);
+			write_pseudoref("ORIG_HEAD", curr_head, NULL);
 	} else {
 		write_file(am_path(state, "abort-safety"), 1, "%s", "");
 		if (!state->rebasing)
-			delete_ref("ORIG_HEAD", NULL, 0);
+			if (unlink(git_path("ORIG_HEAD")) && errno != ENOENT)
+				die("failed to unlink ORIG_HEAD");
 	}
 
 	/*
diff --git a/contrib/examples/git-am.sh b/contrib/examples/git-am.sh
index a3d0c84..a01a06e 100755
--- a/contrib/examples/git-am.sh
+++ b/contrib/examples/git-am.sh
@@ -614,9 +614,9 @@ Use \"git am --abort\" to remove it.")"
 		: >"$dotest/applying"
 		if test -n "$HAS_HEAD"
 		then
-			git update-ref ORIG_HEAD HEAD
+			git rev-parse HEAD >"$GIT_DIR/ORIG_HEAD"
 		else
-			git update-ref -d ORIG_HEAD >/dev/null 2>&1
+			rm -f "$GIT_DIR/ORIG_HEAD"
 		fi
 	fi
 fi
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index f01637b..ae116a6 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -948,7 +948,7 @@ warn_lines () {
 checkout_onto () {
 	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name"
 	output git checkout $onto || die_abort "could not detach HEAD"
-	git update-ref ORIG_HEAD $orig_head
+	echo $orig_head >"$GIT_DIR/ORIG_HEAD"
 }
 
 get_missing_commit_check_level () {
diff --git a/git-rebase.sh b/git-rebase.sh
index 1757404..23e2e64 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -611,7 +611,7 @@ say "$(gettext "First, rewinding head to replay your work on top of it...")"
 
 GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name" \
 	git checkout -q "$onto^0" || die "could not detach HEAD"
-git update-ref ORIG_HEAD $orig_head
+echo $orig_head >"$GIT_DIR/ORIG_HEAD"
 
 # If the $onto is a proper descendant of the tip of the branch, then
 # we just fast-forwarded.
-- 
2.0.4.315.gad8727a-twtrsrc
