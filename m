From: Fabian Emmes <fabian.emmes@rwth-aachen.de>
Subject: [PATCH 2/2] cvsserver: change generation of CVS author names
Date: Fri, 12 Dec 2008 16:24:09 +0100
Message-ID: <1229095449-24755-2-git-send-email-fabian.emmes@rwth-aachen.de>
References: <1229095449-24755-1-git-send-email-fabian.emmes@rwth-aachen.de>
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, Fabian Emmes <fabian.emmes@rwth-aachen.de>,
	Lars Noschinski <lars@public.noschinski.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 12 16:55:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBAMU-0004zc-SW
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 16:55:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757110AbYLLPyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 10:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756857AbYLLPyN
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 10:54:13 -0500
Received: from mta-2.ms.rz.RWTH-Aachen.DE ([134.130.7.73]:49789 "EHLO
	mta-2.ms.rz.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752808AbYLLPyM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Dec 2008 10:54:12 -0500
X-Greylist: delayed 1800 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Dec 2008 10:54:12 EST
Received: from ironport-out-1.rz.rwth-aachen.de ([134.130.5.40])
 by mta-2.ms.rz.RWTH-Aachen.de
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008))
 with ESMTP id <0KBR004Q3S499H20@mta-2.ms.rz.RWTH-Aachen.de> for
 git@vger.kernel.org; Fri, 12 Dec 2008 16:24:09 +0100 (CET)
X-IronPort-AV: E=Sophos;i="4.36,211,1228086000";   d="scan'208";a="93591618"
Received: from smarthost-1.ms.rz.rwth-aachen.de (HELO smarthost.rwth-aachen.de)
 ([134.130.7.89]) by ironport-in-1.rz.rwth-aachen.de with ESMTP; Fri,
 12 Dec 2008 16:24:09 +0100
Received: from aprove.informatik.rwth-aachen.de
 (aprove.informatik.RWTH-Aachen.DE [137.226.194.201])
	by smarthost.rwth-aachen.de (8.13.8+Sun/8.13.8/1)
 with ESMTP id mBCFO9rv028368; Fri, 12 Dec 2008 16:24:09 +0100 (CET)
Received: by aprove.informatik.rwth-aachen.de (Postfix, from userid 1005)
	id 814A711B744; Fri, 12 Dec 2008 16:24:09 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2
In-reply-to: <1229095449-24755-1-git-send-email-fabian.emmes@rwth-aachen.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102906>

CVS username is generated from local part email address.
We take the whole local part but restrict the character set to the
Portable Filename Character Set, which is used for Unix login names
according to Single Unix Specification v3.

Signed-off-by: Fabian Emmes <fabian.emmes@rwth-aachen.de>
Signed-off-by: Lars Noschinski <lars@public.noschinski.de>
---
 git-cvsserver.perl |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index cbcaeb4..fef7faf 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -2533,12 +2533,18 @@ sub open_blob_or_die
     return $fh;
 }
 
-# Generate a CVS author name from Git author information, by taking
-# the first eight characters of the user part of the email address.
+# Generate a CVS author name from Git author information, by taking the local
+# part of the email address and replacing characters not in the Portable
+# Filename Character Set (see IEEE Std 1003.1-2001, 3.276) by underscores. CVS
+# Login names are Unix login names, which should be restricted to this
+# character set.
 sub cvs_author
 {
     my $author_line = shift;
-    (my $author) = $author_line =~ /<([^>@]{1,8})/;
+    (my $author) = $author_line =~ /<([^@>]*)/;
+
+    $author =~ s/[^-a-zA-Z0-9_.]/_/g;
+    $author =~ s/^-/_/;
 
     $author;
 }
-- 
1.6.1.rc2.20.gde0d
