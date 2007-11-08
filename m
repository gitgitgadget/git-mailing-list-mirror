From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] hooks--update: decline deleting tags or branches by default, add config options
Date: Thu, 8 Nov 2007 09:47:39 +0000
Message-ID: <20071108094739.22091.qmail@d736483bdc832c.315fe32.mid.smarden.org>
References: <20071107103450.29849.qmail@c27a4ce40673ff.315fe32.mid.smarden.org> <7v640d8skt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 10:47:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq3z6-0007ck-Gc
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 10:47:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758716AbXKHJrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 04:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758702AbXKHJrU
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 04:47:20 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:47709 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758630AbXKHJrT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 04:47:19 -0500
Received: (qmail 22092 invoked by uid 1000); 8 Nov 2007 09:47:39 -0000
Content-Disposition: inline
In-Reply-To: <7v640d8skt.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63983>

Decline deleting tags or branches through git push <remote> :<ref> by
default, support config options hooks.allowdeletetag, hooks.allowdeletebranch
to override this per repository.

Before this patch the update hook interpreted deleting a tag, no matter if
annotated or not, through git push <remote> :<tag> as unannotated tag, and
declined it by default, but with an unappropriate error message:

 $ git push origin :atag
 deleting 'refs/tags/atag'
 *** The un-annotated tag, atag, is not allowed in this repository
 *** Use 'git tag [ -a | -s ]' for tags you want to propagate.
 ng refs/tags/atag hook declined
 error: hooks/update exited with error code 1
 error: hook declined to update refs/tags/atag
 error: failed to push to 'monolith:/git/qm/test-repo'

Signed-off-by: Gerrit Pape <pape@smarden.org>
---

On Wed, Nov 07, 2007 at 04:54:42PM -0800, Junio C Hamano wrote:
> Since you are allowing deletion for anything, wouldn't this be
> much simpler, I wonder...

Yes, true.  But to be a good axample hook, I suggest to differentiate
this in the implementation, and to deny deleting tags, branches by
default.


 templates/hooks--update |   33 +++++++++++++++++++++++++++++++--
 1 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/templates/hooks--update b/templates/hooks--update
index 65e8c32..7d7c251 100644
--- a/templates/hooks--update
+++ b/templates/hooks--update
@@ -10,6 +10,12 @@
 # hooks.allowunannotated
 #   This boolean sets whether unannotated tags will be allowed into the
 #   repository.  By default they won't be.
+# hooks.allowdeletetag
+#   This boolean sets whether deleting tags will be allowed in the
+#   repository.  By default they won't be.
+# hooks.allowdeletebranch
+#   This boolean sets whether deleting branches will be allowed in the
+#   repository.  By default they won't be.
 #
 
 # --- Command line
@@ -32,6 +38,8 @@ fi
 
 # --- Config
 allowunannotated=$(git-repo-config --bool hooks.allowunannotated)
+allowdeletebranch=$(git-repo-config --bool hooks.allowdeletebranch)
+allowdeletetag=$(git-repo-config --bool hooks.allowdeletetag)
 
 # check for no description
 projectdesc=$(sed -ne '1p' "$GIT_DIR/description")
@@ -41,9 +49,9 @@ if [ -z "$projectdesc" -o "$projectdesc" = "Unnamed repository; edit this file t
 fi
 
 # --- Check types
-# if $newrev is 0000...0000, it's a commit to delete a branch
+# if $newrev is 0000...0000, it's a commit to delete a ref.
 if [ "$newrev" = "0000000000000000000000000000000000000000" ]; then
-	newrev_type=commit
+	newrev_type=delete
 else
 	newrev_type=$(git-cat-file -t $newrev)
 fi
@@ -58,15 +66,36 @@ case "$refname","$newrev_type" in
 			exit 1
 		fi
 		;;
+	refs/tags/*,delete)
+		# delete tag
+		if [ "$allowdeletetag" != "true" ]; then
+			echo "*** Deleting a tag is not allowed in this repository" >&2
+			exit 1
+		fi
+		;;
 	refs/tags/*,tag)
 		# annotated tag
 		;;
 	refs/heads/*,commit)
 		# branch
 		;;
+	refs/heads/*,delete)
+		# delete branch
+		if [ "$allowdeletebranch" != "true" ]; then
+			echo "*** Deleting a branch is not allowed in this repository" >&2
+			exit 1
+		fi
+		;;
 	refs/remotes/*,commit)
 		# tracking branch
 		;;
+	refs/remotes/*,delete)
+		# delete tracking branch
+		if [ "$allowdeletebranch" != "true" ]; then
+			echo "*** Deleting a tracking branch is not allowed in this repository" >&2
+			exit 1
+		fi
+		;;
 	*)
 		# Anything else (is there anything else?)
 		echo "*** Update hook: unknown type of update to ref $refname of type $newrev_type" >&2
-- 
1.5.3.5
