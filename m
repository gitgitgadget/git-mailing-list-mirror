From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH] t3407: make reflog check stricter
Date: Sun, 21 Nov 2010 20:20:34 +0100
Message-ID: <1290367234-8206-1-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1290337881-26449-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 22 02:21:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKL5o-0005MY-Lq
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 02:21:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755995Ab0KVBVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Nov 2010 20:21:09 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39241 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755726Ab0KVBVI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Nov 2010 20:21:08 -0500
Received: by vws13 with SMTP id 13so3214487vws.19
        for <git@vger.kernel.org>; Sun, 21 Nov 2010 17:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=oRnIT1c9ISnP7EMV6CYbD7TW4AaeujAM4Yq0QGNr/DA=;
        b=XIuhvk3SyGWvzmpSt6PlfIU8pLvpzq7+Lq03qFE7i1V5+AwpZ++kqD0aS/4iLn5HgK
         GpoHJCYf1ERTIk7St/N6WQ/ZkjJXAymA5eSHZ5bwH2f6pNhH+S+5/RxVOe37ceLBXajN
         8vRd+N0BZ+0UGG6N+phqBqlHp9DZyluzQ+NX4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CO6zOVDqBKYsMUFRkvbWCbWSfcDTxMaS0yZdWd9J2m7S3PfUtQd8xjApmlqHuSAz37
         ayUNKAckb1kEWd8hm22FUhrMHX7CmUKLDjiaW2pviUOV/YDY7Uq0szMXMCQwPaRUXm/U
         uBVotMh2CFm/SRFVw8e9JAJqeXVYjZGJ/WIY0=
Received: by 10.220.159.196 with SMTP id k4mr1291404vcx.196.1290388866696;
        Sun, 21 Nov 2010 17:21:06 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id c40sm872039vcs.25.2010.11.21.17.21.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Nov 2010 17:21:06 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.190.gfb4ae
In-Reply-To: <1290337881-26449-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161877>

---
This is hopefully an improvement to the test case. Please squash with
previous patch if you agree.

 t/t3407-rebase-abort.sh |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index f3250c3..e573dc8 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -77,11 +77,12 @@ testrebase() {
 		cd "$work_dir" &&
 		# Clean up the state from the previous one
 		git reset --hard pre-rebase &&
-		reflog_entries_before=$(git reflog show to-rebase | wc -l) &&
+		git reflog show to-rebase > reflog_before &&
 		test_must_fail git rebase$type master &&
 		git rebase --abort &&
-		reflog_entries_after=$(git reflog show to-rebase | wc -l) &&
-		test $reflog_entries_before -eq $reflog_entries_after
+		git reflog show to-rebase > reflog_after &&
+		test_cmp reflog_before reflog_after &&
+		rm reflog_before reflog_after
 	'
 }
 
-- 
1.7.3.2.190.gfb4ae
