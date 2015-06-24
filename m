From: David Turner <dturner@twopensource.com>
Subject: [PATCH 3/6] bisect: use refs infrastructure for BISECT_START
Date: Wed, 24 Jun 2015 15:16:25 -0400
Message-ID: <1435173388-8346-4-git-send-email-dturner@twopensource.com>
References: <1435173388-8346-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Jun 24 21:17:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7qAX-0000Is-Uz
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 21:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753772AbbFXTRD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 15:17:03 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:34577 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813AbbFXTQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 15:16:59 -0400
Received: by igboe5 with SMTP id oe5so122077996igb.1
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 12:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u+H22XNGVT2syMI3r/ljHnA8BjT5USQx/JqIxEMdbxA=;
        b=ejEHINfcbPAnW5gLyunmgMdUASqho0dWSTD80FsxuXP4DSl53pMly2OqBVL6QOHTIp
         0yXK/bH/NpVtA+ny4oIcpvVHoHDNotIZHfz+yxqGJ8wyT1mSoZwsGE1CGgBjVB0FqaTB
         KqwsnpFvMfWtEfBAfNZwESlobYB/z63cFq7CErVD9TWXrhaGeXr1nhvhUg4GOKwXdw3d
         BMRXzyWL9efezk2j7+BxyIQaqRsas1nbWG5zXtzESF+FDPBWFN4I+5sfaWd9VuSty1yb
         mzArDJlqV10OLxffjNi4YIdfCY/AHMcghUroSeovxKL89YvQTd1REf+kjPl17apa/f8g
         M2kQ==
X-Gm-Message-State: ALoCoQmWoZk2dMKUcgGZxX+zw5sAZtmno9cBRI5tVUU7wYG/Afo37FRpcW6AzkG+68DFwtD9H9t1
X-Received: by 10.107.160.141 with SMTP id j135mr55604799ioe.43.1435173418544;
        Wed, 24 Jun 2015 12:16:58 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by mx.google.com with ESMTPSA id p8sm1644609iga.13.2015.06.24.12.16.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Jun 2015 12:16:57 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.314.gdbf7a51-twtrsrc
In-Reply-To: <1435173388-8346-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272584>

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
