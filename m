From: Fabian Emmes <fabian.emmes@rwth-aachen.de>
Subject: [PATCH] cvsserver: change generation of CVS author names
Date: Fri, 02 Jan 2009 16:40:14 +0100
Message-ID: <1230910814-32307-2-git-send-email-fabian.emmes@rwth-aachen.de>
References: <1230910814-32307-1-git-send-email-fabian.emmes@rwth-aachen.de>
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, Fabian Emmes <fabian.emmes@rwth-aachen.de>,
	Lars Noschinski <lars@public.noschinski.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 02 16:41:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIm9p-0006IM-Mp
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 16:41:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756896AbZABPkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 10:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756857AbZABPkV
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 10:40:21 -0500
Received: from mta-1.ms.rz.RWTH-Aachen.DE ([134.130.7.72]:51560 "EHLO
	mta-1.ms.rz.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756811AbZABPkS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Jan 2009 10:40:18 -0500
Received: from ironport-out-1.rz.rwth-aachen.de ([134.130.5.40])
 by mta-1.ms.rz.RWTH-Aachen.de
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008))
 with ESMTP id <0KCU00F5TOV1DH80@mta-1.ms.rz.RWTH-Aachen.de> for
 git@vger.kernel.org; Fri, 02 Jan 2009 16:40:13 +0100 (CET)
X-IronPort-AV: E=Sophos;i="4.36,318,1228086000";   d="scan'208";a="95263152"
Received: from smarthost-1.ms.rz.rwth-aachen.de (HELO smarthost.rwth-aachen.de)
 ([134.130.7.89]) by ironport-in-1.rz.rwth-aachen.de with ESMTP; Fri,
 02 Jan 2009 16:40:14 +0100
Received: from aprove.informatik.rwth-aachen.de
 (aprove.informatik.RWTH-Aachen.DE [137.226.194.201])
	by smarthost.rwth-aachen.de (8.13.8+Sun/8.13.8/1)
 with ESMTP id n02FeDDN000870; Fri, 02 Jan 2009 16:40:13 +0100 (CET)
Received: by aprove.informatik.rwth-aachen.de (Postfix, from userid 1005)
	id B025711B760; Fri, 02 Jan 2009 16:40:14 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2
In-reply-to: <1230910814-32307-1-git-send-email-fabian.emmes@rwth-aachen.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104383>

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
1.5.6.3
