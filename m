From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH] git-p4: avoid syncing duplicate changes
Date: Wed, 28 Jan 2009 08:45:40 -0800
Message-ID: <20090128164540.GA2137@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 17:55:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSDh3-00057K-8o
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 17:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbZA1Qxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 11:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbZA1Qxn
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 11:53:43 -0500
Received: from marge.padd.com ([99.188.165.110]:52420 "EHLO marge.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751625AbZA1Qxn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 11:53:43 -0500
X-Greylist: delayed 483 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Jan 2009 11:53:42 EST
Received: from honk.padd.com (honk.padd.com [209.17.171.228])
	by marge.padd.com (Postfix) with ESMTPSA id 5CB7310F807B
	for <git@vger.kernel.org>; Wed, 28 Jan 2009 08:40:44 -0800 (PST)
Received: by honk.padd.com (Postfix, from userid 7770)
	id A31621C400B9; Wed, 28 Jan 2009 08:45:40 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107550>

When a particular changeset affects multiple depot paths, it
will appear multiple times in the output of "p4 changes".
Filter out the duplicates to avoid the extra empty commits that
this would otherwise create.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4 |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index a85a7b2..63c8eca 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -444,8 +444,9 @@ def p4ChangesForPaths(depotPaths, changeRange):
 
     changes = []
     for line in output:
-        changeNum = line.split(" ")[1]
-        changes.append(int(changeNum))
+	changeNum = int(line.split(" ")[1])
+	if changeNum not in changes:
+	    changes.append(changeNum)
 
     changes.sort()
     return changes
-- 
1.6.0.6
