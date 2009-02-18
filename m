From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH v2] git-p4: avoid syncing duplicate changes
Date: Wed, 18 Feb 2009 13:12:14 -0500
Message-ID: <20090218181214.GA21970@padd.com>
References: <20090128164540.GA2137@padd.com> <200902051624.51636.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Wed Feb 18 19:20:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZr2E-00065p-Bx
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 19:20:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755598AbZBRSTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 13:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755235AbZBRSTH
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 13:19:07 -0500
Received: from marge.padd.com ([99.188.165.110]:37153 "EHLO marge.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754546AbZBRSTF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 13:19:05 -0500
X-Greylist: delayed 407 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Feb 2009 13:19:05 EST
Received: from arf.padd.com (pool-71-111-205-109.rlghnc.dsl-w.verizon.net [71.111.205.109])
	by marge.padd.com (Postfix) with ESMTPSA id A2E9F10F81C8;
	Wed, 18 Feb 2009 10:12:17 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 226D53E430C; Wed, 18 Feb 2009 13:12:15 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <200902051624.51636.simon@lst.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110565>

When a particular changeset affects multiple depot paths, it
will appear multiple times in the output of "p4 changes".
Filter out the duplicates to avoid the extra empty commits that
this otherwise would create.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
Switched to a dictionary to avoid the quadratic behavior,
as pointed out by Simon.

 contrib/fast-import/git-p4 |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index a85a7b2..3832f60 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -442,13 +442,14 @@ def p4ChangesForPaths(depotPaths, changeRange):
     output = p4_read_pipe_lines("changes " + ' '.join (["%s...%s" % (p, changeRange)
                                                         for p in depotPaths]))
 
-    changes = []
+    changes = {}
     for line in output:
-        changeNum = line.split(" ")[1]
-        changes.append(int(changeNum))
+	changeNum = int(line.split(" ")[1])
+	changes[changeNum] = True
 
-    changes.sort()
-    return changes
+    changelist = changes.keys()
+    changelist.sort()
+    return changelist
 
 class Command:
     def __init__(self):
-- 
1.6.0.6
