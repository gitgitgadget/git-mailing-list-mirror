From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] hooks--update: allow deleting a tag through git push <remote> :<tag>
Date: Wed, 7 Nov 2007 10:34:50 +0000
Message-ID: <20071107103450.29849.qmail@c27a4ce40673ff.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 11:34:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpiFD-00052O-So
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 11:34:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753290AbXKGKed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 05:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752460AbXKGKec
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 05:34:32 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:41945 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751673AbXKGKec (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 05:34:32 -0500
Received: (qmail 29850 invoked by uid 1000); 7 Nov 2007 10:34:50 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63802>

The update hook interpretes deleting a tag, no matter if annotated or not,
through git push <remote> :<tag> as unannotated tag, and declines it by
default:

 $ git push origin :atag
 deleting 'refs/tags/atag'
 *** The un-annotated tag, atag, is not allowed in this repository
 *** Use 'git tag [ -a | -s ]' for tags you want to propagate.
 ng refs/tags/atag hook declined
 error: hooks/update exited with error code 1
 error: hook declined to update refs/tags/atag
 error: failed to push to 'monolith:/git/qm/test-repo'

With this patch deleting a tag is allowed unconditionally, just as
deleting a branch.

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 templates/hooks--update |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/templates/hooks--update b/templates/hooks--update
index 65e8c32..a109b1b 100644
--- a/templates/hooks--update
+++ b/templates/hooks--update
@@ -43,7 +43,7 @@ fi
 # --- Check types
 # if $newrev is 0000...0000, it's a commit to delete a branch
 if [ "$newrev" = "0000000000000000000000000000000000000000" ]; then
-	newrev_type=commit
+	newrev_type=delete
 else
 	newrev_type=$(git-cat-file -t $newrev)
 fi
@@ -58,13 +58,16 @@ case "$refname","$newrev_type" in
 			exit 1
 		fi
 		;;
+	refs/tags/*,delete)
+		# delete tag
+		;;
 	refs/tags/*,tag)
 		# annotated tag
 		;;
-	refs/heads/*,commit)
+	refs/heads/*,commit | refs/heads/*,delete)
 		# branch
 		;;
-	refs/remotes/*,commit)
+	refs/remotes/*,commit | refs/remotes/*,delete)
 		# tracking branch
 		;;
 	*)
-- 
1.5.3.5
