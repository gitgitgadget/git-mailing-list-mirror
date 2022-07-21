Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B4CC433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 01:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiGUBCX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 21:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiGUBCV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 21:02:21 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8BE550B6
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 18:02:20 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 668971A72A1;
        Wed, 20 Jul 2022 21:02:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=M
        oGKwtO1Z3fLoM6GyVaNwrNWLbZY3Do1OKXw0lWuXls=; b=XPp4SXNHta/ohLUgL
        GGIRfGQrpUKFDSvwI7jzMQUD2xQTf5RQIy5XlY/J1FSTBQPTrSyxiuRBzd5xPJMC
        +2Qr6uG01XnMuKTdDXJgIfnepj/Kazc/3k8eK3c2ebA4sdPYFhDfquem/o47X8lf
        iGwLG9LWmp33yiGaqu4bfmWzT8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5F59E1A72A0;
        Wed, 20 Jul 2022 21:02:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 121B61A729F;
        Wed, 20 Jul 2022 21:02:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] string_list: use the right kind of STRING_LIST_INIT
Date:   Wed, 20 Jul 2022 18:02:15 -0700
Message-ID: <xmqq7d471dns.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C3C16CCC-0890-11ED-A163-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 4a4b4cda (builtin-remote: Make "remote -v" display push urls,
2009-06-13), the string_list that was initialized with 0 in its
strdup_string member is immediately made to strdup its key strings
by flipping the strdup_string member to true.  When 183113a5
(string_list: Add STRING_LIST_INIT macro and make use of it.,
2010-07-04) has introduced STRING_LIST_INIT macros, it mechanically
replaced the initialization to STRING_LIST_INIT_NODUP.

Instead, just use the other initialization macro to make it strdup
the key from the beginning.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/remote.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git c/builtin/remote.c w/builtin/remote.c
index d9b8746cb3..c713463d89 100644
--- c/builtin/remote.c
+++ w/builtin/remote.c
@@ -1229,10 +1229,9 @@ static int get_one_entry(struct remote *remote, void *priv)
 
 static int show_all(void)
 {
-	struct string_list list = STRING_LIST_INIT_NODUP;
+	struct string_list list = STRING_LIST_INIT_DUP;
 	int result;
 
-	list.strdup_strings = 1;
 	result = for_each_remote(get_one_entry, &list);
 
 	if (!result) {
