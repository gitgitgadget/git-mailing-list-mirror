From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH 1/2] t6019: demonstrate --ancestry-path A...B breakage
Date: Mon, 13 May 2013 18:00:46 +0300
Message-ID: <1368457247-19822-2-git-send-email-kevin@bracey.fi>
References: <5190F806.6040207@bracey.fi>
 <1368457247-19822-1-git-send-email-kevin@bracey.fi>
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 13 17:10:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbuOU-0003eg-H0
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 17:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373Ab3EMPK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 11:10:26 -0400
Received: from mo5.mail-out.ovh.net ([178.32.228.5]:41769 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120Ab3EMPK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 11:10:26 -0400
Received: from mail624.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id AB43FFFA986
	for <git@vger.kernel.org>; Mon, 13 May 2013 17:01:03 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 13 May 2013 17:01:22 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 13 May 2013 17:01:20 +0200
X-Ovh-Mailout: 178.32.228.5 (mo5.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.3.rc0.28.g4b02ef5
In-Reply-To: <1368457247-19822-1-git-send-email-kevin@bracey.fi>
X-Ovh-Tracer-Id: 17732924802568415
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -58
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrjeehucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlgedvmd
X-Spam-Check: DONE|U 0.500009/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -58
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrjeehucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlgedvmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224169>

Signed-off-by: Kevin Bracey <kevin@bracey.fi>
---
 t/t6019-rev-list-ancestry-path.sh | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/t/t6019-rev-list-ancestry-path.sh b/t/t6019-rev-list-ancestry-path.sh
index 39b4cb0..5287f6a 100755
--- a/t/t6019-rev-list-ancestry-path.sh
+++ b/t/t6019-rev-list-ancestry-path.sh
@@ -13,6 +13,9 @@ test_description='--ancestry-path'
 #
 #  D..M -- M.t                 == M
 #  --ancestry-path D..M -- M.t == M
+#
+#  F...I                 == F G H I
+#  --ancestry-path F...I == F H I
 
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
 
+test_expect_success 'rev-list F...I' '
+	for c in F G H I; do echo $c; done >expect &&
+	git rev-list --format=%s F...I |
+	sed -e "/^commit /d" |
+	sort >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'rev-list --ancestry-path F...I' '
+	for c in F H I; do echo $c; done >expect &&
+	git rev-list --ancestry-path --format=%s F...I |
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
