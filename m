Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C2B020248
	for <e@80x24.org>; Sun, 17 Mar 2019 18:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfCQSQj (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 14:16:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62707 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbfCQSQj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 14:16:39 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6F36C6117B;
        Sun, 17 Mar 2019 14:16:37 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=ASB1GIPocT3yhzbI8mvz7V74w
        Og=; b=aARdGs3/z8eHf5BlnyQ2LPk7uLtbr0RlInvHNq7EJ/R8nDLBwqYlOHgoN
        /qtzlMhJSkUuANt9oHFofotV3y7pb7GlTEdOL2X48NMINy7l40gYETky/yoj5jLN
        lAKPR+zliKtkPiZbSxs4KQPx7IivfF/8iDJEGhlrvRYsGgQPtg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=b1HA4xz1W89oVBCaReX
        D4Zh2JYYL55Ml39evZ1+pdVFM860D8qUqrEy5HNTXWrVxvqPLLgvRBBIEBwOePF/
        7zJyt6KNpq+pkuse2hrjGTFCPNowhUpdhh3TQwfPRHYCJogxhJyY17wAiMexvw0h
        m3KtaQq3/VE1k9nbxOJqPekE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 669D86117A;
        Sun, 17 Mar 2019 14:16:37 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.93.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D8D7C61174;
        Sun, 17 Mar 2019 14:16:32 -0400 (EDT)
        (envelope-from tmz@pobox.com)
From:   Todd Zullinger <tmz@pobox.com>
To:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 3/4] completion: fix multiple command removals
Date:   Sun, 17 Mar 2019 14:16:19 -0400
Message-Id: <20190317181620.26727-4-tmz@pobox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <CACsJy8BuR=syjT1gjTxXXKKaevzpbdRGp+je+rsX6jV96F3sbA@mail.gmail.com>
References: <CACsJy8BuR=syjT1gjTxXXKKaevzpbdRGp+je+rsX6jV96F3sbA@mail.gmail.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: CC08AC38-48E0-11E9-8335-EE24A11ADF13-09356542!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Commit 6532f3740b ("completion: allow to customize the completable
command list", 2018-05-20) tried to allow multiple space-separated
entries in completion.commands. To do this, it copies each parsed token
into a strbuf so that the result is NUL-terminated.

However, for tokens starting with "-", it accidentally passes the
original non-terminated string, meaning that only the final one worked.
Switch to using the strbuf.

Reported-by: Todd Zullinger <tmz@pobox.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 help.c                | 4 ++--
 t/t9902-completion.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/help.c b/help.c
index 520c9080e8..026f881715 100644
--- a/help.c
+++ b/help.c
@@ -393,8 +393,8 @@ void list_cmds_by_config(struct string_list *list)
 		const char *p =3D strchrnul(cmd_list, ' ');
=20
 		strbuf_add(&sb, cmd_list, p - cmd_list);
-		if (*cmd_list =3D=3D '-')
-			string_list_remove(list, cmd_list + 1, 0);
+		if (sb.buf[0] =3D=3D '-')
+			string_list_remove(list, sb.buf + 1, 0);
 		else
 			string_list_insert(list, sb.buf);
 		strbuf_release(&sb);
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 3f5b420bf8..050fac4fff 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1483,7 +1483,7 @@ test_expect_success 'git --help completion' '
 	test_completion "git --help core" "core-tutorial "
 '
=20
-test_expect_failure 'completion.commands removes multiple commands' '
+test_expect_success 'completion.commands removes multiple commands' '
 	test_config completion.commands "-cherry -mergetool" &&
 	git --list-cmds=3Dlist-mainporcelain,list-complete,config >out &&
 	! grep -E "^(cherry|mergetool)$" out
