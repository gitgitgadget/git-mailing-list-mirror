From: Mike Hommey <mh@glandium.org>
Subject: [PATCH 2/2] Add tests for git tag
Date: Sun,  4 Nov 2007 01:11:15 +0100
Message-ID: <1194135075-28706-2-git-send-email-mh@glandium.org>
References: <7vlk9fxj1r.fsf@gitster.siamese.dyndns.org>
 <1194135075-28706-1-git-send-email-mh@glandium.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 01:12:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoT6H-0005R1-5d
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 01:12:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757794AbXKDAMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 20:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757575AbXKDAMK
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 20:12:10 -0400
Received: from vawad.err.no ([85.19.200.177]:41835 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757361AbXKDAMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 20:12:09 -0400
Received: from aputeaux-153-1-38-67.w82-124.abo.wanadoo.fr ([82.124.130.67] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IoT5v-0007ma-Me; Sun, 04 Nov 2007 01:12:07 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1IoT59-0007Tu-AY; Sun, 04 Nov 2007 01:11:15 +0100
X-Mailer: git-send-email 1.5.3.5
In-Reply-To: <1194135075-28706-1-git-send-email-mh@glandium.org>
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63325>

These tests check whether git-tag properly sends a comment into the
editor, and whether it reuses previous annotation when overwriting
an existing tag.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 t/t7004-tag.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 0d07bc3..096fe33 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1004,4 +1004,20 @@ test_expect_failure \
 	'verify signed tag fails when public key is not present' \
 	'git-tag -v signed-tag'
 
+test_expect_success \
+	'message in editor has initial comment' '
+	GIT_EDITOR=cat git tag -a initial-comment > actual || true &&
+	test $(sed -n "/^\(#\|\$\)/p" actual | wc -l) -gt 0
+'
+
+get_tag_header reuse $commit commit $time >expect
+echo "An annotation to be reused" >> expect
+test_expect_success \
+	'overwriting an annoted tag should use its previous body' '
+	git tag -a -m "An annotation to be reused" reuse &&
+	GIT_EDITOR=true git tag -f -a reuse &&
+	get_tag_msg reuse >actual &&
+	git diff expect actual
+'
+
 test_done
-- 
1.5.3.5
