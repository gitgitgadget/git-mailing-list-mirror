From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] t4014: remove Message-Id/timestamp before comparing patches
Date: Mon, 19 Sep 2011 08:45:43 +0200
Message-ID: <6b2cb6ebec907342a02d56a36ddc58715efabc00.1316414731.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	<git@vger.kernel.org>
To: Pang Yan Han <pangyanhan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 19 08:45:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5Xc0-0002zY-MU
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 08:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810Ab1ISGpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 02:45:47 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:24653 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751763Ab1ISGpr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 02:45:47 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.339.1; Mon, 19 Sep
 2011 08:45:33 +0200
Received: from localhost.localdomain (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.339.1; Mon, 19 Sep
 2011 08:45:43 +0200
X-Mailer: git-send-email 1.7.7.rc1.366.ge210a6
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181666>

The test introduced in 787570c (format-patch: ignore ui.color,
2011-09-13) has a race condition: if the two format-patch invocations
do not ask for the current time in the same second, their Message-Id
headers will disagree.

Normally this would be a pretty unlikely occurrence.  However, under
valgrind format-patch runs so slowly that the race triggers every
time, with a time difference of 2-3s on my hardware.

To avoid this problem, replace the contents of the Message-Id header
with a dummy before comparing.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/t4014-format-patch.sh |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 7e405d7..8700089 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -886,11 +886,18 @@ test_expect_success 'empty subject prefix does not have extra space' '
 	test_cmp expect actual
 '
 
+strip_msgid () {
+	sed 's#\(Message-Id: *\)<[^>]*>#\1<MESSAGE@ID>#' "$1" >"$1+" &&
+	mv "$1+" "$1"
+}
+
 test_expect_success 'format patch ignores color.ui' '
 	test_unconfig color.ui &&
 	git format-patch --stdout -1 >expect &&
+	strip_msgid expect &&
 	test_config color.ui always &&
 	git format-patch --stdout -1 >actual &&
+	strip_msgid actual &&
 	test_cmp expect actual
 '
 
-- 
1.7.7.rc1.366.ge210a6
