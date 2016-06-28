Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30F092018A
	for <e@80x24.org>; Tue, 28 Jun 2016 17:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbcF1R4x (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 13:56:53 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:48924 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752393AbcF1R4v (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2016 13:56:51 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 8CE8D20F66;
	Tue, 28 Jun 2016 13:56:49 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 28 Jun 2016 13:56:49 -0400
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:message-id:subject:to
	:x-sasl-enc:x-sasl-enc; s=smtpout; bh=69SvFh8mTOv8FTBCXYCUFVrTGy
	Q=; b=nN0F3jw7LMy+XY/zAbtGHPmDkvB2rkI54vHKZuwjAIfRgz1t1DANagwwQi
	KBMyph133lnVeAWlRmxj4HuIXt0AbKzSq3n/rBlI5DEQi5UzjH5oPg7krjfQgdM0
	kRl7Bc+CLPEXluw5+JpjzcdulmTXSFJd5kxgSXcUslRxBWtok=
X-Sasl-enc: hgB+q9qBqvAxJgqduSUWT1XiYLASf1ldOyH+MSGKuZhl 1467136609
Received: from localhost (unknown [46.189.27.162])
	by mail.messagingengine.com (Postfix) with ESMTPA id EEB73CC01B;
	Tue, 28 Jun 2016 13:56:48 -0400 (EDT)
From:	Patrick Steinhardt <ps@pks.im>
To:	git@vger.kernel.org
Cc:	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Hahler <git@thequod.de>
Subject: [PATCH] rebase -i: restore autostash on abort
Date:	Tue, 28 Jun 2016 19:57:04 +0200
Message-Id: <20160628175704.26095-1-ps@pks.im>
X-Mailer: git-send-email 2.9.0
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When we abort an interactive rebase we do so by calling
`die_abort`, which cleans up after us by removing the rebase
state directory. If the user has requested to use the autostash
feature, though, the state directory may also contain a reference
to the autostash, which will now be deleted.

Fix the issue by trying to re-apply the autostash in `die_abort`.
This will also handle the case where the autostash does not apply
cleanly anymore by recording it in a user-visible stash.

Reported-by: Daniel Hahler <git@thequod.de>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git-rebase--interactive.sh  |  1 +
 t/t3420-rebase-autostash.sh | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 05f22e4..4f499d2 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -212,6 +212,7 @@ exit_with_patch () {
 }
 
 die_abort () {
+	apply_autostash
 	rm -rf "$state_dir"
 	die "$1"
 }
diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index 944154b..2e1171e 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -192,4 +192,15 @@ test_expect_success 'abort rebase -i with --autostash' '
 	test_cmp expected file0
 '
 
+test_expect_success 'restore autostash on editor failure' '
+	test_when_finished "git reset --hard" &&
+	echo uncommited-content >file0 &&
+	(
+		test_set_editor "false" &&
+		test_must_fail git rebase -i --autostash HEAD^
+	) &&
+	echo uncommited-content >expected &&
+	test_cmp expected file0
+'
+
 test_done
-- 
2.9.0

