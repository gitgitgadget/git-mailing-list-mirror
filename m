From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] hooks--update: new, optional, config variable: hooks.envelopesender
Date: Sat, 24 Mar 2007 20:58:42 +0100
Message-ID: <87slbu2z2l.fsf_-_@rho.meyering.net>
References: <874poc88ix.fsf@rho.meyering.net>
	<200703231615.28350.andyparkins@gmail.com>
	<87wt1651bj.fsf@rho.meyering.net>
	<200703241216.48177.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 24 20:58:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVCNy-0001W5-Ek
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 20:58:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932848AbXCXT6o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 15:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932873AbXCXT6o
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 15:58:44 -0400
Received: from mx.meyering.net ([82.230.74.64]:35815 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932848AbXCXT6n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 15:58:43 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 87C2271EA; Sat, 24 Mar 2007 20:58:42 +0100 (CET)
In-Reply-To: <200703241216.48177.andyparkins@gmail.com> (Andy Parkins's
	message of "Sat, 24 Mar 2007 12:16:35 +0000")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43014>

This change adds a new, optional, config variable: hooks.envelopesender.
When set, the "update" hook uses its value with sendmail's -f option.

Signed-off-by: Jim Meyering <jim@meyering.net>
---
 templates/hooks--update |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/templates/hooks--update b/templates/hooks--update
index 1a60773..02e2494 100644
--- a/templates/hooks--update
+++ b/templates/hooks--update
@@ -12,6 +12,11 @@
 #   This is the list that all pushes will go to; leave it blank to not send
 #   emails frequently.  The log email will list every log entry in full between
 #   the old ref value and the new ref value.
+# hooks.envelopesender
+#   Use this email address as the envelope sender (argument to sendmail's
+#   -f option).  This is not the "From:" address.  This can be useful to
+#   ensure that all delivery problem notifications go to the same, known-
+#   working address.
 # hooks.announcelist
 #   This is the list that all pushes of annotated tags will go to.  Leave it
 #   blank to just use the mailinglist field.  The announce emails list the
@@ -52,10 +57,15 @@ fi

 # --- Config
 projectdesc=$(cat $GIT_DIR/description)
+envelope_sender=$(git-repo-config hooks.envelopesender)
 recipients=$(git-repo-config hooks.mailinglist)
 announcerecipients=$(git-repo-config hooks.announcelist)
 allowunannotated=$(git-repo-config --bool hooks.allowunannotated)

+if [ -n "$envelope_sender" ]; then
+	envelope_sender_option="-f '$envelope_sender'"
+fi
+
 # check for no description
 if [ -z "$projectdesc" -o "$projectdesc" = "Unnamed repository; edit this file to name it for gitweb" ]; then
 	echo "*** Project description file hasn't been set" >&2
@@ -285,7 +295,7 @@ $0 $1 \\
   $3
 EOF
 #) | cat >&2
-) | /usr/sbin/sendmail -t
+) | eval /usr/sbin/sendmail $envelope_sender_option -t

 # --- Finished
 exit 0
