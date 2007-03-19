From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH 3/5] cvsserver: Allow to override the configuration per access method
Date: Mon, 19 Mar 2007 16:55:59 +0100
Message-ID: <11743197613605-git-send-email-frank@lichtenheld.de>
References: <11743197614111-git-send-email-frank@lichtenheld.de>
Cc: Frank Lichtenheld <frank@lichtenheld.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 19 17:00:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTKHV-0003Q1-CA
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 17:00:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030269AbXCSQAT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 12:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbXCSQAT
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 12:00:19 -0400
Received: from mail.lenk.info ([217.160.134.107]:62959 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030269AbXCSQAS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 12:00:18 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HTKEL-000473-17; Mon, 19 Mar 2007 16:57:05 +0100
Received: from p54b0eb28.dip.t-dialin.net ([84.176.235.40] helo=goedel.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HTKE1-0005ue-4p; Mon, 19 Mar 2007 16:56:45 +0100
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1HTKDJ-0005vo-KM; Mon, 19 Mar 2007 16:56:01 +0100
X-Mailer: git-send-email 1.5.0.3
In-Reply-To: <11743197614111-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42630>

Allow to override the gitcvs.enabled and gitcvs.logfile configuration
variables for each access method (i.e. "ext" or "pserver") in the
form gitcvs.<method>.<var>

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 Documentation/git-cvsserver.txt |   12 ++++++++++++
 git-cvsserver.perl              |   10 +++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 85d0950..6904aad 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -68,6 +68,18 @@ Note: you need to ensure each user that is going to invoke git-cvsserver has
 write access to the log file and to the git repository. When offering anon
 access via pserver, this means that the nobody user should have write access
 to at least the sqlite database at the root of the repository.
+
+Both configuration variables can also be overriden for a specific method of
+access. Valid method names are "ext" (for SSH access) and "pserver". The
+following example configuration would disable pserver access while still
+allowing access over SSH.
+------
+   [gitcvs]
+        enabled=0
+
+   [gitcvs "ext"]
+        enabled=1
+------
 --
 3. On the client machine you need to set the following variables.
    CVSROOT should be set as per normal, but the directory should point at the
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 4edb796..5d2b6f3 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -191,7 +191,10 @@ sub req_Root
         }
     }
 
-    unless ( defined ( $cfg->{gitcvs}{enabled} ) and $cfg->{gitcvs}{enabled} =~ /^\s*(1|true|yes)\s*$/i )
+    unless ( ($cfg->{gitcvs}{$state->{method}}{enabled}
+	      and $cfg->{gitcvs}{$state->{method}}{enabled} =~ /^\s*(1|true|yes)\s*$/i)
+	     or ($cfg->{gitcvs}{enabled}
+	      and $cfg->{gitcvs}{enabled} =~ /^\s*(1|true|yes)\s*$/i) )
     {
         print "E GITCVS emulation needs to be enabled on this repo\n";
         print "E the repo config file needs a [gitcvs] section added, and the parameter 'enabled' set to 1\n";
@@ -200,9 +203,10 @@ sub req_Root
         return 0;
     }
 
-    if ( defined ( $cfg->{gitcvs}{logfile} ) )
+    my $logfile = $cfg->{gitcvs}{$state->{method}}{logfile} || $cfg->{gitcvs}{logfile};
+    if ( $logfile )
     {
-        $log->setfile($cfg->{gitcvs}{logfile});
+        $log->setfile($logfile);
     } else {
         $log->nofile();
     }
-- 
1.5.0.3
