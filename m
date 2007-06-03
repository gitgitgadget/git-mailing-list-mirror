From: Scott Lamb <slamb@slamb.org>
Subject: [PATCH 3/4] git-p4import: resume on correct p4 changeset
Date: Sat,  2 Jun 2007 20:58:45 -0700
Message-ID: <11808431364066-git-send-email-slamb@slamb.org>
References: <4ACE2ABC-8D73-4097-87AC-F3B27EDA97DE@slamb.org>
 <1180843126948-git-send-email-slamb@slamb.org>
 <11808431291938-git-send-email-slamb@slamb.org>
Cc: Scott Lamb <slamb@slamb.org>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Jun 03 05:59:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuhFL-0000FV-Pc
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 05:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763443AbXFCD7D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 23:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763449AbXFCD7D
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 23:59:03 -0400
Received: from hobbes.slamb.org ([208.78.103.243]:33669 "EHLO hobbes.slamb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763443AbXFCD7B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 23:59:01 -0400
Received: from hobbes.slamb.org (localhost [127.0.0.1])
	by hobbes.slamb.org (Postfix) with ESMTP id 55C2D980AA;
	Sat,  2 Jun 2007 20:58:57 -0700 (PDT)
X-Spam-Score: -4.3
X-Spam-Checker-Version: SpamAssassin 3.1.8 (2007-02-13) on hobbes.slamb.org
X-Spam-Level: 
X-Spam-Hammy: 0.000-+--H*RT:rdns, 0.000-+--H*RT:intl
X-Spam-Status: No, score=-4.3 required=4.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.1.8
X-Spam-Spammy: 0.987-+--H*r:sk:hobbes., 0.979-+--obvious
Received: from localhost.localdomain (slamb-linux.vpn.slamb.org [172.16.0.6])
	by hobbes.slamb.org (Postfix) with ESMTP;
	Sat,  2 Jun 2007 20:58:57 -0700 (PDT)
X-Mailer: git-send-email 1.5.2
In-Reply-To: <11808431291938-git-send-email-slamb@slamb.org>
X-Envelope-From: <slamb@slamb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48972>

This had been resuming on change 222 rather than 22283.

top_change's removal of the last two characters must have predated the use
of rstrip() in get_single(). A regexp should be less fragile, or at least
more obvious when it breaks.

Signed-off-by: Scott Lamb <slamb@slamb.org>
---
 git-p4import.py |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/git-p4import.py b/git-p4import.py
index 54e5e9e..e7a52b3 100644
--- a/git-p4import.py
+++ b/git-p4import.py
@@ -237,15 +237,16 @@ class git_command:
     def make_tag(self, name, head):
         self.git(["tag", "-f", name, head])
 
+    _tag_re = re.compile(r'tags/p4/(\d+)')
     def top_change(self, branch):
         try:
             a=self.get_single(["name-rev", "--tags", "refs/heads/%s" % branch])
-            loc = a.find(' tags/') + 6
-            if a[loc:loc+3] != "p4/":
-                raise
-            return int(a[loc+3:][:-2])
-        except:
-            return 0
+        except GitException, e:
+            return 0 # fresh repository
+        m = self._tag_re.search(a)
+        if m is None:
+            raise Exception('unable to parse: %r' % (a,))
+        return int(m.group(1))
 
     def update_index(self):
         files = self.git("ls-files -m -d -o -z".split(" "))
-- 
1.5.2
