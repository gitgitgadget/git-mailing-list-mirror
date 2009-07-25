From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 4/5] git-p4 stream: check apple file type
Date: Sat, 25 Jul 2009 10:24:51 -0400
Message-ID: <20090725142451.GE3841@arf.padd.com>
References: <1247301071-9541-1-git-send-email-luke@diamand.org> <20090725142329.GA3841@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sat Jul 25 16:33:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUiJl-0007R3-M9
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 16:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbZGYOdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 10:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbZGYOdG
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 10:33:06 -0400
Received: from marge.padd.com ([99.188.165.110]:39109 "EHLO marge.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751700AbZGYOdE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 10:33:04 -0400
Received: from arf.padd.com (pool-71-111-229-253.rlghnc.dsl-w.verizon.net [71.111.229.253])
	by marge.padd.com (Postfix) with ESMTPSA id 5D3E0121A7D6;
	Sat, 25 Jul 2009 07:24:54 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 17BC83E40FE; Sat, 25 Jul 2009 10:24:51 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20090725142329.GA3841@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124014>

Move this check into the function so both callers do it.
And always reset the file contents in the main loop, as
we just ignored this apple file.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4 |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 3ab016b..af66026 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -954,6 +954,11 @@ class P4Sync(Command):
     # - helper for streamP4Files
 
     def streamOneP4File(self, file, contents):
+	if file["type"] == "apple":
+	    print "\nfile %s is a strange apple file that forks. Ignoring" % \
+	    	  file['depotFile']
+	    return
+
         relPath = self.stripRepoPath(file['depotFile'], self.branchPrefixes)
         if verbose:
             sys.stderr.write("%s\n" % relPath)
@@ -1049,12 +1054,6 @@ class P4Sync(Command):
 
                     if marshalled.has_key('depotFile') and have_file_info:
                         # start of a new file - output the old one first
-
-                        if file["type"] == "apple":
-                            print "\nfile %s is a strange apple file that forks. Ignoring" % file['path']
-                            continue
-
-
                         self.streamOneP4File(file, contents)
                         file = {}
                         contents = []
-- 
1.6.2.5
