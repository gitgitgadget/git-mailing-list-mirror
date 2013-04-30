From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH v2 5/8] t6012: update test for tweaked full-history traversal
Date: Tue, 30 Apr 2013 20:26:25 +0300
Message-ID: <1367342788-7795-6-git-send-email-kevin@bracey.fi>
References: <1367342788-7795-1-git-send-email-kevin@bracey.fi>
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 30 19:35:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXESp-0005j8-8N
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 19:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761277Ab3D3Ref (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 13:34:35 -0400
Received: from 10.mo5.mail-out.ovh.net ([46.105.52.148]:34424 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760805Ab3D3Ree (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 13:34:34 -0400
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Apr 2013 13:34:33 EDT
Received: from mail414.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id BF6C9FFA59D
	for <git@vger.kernel.org>; Tue, 30 Apr 2013 19:26:57 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 30 Apr 2013 19:26:57 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 30 Apr 2013 19:26:55 +0200
X-Ovh-Mailout: 178.32.228.5 (mo5.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.2.1.632.gd2b1879
In-Reply-To: <1367342788-7795-1-git-send-email-kevin@bracey.fi>
X-Ovh-Tracer-Id: 18365397806480527587
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrheehucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrheehucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222963>

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
1.8.2.1.632.gd2b1879
