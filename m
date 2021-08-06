Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F217CC4320E
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 20:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6045611BF
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 20:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237522AbhHFUxE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 16:53:04 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65302 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237026AbhHFUxD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 16:53:03 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 09C58149FFD;
        Fri,  6 Aug 2021 16:52:47 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=P23OOUhCYA3v2pXp0XLNiZEl9
        v9h5Q/bTsmg/F//I8s=; b=sGhkgRb9eNQycV2m24Gpdk2vZC2aFmD9iYh2GC6Aa
        tVmOJjDpG+TWBZhPg9heJ/Lxl7w4Je/wdN4vidJ4C21mj+pebFAHnXEXRx2OaQtg
        uE3BCXnGg7xlbfWTJSGZRwItnQzgSlg5FOi/w2vjI2EWOJZ/evX73nuiuSlA3bh6
        8k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 02542149FFC;
        Fri,  6 Aug 2021 16:52:47 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4B2A3149FFB;
        Fri,  6 Aug 2021 16:52:44 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH v2 2/3] build: clang version may not be followed by extra words
Date:   Fri,  6 Aug 2021 13:52:34 -0700
Message-Id: <20210806205235.988761-3-gitster@pobox.com>
X-Mailer: git-send-email 2.33.0-rc1-159-gdd7297d7fa
In-Reply-To: <20210806205235.988761-1-gitster@pobox.com>
References: <YQ2LdvwEnZN9LUQn@coredump.intra.peff.net>
 <20210806205235.988761-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 3F89CA1C-F6F8-11EB-BAB9-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

The get_family and get_version helpers of detect-compiler assume
that the line to identify the version from the compilers have a
token "version", followed by the version number, followed by some
other string, e.g.

  $ CC=3Dgcc get_version_line
  gcc version 10.2.1 20210110 (Debian 10.2.1-6)

But that is not necessarily true, e.g.

  $ CC=3Dclang get_version_line
  Debian clang version 11.0.1-2

Tweak the script not to require extra string after the version.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 detect-compiler | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/detect-compiler b/detect-compiler
index c85be83c64..955be1c906 100755
--- a/detect-compiler
+++ b/detect-compiler
@@ -13,11 +13,11 @@ get_version_line() {
 }
=20
 get_family() {
-	get_version_line | sed 's/^\(.*\) version [0-9][^ ]* .*/\1/'
+	get_version_line | sed 's/^\(.*\) version [0-9].*/\1/'
 }
=20
 get_version() {
-	get_version_line | sed 's/^.* version \([0-9][^ ]*\) .*/\1/'
+	get_version_line | sed 's/^.* version \([0-9][^ ]*\).*/\1/'
 }
=20
 print_flags() {
--=20
2.33.0-rc1-159-gdd7297d7fa

