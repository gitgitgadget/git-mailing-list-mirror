From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH v4 09/15] t6012: update test for tweaked full-history traversal
Date: Thu, 16 May 2013 18:32:35 +0300
Message-ID: <1368718361-27859-10-git-send-email-kevin@bracey.fi>
References: <1368718361-27859-1-git-send-email-kevin@bracey.fi>
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 17:33:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud0BD-0003hg-8x
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 17:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760Ab3EPPdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 11:33:15 -0400
Received: from 12.mo4.mail-out.ovh.net ([178.33.104.253]:55699 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752682Ab3EPPdN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 11:33:13 -0400
Received: from mail92.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id 9B0C410540ED
	for <git@vger.kernel.org>; Thu, 16 May 2013 17:33:12 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 16 May 2013 17:33:12 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 16 May 2013 17:33:08 +0200
X-Ovh-Mailout: 178.32.228.4 (mo4.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.3.rc0.28.g4b02ef5
In-Reply-To: <1368718361-27859-1-git-send-email-kevin@bracey.fi>
X-Ovh-Tracer-Id: 18173150397834563815
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrkeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrkeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224574>

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t6012-rev-list-simplify.sh | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
index dd6dc84..4e55872 100755
--- a/t/t6012-rev-list-simplify.sh
+++ b/t/t6012-rev-list-simplify.sh
@@ -14,21 +14,24 @@ unnote () {
 
 test_expect_success setup '
 	echo "Hi there" >file &&
-	git add file &&
-	test_tick && git commit -m "Initial file" &&
+	echo "initial" >lost &&
+	git add file lost &&
+	test_tick && git commit -m "Initial file and lost" &&
 	note A &&
 
 	git branch other-branch &&
 
 	echo "Hello" >file &&
-	git add file &&
-	test_tick && git commit -m "Modified file" &&
+	echo "second" >lost &&
+	git add file lost &&
+	test_tick && git commit -m "Modified file and lost" &&
 	note B &&
 
 	git checkout other-branch &&
 
 	echo "Hello" >file &&
-	git add file &&
+	>lost &&
+	git add file lost &&
 	test_tick && git commit -m "Modified the file identically" &&
 	note C &&
 
@@ -37,7 +40,9 @@ test_expect_success setup '
 	test_tick && git commit -m "Add another file" &&
 	note D &&
 
-	test_tick && git merge -m "merge" master &&
+	test_tick &&
+	test_must_fail git merge -m "merge" master &&
+	>lost && git commit -a -m "merge" &&
 	note E &&
 
 	echo "Yet another" >elif &&
@@ -110,4 +115,16 @@ check_result 'I B A' -- file
 check_result 'I B A' --topo-order -- file
 check_result 'H' --first-parent -- another-file
 
+check_result 'E C B A' --full-history E -- lost
+test_expect_success 'full history simplification without parent' '
+	printf "%s\n" E C B A >expect &&
+	git log --pretty="$FMT" --full-history E -- lost |
+	unnote >actual &&
+	sed -e "s/^.*	\([^ ]*\) .*/\1/" >check <actual &&
+	test_cmp expect check || {
+		cat actual
+		false
+	}
+'
+
 test_done
-- 
1.8.3.rc0.28.g4b02ef5
