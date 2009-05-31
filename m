From: Peter Baumann <waste.manager@gmx.de>
Subject: [PATCH] Show selected subdirectory paths in gitk
Date: Sun, 31 May 2009 10:50:45 +0200
Message-ID: <20090531085045.GA8129@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 31 10:44:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAgeh-0003UA-Rj
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 10:44:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757328AbZEaIo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 04:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757291AbZEaIo1
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 04:44:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:53403 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757240AbZEaIo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 04:44:26 -0400
Received: (qmail invoked by alias); 31 May 2009 08:44:27 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp039) with SMTP; 31 May 2009 10:44:27 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1//uTAOhmb/pR8fGtX187TP2qBk9Itf5v3wa0SPew
	2kJC427cTgffeB
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id 79DDB180BA; Sun, 31 May 2009 10:50:45 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120391>

Previously, running 'gitk -- file' in a subdirectory of the worktree didn't
show the file in the file selection widget. This is especially annoying if
multiple files and/or a subdirectory was given as parameter to gitk, because
no visual reprasentation on the changed files was given besides the commit
diff itself.

By prefixing all file filters with the result of the newly added function
get_subdir_prefix which returns the subdirectory relative to the GIT_DIR,
we make sure we always use the correct file name.

Signed-off-by: Peter Baumann <waste.manager@gmx.de>
---

The problem this patch fixes could be reproduced in the git repo by

	cd Documentation
	gitk git-add.txt

Running the above commands and you should not see any file listed in the
file selection widget in gitk. After applying the patch, the file is listed
there (for any non merge commit).


 gitk-git/gitk |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)
 mode change 100644 => 100755 gitk-git/gitk

diff --git a/gitk-git/gitk b/gitk-git/gitk
old mode 100644
new mode 100755
index 1a7887b..2355d82
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -7104,8 +7104,17 @@ proc startdiff {ids} {
     }
 }
 
+# Return the current subdirectory relative to the repository root
+proc get_subdir_prefix {} {
+    return [exec git rev-parse --show-prefix]
+}
+
 proc path_filter {filter name} {
-    foreach p $filter {
+    set prefix [get_subdir_prefix]
+    foreach f $filter {
+	# get full pathname starting from the workdir root
+	set p "$prefix$f"
+
 	set l [string length $p]
 	if {[string index $p end] eq "/"} {
 	    if {[string compare -length $l $p $name] == 0} {
-- 
1.6.3.1.70.ga80aa.dirty
