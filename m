From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] bisect: print an error message when
 "git rev-list --bisect-vars" fails
Date: Wed, 7 May 2008 23:54:28 +0200
Message-ID: <20080507235428.a3579911.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed May 07 23:52:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtrWz-0005nR-0O
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 23:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757571AbYEGVtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 17:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755298AbYEGVtj
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 17:49:39 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:36514 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757915AbYEGVth (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 17:49:37 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id DD7F91AB2DB;
	Wed,  7 May 2008 23:49:35 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 810331AB2C3;
	Wed,  7 May 2008 23:49:35 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81481>

Before this patch no error was printed when "git rev-list --bisect-vars"
failed. This can happen when bad and good revs are mistaken.

This patch prints an error message on stderr that describe the likely
failure cause.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh               |   19 +++++++++++++++++--
 t/t6030-bisect-porcelain.sh |    7 +++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index b5171c9..164e8ed 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -224,18 +224,33 @@ bisect_auto_next() {
 	bisect_next_check && bisect_next || :
 }
 
+eval_rev_list() {
+	_eval="$1"
+
+	eval $_eval
+	res=$?
+
+	if [ $res -ne 0 ]; then
+		echo >&2 "'git rev-list --bisect-vars' failed:"
+		echo >&2 "maybe you mistake good and bad revs?"
+		exit $res
+	fi
+
+	return $res
+}
+
 filter_skipped() {
 	_eval="$1"
 	_skip="$2"
 
 	if [ -z "$_skip" ]; then
-		eval $_eval
+		eval_rev_list "$_eval"
 		return
 	fi
 
 	# Let's parse the output of:
 	# "git rev-list --bisect-vars --bisect-all ..."
-	eval $_eval | while read hash line
+	eval_rev_list "$_eval" | while read hash line
 	do
 		case "$VARS,$FOUND,$TRIED,$hash" in
 			# We display some vars.
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index ccd459b..b5102fb 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -302,6 +302,13 @@ test_expect_success 'bisect refuses to start if branch new-bisect exists' '
 	git branch -d new-bisect
 '
 
+test_expect_success 'bisect errors out if bad and good are mistaken' '
+	git bisect reset &&
+	test_must_fail git bisect start $HASH2 $HASH4 2> rev_list_error &&
+	grep "mistake good and bad" rev_list_error &&
+	git bisect reset
+'
+
 #
 #
 test_done
-- 
1.5.5.1.322.g312d.dirty
