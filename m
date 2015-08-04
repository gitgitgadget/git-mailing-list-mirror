From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 6/6] clone: add tests for cloning with empty path
Date: Tue,  4 Aug 2015 13:29:57 +0200
Message-ID: <1438687797-14254-7-git-send-email-ps@pks.im>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
 <1438687797-14254-1-git-send-email-ps@pks.im>
Cc: ps@pks.im, peff@peff.net, pclouds@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 13:30:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMaQT-0006sg-5v
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 13:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933417AbbHDLaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 07:30:25 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:53957 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933201AbbHDLaV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Aug 2015 07:30:21 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 1D26C20C39
	for <git@vger.kernel.org>; Tue,  4 Aug 2015 07:30:21 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 04 Aug 2015 07:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=/6mX
	8H3L1HXwJIekvJ6tGZsGlog=; b=N8rnhSOqtk9qDR9txbcT+rnnfFd9oA5caQy+
	Uzc7ObBz+ZLjjZlspwaDYJtmSspJapVzTkbuIgxfAUmL2vOOFudozrXXqAogxVs5
	M/6qLM6nZXxKS4K0GiWdcrPMGjA2VjkigZZgIv/y8mt/5KhG9/+2GiQCkOIXHEnn
	luDSenc=
X-Sasl-enc: HHJbyj+lt/smvCBum/qPHlQCBWslAc2VkLbKTrY2e4qf 1438687820
Received: from localhost (x5ce1225a.dyn.telefonica.de [92.225.34.90])
	by mail.messagingengine.com (Postfix) with ESMTPA id 9AB9A680195;
	Tue,  4 Aug 2015 07:30:20 -0400 (EDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1438687797-14254-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275248>

Test behavior of `git clone` when working with an empty path
component. This may be the case when cloning a file system's root
directory or from a remote server's root.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1509-root-worktree.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/t/t1509-root-worktree.sh b/t/t1509-root-worktree.sh
index 553a3f6..d521ca3 100755
--- a/t/t1509-root-worktree.sh
+++ b/t/t1509-root-worktree.sh
@@ -237,6 +237,49 @@ test_foobar_foobar
 
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
+	cat <<-EOF >expected &&
+		Cloning into '$DIR'...
+		warning: You appear to have cloned an empty repository.
+		EOF
+	git clone "$URL" >result 2>&1 &&
+	rm -rf "$DIR" &&
+	test_cmp expected result
+}
+
+test_expect_success 'go to /clones' 'mkdir /clones && cd /clones'
+test_expect_success 'simple clone of /' '
+	cat <<-EOF >expected &&
+		fatal: No directory name could be guessed.
+		Please specify a directory on the command line
+		EOF
+	test_expect_code 128 git clone / >result 2>&1 &&
+	test_cmp expected result'
+
+test_expect_success 'clone with file://host/' '
+	test_clone_expect_dir file://127.0.0.1/ 127.0.0.1'
+test_expect_success 'clone with file://user@host/' '
+	test_clone_expect_dir file://user@127.0.0.1/ 127.0.0.1'
+test_expect_success 'clone with file://user:password@host/' '
+	test_clone_expect_dir file://user:password@127.0.0.1/ 127.0.0.1'
+test_expect_success 'clone with file://host:port/' '
+	test_clone_expect_dir file://127.0.0.1:9999/ 127.0.0.1'
+test_expect_success 'clone with file://user:password@host:port' '
+	test_clone_expect_dir file://user:password@127.0.0.1:9999/ 127.0.0.1'
+
+test_expect_success 'cleanup' 'rm -rf /.git /clones'
+
 say "auto bare gitdir"
 
 # DESTROYYYYY!!!!!
-- 
2.5.0
