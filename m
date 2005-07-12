From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: [PATCH] cg-commit chokes when given a very large list of files
Date: Tue, 12 Jul 2005 07:20:25 -0400
Message-ID: <20050712112012.23805.32745.sendpatchset@bryan-larsens-ibook-g4.local>
Cc: Bryan Larsen <bryanlarsen@yahoo.com>, pasky@suse.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 13:22:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsIp1-00049e-16
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 13:21:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVGLLUg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 07:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVGLLUe
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 07:20:34 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:2731 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261340AbVGLLUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2005 07:20:25 -0400
Received: (qmail 45342 invoked from network); 12 Jul 2005 11:20:18 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Message-Id:Subject;
  b=CGEbxVwKWYZJ+GD+o3BwM4hDdHyN9Yu39Y0QLFV6e7PWr/LcIo59UH3np1c4QS+nI6eGNt2U+l0LHx5aMCRcczJ8iN/KQsVr7o7TtSXe3jeWFq2mQ7CMzER7TEn7dO0CgO7RxLJpOoHrPtXO7Tawqe0NiH8n502AVVu5cLhUrT0=  ;
Received: from unknown (HELO bryan-larsens-ibook-g4.local) (bryanlarsen@69.159.204.165 with plain)
  by smtp105.mail.sc5.yahoo.com with SMTP; 12 Jul 2005 11:20:18 -0000
To: bryan.larsen@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

cg-commit currently chokes when passed a very large list of files.  Fix it.

This patch depends on your filenames not containing line feeds.  No big deal, lots of other parts of cogito break on filenames containing line feeds.

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

 cg-commit |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/cg-commit b/cg-commit
--- a/cg-commit
+++ b/cg-commit
@@ -288,10 +288,12 @@ precommit_update () {
 		[ "$op" = "N" ] || [ "$op" = "D" ] || [ "$op" = "M" ] || op=M
 		eval "queue$op[\${#queue$op[@]}]=\"\$fname\""
 	done
+	IFS=$'\n'
 	# XXX: Do we even need to do the --add and --remove update-caches?
-	[ "$queueN" ] && { git-update-cache --add ${infoonly} -- "${queueN[@]}" || return 1; }
-	[ "$queueD" ] && { git-update-cache --force-remove -- "${queueD[@]}" || return 1; }
-	[ "$queueM" ] && { git-update-cache ${infoonly} -- "${queueM[@]}" || return 1; }
+	[ "$queueN" ] && { ( echo "${queueN[*]}" | tr \\n \\0 | xargs -0 git-update-cache --add ${infoonly} -- ) || return 1; }
+	[ "$queueD" ] && { ( echo "${queueD[*]}" | tr \\n \\0 | xargs -0 git-update-cache --force-remove -- ) || return 1;  }
+	[ "$queueM" ] && { ( echo "${queueM[*]}" | tr \\n \\0 | xargs -0 git-update-cache ${infoonly} -- ) || return 1; }
+	IFS=$' \n\t'
 	return 0
 }
 
