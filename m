From: Fabian Emmes <fabian.emmes@rwth-aachen.de>
Subject: [PATCH 1/2] cvsserver: add option to configure commit message
Date: Fri, 12 Dec 2008 16:24:08 +0100
Message-ID: <1229095449-24755-1-git-send-email-fabian.emmes@rwth-aachen.de>
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, Fabian Emmes <fabian.emmes@rwth-aachen.de>,
	Lars Noschinski <lars@public.noschinski.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 12 16:56:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBAMV-0004zc-KU
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 16:55:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757307AbYLLPyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 10:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757314AbYLLPyP
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 10:54:15 -0500
Received: from mta-2.ms.rz.RWTH-Aachen.DE ([134.130.7.73]:49789 "EHLO
	mta-2.ms.rz.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753027AbYLLPyN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Dec 2008 10:54:13 -0500
X-Greylist: delayed 1800 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Dec 2008 10:54:12 EST
Received: from ironport-out-1.rz.rwth-aachen.de ([134.130.5.40])
 by mta-2.ms.rz.RWTH-Aachen.de
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008))
 with ESMTP id <0KBR004Q3S499H20@mta-2.ms.rz.RWTH-Aachen.de> for
 git@vger.kernel.org; Fri, 12 Dec 2008 16:24:09 +0100 (CET)
X-IronPort-AV: E=Sophos;i="4.36,211,1228086000";   d="scan'208";a="93591619"
Received: from smarthost-1.ms.rz.rwth-aachen.de (HELO smarthost.rwth-aachen.de)
 ([134.130.7.89]) by ironport-in-1.rz.rwth-aachen.de with ESMTP; Fri,
 12 Dec 2008 16:24:09 +0100
Received: from aprove.informatik.rwth-aachen.de
 (aprove.informatik.RWTH-Aachen.DE [137.226.194.201])
	by smarthost.rwth-aachen.de (8.13.8+Sun/8.13.8/1)
 with ESMTP id mBCFO9dY028367; Fri, 12 Dec 2008 16:24:09 +0100 (CET)
Received: by aprove.informatik.rwth-aachen.de (Postfix, from userid 1005)
	id 7BFAE11B745; Fri, 12 Dec 2008 16:24:09 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102907>

cvsserver annotates each commit message by "via git-CVS emulator". This is
made configurable via gitcvs.commitmsgannotation.

Signed-off-by: Fabian Emmes <fabian.emmes@rwth-aachen.de>
Signed-off-by: Lars Noschinski <lars@public.noschinski.de>
---
 Documentation/config.txt |    4 ++++
 git-cvsserver.perl       |    8 +++++++-
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b233fe5..ee937fe 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -723,6 +723,10 @@ gc.rerereunresolved::
 	kept for this many days when 'git-rerere gc' is run.
 	The default is 15 days.  See linkgit:git-rerere[1].
 
+gitcvs.commitmsgannotation::
+	Append this string to each commit message. Set to empty string
+	to disable this feature. Defaults to "via git-CVS emulator".
+
 gitcvs.enabled::
 	Whether the CVS server interface is enabled for this repository.
 	See linkgit:git-cvsserver[1].
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index b0a805c..cbcaeb4 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -1358,7 +1358,13 @@ sub req_ci
     # write our commit message out if we have one ...
     my ( $msg_fh, $msg_filename ) = tempfile( DIR => $TEMP_DIR );
     print $msg_fh $state->{opt}{m};# if ( exists ( $state->{opt}{m} ) );
-    print $msg_fh "\n\nvia git-CVS emulator\n";
+    if ( defined ( $cfg->{gitcvs}{commitmsgannotation} ) ) {
+        if ($cfg->{gitcvs}{commitmsgannotation} !~ /^\s*$/ ) {
+            print $msg_fh "\n\n".$cfg->{gitcvs}{commitmsgannotation}."\n"
+        }
+    } else {
+        print $msg_fh "\n\nvia git-CVS emulator\n";
+    }
     close $msg_fh;
 
     my $commithash = `git-commit-tree $treehash -p $parenthash < $msg_filename`;
-- 
1.6.1.rc2.20.gde0d
