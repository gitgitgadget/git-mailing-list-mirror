From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH 2/2] rebase -i: interrupt rebase when "commit --amend" failed
Date: Sun, 24 Jul 2011 23:38:33 -0400
Message-ID: <1311565113-5022-3-git-send-email-andrew.kw.w@gmail.com>
References: <1311565113-5022-1-git-send-email-andrew.kw.w@gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 30 09:04:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qn3ax-0006Ee-3q
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 09:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378Ab1G3HEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 03:04:10 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57751 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753048Ab1G3HEF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 03:04:05 -0400
Received: by mail-iy0-f174.google.com with SMTP id 12so4819660iyb.19
        for <git@vger.kernel.org>; Sat, 30 Jul 2011 00:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jdgx06/qnlcnvHA7ui3YHPdm596tws8tcMeALVn8zqU=;
        b=I/simfJ4lMDofd3bpKSYkPPJjgXhid/kj+dFo0riMasMIEY/4EApcATaNvBL307uLK
         C4dY899RwpiGTmkq49wgvK/U5WYXdMczdGAnniLOLRVEq6ZGkMEAa8TKFs7ZBMUDmrVQ
         htamNEH/AGCrTzKoY3iuPBpheTGdHHImegfNo=
Received: by 10.42.168.134 with SMTP id w6mr1734342icy.156.1312009445657;
        Sat, 30 Jul 2011 00:04:05 -0700 (PDT)
Received: from localhost.localdomain (24-246-58-202.cable.teksavvy.com [24.246.58.202])
        by mx.google.com with ESMTPS id h6sm3831145icw.19.2011.07.30.00.04.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 30 Jul 2011 00:04:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2
In-Reply-To: <1311565113-5022-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178178>

"commit --amend" could fail if the user empties the commit message.
Although this is not a real error, it seems to make more sense to
interrupt the rebasing, rather than ignoring the error and continue on
rebasing.  This gives users a way to gracefully interrupt a "reword" if
they decided they actually want to do an "edit", or even "rebase
--abort".

Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
---
 git-rebase--interactive.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index df9f7e9..7055ef4 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -397,7 +397,8 @@ do_next () {
 		mark_action_done
 		pick_one $sha1 ||
 			die_with_patch $sha1 "Could not apply $sha1... $rest"
-		git commit $commit_verbose_flag --amend --no-post-rewrite
+		git commit $commit_verbose_flag --amend --no-post-rewrite ||
+			die_with_patch $sha1 "Cannot amend commit after successfully picking $sha1... $rest"
 		record_in_rewritten $sha1
 		;;
 	edit|e)
-- 
1.7.2.2
