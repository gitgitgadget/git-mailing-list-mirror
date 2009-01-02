From: Fabian Emmes <fabian.emmes@rwth-aachen.de>
Subject: [PATCH] cvsserver: add option to configure commit message
Date: Fri, 02 Jan 2009 16:40:13 +0100
Message-ID: <1230910814-32307-1-git-send-email-fabian.emmes@rwth-aachen.de>
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, Fabian Emmes <fabian.emmes@rwth-aachen.de>,
	Lars Noschinski <lars@public.noschinski.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 02 16:41:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIm9q-0006IM-DO
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 16:41:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756858AbZABPkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 10:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbZABPkW
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 10:40:22 -0500
Received: from mta-2.ms.rz.RWTH-Aachen.DE ([134.130.7.73]:33575 "EHLO
	mta-2.ms.rz.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756833AbZABPkS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Jan 2009 10:40:18 -0500
Received: from ironport-out-2.rz.rwth-aachen.de ([134.130.5.41])
 by mta-2.ms.rz.RWTH-Aachen.de
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008))
 with ESMTP id <0KCU00LBBOV1H480@mta-2.ms.rz.RWTH-Aachen.de> for
 git@vger.kernel.org; Fri, 02 Jan 2009 16:40:13 +0100 (CET)
X-IronPort-AV: E=Sophos;i="4.36,318,1228086000";   d="scan'208";a="63471057"
Received: from smarthost-1.ms.rz.rwth-aachen.de (HELO smarthost.rwth-aachen.de)
 ([134.130.7.89]) by ironport-in-2.rz.rwth-aachen.de with ESMTP; Fri,
 02 Jan 2009 16:40:13 +0100
Received: from aprove.informatik.rwth-aachen.de
 (aprove.informatik.RWTH-Aachen.DE [137.226.194.201])
	by smarthost.rwth-aachen.de (8.13.8+Sun/8.13.8/1)
 with ESMTP id n02FeDKG000869; Fri, 02 Jan 2009 16:40:13 +0100 (CET)
Received: by aprove.informatik.rwth-aachen.de (Postfix, from userid 1005)
	id AA16A11B7C4; Fri, 02 Jan 2009 16:40:14 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104384>

cvsserver annotates each commit message by "via git-CVS emulator". This is
made configurable via gitcvs.commitmsgannotation.

Signed-off-by: Fabian Emmes <fabian.emmes@rwth-aachen.de>
Signed-off-by: Lars Noschinski <lars@public.noschinski.de>
---
 Documentation/config.txt |    4 ++++
 git-cvsserver.perl       |    8 +++++++-
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7408bb2..8b14d8a 100644
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
1.5.6.3
