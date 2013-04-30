From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH v2 2/8] t6019: test file dropped in -s ours merge
Date: Tue, 30 Apr 2013 20:26:22 +0300
Message-ID: <1367342788-7795-3-git-send-email-kevin@bracey.fi>
References: <1367342788-7795-1-git-send-email-kevin@bracey.fi>
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 30 21:54:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXGdL-0001FI-PQ
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 21:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760223Ab3D3Tyg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 15:54:36 -0400
Received: from 13.mo5.mail-out.ovh.net ([87.98.182.191]:38564 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759985Ab3D3Tye (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 15:54:34 -0400
X-Greylist: delayed 4198 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Apr 2013 15:54:34 EDT
Received: from mail414.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id 7989CFFA515
	for <git@vger.kernel.org>; Tue, 30 Apr 2013 19:26:51 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 30 Apr 2013 19:26:51 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 30 Apr 2013 19:26:49 +0200
X-Ovh-Mailout: 178.32.228.5 (mo5.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.2.1.632.gd2b1879
In-Reply-To: <1367342788-7795-1-git-send-email-kevin@bracey.fi>
X-Ovh-Tracer-Id: 18363427481643552992
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrheehucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.501522/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrheehucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222998>

In preparation for upcoming TREESAME work, check the result for G.t,
which is dropped in "-s ours" merge L. The default rev-list is empty, as
expected - it follows the first parent path where it never existed.

Unfortunately, --ancestry-path is also empty. Merges H J and L are all
TREESAME to 1 parent, so are treated as TREESAME and not shown. This is
clearly undesirable in the case of merge L, which dropped our G.t by
taking the non-ancestry-path version. Document this as a known failure,
and expect "H J L", the 3 merges along the path that had to choose
between G.t versions.

Signed-off-by: Kevin Bracey <kevin@bracey.fi>
---
 t/t6019-rev-list-ancestry-path.sh | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/t/t6019-rev-list-ancestry-path.sh b/t/t6019-rev-list-ancestry-path.sh
index 39b4cb0..86ef908 100755
--- a/t/t6019-rev-list-ancestry-path.sh
+++ b/t/t6019-rev-list-ancestry-path.sh
@@ -13,6 +13,9 @@ test_description='--ancestry-path'
 #
 #  D..M -- M.t                 == M
 #  --ancestry-path D..M -- M.t == M
+#
+#  G..M -- G.t                 == [nothing - was dropped in "-s ours" merge L]
+#  --ancestry-path G..M -- G.t == H J L
 
 . ./test-lib.sh
 
@@ -63,13 +66,29 @@ test_expect_success 'rev-list D..M -- M.t' '
 	test_cmp expect actual
 '
 
-test_expect_success 'rev-list --ancestry-patch D..M -- M.t' '
+test_expect_success 'rev-list --ancestry-path D..M -- M.t' '
 	echo M >expect &&
 	git rev-list --ancestry-path --format=%s D..M -- M.t |
 	sed -e "/^commit /d" >actual &&
 	test_cmp expect actual
 '
 
+# G.t is dropped in an "-s ours" merge
+test_expect_success 'rev-list G..M -- G.t' '
+	>expect &&
+	git rev-list --format=%s G..M -- G.t |
+	sed -e "/^commit /d" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'rev-list --ancestry-path G..M -- G.t' '
+	for c in H J L; do echo $c; done >expect &&
+	git rev-list --ancestry-path --format=%s G..M -- G.t |
+	sed -e "/^commit /d" |
+	sort >actual &&
+	test_cmp expect actual
+'
+
 #   b---bc
 #  / \ /
 # a   X
-- 
1.8.2.1.632.gd2b1879
