From: Jon Jensen <jon@endpoint.com>
Subject: [PATCH] Add option hooks.emaildiff to include full diff in post-receive-email.
Date: Mon, 11 Aug 2008 15:01:31 -0600
Message-ID: <1218488491-21236-1-git-send-email-jon@endpoint.com>
Cc: Jon Jensen <jon@endpoint.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 11 23:02:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSeXF-0007mZ-Rb
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 23:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753341AbYHKVBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 17:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753528AbYHKVBe
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 17:01:34 -0400
Received: from sb3.endpoint.com ([64.34.193.88]:41780 "EHLO mail.endcrypt.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753091AbYHKVBd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 17:01:33 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mail.endcrypt.com (Postfix) with ESMTP id BEBB23950C6;
	Mon, 11 Aug 2008 21:01:31 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.2.gd827
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92001>

I've always found that a very important part of receiving email
notification of commits is being able to read the diff inline,
easily, where I can reply and quote the diff and make comments.
It's similar to the reason patches sent to the Git mailing list
need to be inline, not attachments.

Since post-receive-email didn't have that option, I added it as a
boolean config variable, hooks.emaildiff.
---
 contrib/hooks/post-receive-email |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 4136895..07351cc 100644
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -38,6 +38,9 @@
 # hooks.emailprefix
 #   All emails have their subjects prefixed with this prefix, or "[SCM]"
 #   if emailprefix is unset, to aid filtering
+# hooks.emaildiff
+#   If set, then a full diff of changes is sent in addition to the default
+#   summary output.
 #
 # Notes
 # -----
@@ -410,8 +413,13 @@ generate_update_branch_email()
 	# - including the undoing of previous revisions in the case of
 	# non-fast forward updates.
 	echo ""
-	echo "Summary of changes:"
-	git diff-tree --stat --summary --find-copies-harder $oldrev..$newrev
+	if [ -n "$emaildiff" ]; then
+		echo "Summary of changes and diff:"
+		git diff-tree --find-copies-harder --stat --summary -p $oldrev..$newrev
+	else
+		echo "Summary of changes:"
+		git diff-tree --find-copies-harder --stat --summary $oldrev..$newrev
+	fi
 }
 
 #
@@ -627,6 +635,7 @@ recipients=$(git config hooks.mailinglist)
 announcerecipients=$(git config hooks.announcelist)
 envelopesender=$(git config hooks.envelopesender)
 emailprefix=$(git config hooks.emailprefix || echo '[SCM] ')
+emaildiff=$(git config hooks.emaildiff)
 
 # --- Main loop
 # Allow dual mode: run from the command line just like the update hook, or
-- 
1.6.0.rc2.2.gd827
