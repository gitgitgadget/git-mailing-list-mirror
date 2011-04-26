From: Johan Herland <johan@herland.net>
Subject: [PATCH 2/6] Make --dirstat=0 output directories that contribute < 0.1%
 of changes
Date: Tue, 26 Apr 2011 02:01:38 +0200
Message-ID: <1303776102-9085-3-git-send-email-johan@herland.net>
References: <BANLkTim9U4cOnV+5=Mp-2g_M6+JOiM5e7A@mail.gmail.com>
 <1303776102-9085-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 02:02:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEVjd-0006yW-HY
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 02:02:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380Ab1DZACG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2011 20:02:06 -0400
Received: from smtp.getmail.no ([84.208.15.66]:53577 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932157Ab1DZACE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2011 20:02:04 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LK80023WG3C6S30@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 26 Apr 2011 02:02:00 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id C25EF1EEFAA9_DB60B78B	for <git@vger.kernel.org>; Tue,
 26 Apr 2011 00:02:00 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 155211EEF930_DB60B78F	for <git@vger.kernel.org>; Tue,
 26 Apr 2011 00:02:00 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LK8006GDG35AA10@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 26 Apr 2011 02:01:59 +0200 (MEST)
X-Mailer: git-send-email 1.7.5.rc1.3.g4d7b
In-reply-to: <1303776102-9085-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172058>

The expected output from --dirstat=0, is to include any directory with
changes, even if those changes contribute a minuscule portion of the total
changes. However, currently, directories that contribute less than 0.1% are
not included, since their 'permille' value is 0, and there is an
'if (permille)' check in gather_dirstat() that causes them to be ignored.

This test is obviously intended to exclude directories that contribute no
changes whatsoever, but in this case, it hits too broadly. The correct
check is against 'this_dir' from which the permille is calculated. Only if
this value is 0 does the directory truly contribute no changes, and should
be skipped from the output.

This patches fixes this issue, and updates corresponding testcases to
expect the new behvaior.

Signed-off-by: Johan Herland <johan@herland.net>
---
 diff.c                  |    4 ++--
 t/t4046-diff-dirstat.sh |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index abd9cd5..cfbfa92 100644
--- a/diff.c
+++ b/diff.c
@@ -1500,8 +1500,8 @@ static long gather_dirstat(struct diff_options *opt, struct dirstat_dir *dir,
 	 *    under this directory (sources == 1).
 	 */
 	if (baselen && sources != 1) {
-		int permille = this_dir * 1000 / changed;
-		if (permille) {
+		if (this_dir) {
+			int permille = this_dir * 1000 / changed;
 			int percent = permille / 10;
 			if (percent >= dir->percent) {
 				fprintf(opt->file, "%s%4d.%01d%% %.*s\n", line_prefix,
diff --git a/t/t4046-diff-dirstat.sh b/t/t4046-diff-dirstat.sh
index 1690468..694a950 100755
--- a/t/t4046-diff-dirstat.sh
+++ b/t/t4046-diff-dirstat.sh
@@ -337,7 +337,6 @@ test_expect_success 'vanilla --dirstat' '
 	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
 '
 
-# rearranged/text falls below 0% threshold (1 / (240 * 9 + 48 + 1) ~= 0.045 %)
 cat <<EOF >expect_diff_dirstat
    2.1% changed/
   10.8% dst/copy/changed/
@@ -346,6 +345,7 @@ cat <<EOF >expect_diff_dirstat
   10.8% dst/move/changed/
   10.8% dst/move/rearranged/
   10.8% dst/move/unchanged/
+   0.0% rearranged/
   10.8% src/move/changed/
   10.8% src/move/rearranged/
   10.8% src/move/unchanged/
@@ -379,7 +379,6 @@ test_expect_success '--dirstat=0' '
 	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
 '
 
-# rearranged/text falls below 0% threshold (1 / (240 * 9 + 48 + 1) ~= 0.045 %)
 cat <<EOF >expect_diff_dirstat
    2.1% changed/
   10.8% dst/copy/changed/
@@ -391,6 +390,7 @@ cat <<EOF >expect_diff_dirstat
   10.8% dst/move/unchanged/
   32.5% dst/move/
   65.1% dst/
+   0.0% rearranged/
   10.8% src/move/changed/
   10.8% src/move/rearranged/
   10.8% src/move/unchanged/
-- 
1.7.5.rc1.3.g4d7b
