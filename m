From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] contrib/subtree: don't delete remote branches if split fails
Date: Wed,  1 May 2013 09:25:52 +0100
Message-ID: <397ab75eeb9d1c60f418b1ded23d8de04cf16251.1367396752.git.john@keeping.me.uk>
Cc: "David A. Greene" <greened@obbligato.org>,
	Steffen Jaeckel <steffen.jaeckel@stzedn.de>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 01 10:26:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXSMe-0000O5-Nv
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 10:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754148Ab3EAI0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 04:26:09 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:40553 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab3EAI0G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 04:26:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id B4B86606565;
	Wed,  1 May 2013 09:26:04 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BG7HsMy7Nw-u; Wed,  1 May 2013 09:26:04 +0100 (BST)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 20491606507;
	Wed,  1 May 2013 09:25:57 +0100 (BST)
X-Mailer: git-send-email 1.8.3.rc0.149.g98a72f2.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223074>

When using "git subtree push" to split out a subtree and push it to a
remote repository, we do not detect if the split command fails which
causes the LHS of the refspec to be empty, deleting the remote branch.

Fix this by pulling the result of the split command into a variable so
that we can die if the command fails.

Reported-by: Steffen Jaeckel <steffen.jaeckel@stzedn.de>
Signed-off-by: John Keeping <john@keeping.me.uk>
---
 contrib/subtree/git-subtree.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 8a23f58..10daa8b 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -715,7 +715,8 @@ cmd_push()
 	    repository=$1
 	    refspec=$2
 	    echo "git push using: " $repository $refspec
-	    git push $repository $(git subtree split --prefix=$prefix):refs/heads/$refspec
+	    localrev=$(git subtree split --prefix="$prefix") || die
+	    git push $repository $localrev:refs/heads/$refspec
 	else
 	    die "'$dir' must already exist. Try 'git subtree add'."
 	fi
-- 
1.8.3.rc0.149.g98a72f2.dirty
