From: Lukas Fleischer <lfleischer@lfos.de>
Subject: [PATCH v3 4/4] t5509: add basic tests for hideRefs
Date: Thu,  5 Nov 2015 07:07:31 +0100
Message-ID: <1446703651-9049-5-git-send-email-lfleischer@lfos.de>
References: <1446703651-9049-1-git-send-email-lfleischer@lfos.de>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 05 07:08:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuDiW-000386-Tz
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 07:08:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030656AbbKEGIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 01:08:06 -0500
Received: from elnino.cryptocrack.de ([46.165.227.75]:43646 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030300AbbKEGIE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 01:08:04 -0500
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id 79f7d1a2;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	Thu, 5 Nov 2015 07:07:36 +0100 (CET)
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1446703651-9049-1-git-send-email-lfleischer@lfos.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280902>

Test whether regular and full hideRefs patterns work as expected when
namespaces are used.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Lukas Fleischer <lfleischer@lfos.de>
---
 t/t5509-fetch-push-namespaces.sh | 41 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/t/t5509-fetch-push-namespaces.sh b/t/t5509-fetch-push-namespaces.sh
index cc0b31f..bc44ac3 100755
--- a/t/t5509-fetch-push-namespaces.sh
+++ b/t/t5509-fetch-push-namespaces.sh
@@ -82,4 +82,45 @@ test_expect_success 'mirroring a repository using a ref namespace' '
 	)
 '
 
+test_expect_success 'hide namespaced refs with transfer.hideRefs' '
+	GIT_NAMESPACE=namespace \
+		git -C pushee -c transfer.hideRefs=refs/tags \
+		ls-remote "ext::git %s ." >actual &&
+	printf "$commit1\trefs/heads/master\n" >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'check that transfer.hideRefs does not match unstripped refs' '
+	GIT_NAMESPACE=namespace \
+		git -C pushee -c transfer.hideRefs=refs/namespaces/namespace/refs/tags \
+		ls-remote "ext::git %s ." >actual &&
+	printf "$commit1\trefs/heads/master\n" >expected &&
+	printf "$commit0\trefs/tags/0\n" >>expected &&
+	printf "$commit1\trefs/tags/1\n" >>expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'hide full refs with transfer.hideRefs' '
+	GIT_NAMESPACE=namespace \
+		git -C pushee -c transfer.hideRefs="^refs/namespaces/namespace/refs/tags" \
+		ls-remote "ext::git %s ." >actual &&
+	printf "$commit1\trefs/heads/master\n" >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'try to update a hidden ref' '
+	test_config -C pushee transfer.hideRefs refs/heads/master &&
+	test_must_fail git -C original push pushee-namespaced master
+'
+
+test_expect_success 'try to update a ref that is not hidden' '
+	test_config -C pushee transfer.hideRefs refs/namespaces/namespace/refs/heads/master &&
+	git -C original push pushee-namespaced master
+'
+
+test_expect_success 'try to update a hidden full ref' '
+	test_config -C pushee transfer.hideRefs "^refs/namespaces/namespace/refs/heads/master" &&
+	test_must_fail git -C original push pushee-namespaced master
+'
+
 test_done
-- 
2.6.2
