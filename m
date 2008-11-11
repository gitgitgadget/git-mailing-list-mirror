From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 7/9 v4] bisect: use "--bisect-replace" options when checking
 merge bases
Date: Tue, 11 Nov 2008 06:45:30 +0100
Message-ID: <20081111064530.ec975034.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 11 06:44:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzm3C-0005RY-LB
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 06:44:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180AbYKKFnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 00:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbYKKFnQ
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 00:43:16 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:37081 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751787AbYKKFnP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 00:43:15 -0500
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 717D519705;
	Tue, 11 Nov 2008 06:43:14 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g19.free.fr (Postfix) with SMTP id 345471972B;
	Tue, 11 Nov 2008 06:43:14 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100622>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh             |    4 ++--
 t/t6035-bisect-replace.sh |   10 ++++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index b0139d5..be37b64 100755
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
1.6.0.3.614.g0f3b9
