From: Sam Hocevar <sam@zoy.org>
Subject: [PATCH v5] git-p4: improve performance when importing huge files
	by reducing the number of string concatenations while constraining
	memory usage.
Date: Sat, 7 Mar 2009 13:25:17 +0100
Message-ID: <20090307122517.GA7325@zoy.org>
References: <20090306155322.GC12880@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 07 13:32:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfvhm-0000mZ-Px
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 13:32:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754207AbZCGMbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 07:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753786AbZCGMbL
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 07:31:11 -0500
Received: from poulet.zoy.org ([80.65.228.129]:56951 "EHLO poulet.zoy.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752269AbZCGMbK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 07:31:10 -0500
Received: from poukram (localhost [127.0.0.1])
	by poulet.zoy.org (Postfix) with ESMTP id 43CD01203B7
	for <git@vger.kernel.org>; Sat,  7 Mar 2009 13:31:03 +0100 (CET)
Received: by poukram (Postfix, from userid 1000)
	id A9D67E535F; Sat,  7 Mar 2009 13:25:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090306101339.GB12880@zoy.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112533>


Signed-off-by: Sam Hocevar <sam@zoy.org>
---
 This is a properly formatted version of the previous patch.

 contrib/fast-import/git-p4 |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 3832f60..db0ea0a 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -984,11 +984,22 @@ class P4Sync(Command):
         while j < len(filedata):
             stat = filedata[j]
             j += 1
+            data = []
             text = ''
+            # Append data every 8192 chunks to 1) ensure decent performance
+            # by not making too many string concatenations and 2) avoid
+            # excessive memory usage by purging "data" often enough. p4
+            # sends 4k chunks, so we should not use more than 32 MiB of
+            # additional memory while rebuilding the file data.
             while j < len(filedata) and filedata[j]['code'] in ('text', 'unicode', 'binary'):
-                text += filedata[j]['data']
+                data.append(filedata[j]['data'])
                 del filedata[j]['data']
+                if len(data) > 8192:
+                    text += ''.join(data)
+                    data = []
                 j += 1
+            text += ''.join(data)
+            data = None
 
             if not stat.has_key('depotFile'):
                 sys.stderr.write("p4 print fails with: %s\n" % repr(stat))
-- 
1.6.1.3
