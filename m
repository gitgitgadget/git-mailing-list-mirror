Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBBD320248
	for <e@80x24.org>; Sun, 17 Mar 2019 18:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfCQSQc (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 14:16:32 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55193 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfCQSQc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 14:16:32 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5A54A61173;
        Sun, 17 Mar 2019 14:16:30 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=p6MwUhd+IOJG2/En24yWXLyWu
        +4=; b=aLthoAckiABsIoK2xne7G4kNhF8UMA+wW3g3XVvqYONDQUpBz91arApoD
        /gP+TEgsb54QAj31prHJNJKSVRwoV1kTqM5vOZKX2ysfuSS86R2vJLEA51kRYlxD
        JpfF2Bz1P8HvU+A/1y8vBgMKlz+3iumjptZGv1cx/UyFhHQ6ok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=gOwxuUdaWjgcKAaxTHt
        C2sPQff6J08UMsBKrNaUeg5Sr2MCD8rizniTs9QAEPd4gFKXdw6g3q10irYYX07C
        r3nq0gwrftyAF3ESjLsv0M86H5s9QczgqVHV0EINH1lY4rKw+TvVK7aKqRMTjujM
        S0p5U+TUiCrP+FKGPOgcaUUw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 52A3B61172;
        Sun, 17 Mar 2019 14:16:30 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.93.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C7A856116C;
        Sun, 17 Mar 2019 14:16:25 -0400 (EDT)
        (envelope-from tmz@pobox.com)
From:   Todd Zullinger <tmz@pobox.com>
To:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/4] git: read local config in --list-cmds
Date:   Sun, 17 Mar 2019 14:16:17 -0400
Message-Id: <20190317181620.26727-2-tmz@pobox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <CACsJy8BuR=syjT1gjTxXXKKaevzpbdRGp+je+rsX6jV96F3sbA@mail.gmail.com>
References: <CACsJy8BuR=syjT1gjTxXXKKaevzpbdRGp+je+rsX6jV96F3sbA@mail.gmail.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: C7D1AF84-48E0-11E9-BF85-EE24A11ADF13-09356542!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Normally code that is checking config before we've decided to do
setup_git_directory() would use read_early_config(), which uses
discover_git_directory() to tentatively see if we're in a repo,
and if so to add it to the config sequence.

But list_cmds() uses the caching configset mechanism which
rightly does not use read_early_config(), because it has no
idea if it's being called early.

Call setup_git_directory_gently() so we can pick up repo-level
config (like completion.commands).

Signed-off-by: Jeff King <peff@peff.net>
---
 git.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/git.c b/git.c
index 2dd588674f..10e49d79f6 100644
--- a/git.c
+++ b/git.c
@@ -62,6 +62,13 @@ static int list_cmds(const char *spec)
 {
 	struct string_list list =3D STRING_LIST_INIT_DUP;
 	int i;
+	int nongit;
+
+	/*
+	* Set up the repository so we can pick up any repo-level config (like
+	* completion.commands).
+	*/
+	setup_git_directory_gently(&nongit);
=20
 	while (*spec) {
 		const char *sep =3D strchrnul(spec, ',');
