From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] rerere: make sorting really stable.
Date: Wed, 04 Apr 2007 14:13:35 -0700
Message-ID: <7vircb2680.fsf@assigned-by-dhcp.cox.net>
References: <7v1wj1ujf5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0704041746580.4045@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v8xd83sfn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 04 23:13:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZCne-0005EV-0P
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 23:13:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbXDDVNi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 17:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751669AbXDDVNi
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 17:13:38 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:36942 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbXDDVNg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 17:13:36 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070404211334.BBVE28911.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Wed, 4 Apr 2007 17:13:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id j9Db1W00l1kojtg0000000; Wed, 04 Apr 2007 17:13:36 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43778>

The earlier code does not swap hunks when the beginning of the
first side is identical to the whole of the second side.  In
such a case, the first one should sort later.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-rerere.c  |    7 +++++--
 t/t4200-rerere.sh |    9 +++++----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/builtin-rerere.c b/builtin-rerere.c
index b463c07..8c2c8bd 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -117,10 +117,13 @@ static int handle_file(const char *path,
 		else if (!prefixcmp(buf, "======="))
 			hunk = 2;
 		else if (!prefixcmp(buf, ">>>>>>> ")) {
+			int one_is_longer = (one->nr > two->nr);
+			int common_len = one_is_longer ? two->nr : one->nr;
+			int cmp = memcmp(one->ptr, two->ptr, common_len);
+
 			hunk_no++;
 			hunk = 0;
-			if (memcmp(one->ptr, two->ptr, one->nr < two->nr ?
-						one->nr : two->nr) > 0) {
+			if ((cmp > 0) || ((cmp == 0) && one_is_longer)) {
 				struct buffer *swap = one;
 				one = two;
 				two = swap;
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index bc878d7..6ba63d7 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -35,7 +35,8 @@ git commit -q -a -m first
 
 git checkout -b second master
 git show first:a1 |
-sed -e 's/To die, t/To die! T/' -e 's/life;$/life./' > a1
+sed -e 's/To die, t/To die! T/' > a1
+echo "* END *" >>a1
 git commit -q -a -m second
 
 # activate rerere
@@ -53,7 +54,7 @@ test_expect_success 'no postimage or thisimage yet' \
 test_expect_success 'preimage has right number of lines' '
 
 	cnt=$(sed -ne "/^<<<<<<</,/^>>>>>>>/p" $rr/preimage | wc -l) &&
-	test $cnt = 10
+	test $cnt = 9
 
 '
 
@@ -75,10 +76,10 @@ cat > expect << EOF
  For in that sleep of death what dreams may come
  When we have shuffled off this mortal coil,
  Must give us pause: there's the respect
+ That makes calamity of so long life;
 -<<<<<<<
--That makes calamity of so long life.
 -=======
- That makes calamity of so long life;
+-* END *
 ->>>>>>>
 EOF
 git rerere diff > out
-- 
1.5.1.31.ge421f
