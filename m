From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 6/6] clone: add tests for cloning with empty path
Date: Wed, 29 Jul 2015 17:51:16 +0200
Message-ID: <1438185076-28870-7-git-send-email-ps@pks.im>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
 <1438185076-28870-1-git-send-email-ps@pks.im>
Cc: peff@peff.net, pclouds@gmail.com, gitster@pobox.com,
	Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 29 17:51:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKTdq-000115-RR
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 17:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753583AbbG2Pvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 11:51:31 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:38890 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753464AbbG2Pv3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2015 11:51:29 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 8B2A720DBA
	for <git@vger.kernel.org>; Wed, 29 Jul 2015 11:51:29 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Wed, 29 Jul 2015 11:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=/HVm
	SypBJiuyXf2/rx1lr38l3+s=; b=QU7uergpbsqztXTzskTgvjc5to8oagwxnNaH
	pDQSGP8euIc9dBURO0IL/bkFMcg/N6y1Epq69C65WWnlTe4ZU3PcsJcASgzTAztQ
	zLxqs7PWlyrfcjHUBMvohQCB3w4V8N3G/PKxH9lwUArwa4KV9eAsd8mrO+1pRyyY
	wwLUVaA=
X-Sasl-enc: r1hIVDcXqPWOuk5CuYLkFbLoGuBVbq8baELnayE7Zdnh 1438185088
Received: from localhost (unknown [46.189.27.162])
	by mail.messagingengine.com (Postfix) with ESMTPA id EAB3AC0001F;
	Wed, 29 Jul 2015 11:51:28 -0400 (EDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1438185076-28870-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274904>

Test behavior of `git clone` when working with an empty path
component. This may be the case when cloning a file system's root
directory or from a remote server's root.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1509-root-worktree.sh | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/t/t1509-root-worktree.sh b/t/t1509-root-worktree.sh
index 553a3f6..acfa133 100755
--- a/t/t1509-root-worktree.sh
+++ b/t/t1509-root-worktree.sh
@@ -237,6 +237,45 @@ test_foobar_foobar
 
 test_expect_success 'cleanup' 'rm -rf /.git'
 
+say "clone .git at root without reponame"
+
+test_expect_success 'go to /' 'cd /'
+test_expect_success 'setup' '
+	echo "Initialized empty Git repository in /.git/" > expected &&
+	git init > result &&
+	test_cmp expected result
+'
+
+test_clone_expect_dir() {
+	URL="$1"
+	DIR="$2"
+	echo "Cloning into '$DIR'..." >expected
+	echo "warning: You appear to have cloned an empty repository." >>expected
+	git clone "$URL" 2>result >result
+	rm -r "$DIR"
+	test_cmp expected result
+}
+
+test_expect_success 'go to /clones' 'mkdir /clones && cd /clones'
+test_expect_success 'simple clone of /' '
+	echo "fatal: No directory name could be guessed." > expected &&
+	echo "Please specify a directory on the command line" >> expected &&
+	test_expect_code 128 git clone / 2>result >result &&
+	test_cmp expected result'
+
+test_expect_success 'clone with file://' '
+	test_clone_expect_dir file://127.0.0.1/ 127.0.0.1'
+test_expect_success 'clone with file://user@' '
+	test_clone_expect_dir file://user@127.0.0.1/ 127.0.0.1'
+test_expect_success 'clone with file://user:password@' '
+	test_clone_expect_dir file://user:password@127.0.0.1/ 127.0.0.1'
+test_expect_success 'clone with file://:port' '
+	test_clone_expect_dir file://127.0.0.1:9999/ 127.0.0.1'
+test_expect_success 'clone with file://user:password@:port' '
+	test_clone_expect_dir file://user:password@127.0.0.1:9999/ 127.0.0.1'
+
+test_expect_success 'cleanup' 'rm -rf /.git /clones'
+
 say "auto bare gitdir"
 
 # DESTROYYYYY!!!!!
-- 
2.5.0
