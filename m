Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1FE7202BB
	for <e@80x24.org>; Wed, 20 Mar 2019 18:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfCTSDt (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 14:03:49 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62403 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbfCTSDq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 14:03:46 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7CF0455F25;
        Wed, 20 Mar 2019 14:03:46 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=YkLFDYSxyURvp0Vo1uDEQQXRb
        T8=; b=ugZldrLSisfCx4arLD9toeQTuOysHPmADjOrLMXcXsEjv0eOXgK4Q9eoU
        a2P3vSi+N6vTzRcfhELsVvcVr824593L6EeBTLHxWg5wNAvhc2ID3yNeUk82y369
        2NL78W2cdhYGns9mz+HVNNAM9PgVHEtcycnU8baQAg+L4ekTX8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=SQo9vYZ4uff3isQgYen
        moloNeJ1uVNKWFI4PKgT/e6E7XDBxJ1pUzp6gUZhsV4kzBhPnFQG0QZriuFlY7oN
        iShUxI0ft6mzILYGpkSQ+hh8/s0dJIH41QUrJlIbfBJgqUaLSM7mWJbWNgDEAi44
        GJ2WftsvPwr18Tt9aYp3Y7mo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7697955F24;
        Wed, 20 Mar 2019 14:03:46 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.93.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DB74255F1C;
        Wed, 20 Mar 2019 14:03:41 -0400 (EDT)
        (envelope-from tmz@pobox.com)
From:   Todd Zullinger <tmz@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 3/4] completion: fix multiple command removals
Date:   Wed, 20 Mar 2019 14:03:28 -0400
Message-Id: <20190320180329.22280-4-tmz@pobox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <CACsJy8DiQwmAKMruOAO4roPbiRTvt5TESBTd682hTwkZjcoj2Q@mail.gmail.com>
References: <CACsJy8DiQwmAKMruOAO4roPbiRTvt5TESBTd682hTwkZjcoj2Q@mail.gmail.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 7FB9D288-4B3A-11E9-9479-EE24A11ADF13-09356542!pb-smtp21.pobox.com
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
index fac7e421d0..a9e451f2ee 100644
--- a/help.c
+++ b/help.c
@@ -386,8 +386,8 @@ void list_cmds_by_config(struct string_list *list)
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
