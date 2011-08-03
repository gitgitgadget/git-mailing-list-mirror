From: Jon Jensen <jon@endpoint.com>
Subject: [PATCH] Add option hooks.emaildiff to include full diff in
 post-receive-email
Date: Tue, 2 Aug 2011 21:34:48 -0600 (MDT)
Message-ID: <alpine.DEB.2.02.1108022132230.3386@ybpnyubfg6.ybpnyqbznva6>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 06:01:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoSeI-0005ZT-5u
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 06:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129Ab1HCEBc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 00:01:32 -0400
Received: from mail.endcrypt.com ([74.205.105.202]:43790 "EHLO
	mail.endcrypt.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821Ab1HCEB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 00:01:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.endcrypt.com (Postfix) with ESMTP id AAD4330891
	for <git@vger.kernel.org>; Wed,  3 Aug 2011 03:34:50 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178537>

I've always found that a very important part of receiving email
notification of commits is being able to read the diff inline,
easily, where I can reply and quote the diff and make comments.
It's similar to the reason patches sent to the Git mailing list
need to be inline, not attachments.

Since post-receive-email didn't have that option, this adds it as a
boolean config variable, hooks.emaildiff.

Signed-off-by: Jon Jensen <jon@endpoint.com>
---
 contrib/hooks/post-receive-email |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 21989fc..5b9b26d 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -60,6 +60,9 @@
 #   email body. If not specified, there is no limit.
 #   Lines beyond the limit are suppressed and counted, and a final
 #   line is added indicating the number of suppressed lines.
+# hooks.emaildiff
+#   If set, then a full diff of changes is sent in addition to the default
+#   summary output.
 #
 # Notes
 # -----
@@ -445,8 +448,13 @@ generate_update_branch_email()
 	# - including the undoing of previous revisions in the case of
 	# non-fast-forward updates.
 	echo ""
-	echo "Summary of changes:"
-	git diff-tree --stat --summary --find-copies-harder $oldrev..$newrev
+	if [ -n "$emaildiff" ]; then
+		echo "Summary of changes and diff:"
+		git diff-tree --stat --summary --find-copies-harder -p $oldrev..$newrev
+	else
+		echo "Summary of changes:"
+		git diff-tree --stat --summary --find-copies-harder $oldrev..$newrev
+	fi
 }
 
 #
@@ -723,6 +731,7 @@ envelopesender=$(git config hooks.envelopesender)
 emailprefix=$(git config hooks.emailprefix || echo '[SCM] ')
 custom_showrev=$(git config hooks.showrev)
 maxlines=$(git config hooks.emailmaxlines)
+emaildiff=$(git config hooks.emaildiff)
 
 # --- Main loop
 # Allow dual mode: run from the command line just like the update hook, or
-- 
1.7.6.233.gd79bc
