From: Johan Herland <johan@herland.net>
Subject: [PATCH 5/6] git-mktag tests: Fix and expand the mktag tests according
 to the new tag object structure
Date: Mon, 04 Jun 2007 02:54:34 +0200
Message-ID: <200706040254.34554.johan@herland.net>
References: <200706040251.05286.johan@herland.net>
 <200706040251.52613.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 02:54:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv0qN-00027U-2Q
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 02:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbXFDAyl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 20:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbXFDAyl
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 20:54:41 -0400
Received: from smtp.getmail.no ([84.208.20.33]:33976 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751340AbXFDAyk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 20:54:40 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJ300J036J35C00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Jun 2007 02:54:39 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJ300EDC6IZJV20@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Jun 2007 02:54:35 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJ300J2O6IYFE30@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Jun 2007 02:54:35 +0200 (CEST)
In-reply-to: <200706040251.52613.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49058>

The existing tests are updated to reflect the changes in the tag object.

Additionally some more tests are added to test the new "keywords" header,
and to test the more thorough verification routine.

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t3800-mktag.sh |  204 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 190 insertions(+), 14 deletions(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 7c7e433..f6e3d10 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -34,7 +34,7 @@ too short for a tag
 EOF
 
 cat >expect.pat <<EOF
-^error: .*size wrong.*$
+^error: .* size .*$
 EOF
 
 check_verify_failure 'Tag object length check'
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
@@ -91,7 +97,7 @@ echo "object 779e9b33986b1c2670fff52c5067603117b3e895" >tag.sig
 printf "type tagsssssssssssssssssssssssssssssss" >>tag.sig
 
 cat >expect.pat <<EOF
-^error: char48: .*"[\]n"$
+^error: char48: .*"[\]n" after "type"$
 EOF
 
 check_verify_failure '"type" line eol check'
@@ -103,10 +109,12 @@ cat >tag.sig <<EOF
 object 779e9b33986b1c2670fff52c5067603117b3e895
 type tag
 xxx mytag
+tagger foo
+
 EOF
 
 cat >expect.pat <<EOF
-^error: char57: no "tag " found$
+^error: char57: .*$
 EOF
 
 check_verify_failure '"tag" line label check #1'
@@ -118,21 +126,27 @@ cat >tag.sig <<EOF
 object 779e9b33986b1c2670fff52c5067603117b3e895
 type taggggggggggggggggggggggggggggggg
 tag
+keywords foo
+tagger bar@baz.com
+
 EOF
 
 cat >expect.pat <<EOF
-^error: char87: no "tag " found$
+^error: char87: .*$
 EOF
 
 check_verify_failure '"tag" line label check #2'
 
 ############################################################
-#  8. type line type-name length check
+#  8. type line type name length check
 
 cat >tag.sig <<EOF
 object 779e9b33986b1c2670fff52c5067603117b3e895
 type taggggggggggggggggggggggggggggggg
 tag mytag
+keywords foo
+tagger bar@baz.com
+
 EOF
 
 cat >expect.pat <<EOF
@@ -148,6 +162,9 @@ cat >tag.sig <<EOF
 object 779e9b33986b1c2670fff52c5067603117b3e895
 type tagggg
 tag mytag
+keywords foo
+tagger bar@baz.com
+
 EOF
 
 cat >expect.pat <<EOF
@@ -157,12 +174,15 @@ EOF
 check_verify_failure 'verify object (SHA1/type) check'
 
 ############################################################
-# 10. verify tag-name check
+# 10. verify tag name check
 
 cat >tag.sig <<EOF
 object $head
 type commit
 tag my	tag
+keywords foo
+tagger bar@baz.com
+
 EOF
 
 cat >expect.pat <<EOF
@@ -172,56 +192,212 @@ EOF
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
+tagger bar@baz.com
+
+EOF
+
+cat >expect.pat <<EOF
+^error: char70: .*$
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
+^error: char70: .*$
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
+^error: char83: .*$
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
+^error: char87: .*$
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
+^error: char83: .*$
+EOF
+
+check_verify_failure '"keywords" line check #3'
+
+############################################################
+# 16. tagger line label check #1
 
 cat >tag.sig <<EOF
 object $head
 type commit
 tag mytag
+
 EOF
 
 cat >expect.pat <<EOF
-^error: char70: could not find "tagger"$
+^error: char70: .*$
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
-^error: char70: could not find "tagger"$
+^error: char70: .*$
 EOF
 
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
+^error: char83: .*$
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
 
 test_done
-- 
1.5.2
