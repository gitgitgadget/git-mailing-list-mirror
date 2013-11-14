From: Torstein Hegge <hegge@resisty.net>
Subject: [PATCH] branch: fix --verbose output column alignment
Date: Thu, 14 Nov 2013 19:18:01 +0100
Message-ID: <1384453081-7679-1-git-send-email-hegge@resisty.net>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Torstein Hegge <hegge@resisty.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 14 19:19:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vh1WD-0006Zp-Hu
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 19:19:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755049Ab3KNSTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 13:19:50 -0500
Received: from microbel.pvv.ntnu.no ([129.241.210.179]:34052 "EHLO
	microbel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999Ab3KNSTs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 13:19:48 -0500
Received: from 120.179.202.84.customer.cdi.no ([84.202.179.120] helo=stacker.resisty.net)
	by microbel.pvv.ntnu.no with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <torstehe@pvv.ntnu.no>)
	id 1Vh1Vk-0007ZG-1U; Thu, 14 Nov 2013 19:19:25 +0100
X-Mailer: git-send-email 1.8.5.rc0.216.ge00de29
X-Spam-Score: -0.9 (/)
X-Spam-Report: Status=No hits=-0.9 required=5.0 tests=ALL_TRUSTED,TVD_RCVD_IP version=3.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237859>

Commit f2e0873 (branch: report invalid tracking branch as gone) removed
an early return from fill_tracking_info() in the path taken when 'git
branch -v' lists a branch in sync with its upstream. This resulted in an
unconditionally added space in front of the subject line:

    $ git branch -v
    * master f5eb3da  commit pushed to upstream
      topic  f935eb6 unpublished topic

Instead, only add the trailing space if a decoration have been added.

To catch this kind of whitespace breakage in the tests, be a bit less
smart when filtering the output through sed.

Signed-off-by: Torstein Hegge <hegge@resisty.net>
---
 builtin/branch.c         |  8 +++++++-
 t/t6040-tracking-info.sh | 24 +++++++++++++-----------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 0bb0e93..636a16e 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -424,6 +424,7 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 	struct branch *branch = branch_get(branch_name);
 	struct strbuf fancy = STRBUF_INIT;
 	int upstream_is_gone = 0;
+	int added_decoration = 1;
 
 	switch (stat_tracking_info(branch, &ours, &theirs)) {
 	case 0:
@@ -451,9 +452,13 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 	if (upstream_is_gone) {
 		if (show_upstream_ref)
 			strbuf_addf(stat, _("[%s: gone]"), fancy.buf);
+		else
+			added_decoration = 0;
 	} else if (!ours && !theirs) {
 		if (show_upstream_ref)
 			strbuf_addf(stat, _("[%s]"), fancy.buf);
+		else
+			added_decoration = 0;
 	} else if (!ours) {
 		if (show_upstream_ref)
 			strbuf_addf(stat, _("[%s: behind %d]"), fancy.buf, theirs);
@@ -474,7 +479,8 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 				    ours, theirs);
 	}
 	strbuf_release(&fancy);
-	strbuf_addch(stat, ' ');
+	if (added_decoration)
+		strbuf_addch(stat, ' ');
 	free(ref);
 }
 
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index ba26cfe..7ac8fd0 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -39,12 +39,14 @@ test_expect_success setup '
 	advance h
 '
 
-script='s/^..\(b.\)[	 0-9a-f]*\[\([^]]*\)\].*/\1 \2/p'
+script='s/^..\(b.\) *[0-9a-f]* \(.*\)$/\1 \2/p'
 cat >expect <<\EOF
-b1 ahead 1, behind 1
-b2 ahead 1, behind 1
-b3 behind 1
-b4 ahead 2
+b1 [ahead 1, behind 1] d
+b2 [ahead 1, behind 1] d
+b3 [behind 1] b
+b4 [ahead 2] f
+b5 g
+b6 c
 EOF
 
 test_expect_success 'branch -v' '
@@ -57,12 +59,12 @@ test_expect_success 'branch -v' '
 '
 
 cat >expect <<\EOF
-b1 origin/master: ahead 1, behind 1
-b2 origin/master: ahead 1, behind 1
-b3 origin/master: behind 1
-b4 origin/master: ahead 2
-b5 brokenbase: gone
-b6 origin/master
+b1 [origin/master: ahead 1, behind 1] d
+b2 [origin/master: ahead 1, behind 1] d
+b3 [origin/master: behind 1] b
+b4 [origin/master: ahead 2] f
+b5 [brokenbase: gone] g
+b6 [origin/master] c
 EOF
 
 test_expect_success 'branch -vv' '
-- 
1.8.5.rc0.216.ge00de29
