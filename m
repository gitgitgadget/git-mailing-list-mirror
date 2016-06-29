Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 278A22018A
	for <e@80x24.org>; Wed, 29 Jun 2016 06:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbcF2GVI (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 02:21:08 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56357 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750756AbcF2GVH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jun 2016 02:21:07 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id DFD8F20B4C;
	Wed, 29 Jun 2016 02:21:05 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Wed, 29 Jun 2016 02:21:06 -0400
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=a56h
	62C3aZOTzB68iJqS+cie2To=; b=ormAKtO4S5DtmHpIAZCQd1QhF7kRwesfFYQw
	lASQIjDWR7dGn2MMoNfoe3DXLJDi96Rv3pl0ctFG5zJr5vtlllcvMXrGWb47/ITe
	W5ujQJUzVIopXZbE20l5ZqLStlM9qEWSoarBJob60JwY2BX2+OLWGB1RAmKN43Gb
	z+CzqMA=
X-Sasl-enc: QGFvfV642x6WviVpITABydkTedXBlAVm30PnzMX3PIOc 1467181265
Received: from localhost (x4e340075.dyn.telefonica.de [78.52.0.117])
	by mail.messagingengine.com (Postfix) with ESMTPA id 48A12F29F3;
	Wed, 29 Jun 2016 02:21:05 -0400 (EDT)
From:	Patrick Steinhardt <ps@pks.im>
To:	git@vger.kernel.org
Cc:	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Hahler <git@thequod.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: [PATCH v2] rebase -i: restore autostash on abort
Date:	Wed, 29 Jun 2016 08:21:27 +0200
Message-Id: <20160629062127.8946-1-ps@pks.im>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160628175704.26095-1-ps@pks.im>
References: <20160628175704.26095-1-ps@pks.im>
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

The original bug-report can be found at [1], the previous version
of this patch at [2].

I've included a second test which now also tests how we fare when
we actually fail to restore the autostash after the editor has
been aborted.

Another minor change is fixing of a typo inherited from the
previous test "abort rebase -i with --autostash" (commited ->
committed). I don't think there's any benefit in fixing the typo
in the existing test so I'll just keep it there.

[1]: http://article.gmane.org/gmane.comp.version-control.git/297404
[2]: http://article.gmane.org/gmane.comp.version-control.git/298481

 git-rebase--interactive.sh  |  1 +
 t/t3420-rebase-autostash.sh | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

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
index 944154b..532ff5c 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -192,4 +192,35 @@ test_expect_success 'abort rebase -i with --autostash' '
 	test_cmp expected file0
 '
 
+test_expect_success 'restore autostash on editor failure' '
+	test_when_finished "git reset --hard" &&
+	echo uncommitted-content >file0 &&
+	(
+		test_set_editor "false" &&
+		test_must_fail git rebase -i --autostash HEAD^
+	) &&
+	echo uncommitted-content >expected &&
+	test_cmp expected file0
+'
+
+test_expect_success 'autostash is saved on editor failure with conflict' '
+	test_when_finished "git reset --hard" &&
+	echo uncommitted-content >file0 &&
+	(
+		write_script abort-editor.sh <<-\EOF &&
+			echo conflicting-content >file0
+			exit 1
+		EOF
+		test_set_editor "$(pwd)/abort-editor.sh" &&
+		test_must_fail git rebase -i --autostash HEAD^ &&
+		rm -f abort-editor.sh
+	) &&
+	echo conflicting-content >expected &&
+	test_cmp expected file0 &&
+	git checkout file0 &&
+	git stash pop &&
+	echo uncommitted-content >expected &&
+	test_cmp expected file0
+'
+
 test_done
-- 
2.9.0

