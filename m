From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 3/6] bisect: use refs infrastructure for BISECT_START
Date: Thu, 25 Jun 2015 16:45:07 -0400
Message-ID: <1435265110-6414-3-git-send-email-dturner@twopensource.com>
References: <1435265110-6414-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Jun 25 22:45:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8E1j-00067M-HL
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 22:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbbFYUpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 16:45:32 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:34945 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbbFYUp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 16:45:28 -0400
Received: by iebrt9 with SMTP id rt9so62827378ieb.2
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 13:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u+H22XNGVT2syMI3r/ljHnA8BjT5USQx/JqIxEMdbxA=;
        b=GVLwlWrkWLhgh5MqIZm6Rl3vUvvVU6aNeqSzSxQPijgSxKF7wPSasd19NlbfBBOxjA
         g9Sk6NGvpTCdqVBBNFCIY4x5UMe/8YEwaiDZGWe5nIiaK35RTQuDkaj9knE6PbCipcl/
         PuhDbrK7uyxQg4LKqhbNJCvfPuKD27qlOjSDe+osuDo4C3a+h37YPAXHIqvg6gnFtBUO
         2K4ZkJ0e5DSd31aQWAsbPeRkOzWTRi+ryzEEqEQhQeiUO9m9+rhRWNmAbAeOix56eyqR
         vX9BZP18sasNe2SbDRkIaoci1O94tx541UznveyDf6xLiJfBPNnTjsMKrKTlq/ogADNk
         XNVw==
X-Gm-Message-State: ALoCoQn8+YIYevETDKt66N+roVwPmFu0bsZoCrSEud9C8iLncM/cvZY5ZUqLQz2NqlmkuGkz0Su2
X-Received: by 10.50.143.38 with SMTP id sb6mr6592979igb.44.1435265127149;
        Thu, 25 Jun 2015 13:45:27 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by mx.google.com with ESMTPSA id fv2sm4042683igb.22.2015.06.25.13.45.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jun 2015 13:45:26 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.314.gdbf7a51-twtrsrc
In-Reply-To: <1435265110-6414-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272728>

This ref needs to go through the refs backend, since some code assumes
that it can be written and read as a ref.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 contrib/completion/git-completion.bash | 2 +-
 git-bisect.sh                          | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 93716c4..c4d4d80 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -938,7 +938,7 @@ _git_bisect ()
 	local subcommands="start bad good skip reset visualize replay log run"
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
-		if [ -f "$(__gitdir)"/BISECT_START ]; then
+		if [ git rev-parse BISECT_START 2>/dev/null ]; then
 			__gitcomp "$subcommands"
 		else
 			__gitcomp "replay start"
diff --git a/git-bisect.sh b/git-bisect.sh
index ae3fec2..8658772 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -166,7 +166,7 @@ bisect_start() {
 	#
 	echo "$start_head" >"$GIT_DIR/BISECT_START" && {
 		test "z$mode" != "z--no-checkout" ||
-		git update-ref --no-deref BISECT_HEAD "$start_head"
+		git rev-parse "$start_head" > "$GIT_DIR/BISECT_HEAD"
 	} &&
 	git rev-parse --sq-quote "$@" >"$GIT_DIR/BISECT_NAMES" &&
 	eval "$eval true" &&
@@ -399,7 +399,7 @@ bisect_clean_state() {
 	rm -f "$GIT_DIR/BISECT_RUN" &&
 	# Cleanup head-name if it got left by an old version of git-bisect
 	rm -f "$GIT_DIR/head-name" &&
-	git update-ref -d --no-deref BISECT_HEAD &&
+	rm -f "$GIT_DIR/BISECT_HEAD" &&
 	# clean up BISECT_START last
 	rm -f "$GIT_DIR/BISECT_START"
 }
-- 
2.0.4.314.gdbf7a51-twtrsrc
