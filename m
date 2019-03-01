Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B46B220248
	for <e@80x24.org>; Fri,  1 Mar 2019 17:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389469AbfCARfC (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 12:35:02 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59796 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388333AbfCARfC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 12:35:02 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 73A9843199;
        Fri,  1 Mar 2019 12:35:00 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=cXpqm0cC00kkQCFegZi04HQYN
        gg=; b=smunXT8pHMmGL1hGKPDW3X/xMdqGgQ+r2Ps+KbQH7Zy5mil9ucMJIQHX6
        T4l7fmZkG750TifI5l0qOArkPT0C2ryuLvGeMZLiPoXQtIXAioUOwvpekjFn5/8p
        LM0rHNr+GrJjaIoxiGgG7fwCySdK27tQ2mYsgO3GiNfKfa2woY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=uJikgwJSusKCSR4KR24
        4AHdSdgBRuRYbX8dh1A9LvBi307JVMoPI5+4l0qFtBS7zCRdgXZth0PCMHK2t/76
        OigXxN2/+IpkZtExsXhEIKO/hFWEBBYgg300ZbrBbwEcIWDn/56BRdtL1mORN0iG
        5Vj+EJjLQOExkRU7f2623rnw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6C75943198;
        Fri,  1 Mar 2019 12:35:00 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.93.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8296443192;
        Fri,  1 Mar 2019 12:34:55 -0500 (EST)
        (envelope-from tmz@pobox.com)
From:   Todd Zullinger <tmz@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 3/3] completion: fix multiple command removals
Date:   Fri,  1 Mar 2019 12:34:43 -0500
Message-Id: <20190301173443.16429-4-tmz@pobox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190228230506.GA20625@sigill.intra.peff.net>
References: <20190228230506.GA20625@sigill.intra.peff.net>
MIME-Version: 1.0
X-Pobox-Relay-ID: 54C7B55A-3C48-11E9-9168-EE24A11ADF13-09356542!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

6532f3740b ("completion: allow to customize the completable
command list", 2018-05-20) added the completion.commands config
variable.

The documentation states multiple commands may be added,
separated by spaces.  Adding multiple commands to remove fails,
only removing the last command in the config.

Fix multiple command removals.

Signed-off-by: Jeff King <peff@peff.net>
---
Jeff,

The commit message could probably be worded better, particularly since it=
's
forged in your name.

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
index dd11bb660d..d7daa1ca92 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1483,7 +1483,7 @@ test_expect_success 'git --help completion' '
 	test_completion "git --help core" "core-tutorial "
 '
=20
-test_expect_failure 'completion.commands removes multiple commands' '
+test_expect_success 'completion.commands removes multiple commands' '
 	echo cherry-pick >expected &&
 	test_config_global completion.commands "-cherry -mergetool" &&
 	git --list-cmds=3Dlist-mainporcelain,list-complete,config |
