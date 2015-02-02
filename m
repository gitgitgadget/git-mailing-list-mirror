From: Jonathon Mah <me@jonathonmah.com>
Subject: [PATCHv2 1/2] t5304-prune: demonstrate bug in pruning alternates
Date: Mon, 2 Feb 2015 10:33:02 -0800
Message-ID: <0BD44E44-686B-44B2-A4C0-9E14A99BA96B@jonathonmah.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 19:33:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YILo7-0001uN-N2
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 19:33:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754724AbbBBSdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 13:33:07 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:41360 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754414AbbBBSdG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Feb 2015 13:33:06 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 8B1A120729
	for <git@vger.kernel.org>; Mon,  2 Feb 2015 13:33:02 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Mon, 02 Feb 2015 13:33:02 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=jonathonmah.com;
	 h=x-sasl-enc:from:content-type:content-transfer-encoding
	:subject:date:message-id:cc:to:mime-version; s=mesmtp; bh=qbLLFa
	98i3NRu+NlHhjW+18Qil4=; b=VyZZ8HISAQqq6n9aOKemuCLi94FQPPRlcE9tkQ
	ZQHCiYUmQ6ZQ98ta9zmDm/1+BYdqKXAa5SK2WLax8ebcvzYzjNpFSgoRYfSjJmHC
	JIVZHD5UE7ob1zwlBNi3PLeDVLU9/LCRYWQRNMx8rgh/tecxF0FdBV2vv1gcbyg8
	SbHgU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:content-type
	:content-transfer-encoding:subject:date:message-id:cc:to
	:mime-version; s=smtpout; bh=qbLLFa98i3NRu+NlHhjW+18Qil4=; b=a/e
	cmbP5wtYDkk7q3VG+aqaTIn9CjteC/Y/jrNSLWue+AK9VFFPDSqZZmxCSvY7b17g
	kejebBr+/HT4ONKqMN2wiGc2F9zzgXXPRYAsbrTemwpH2ZWuP0YgSNqouhCA9mXN
	rzJAwy4kZEdA1ZHuJHEiuLBOnvf4WdFel46p4r54=
X-Sasl-enc: Tamu0wpnCStJBOZt4pqimFV19vw+7B6+L2u1SBeFtBSz 1422901982
Received: from [172.16.3.162] (unknown [206.169.144.70])
	by mail.messagingengine.com (Postfix) with ESMTPA id D104CC00296;
	Mon,  2 Feb 2015 13:33:01 -0500 (EST)
X-Mailer: Apple Mail (2.2070.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263268>

Signed-off-by: Jonathon Mah <me@JonathonMah.com>
---
Adjust prune test directly, much nicer.

 t/t5304-prune.sh          | 13 +++++++++++++
 t/t5710-info-alternate.sh |  4 ++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index e32e46d..e825be7 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -253,4 +253,17 @@ test_expect_success 'prune .git/shallow' '
 	test_path_is_missing .git/shallow
 '
 
+test_expect_success 'prune: handle alternate object database' '
+	test_create_repo A && cd A &&
+	echo "Hello World" > file1 &&
+	git add file1 &&
+	git commit -m "Initial commit" file1 &&
+	cd .. &&
+	git clone -l -s A B && cd B &&
+	echo "foo bar" > file2 &&
+	git add file2 &&
+	git commit -m "next commit" file2 &&
+	git prune
+'
+
 test_done
diff --git a/t/t5710-info-alternate.sh b/t/t5710-info-alternate.sh
index 5a6e49d..d82844a 100755
--- a/t/t5710-info-alternate.sh
+++ b/t/t5710-info-alternate.sh
@@ -18,6 +18,7 @@ reachable_via() {
 
 test_valid_repo() {
 	git fsck --full > fsck.log &&
+	git prune &&
 	test_line_count = 0 fsck.log
 }
 
@@ -47,8 +48,7 @@ test_expect_success 'preparing third repository' \
 'git clone -l -s B C && cd C &&
 echo "Goodbye, cruel world" > file3 &&
 git add file3 &&
-git commit -m "one more" file3 &&
-git repack -a -d -l &&
+git commit -m "one more without packing" file3 &&
 git prune'
 
 cd "$base_dir"
-- 
2.3.0.rc2.2.g184f7a0
