From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/2] bisect: string commands emited by "filter_skipped"
 together with "&&"
Date: Fri, 27 Feb 2009 07:31:46 +0100
Message-ID: <20090227073146.6699964f.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 07:34:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcwIQ-00033t-RO
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 07:34:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753540AbZB0Gcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 01:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbZB0Gcg
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 01:32:36 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:44238 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753328AbZB0Gcg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 01:32:36 -0500
Received: from smtp5-g21.free.fr (localhost [127.0.0.1])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 78932D480E1;
	Fri, 27 Feb 2009 07:32:27 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g21.free.fr (Postfix) with SMTP id 37894D480AD;
	Fri, 27 Feb 2009 07:32:25 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111635>

So that when they are evaled and there is an error, the result from
the eval is an error.

This way we should be protected from errors in the output emited by
"filter_skipped".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh |   29 ++++++++++++++++-------------
 1 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index a9324b2..08e31d6 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -296,14 +296,14 @@ filter_skipped() {
 	do
 		case "$VARS,$FOUND,$TRIED,$hash" in
 			# We display some vars.
-			1,*,*,*) echo "$hash $line" ;;
+			1,*,*,*) echo "$hash $line &&" ;;
 
 			# Split line.
 			,*,*,---*) ;;
 
 			# We had nothing to search.
 			,,,bisect_rev*)
-				echo "bisect_rev="
+				echo "bisect_rev= &&"
 				VARS=1
 				;;
 
@@ -311,7 +311,7 @@ filter_skipped() {
 			# This should happen only if the "bad"
 			# commit is also a "skip" commit.
 			,,*,bisect_rev*)
-				echo "bisect_rev='$TRIED'"
+				echo "bisect_rev='$TRIED' &&"
 				VARS=1
 				;;
 
@@ -321,8 +321,8 @@ filter_skipped() {
 				case "$_skip" in
 				*$hash*) ;;
 				*)
-					echo "bisect_rev=$hash"
-					echo "bisect_tried='$TRIED'"
+					echo "bisect_rev=$hash &&"
+					echo "bisect_tried='$TRIED' &&"
 					FOUND=1
 					;;
 				esac
@@ -332,16 +332,19 @@ filter_skipped() {
 			,1,*,bisect_rev*) VARS=1 ;;
 			,1,*,*) ;;
 
-			# ???
-			*) die "filter_skipped error " \
-			    "VARS: '$VARS' " \
-			    "FOUND: '$FOUND' " \
-			    "TRIED: '$TRIED' " \
-			    "hash: '$hash' " \
-			    "line: '$line'"
-			;;
+			# Unexpected input
+			*)
+				echo "die 'filter_skipped error'"
+				die "filter_skipped error " \
+				    "VARS: '$VARS' " \
+				    "FOUND: '$FOUND' " \
+				    "TRIED: '$TRIED' " \
+				    "hash: '$hash' " \
+				    "line: '$line'"
+				;;
 		esac
 	done
+	echo ':'
 }
 
 exit_if_skipped_commits () {
-- 
1.6.2.rc1.257.g6c75
