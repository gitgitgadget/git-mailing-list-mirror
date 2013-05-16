From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH v4 02/15] t6019: test file dropped in -s ours merge
Date: Thu, 16 May 2013 18:32:28 +0300
Message-ID: <1368718361-27859-3-git-send-email-kevin@bracey.fi>
References: <1368718361-27859-1-git-send-email-kevin@bracey.fi>
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 18:09:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud0kS-0000Vj-J8
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 18:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651Ab3EPQJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 12:09:40 -0400
Received: from mo4.mail-out.ovh.net ([178.32.228.4]:46141 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256Ab3EPQJk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 12:09:40 -0400
Received: from mail92.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id 8D72C10540E5
	for <git@vger.kernel.org>; Thu, 16 May 2013 17:33:05 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 16 May 2013 17:33:05 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 16 May 2013 17:33:00 +0200
X-Ovh-Mailout: 178.32.228.4 (mo4.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.3.rc0.28.g4b02ef5
In-Reply-To: <1368718361-27859-1-git-send-email-kevin@bracey.fi>
X-Ovh-Tracer-Id: 18170898598020878560
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -58
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrkeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlgedvmd
X-Spam-Check: DONE|U 0.500025/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -58
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrkeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlgedvmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224589>

In preparation for upcoming TREESAME work, check the result for G.t,
which is dropped in "-s ours" merge L. The default rev-list is empty, as
expected - it follows the first parent path where it never existed.

Unfortunately, --ancestry-path is also empty. Merges H J and L are all
TREESAME to 1 parent, so are treated as TREESAME and not shown. This is
clearly undesirable in the case of merge L, which dropped our G.t by
taking the non-ancestry-path version. Document this as a known failure,
and expect "H J L", the 3 merges along the path that had to chose G.t
versions.

Signed-off-by: Kevin Bracey <kevin@bracey.fi>
---
 t/t6019-rev-list-ancestry-path.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/t6019-rev-list-ancestry-path.sh b/t/t6019-rev-list-ancestry-path.sh
index dd5b0e5..c3bc2e7 100755
--- a/t/t6019-rev-list-ancestry-path.sh
+++ b/t/t6019-rev-list-ancestry-path.sh
@@ -16,6 +16,9 @@ test_description='--ancestry-path'
 #
 #  F...I                 == F G H I
 #  --ancestry-path F...I == F H I
+#
+#  G..M -- G.t                 == [nothing - was dropped in "-s ours" merge L]
+#  --ancestry-path G..M -- G.t == H J L
 
 . ./test-lib.sh
 
@@ -89,6 +92,22 @@ test_expect_success 'rev-list --ancestry-path F...I' '
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
1.8.3.rc0.28.g4b02ef5
