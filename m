From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH] rebase -i: interrupt rebase when "commit --amend" failed during "reword"
Date: Mon, 28 Nov 2011 11:15:52 -0500
Message-ID: <1322496952-23819-2-git-send-email-andrew.kw.w@gmail.com>
References: <20111117125847.190e9b25@ashu.dyn.rarus.ru>
 <1322496952-23819-1-git-send-email-andrew.kw.w@gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 17:17:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RV3tX-00041L-Gh
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 17:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836Ab1K1QRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Nov 2011 11:17:23 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:35768 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499Ab1K1QRW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2011 11:17:22 -0500
Received: by vcbfk14 with SMTP id fk14so3773902vcb.19
        for <git@vger.kernel.org>; Mon, 28 Nov 2011 08:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=bbpy18kdbk2RCYLf62lDmY1ODbOEnZ/qjAh35VoaKUc=;
        b=iWVbOORN0oDuh0glX+xmXUQEnbeKH1X4rwSBUIV0wiX76whjaCkXk6g/Gr7jd83CM7
         wAb+3hLmSgmfNG5s2u96I1Q6Nk85NQl92Vs1cPvT+zimkAFsVmD8gtnYJ0dvVqwRLkLn
         NCGzY+Bfc5H7HMsrGzY0BFiqLT8qzbBJ+gqbc=
Received: by 10.220.205.195 with SMTP id fr3mr5051917vcb.211.1322496985625;
        Mon, 28 Nov 2011 08:16:25 -0800 (PST)
Received: from nigel.sohovfx-toronto.com ([66.207.196.114])
        by mx.google.com with ESMTPS id q17sm14153192vdi.14.2011.11.28.08.16.24
        (version=SSLv3 cipher=OTHER);
        Mon, 28 Nov 2011 08:16:24 -0800 (PST)
X-Mailer: git-send-email 1.7.8.rc3.32.gb2fac
In-Reply-To: <1322496952-23819-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186020>

"commit --amend" could fail in cases like the user empties the commit
message, or pre-commit failed.  When it fails, rebase should be
interrupted, rather than ignoring the error and continue on rebasing.
This gives users a way to gracefully interrupt a "reword" if they
decided they actually want to do an "edit", or even "rebase --abort".

Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
---
 git-rebase--interactive.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 804001b..669f378 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -408,7 +408,8 @@ do_next () {
 		mark_action_done
 		pick_one $sha1 ||
 			die_with_patch $sha1 "Could not apply $sha1... $rest"
-		git commit --amend --no-post-rewrite
+		git commit --amend --no-post-rewrite ||
+			die_with_patch $sha1 "Cannot amend commit after successfully picking $sha1... $rest"
 		record_in_rewritten $sha1
 		;;
 	edit|e)
-- 
1.7.8.rc3.32.gb2fac
