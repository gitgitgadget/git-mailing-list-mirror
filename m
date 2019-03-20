Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64475202BB
	for <e@80x24.org>; Wed, 20 Mar 2019 18:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfCTSDm (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 14:03:42 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61318 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbfCTSDl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 14:03:41 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 61F3455F19;
        Wed, 20 Mar 2019 14:03:39 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=e+ERwF9EYJ9pyQhKrJl7PR4qr
        nI=; b=GWz5yOsAxfT3i/QC0KYRTU5JDurZ4R8nNchI5znZ3Puorm8WstOJ5WbqI
        ONjIgRqmzHONfk1p5+kbeBmhWZgJL8B5hy6C0E9iZXAt2V2viCWxbsR9HEXQlLOI
        K/CBiavaSH0MtpvaTVj8JzH/OKgbe+tn4ksEgMPc9LSEwFnaHk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=JPeJbqdhFTs2SfTUTcm
        NiyiJfZJcyms6dUgQyavozLD68KcpxCPbBCY8lVATPOk4QmnpzlyJCBBGX+fruIm
        /GG9NwzEg2Ym7gpOxWXXR47J1Dj3Bp6yWQV4pY56m/Id/tJev3IKhH3ocqLxU6IJ
        dbTemQxX/OxwjS3l/jEEwERA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5A3D755F17;
        Wed, 20 Mar 2019 14:03:39 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.93.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C41EF55F13;
        Wed, 20 Mar 2019 14:03:34 -0400 (EDT)
        (envelope-from tmz@pobox.com)
From:   Todd Zullinger <tmz@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 1/4] git: read local config in --list-cmds
Date:   Wed, 20 Mar 2019 14:03:26 -0400
Message-Id: <20190320180329.22280-2-tmz@pobox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <CACsJy8DiQwmAKMruOAO4roPbiRTvt5TESBTd682hTwkZjcoj2Q@mail.gmail.com>
References: <CACsJy8DiQwmAKMruOAO4roPbiRTvt5TESBTd682hTwkZjcoj2Q@mail.gmail.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 7B7F8B18-4B3A-11E9-A628-EE24A11ADF13-09356542!pb-smtp21.pobox.com
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
 git.c  | 7 +++++++
 help.c | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

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
diff --git a/help.c b/help.c
index 520c9080e8..fac7e421d0 100644
--- a/help.c
+++ b/help.c
@@ -375,13 +375,6 @@ void list_cmds_by_config(struct string_list *list)
 {
 	const char *cmd_list;
=20
-	/*
-	 * There's no actual repository setup at this point (and even
-	 * if there is, we don't really care; only global config
-	 * matters). If we accidentally set up a repository, it's ok
-	 * too since the caller (git --list-cmds=3D) should exit shortly
-	 * anyway.
-	 */
 	if (git_config_get_string_const("completion.commands", &cmd_list))
 		return;
=20
