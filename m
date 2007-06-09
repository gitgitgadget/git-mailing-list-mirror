From: Johan Herland <johan@herland.net>
Subject: [PATCH 20/21] git-mktag tests: Expand on mktag selftests according to
 the new tag object structure
Date: Sat, 09 Jun 2007 02:21:34 +0200
Message-ID: <200706090221.35008.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net>
 <200706090210.36270.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 02:21:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwoi7-00050i-5V
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 02:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031657AbXFIAVm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 20:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S970218AbXFIAVm
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 20:21:42 -0400
Received: from smtp.getmail.no ([84.208.20.33]:50805 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S969344AbXFIAVl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 20:21:41 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJC00A03EC39J00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:21:39 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC000TREC0ZK30@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:21:36 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC009S2EBZAH10@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:21:35 +0200 (CEST)
In-reply-to: <200706090210.36270.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49547>

Some more tests are added to test the new "keywords" header, and to test
the more thorough verification routine.

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t3800-mktag.sh |  212 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 200 insertions(+), 12 deletions(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 3381239..b3b3121 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -46,6 +46,8 @@ cat >tag.sig <<EOF
 xxxxxx 139e9b33986b1c2670fff52c5067603117b3e895
 type tag
 tag mytag
+tagger foo
+
 EOF
 
 cat >expect.pat <<EOF
@@ -61,6 +63,8 @@ cat >tag.sig <<EOF
 object zz9e9b33986b1c2670fff52c5067603117b3e895
 type tag
 tag mytag
+tagger foo
+
 EOF
 
 cat >expect.pat <<EOF
@@ -76,6 +80,8 @@ cat >tag.sig <<EOF
 object 779e9b33986b1c2670fff52c5067603117b3e895
 xxxx tag
 tag mytag
+tagger foo
+
 EOF
 
 cat >expect.pat <<EOF
@@ -103,6 +109,8 @@ cat >tag.sig <<EOF
 object 779e9b33986b1c2670fff52c5067603117b3e895
 type tag
 xxx mytag
+tagger foo
+
 EOF
 
 cat >expect.pat <<EOF
@@ -118,6 +126,9 @@ cat >tag.sig <<EOF
 object 779e9b33986b1c2670fff52c5067603117b3e895
 type taggggggggggggggggggggggggggggggg
 tag
+keywords foo
+tagger bar@baz.com
+
 EOF
 
 cat >expect.pat <<EOF
@@ -127,13 +138,15 @@ EOF
 check_verify_failure '"tag" line label check #2'
 
 ############################################################
-#  8. type line type-name length check
+#  8. type line type name length check
 
 cat >tag.sig <<EOF
 object 779e9b33986b1c2670fff52c5067603117b3e895
 type taggggggggggggggggggggggggggggggg
 tag mytag
-tagger a
+keywords foo
+tagger bar@baz.com
+
 EOF
 
 cat >expect.pat <<EOF
@@ -149,7 +162,9 @@ cat >tag.sig <<EOF
 object 779e9b33986b1c2670fff52c5067603117b3e895
 type tagggg
 tag mytag
-tagger a
+keywords foo
+tagger bar@baz.com
+
 EOF
 
 cat >expect.pat <<EOF
@@ -159,13 +174,15 @@ EOF
 check_verify_failure 'verify object (SHA1/type) check'
 
 ############################################################
-# 10. verify tag-name check
+# 10. verify tag name check
 
 cat >tag.sig <<EOF
 object $head
 type commit
 tag my	tag
-tagger a
+keywords foo
+tagger bar@baz.com
+
 EOF
 
 cat >expect.pat <<EOF
@@ -175,28 +192,120 @@ EOF
 check_verify_failure 'verify tag-name check'
 
 ############################################################
-# 11. tagger line label check #1
+# 11. keywords line label check #1
 
 cat >tag.sig <<EOF
 object $head
 type commit
 tag mytag
+xxxxxxxx foo
+tagger bar@baz.com
+
 EOF
 
 cat >expect.pat <<EOF
-^error: .*char 70.*Could not find "tagger ".*$
+^error: .*char 70.*$
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
+^error: .*char 70.*$
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
+^error: .*char 82.*$
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
+^error: .*char 86.*$
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
+^error: .*char 82.*Found empty keyword.*$
+EOF
+
+check_verify_failure '"keywords" line check #3'
+
+############################################################
+# 16. tagger line label check #1
+
+cat >tag.sig <<EOF
+object $head
+type commit
+tag mytag
+
+EOF
+
+cat >expect.pat <<EOF
+^error: .*char 70.*$
 EOF
 
 check_verify_failure '"tagger" line label check #1'
 
 ############################################################
-# 12. tagger line label check #2
+# 17. tagger line label check #2
 
 cat >tag.sig <<EOF
 object $head
 type commit
 tag mytag
-tagger
+xxxxxx bar@baz.com
+
 EOF
 
 cat >expect.pat <<EOF
@@ -206,25 +315,104 @@ EOF
 check_verify_failure '"tagger" line label check #2'
 
 ############################################################
-# 13. create valid tag
+# 18. tagger line label check #3
+
+cat >tag.sig <<EOF
+object $head
+type commit
+tag mytag
+keywords foo
+tagger
+
+EOF
+
+cat >expect.pat <<EOF
+^error: .*char 83.*$
+EOF
+
+check_verify_failure '"tagger" line label check #3'
+
+############################################################
+# 19. create valid tag #1
 
 cat >tag.sig <<EOF
 object $head
 type commit
 tag mytag
 tagger another@example.com
+
 EOF
 
 test_expect_success \
-    'create valid tag' \
+    'create valid tag #1' \
     'git-mktag <tag.sig >.git/refs/tags/mytag 2>message'
 
 ############################################################
-# 14. check mytag
+# 20. check mytag
 
 test_expect_success \
     'check mytag' \
     'git-tag -l | grep mytag'
 
+############################################################
+# 21. create valid tag #2
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
+# 22. create valid tag #3
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
+# 23. create valid tag #4
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
+# 24. create valid tag #5 (with empty message)
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
1.5.2
