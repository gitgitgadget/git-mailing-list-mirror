From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH] mergetool: Remove explicit references to /dev/tty
Date: Fri, 20 Aug 2010 12:17:29 +0100
Message-ID: <1282303049-11201-1-git-send-email-charles@hashpling.org>
References: <20100820035236.GA18267@gmail.com>
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Magnus=20B=C3=A4ck?= <magnus.back@sonyericsson.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Charles Bailey <charles@hashpling.org>
To: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 20 13:17:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmPbh-0005Pd-Ph
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 13:17:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631Ab0HTLRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 07:17:53 -0400
Received: from relay.pcl-ipout01.plus.net ([212.159.7.99]:43841 "EHLO
	relay.pcl-ipout01.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751050Ab0HTLRw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Aug 2010 07:17:52 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAAwBbkxUXebj/2dsb2JhbACgVXG6ZIU3BA
Received: from outmx01.plus.net ([84.93.230.227])
  by relay.pcl-ipout01.plus.net with ESMTP; 20 Aug 2010 12:17:51 +0100
Received: from hashpling.plus.com ([212.159.69.125])
	 by outmx01.plus.net with esmtp (Exim) id 1OmPba-00061E-No; Fri, 20 Aug 2010 12:17:50 +0100
Received: from charles by hashpling.plus.com with local (Exim 4.72)
	(envelope-from <charles@hashpling.org>)
	id 1OmPbZ-0002vB-BO; Fri, 20 Aug 2010 12:17:49 +0100
X-Mailer: git-send-email 1.7.2.2.110.gf04b9.dirty
In-Reply-To: <20100820035236.GA18267@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154014>

mergetool used /dev/tty to switch back to receiving input from the user
via inside a block with a redirected stdin.

This harms testability, so change mergetool to save its original stdin
to an alternative fd in this block and restore it for those sub-commands
that need the original stdin.

Signed-off-by: Charles Bailey <charles@hashpling.org>
---

This works on my fedora 12 box with bash. The redirects should be
standard but this could do with some testing on other bourne shell
implementations.

 git-mergetool--lib.sh |    2 +-
 git-mergetool.sh      |    7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 51dd0d6..b5e1943 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -35,7 +35,7 @@ check_unchanged () {
 		while true; do
 			echo "$MERGED seems unchanged."
 			printf "Was the merge successful? [y/n] "
-			read answer < /dev/tty
+			read answer
 			case "$answer" in
 			y*|Y*) status=0; break ;;
 			n*|N*) status=1; break ;;
diff --git a/git-mergetool.sh b/git-mergetool.sh
index bd7ab02..84edf7d 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -292,14 +292,15 @@ if test $# -eq 0 ; then
     printf "Merging:\n"
     printf "$files\n"
 
-    files_to_merge |
+    # Save original stdin to fd 3
+    files_to_merge 3<&0 |
     while IFS= read i
     do
 	if test $last_status -ne 0; then
-	    prompt_after_failed_merge < /dev/tty || exit 1
+	    prompt_after_failed_merge <&3 || exit 1
 	fi
 	printf "\n"
-	merge_file "$i" < /dev/tty > /dev/tty
+	merge_file "$i" <&3
 	last_status=$?
 	if test $last_status -ne 0; then
 	    rollup_status=1
-- 
1.7.2.2.110.gf04b9.dirty
