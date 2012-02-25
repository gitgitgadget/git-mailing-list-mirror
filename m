From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH] rebase -m: only call "notes copy" when rewritten exists and is non-empty
Date: Fri, 24 Feb 2012 23:31:22 -0500
Message-ID: <1330144282-22540-1-git-send-email-andrew.kw.w@gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 25 21:54:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1Ocz-0003vg-AM
	for gcvg-git-2@plane.gmane.org; Sat, 25 Feb 2012 21:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752429Ab2BYUx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Feb 2012 15:53:28 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52709 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570Ab2BYUx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2012 15:53:28 -0500
Received: by iazz13 with SMTP id z13so1587374iaz.19
        for <git@vger.kernel.org>; Sat, 25 Feb 2012 12:53:27 -0800 (PST)
Received-SPF: pass (google.com: domain of andrew.kw.w@gmail.com designates 10.42.174.71 as permitted sender) client-ip=10.42.174.71;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of andrew.kw.w@gmail.com designates 10.42.174.71 as permitted sender) smtp.mail=andrew.kw.w@gmail.com; dkim=pass header.i=andrew.kw.w@gmail.com
Received: from mr.google.com ([10.42.174.71])
        by 10.42.174.71 with SMTP id u7mr8067807icz.44.1330203207539 (num_hops = 1);
        Sat, 25 Feb 2012 12:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=l9ZreBRS0PgGqAYqUsHQsOmomJFRFyd/3YIx2OTDgHI=;
        b=JXYYpacn+jhD2IRqILbEXjaiyYYgfQTxOtRSma3m5dlv/u1w8g5X0n2LWwMTpZMbX5
         hflbCyikHYQ0FfylgIm/qUZ/g1CZBI3iF/7PVX1p6/59HHhSSEPGf0EaE08SiyZxxZ9y
         IiNJm88Gm/tddja/VJf8EujZDytsv6mHBgbgU=
Received: by 10.42.174.71 with SMTP id u7mr6385039icz.44.1330203207455;
        Sat, 25 Feb 2012 12:53:27 -0800 (PST)
Received: from localhost.localdomain (24-246-58-202.cable.teksavvy.com. [24.246.58.202])
        by mx.google.com with ESMTPS id vr4sm5679346igb.1.2012.02.25.12.53.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 25 Feb 2012 12:53:26 -0800 (PST)
X-Mailer: git-send-email 1.7.9.2.263.g07763
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191546>

This prevents a shell error complaining rebase-merge/rewritten doesn't exist.

Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
---
 git-rebase--merge.sh |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index 26afc75..5e9d95f 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -90,10 +90,11 @@ call_merge () {
 
 finish_rb_merge () {
 	move_to_original_branch
-	git notes copy --for-rewrite=rebase < "$state_dir"/rewritten
-	if test -x "$GIT_DIR"/hooks/post-rewrite &&
-		test -s "$state_dir"/rewritten; then
-		"$GIT_DIR"/hooks/post-rewrite rebase < "$state_dir"/rewritten
+	if test -s "$state_dir"/rewritten; then
+		git notes copy --for-rewrite=rebase < "$state_dir"/rewritten
+		if test -x "$GIT_DIR"/hooks/post-rewrite; then
+			"$GIT_DIR"/hooks/post-rewrite rebase < "$state_dir"/rewritten
+		fi
 	fi
 	rm -r "$state_dir"
 	say All done.
-- 
1.7.9.2.263.g07763
