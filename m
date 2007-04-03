From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] rerere should not repeat the earlier hunks in later ones
Date: Tue, 03 Apr 2007 16:28:46 -0700
Message-ID: <7v1wj1ujf5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 04 01:28:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYsQl-0007uQ-Fu
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 01:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946030AbXDCX2s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 19:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946033AbXDCX2s
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 19:28:48 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:56922 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946030AbXDCX2r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 19:28:47 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070403232848.XFHJ25613.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Tue, 3 Apr 2007 19:28:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id inUm1W00D1kojtg0000000; Tue, 03 Apr 2007 19:28:47 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43696>

When a file has more then one conflicting hunks, it repeated the
contents of previous hunks in output for later ones.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff --git a/builtin-rerere.c b/builtin-rerere.c
index b8867ab..b463c07 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -78,6 +78,13 @@ static void append_line(struct buffer *buffer, const char *line)
 	buffer->nr += len;
 }
 
+static void clear_buffer(struct buffer *buffer)
+{
+	free(buffer->ptr);
+	buffer->ptr = NULL;
+	buffer->nr = buffer->alloc = 0;
+}
+
 static int handle_file(const char *path,
 	 unsigned char *sha1, const char *output)
 {
@@ -131,6 +138,8 @@ static int handle_file(const char *path,
 				SHA1_Update(&ctx, two->ptr, two->nr);
 				SHA1_Update(&ctx, "\0", 1);
 			}
+			clear_buffer(one);
+			clear_buffer(two);
 		} else if (hunk == 1)
 			append_line(one, buf);
 		else if (hunk == 2)
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index e081b32..8b611bb 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -34,7 +34,8 @@ EOF
 git commit -q -a -m first
 
 git checkout -b second master
-git show first:a1 | sed 's/To die, t/To die! T/' > a1
+git show first:a1 |
+sed -e 's/To die, t/To die! T/' -e 's/life;$/life./' > a1
 git commit -q -a -m second
 
 # activate rerere
@@ -42,19 +43,26 @@ mkdir .git/rr-cache
 
 test_expect_failure 'conflicting merge' 'git pull . first'
 
-sha1=4f58849a60b4f969a2848966b6d02893b783e8fb
+sha1=$(sed -e 's/\t.*//' .git/rr-cache/MERGE_RR)
 rr=.git/rr-cache/$sha1
 test_expect_success 'recorded preimage' "grep ======= $rr/preimage"
 
 test_expect_success 'no postimage or thisimage yet' \
 	"test ! -f $rr/postimage -a ! -f $rr/thisimage"
 
+test_expect_success 'preimage have right number of lines' '
+
+	cnt=$(sed -ne "/^<<<<<<</,/^>>>>>>>/p" $rr/preimage | wc -l) &&
+	test "$cnt" = 10
+
+'
+
 git show first:a1 > a1
 
 cat > expect << EOF
 --- a/a1
 +++ b/a1
-@@ -6,11 +6,7 @@
+@@ -6,17 +6,9 @@
  The heart-ache and the thousand natural shocks
  That flesh is heir to, 'tis a consummation
  Devoutly to be wish'd.
@@ -66,8 +74,13 @@ cat > expect << EOF
  To sleep: perchance to dream: ay, there's the rub;
  For in that sleep of death what dreams may come
  When we have shuffled off this mortal coil,
+ Must give us pause: there's the respect
+-<<<<<<<
+-That makes calamity of so long life.
+-=======
+ That makes calamity of so long life;
+->>>>>>>
 EOF
-
 git rerere diff > out
 
 test_expect_success 'rerere diff' 'git diff expect out'
