From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH v2] mergetool: Remove explicit references to /dev/tty
Date: Fri, 20 Aug 2010 16:25:09 +0100
Message-ID: <1282317909-13628-1-git-send-email-charles@hashpling.org>
References: <20100820122724.GS10407@burratino>
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Magnus=20B=C3=A4ck?= <magnus.back@sonyericsson.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Charles Bailey <charles@hashpling.org>
To: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 20 17:26:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmTTk-0008GO-3F
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 17:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753283Ab0HTPZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 11:25:50 -0400
Received: from relay.ptn-ipout01.plus.net ([212.159.7.35]:4764 "EHLO
	relay.ptn-ipout01.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752824Ab0HTPZt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Aug 2010 11:25:49 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAOQ7bkzUnw4T/2dsb2JhbACgUHG8J4U3BA
Received: from outmx04.plus.net ([212.159.14.19])
  by relay.ptn-ipout01.plus.net with ESMTP; 20 Aug 2010 16:25:36 +0100
Received: from hashpling.plus.com ([212.159.69.125])
	 by outmx04.plus.net with esmtp (Exim) id 1OmTTL-0001Gq-I5; Fri, 20 Aug 2010 16:25:35 +0100
Received: from charles by hashpling.plus.com with local (Exim 4.72)
	(envelope-from <charles@hashpling.org>)
	id 1OmTTK-0003Yg-7v; Fri, 20 Aug 2010 16:25:34 +0100
X-Mailer: git-send-email 1.7.2.2.110.gf04b9.dirty
In-Reply-To: <20100820122724.GS10407@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154050>

mergetool used /dev/tty to switch back to receiving input from the user
via inside a block with a redirected stdin.

This harms testability, so change mergetool to save its original stdin
to an alternative fd in this block and restore it for those sub-commands
that need the original stdin.

Includes additional compatibility fix from Jonathan Nieder.

Tested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Charles Bailey <charles@hashpling.org>
---

Now works on ksh as well as bash and dash.

 git-mergetool--lib.sh |    2 +-
 git-mergetool.sh      |    7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

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
index bd7ab02..165b700 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -279,6 +279,9 @@ files_to_merge() {
 if test $# -eq 0 ; then
     cd_to_toplevel
 
+    # Save original stdin
+    exec 3<&0
+
     if test -e "$GIT_DIR/MERGE_RR"
     then
 	rerere=true
@@ -296,10 +299,10 @@ if test $# -eq 0 ; then
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
