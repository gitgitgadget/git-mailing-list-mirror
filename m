From: Johan Herland <johan@herland.net>
Subject: [PATCH 4/4] git-mktag tests: Expand on mktag selftests according to
 the new tag object structure
Date: Sun, 10 Jun 2007 13:50:54 +0200
Message-ID: <200706101350.55062.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vwsyc8bt3.fsf@assigned-by-dhcp.cox.net>
 <200706101347.57023.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 10 13:51:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxLwo-0004Cf-M1
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 13:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753792AbXFJLvE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 07:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753825AbXFJLvD
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 07:51:03 -0400
Received: from smtp.getmail.no ([84.208.20.33]:46348 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753767AbXFJLvB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 07:51:01 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJF00C094X04K00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 13:51:00 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJF0054W4WV4X30@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 13:50:55 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJF001UD4WV13A0@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 13:50:55 +0200 (CEST)
In-reply-to: <200706101347.57023.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49716>

Some more tests are added to test the new "keywords" header.

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t3800-mktag.sh |  156 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 152 insertions(+), 4 deletions(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index ca90662..cc2f246 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -174,7 +174,95 @@ EOF
 check_verify_failure 'verify tag-name check'
 
 ############################################################
-# 11. tagger line label check #1
+# 11. keywords line label check #1
+
+cat >tag.sig <<EOF
+object $head
+type commit
+tag mytag
+xxxxxxxx foo
+EOF
+
+cat >expect.pat <<EOF
+^error: char70: could not find "tagger"$
+EOF
+
+check_verify_failure '"keywords" line label check #1'
+
+############################################################
+# 12. keywords line label check #2
+
+cat >tag.sig <<EOF
+object $head
+type commit
+tag mytag
+keywords
+tagger bar@baz.com
+
+EOF
+
+cat >expect.pat <<EOF
+^error: char70: could not find "tagger"$
+EOF
+
+check_verify_failure '"keywords" line label check #2'
+
+############################################################
+# 13. keywords line check #1
+
+cat >tag.sig <<EOF
+object $head
+type commit
+tag mytag
+keywords foo bar	baz
+tagger bar@baz.com
+
+EOF
+
+cat >expect.pat <<EOF
+^error: char83: could not verify keywords$
+EOF
+
+check_verify_failure '"keywords" line check #1'
+
+############################################################
+# 14. keywords line check #2
+
+cat >tag.sig <<EOF
+object $head
+type commit
+tag mytag
+keywords foo,bar	baz
+tagger bar@baz.com
+
+EOF
+
+cat >expect.pat <<EOF
+^error: char87: could not verify keywords$
+EOF
+
+check_verify_failure '"keywords" line check #2'
+
+############################################################
+# 15. keywords line check #3
+
+cat >tag.sig <<EOF
+object $head
+type commit
+tag mytag
+keywords foo,,bar
+tagger bar@baz.com
+
+EOF
+
+cat >expect.pat <<EOF
+^error: char83: could not verify keywords$
+EOF
+
+check_verify_failure '"keywords" line check #3'
+
+############################################################
+# 16. tagger line label check #1
 
 cat >tag.sig <<EOF
 object $head
@@ -189,7 +277,7 @@ EOF
 check_verify_failure '"tagger" line label check #1'
 
 ############################################################
-# 12. tagger line label check #2
+# 17. tagger line label check #2
 
 cat >tag.sig <<EOF
 object $head
@@ -205,7 +293,7 @@ EOF
 check_verify_failure '"tagger" line label check #2'
 
 ############################################################
-# 13. create valid tag
+# 18. create valid tag #1
 
 cat >tag.sig <<EOF
 object $head
@@ -219,11 +307,71 @@ test_expect_success \
     'git-mktag <tag.sig >.git/refs/tags/mytag 2>message'
 
 ############################################################
-# 14. check mytag
+# 19. check mytag
 
 test_expect_success \
     'check mytag' \
     'git-tag -l | grep mytag'
 
+############################################################
+# 20. create valid tag #2
+
+cat >tag.sig <<EOF
+object $head
+type commit
+tagger another@example.com
+
+EOF
+
+test_expect_success \
+    'create valid tag #2' \
+    'git-mktag <tag.sig >.git/refs/tags/mytag 2>message'
+
+############################################################
+# 21. create valid tag #3
+
+cat >tag.sig <<EOF
+object $head
+type commit
+keywords foo,bar,baz,spam,spam,spam,spam,spam,spam,spam,spam
+tagger another@example.com
+
+EOF
+
+test_expect_success \
+    'create valid tag #3' \
+    'git-mktag <tag.sig >.git/refs/tags/mytag 2>message'
+
+############################################################
+# 22. create valid tag #4
+
+cat >tag.sig <<EOF
+object $head
+type commit
+tag mytag
+keywords note
+tagger another@example.com
+
+EOF
+
+test_expect_success \
+    'create valid tag #4' \
+    'git-mktag <tag.sig >.git/refs/tags/mytag 2>message'
+
+############################################################
+# 23. create valid tag #5 (with empty message)
+
+cat >tag.sig <<EOF
+object $head
+type commit
+tag mytag
+keywords note
+tagger a
+EOF
+
+test_expect_success \
+    'create valid tag #4' \
+    'git-mktag <tag.sig >.git/refs/tags/mytag 2>message'
+
 
 test_done
-- 
1.5.2.1.144.gabc40
