From: Sam Hocevar <sam@zoy.org>
Subject: [PATCH] git-p4: improve performance with large files
Date: Wed, 4 Mar 2009 22:54:38 +0100
Message-ID: <20090304215438.GA12653@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 04 23:24:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LezVd-0007Nl-1h
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 23:24:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236AbZCDWWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 17:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753193AbZCDWWo
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 17:22:44 -0500
Received: from poulet.zoy.org ([80.65.228.129]:55221 "EHLO poulet.zoy.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751286AbZCDWWn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 17:22:43 -0500
X-Greylist: delayed 1350 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Mar 2009 17:22:43 EST
Received: from poukram (localhost [127.0.0.1])
	by poulet.zoy.org (Postfix) with ESMTP id 0DB3A1206FD
	for <git@vger.kernel.org>; Wed,  4 Mar 2009 23:00:10 +0100 (CET)
Received: by poukram (Postfix, from userid 1000)
	id F2F247FA95; Wed,  4 Mar 2009 22:54:38 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112244>

   The current git-p4 way of concatenating strings performs in O(n^2)
and is therefore terribly slow with large files because of unnecessary
memory copies. The following patch makes the operation O(n).

   Using this patch, importing a 17GB repository with large files
(50 to 500MB) takes 2 hours instead of a week.

Signed-off-by: Sam Hocevar <sam@zoy.org>
---
 contrib/fast-import/git-p4 |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 9fdb0c6..09e9746 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -990,11 +990,12 @@ class P4Sync(Command):
         while j < len(filedata):
             stat = filedata[j]
             j += 1
-            text = ''
+            data = []
             while j < len(filedata) and filedata[j]['code'] in ('text', 'unicode', 'binary'):
-                text += filedata[j]['data']
+                data.append(filedata[j]['data'])
                 del filedata[j]['data']
                 j += 1
+            text = "".join(data)
 
             if not stat.has_key('depotFile'):
                 sys.stderr.write("p4 print fails with: %s\n" % repr(stat))
-- 
1.6.1.3
