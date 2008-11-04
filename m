From: Pete Harlan <pgit@pcharlan.com>
Subject: [PATCH v2 2/2] contrib/hooks/post-receive-email: Make revision display configurable
Date: Mon,  3 Nov 2008 23:19:54 -0800
Message-ID: <1225783194-24640-3-git-send-email-pgit@pcharlan.com>
References: <1225783194-24640-1-git-send-email-pgit@pcharlan.com>
 <1225783194-24640-2-git-send-email-pgit@pcharlan.com>
Cc: Pete Harlan <pgit@pcharlan.com>
To: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 04 08:21:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxGEE-0007yx-OC
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 08:21:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015AbYKDHT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 02:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752980AbYKDHT6
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 02:19:58 -0500
Received: from lax-green-bigip-5.dreamhost.com ([208.113.200.5]:46331 "EHLO
	swarthymail-a6.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752157AbYKDHT4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Nov 2008 02:19:56 -0500
Received: from localhost.localdomain (031.132-78-65.ftth.swbr.surewest.net [65.78.132.31])
	by swarthymail-a6.g.dreamhost.com (Postfix) with ESMTP id 36E9110656D;
	Mon,  3 Nov 2008 23:19:55 -0800 (PST)
X-Mailer: git-send-email 1.6.0.3.533.ge0502
In-Reply-To: <1225783194-24640-2-git-send-email-pgit@pcharlan.com>
In-Reply-To: <7v7i7kthkc.fsf@gitster.siamese.dyndns.org>
References: <7v7i7kthkc.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100048>

Add configuration option hooks.showrev, letting the user override how
revisions will be shown in the commit email.

Signed-off-by: Pete Harlan <pgit@pcharlan.com>
---
 contrib/hooks/post-receive-email |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 2cd373d..28a3c0e 100644
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
@@ -610,7 +616,16 @@ show_new_revisions()
 	fi
 
 	git rev-parse --not --branches | grep -v $(git rev-parse $refname) |
-	git rev-list --pretty --stdin $revspec
+	if [ -z "$custom_showrev" ]
+	then
+		git rev-list --pretty --stdin $revspec
+	else
+		git rev-list --stdin $revspec |
+		while read onerev
+		do
+			eval $(printf "$custom_showrev" $onerev)
+		done
+	fi
 }
 
 
@@ -650,6 +665,7 @@ recipients=$(git config hooks.mailinglist)
 announcerecipients=$(git config hooks.announcelist)
 envelopesender=$(git config hooks.envelopesender)
 emailprefix=$(git config hooks.emailprefix || echo '[SCM] ')
+custom_showrev=$(git config hooks.showrev)
 
 # --- Main loop
 # Allow dual mode: run from the command line just like the update hook, or
-- 
1.6.0.3.533.ge0502
