From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH 1/2] git-branch: improve abbreviation of sha1s in verbose mode
Date: Sat,  3 Mar 2007 00:31:16 +0000
Message-ID: <11728818771064-git-send-email-julian@quantumfyre.co.uk>
References: <11728818772136-git-send-email-julian@quantumfyre.co.uk>
Cc: Julian Phillips <julian@quantumfyre.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 01:31:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNI9k-00013T-NY
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 01:31:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992797AbXCCAbU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 19:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992800AbXCCAbU
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 19:31:20 -0500
Received: from neutron.datavampyre.co.uk ([212.159.54.235]:47303 "EHLO
	neutron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992797AbXCCAbS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 19:31:18 -0500
Received: (qmail 6433 invoked by uid 103); 3 Mar 2007 00:31:17 +0000
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90/2691. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.024416 secs); 03 Mar 2007 00:31:17 -0000
Received: from unknown (HELO localhost.localdomain) (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 3 Mar 2007 00:31:17 +0000
X-Mailer: git-send-email 1.5.0.2
In-Reply-To: <11728818772136-git-send-email-julian@quantumfyre.co.uk>
Message-Id: <028df363480685d1fe1ab84a99b2573dda853440.1172881822.git.julian@quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

git-branch has an --abbrev= command line option, but it does
no checking of the input.  Take the argument parsing code from
setup_revisions in revisions.c, and also the code for parsing
the --no-abbrev option.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---
 builtin-branch.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index d0179b0..d371849 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -12,7 +12,7 @@
 #include "builtin.h"
 
 static const char builtin_branch_usage[] =
-  "git-branch [-r] (-d | -D) <branchname> | [-l] [-f] <branchname> [<start-point>] | (-m | -M) [<oldbranch>] <newbranch> | [--color | --no-color] [-r | -a] [-v [--abbrev=<length>]]";
+  "git-branch [-r] (-d | -D) <branchname> | [-l] [-f] <branchname> [<start-point>] | (-m | -M) [<oldbranch>] <newbranch> | [--color | --no-color] [-r | -a] [-v [--abbrev=<length> | --no-abbrev]]";
 
 #define REF_UNKNOWN_TYPE    0x00
 #define REF_LOCAL_BRANCH    0x01
@@ -446,8 +446,16 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			reflog = 1;
 			continue;
 		}
+		if (!prefixcmp(arg, "--no-abbrev")) {
+			abbrev = 0;
+			continue;
+		}
 		if (!prefixcmp(arg, "--abbrev=")) {
-			abbrev = atoi(arg+9);
+			abbrev = strtoul(arg + 9, NULL, 10);
+			if (abbrev < MINIMUM_ABBREV)
+				abbrev = MINIMUM_ABBREV;
+			else if (abbrev > 40)
+				abbrev = 40;
 			continue;
 		}
 		if (!strcmp(arg, "-v")) {
-- 
1.5.0.2
