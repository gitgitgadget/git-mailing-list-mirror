From: Pete Harlan <pgit@pcharlan.com>
Subject: [PATCH] contrib/hooks/post-receive-email: Make revision display configurable
Date: Sun,  2 Nov 2008 15:20:59 -0800
Message-ID: <1225668059-12670-1-git-send-email-pgit@pcharlan.com>
Cc: Pete Harlan <pgit@pcharlan.com>
To: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 00:22:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwmGt-0000nX-KE
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 00:22:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753705AbYKBXVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 18:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753702AbYKBXVB
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 18:21:01 -0500
Received: from lax-green-bigip-5.dreamhost.com ([208.113.200.5]:40207 "EHLO
	swarthymail-a3.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753699AbYKBXVA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Nov 2008 18:21:00 -0500
Received: from localhost.localdomain (031.132-78-65.ftth.swbr.surewest.net [65.78.132.31])
	by swarthymail-a3.g.dreamhost.com (Postfix) with ESMTP id 7BE4F7F051;
	Sun,  2 Nov 2008 15:20:59 -0800 (PST)
X-Mailer: git-send-email 1.6.0.3.533.ge0502
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99886>

Add configuration option hooks.showrev, letting the user override how
revisions will be shown in the commit email.

Signed-off-by: Pete Harlan <pgit@pcharlan.com>
---

This allows, for example, to show full diffs in the post-receive email
to simply after-the-fact reviewing of commits.  Perhaps others would
find this useful also.

 contrib/hooks/post-receive-email |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 4136895..a365c3f 100644
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -38,6 +38,12 @@
 # hooks.emailprefix
 #   All emails have their subjects prefixed with this prefix, or "[SCM]"
 #   if emailprefix is unset, to aid filtering
+# hooks.showrev
+#   The shell command used to format each revision in the email, with
+#   "%s" replaced with the commit id.  Defaults to "git rev-list -1
+#   --pretty %s", displaying the commit id, author, date and log
+#   message.  To list full patches separated by a blank line, you
+#   could set this to "git show -C %s; echo".
 #
 # Notes
 # -----
@@ -390,8 +396,13 @@ generate_update_branch_email()
 
 		echo ""
 		echo $LOGBEGIN
-		git rev-parse --not --branches | grep -v $(git rev-parse $refname) |
-		git rev-list --pretty --stdin $oldrev..$newrev
+		git rev-parse --not --branches |
+			grep -v $(git rev-parse $refname) |
+			git rev-list --stdin $oldrev..$newrev |
+		while read onerev
+		do
+			eval $(printf "$showrev" $onerev)
+		done
 
 		# XXX: Need a way of detecting whether git rev-list actually
 		# outputted anything, so that we can issue a "no new
@@ -627,6 +638,7 @@ recipients=$(git config hooks.mailinglist)
 announcerecipients=$(git config hooks.announcelist)
 envelopesender=$(git config hooks.envelopesender)
 emailprefix=$(git config hooks.emailprefix || echo '[SCM] ')
+showrev=$(git config hooks.showrev || echo 'git rev-list -1 --pretty %s')
 
 # --- Main loop
 # Allow dual mode: run from the command line just like the update hook, or
-- 
1.6.0.3.533.ge0502
