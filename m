From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 7/9 v5] bisect: use "--bisect-replace" options when checking
 merge bases
Date: Mon, 24 Nov 2008 22:20:00 +0100
Message-ID: <20081124222000.13a3c8a5.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"H. Peter Anvin" <hpa@zytor.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 24 22:19:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4iqE-000574-6g
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 22:19:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752925AbYKXVST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 16:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752887AbYKXVSS
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 16:18:18 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:48508 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750910AbYKXVSS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2008 16:18:18 -0500
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id D4DC517B561;
	Mon, 24 Nov 2008 22:18:16 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g19.free.fr (Postfix) with SMTP id 7F2CC17B545;
	Mon, 24 Nov 2008 22:18:16 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101624>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh             |    4 ++--
 t/t6035-bisect-replace.sh |   10 ++++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index ed7c620..c8d5905 100755
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
1.5.6.1.1657.g6a50
