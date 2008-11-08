From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 7/7 v3 updated] bisect: use "--bisect-replace" options when
 checking merge bases
Date: Sat, 8 Nov 2008 16:33:51 +0100
Message-ID: <20081108163351.5980a16c.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 08 16:32:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kypnr-0006ME-QZ
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 16:32:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446AbYKHPbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 10:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753369AbYKHPbd
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 10:31:33 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:43867 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753162AbYKHPbc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 10:31:32 -0500
Received: from smtp5-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 0BB5F3EA200;
	Sat,  8 Nov 2008 16:31:31 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g19.free.fr (Postfix) with SMTP id C87FE3EA1D8;
	Sat,  8 Nov 2008 16:31:30 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100409>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh             |    4 ++--
 t/t6035-bisect-replace.sh |   10 ++++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

	This is the same as [PATCH 7/7 v3] but with a test case
	added.

diff --git a/git-bisect.sh b/git-bisect.sh
index 1daa81c..87e186f 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -401,7 +401,7 @@ check_merge_bases() {
 	_bad="$1"
 	_good="$2"
 	_skip="$3"
-	for _mb in $(git merge-base --all $_bad $_good)
+	for _mb in $(git merge-base --all --bisect-replace $_bad $_good)
 	do
 		if is_among "$_mb" "$_good"; then
 			continue
@@ -436,7 +436,7 @@ check_good_are_ancestors_of_bad() {
 	# Bisecting with no good rev is ok
 	test -z "$_good" && return
 
-	_side=$(git rev-list $_good ^$_bad)
+	_side=$(git rev-list --bisect-replace $_good ^$_bad)
 	if test -n "$_side"; then
 		# Return if a checkout was done
 		check_merge_bases "$_bad" "$_good" "$_skip" || return
diff --git a/t/t6035-bisect-replace.sh b/t/t6035-bisect-replace.sh
index 8fe7cc5..dabf1ae 100755
--- a/t/t6035-bisect-replace.sh
+++ b/t/t6035-bisect-replace.sh
@@ -144,6 +144,16 @@ test_expect_success '"git merge-base --bisect-replace" works' '
      test "$hash" = "$HASH1"
 '
 
+test_expect_success 'git bisect works when starting on the replace branch' '
+     git bisect start $HASH7 $HASHFIX3 &&
+     test "$(git rev-parse --verify HEAD)" = "$HASH5" &&
+     git bisect bad &&
+     test "$(git rev-parse --verify HEAD)" = "$HASHFIX4" &&
+     git bisect good > my_bisect_log.txt &&
+     grep "$HASH5 is first bad commit" my_bisect_log.txt &&
+     git bisect reset
+'
+
 #
 #
 test_done
-- 
1.6.0.3.620.ge1fc
