From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] rerere: record resolution even if file is not in merge base
Date: Mon, 9 Jul 2007 14:47:24 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707091445450.5546@racer.site>
References: <20070709070725.GA4445@lala> <7vps32ugu2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-883559467-1183988844=:5546"
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 15:55:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7thn-0005iZ-Nb
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 15:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753100AbXGINzA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 09:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753044AbXGINzA
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 09:55:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:38730 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752703AbXGINy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 09:54:59 -0400
Received: (qmail invoked by alias); 09 Jul 2007 13:54:57 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp055) with SMTP; 09 Jul 2007 15:54:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18DDNFhhBwD0PasSTwBDdUbSuOnYhKCY1uldMqgKw
	pc2tRmLeXBPXRC
X-X-Sender: gene099@racer.site
In-Reply-To: <7vps32ugu2.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51994>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-883559467-1183988844=:5546
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT


Two-file merges were rare enough that they were dropped outside of the 
radar.  This fix is a trivial change to builtin-rerere.c::find_conflict().  
It is still sane to insist that we do not do rerere for symlinks, and 
require to have stages #2 and #3, but we can drop the requirement to have 
stage #1. rerere does not use information from there anyway.

This fix is from Junio, together with two tests to verify that it works
as expected.

Noticed by Uwe Kleine-König.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Heh, this time I steal your patch and take all the credit ;-)

 builtin-rerere.c  |   17 +++++++----------
 t/t4200-rerere.sh |   44 +++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 46 insertions(+), 15 deletions(-)

diff --git a/builtin-rerere.c b/builtin-rerere.c
index c25b3d5..6ffc43d 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -168,19 +168,16 @@ static int find_conflict(struct path_list *conflict)
 	int i;
 	if (read_cache() < 0)
 		return error("Could not read index");
-	for (i = 0; i + 2 < active_nr; i++) {
-		struct cache_entry *e1 = active_cache[i];
-		struct cache_entry *e2 = active_cache[i+1];
-		struct cache_entry *e3 = active_cache[i+2];
-		if (ce_stage(e1) == 1 &&
-		    ce_stage(e2) == 2 &&
+	for (i = 0; i+1 < active_nr; i++) {
+		struct cache_entry *e2 = active_cache[i];
+		struct cache_entry *e3 = active_cache[i+1];
+		if (ce_stage(e2) == 2 &&
 		    ce_stage(e3) == 3 &&
-		    ce_same_name(e1, e2) && ce_same_name(e1, e3) &&
-		    S_ISREG(ntohl(e1->ce_mode)) &&
+		    ce_same_name(e2, e3) &&
 		    S_ISREG(ntohl(e2->ce_mode)) &&
 		    S_ISREG(ntohl(e3->ce_mode))) {
-			path_list_insert((const char *)e1->name, conflict);
-			i += 2;
+			path_list_insert((const char *)e2->name, conflict);
+			i++; /* skip over both #2 and #3 */
 		}
 	}
 	return 0;
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 6f55ba0..cfcdb69 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -116,11 +116,12 @@ test_expect_success 'commit succeeds' \
 
 test_expect_success 'recorded postimage' "test -f $rr/postimage"
 
-git checkout -b third master
-git show second^:a1 | sed 's/To die: t/To die! T/' > a1
-git commit -q -a -m third
-
-test_expect_failure 'another conflicting merge' 'git pull . first'
+test_expect_success 'another conflicting merge' '
+	git checkout -b third master &&
+	git show second^:a1 | sed "s/To die: t/To die! T/" > a1 &&
+	git commit -q -a -m third &&
+	! git pull . first
+'
 
 git show first:a1 | sed 's/To die: t/To die! T/' > expect
 test_expect_success 'rerere kicked in' "! grep ======= a1"
@@ -164,4 +165,37 @@ test_expect_success 'garbage collection (part2)' 'git rerere gc'
 test_expect_success 'old records rest in peace' \
 	"test ! -f $rr/preimage && test ! -f $rr2/preimage"
 
+test_expect_success 'file2 added differently in two branches' '
+	git reset --hard &&
+	git checkout -b fourth &&
+	echo Hallo > file2 &&
+	git add file2 &&
+	git commit -m version1 &&
+	git checkout third &&
+	echo Bello > file2 &&
+	git add file2 &&
+	git commit -m version2 &&
+	! git merge fourth &&
+	sha1=$(sed -e "s/	.*//" .git/rr-cache/MERGE_RR) &&
+	rr=.git/rr-cache/$sha1 &&
+	echo Cello > file2 &&
+	git add file2 &&
+	git commit -m resolution
+'
+
+test_expect_success 'resolution was recorded properly' '
+	git reset --hard HEAD~2 &&
+	git checkout -b fifth &&
+	echo Hallo > file3 &&
+	git add file3 &&
+	git commit -m version1 &&
+	git checkout third &&
+	echo Bello > file3 &&
+	git add file3 &&
+	git commit -m version2 &&
+	! git merge fifth &&
+	git diff-files -q &&
+	test Cello = "$(cat file3)"
+'
+
 test_done
-- 
1.5.3.rc0.2769.gd9be2


--8323584-883559467-1183988844=:5546--
