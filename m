From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] hooks--update: new, required, config variable: hooks.envelopesender,
Date: Fri, 23 Mar 2007 13:11:02 +0100
Message-ID: <874poc88ix.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 13:11:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUibv-0000It-Q1
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 13:11:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422829AbXCWMLG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 08:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422833AbXCWMLG
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 08:11:06 -0400
Received: from mx.meyering.net ([82.230.74.64]:49524 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422829AbXCWMLF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 08:11:05 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id C56FA6BF0; Fri, 23 Mar 2007 13:11:02 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42927>

This change adds a new, required, config variable: hooks.envelopesender,
and use that with sendmail's -f option.  This is important in order
to avoid relying on sendmail's "guess" at an appropriate envelope
sender address.  Without this, and in the presence of strict servers,
it is far too easy not ever to be notified, or (more insidious) never
to receive bounce email.

Below, I've included an additional patch in case you want
to require the envelopesender setting only when at least one of the
mailing list variables is set.

Signed-off-by: Jim Meyering <jim@meyering.net>
---
 templates/hooks--update |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/templates/hooks--update b/templates/hooks--update
index 8f6c4fe..bc1f1a9 100644
--- a/templates/hooks--update
+++ b/templates/hooks--update
@@ -12,6 +12,10 @@
 #   This is the list that all pushes will go to; leave it blank to not send
 #   emails frequently.  The log email will list every log entry in full between
 #   the old ref value and the new ref value.
+# hooks.envelopesender
+#   Use this email address as the envelope sender (argument to sendmail's
+#   -f option).  This is not the "From:" address.  This should be a useful
+#   email address within your organization.  Required.
 # hooks.announcelist
 #   This is the list that all pushes of annotated tags will go to.  Leave it
 #   blank to just use the mailinglist field.  The announce emails list the
@@ -52,10 +56,16 @@ fi
 
 # --- Config
 projectdesc=$(cat $GIT_DIR/description)
+envelope_sender=$(git-repo-config hooks.envelopesender)
 recipients=$(git-repo-config hooks.mailinglist)
 announcerecipients=$(git-repo-config hooks.announcelist)
 allowunannotated=$(git-repo-config --bool hooks.allowunannotated)
 
+if [ -z "$envelope_sender" ]; then
+	echo "Usage: hooks.envelopesender must be set in config" >&2
+	exit 1
+fi
+
 # --- Check types
 newrev_type=$(git-cat-file -t $newrev)
 
@@ -279,7 +289,7 @@ $0 $1 \\
   $3
 EOF
 #) | cat >&2
-) | /usr/sbin/sendmail -t
+) | /usr/sbin/sendmail -f "$envelope_sender" -t
 
 # --- Finished
 exit 0
-- 
1.5.1.rc1


>From 4b3d42890b2b33b2f34902d26561b78e5e92ddba Mon Sep 17 00:00:00 2001
From: Jim Meyering <jim@meyering.net>
Date: Fri, 23 Mar 2007 13:06:00 +0100
Subject: [PATCH] Fail upon undefined envelopesender only if at least one of
the mailing list variables is set.

Signed-off-by: Jim Meyering <jim@meyering.net>
---
 templates/hooks--update |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/templates/hooks--update b/templates/hooks--update
index bc1f1a9..c79b4b4 100644
--- a/templates/hooks--update
+++ b/templates/hooks--update
@@ -61,9 +61,11 @@ recipients=$(git-repo-config hooks.mailinglist)
 announcerecipients=$(git-repo-config hooks.announcelist)
 allowunannotated=$(git-repo-config --bool hooks.allowunannotated)
 
-if [ -z "$envelope_sender" ]; then
-	echo "Usage: hooks.envelopesender must be set in config" >&2
-	exit 1
+if [ -n "$recipients$announcerecipients" ]; then
+	if [ -z "$envelope_sender" ]; then
+		echo "Usage: hooks.envelopesender must be set in config" >&2
+		exit 1
+	fi
 fi
 
 # --- Check types
-- 
1.5.1.rc1
