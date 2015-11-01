From: Lukas Fleischer <lfleischer@lfos.de>
Subject: [PATCH 4/4] t5509: add basic tests for hideRefs
Date: Sun,  1 Nov 2015 20:34:23 +0100
Message-ID: <1446406463-22527-5-git-send-email-lfleischer@lfos.de>
References: <1446406463-22527-1-git-send-email-lfleischer@lfos.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 01 20:34:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsyOt-0000So-2H
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 20:34:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969AbbKATen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 14:34:43 -0500
Received: from elnino.cryptocrack.de ([46.165.227.75]:8371 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861AbbKATek (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 14:34:40 -0500
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id 03f69787;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	for <git@vger.kernel.org>;
	Sun, 1 Nov 2015 20:34:32 +0100 (CET)
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1446406463-22527-1-git-send-email-lfleischer@lfos.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280661>

Test whether regular and full hideRefs patterns work as expected when
namespaces are used.

Signed-off-by: Lukas Fleischer <lfleischer@lfos.de>
---
 t/t5509-fetch-push-namespaces.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/t/t5509-fetch-push-namespaces.sh b/t/t5509-fetch-push-namespaces.sh
index cc0b31f..a3f1060 100755
--- a/t/t5509-fetch-push-namespaces.sh
+++ b/t/t5509-fetch-push-namespaces.sh
@@ -82,4 +82,33 @@ test_expect_success 'mirroring a repository using a ref namespace' '
 	)
 '
 
+test_expect_success "Hide namespaced refs with transfer.hideRefs" '
+	cd pushee &&
+	test_config transfer.hideRefs refs/tags &&
+	GIT_NAMESPACE=namespace git ls-remote "ext::git %s ." >actual &&
+	printf "$commit1\trefs/heads/master\n" >expected &&
+	test_cmp expected actual &&
+	cd ..
+'
+
+test_expect_success "Check that transfer.hideRefs does not match unstripped refs" '
+	cd pushee &&
+	test_config transfer.hideRefs "refs/namespaces/namespace/refs/tags" &&
+	GIT_NAMESPACE=namespace git ls-remote "ext::git %s ." >actual &&
+	printf "$commit1\trefs/heads/master\n" >expected &&
+	printf "$commit0\trefs/tags/0\n" >>expected &&
+	printf "$commit1\trefs/tags/1\n" >>expected &&
+	test_cmp expected actual &&
+	cd ..
+'
+
+test_expect_success "Hide full refs with transfer.hideRefs" '
+	cd pushee &&
+	test_config transfer.hideRefs "^refs/namespaces/namespace/refs/tags" &&
+	GIT_NAMESPACE=namespace git ls-remote "ext::git %s ." >actual &&
+	printf "$commit1\trefs/heads/master\n" >expected &&
+	test_cmp expected actual &&
+	cd ..
+'
+
 test_done
-- 
2.6.2
