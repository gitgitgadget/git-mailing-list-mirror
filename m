From: Pete Harlan <pgit@pcharlan.com>
Subject: [PATCH v2 1/2] contrib/hooks/post-receive-email: Put rev display in separate function
Date: Mon,  3 Nov 2008 23:19:53 -0800
Message-ID: <1225783194-24640-2-git-send-email-pgit@pcharlan.com>
References: <1225783194-24640-1-git-send-email-pgit@pcharlan.com>
Cc: Pete Harlan <pgit@pcharlan.com>
To: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 04 08:21:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxGEF-0007yx-GK
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 08:21:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179AbYKDHUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 02:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753045AbYKDHT7
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 02:19:59 -0500
Received: from lax-green-bigip-5.dreamhost.com ([208.113.200.5]:46333 "EHLO
	swarthymail-a6.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752015AbYKDHT4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Nov 2008 02:19:56 -0500
Received: from localhost.localdomain (031.132-78-65.ftth.swbr.surewest.net [65.78.132.31])
	by swarthymail-a6.g.dreamhost.com (Postfix) with ESMTP id 0EDD51063F4;
	Mon,  3 Nov 2008 23:19:55 -0800 (PST)
X-Mailer: git-send-email 1.6.0.3.533.ge0502
In-Reply-To: <1225783194-24640-1-git-send-email-pgit@pcharlan.com>
In-Reply-To: <7v7i7kthkc.fsf@gitster.siamese.dyndns.org>
References: <7v7i7kthkc.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100049>

The display of a revision in an email-appropriate format is done in
two places with similar code.  In preparation for making that display
more complex, move it into a separate function that handles both cases.

Signed-off-by: Pete Harlan <pgit@pcharlan.com>
---
 contrib/hooks/post-receive-email |   41 +++++++++++++++++++++++++++++--------
 1 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 4136895..2cd373d 100644
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -224,13 +224,7 @@ generate_create_branch_email()
 	echo ""
 
 	echo $LOGBEGIN
-	# This shows all log entries that are not already covered by
-	# another ref - i.e. commits that are now accessible from this
-	# ref that were previously not accessible
-	# (see generate_update_branch_email for the explanation of this
-	# command)
-	git rev-parse --not --branches | grep -v $(git rev-parse $refname) |
-	git rev-list --pretty --stdin $newrev
+	show_new_revisions
 	echo $LOGEND
 }
 
@@ -390,8 +384,7 @@ generate_update_branch_email()
 
 		echo ""
 		echo $LOGBEGIN
-		git rev-parse --not --branches | grep -v $(git rev-parse $refname) |
-		git rev-list --pretty --stdin $oldrev..$newrev
+		show_new_revisions
 
 		# XXX: Need a way of detecting whether git rev-list actually
 		# outputted anything, so that we can issue a "no new
@@ -591,6 +584,36 @@ generate_delete_general_email()
 	echo $LOGEND
 }
 
+
+# --------------- Miscellaneous utilities
+
+#
+# Show new revisions as the user would like to see them in the email.
+#
+show_new_revisions()
+{
+	# This shows all log entries that are not already covered by
+	# another ref - i.e. commits that are now accessible from this
+	# ref that were previously not accessible
+	# (see generate_update_branch_email for the explanation of this
+	# command)
+
+	# Revision range passed to rev-list differs for new vs. updated
+	# branches.
+	if [ "$change_type" = create ]
+	then
+		# Show all revisions exclusive to this (new) branch.
+		revspec=$newrev
+	else
+		# Branch update; show revisions not part of $oldrev.
+		revspec=$oldrev..$newrev
+	fi
+
+	git rev-parse --not --branches | grep -v $(git rev-parse $refname) |
+	git rev-list --pretty --stdin $revspec
+}
+
+
 send_mail()
 {
 	if [ -n "$envelopesender" ]; then
-- 
1.6.0.3.533.ge0502
