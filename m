From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] bisect: avoid pipes to better catch "git rev-list" errors
Date: Sun, 29 Mar 2009 11:58:32 +0200
Message-ID: <20090329115832.28acd74e.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 29 12:01:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnrpC-00076v-Un
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 12:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753617AbZC2J7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 05:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752960AbZC2J7g
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 05:59:36 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:55983 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751452AbZC2J7f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 05:59:35 -0400
Received: from smtp5-g21.free.fr (localhost [127.0.0.1])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 2957CD48070;
	Sun, 29 Mar 2009 11:59:26 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g21.free.fr (Postfix) with SMTP id 19B35D480F7;
	Sun, 29 Mar 2009 11:59:24 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115013>

When doing:

eval "git rev-list --bisect-vars ..." | {
        while read line
        do
                echo "$line &&"
        done
        echo ':'
}

the result code comes from the last "echo ':'", not from running
"git rev-list --bisect-vars ...".

This means that we may miss errors from "git rev-list".

To fix that, this patch gets rid of the pipes by redirecting the
output of "git rev-list" into a file, and then reading from this
file.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

This applies to master.

diff --git a/git-bisect.sh b/git-bisect.sh
index e313bde..45214ca 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -284,19 +284,22 @@ filter_skipped() {
 	_skip="$2"
 
 	if [ -z "$_skip" ]; then
-		eval "$_eval" | {
+		eval "$_eval" > "$GIT_DIR/BISECT_EVAL_TMP" &&
+		{
 			while read line
 			do
 				echo "$line &&"
-			done
+			done < "$GIT_DIR/BISECT_EVAL_TMP" &&
 			echo ':'
-		}
+		} &&
+		rm -f "$GIT_DIR/BISECT_EVAL_TMP"
 		return
 	fi
 
 	# Let's parse the output of:
 	# "git rev-list --bisect-vars --bisect-all ..."
-	eval "$_eval" | {
+	eval "$_eval" > "$GIT_DIR/BISECT_EVAL_TMP" &&
+	{
 		VARS= FOUND= TRIED=
 		while read hash line
 		do
@@ -349,9 +352,10 @@ filter_skipped() {
 				    "line: '$line'"
 				;;
 			esac
-		done
+		done < "$GIT_DIR/BISECT_EVAL_TMP" &&
 		echo ':'
-	}
+	} &&
+	rm -f "$GIT_DIR/BISECT_EVAL_TMP"
 }
 
 exit_if_skipped_commits () {
-- 
1.6.2.1.404.gb0085.dirty
