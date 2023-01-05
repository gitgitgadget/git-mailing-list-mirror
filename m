Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF21C3DA7D
	for <git@archiver.kernel.org>; Thu,  5 Jan 2023 06:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjAEGZO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Jan 2023 01:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjAEGZM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jan 2023 01:25:12 -0500
Received: from mx-out2.startmail.com (mx-out2.startmail.com [145.131.90.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB9B52776
        for <git@vger.kernel.org>; Wed,  4 Jan 2023 22:25:09 -0800 (PST)
From:   Toon Claes <toon@iotcl.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2020-07; t=1672899906;
        bh=i5sfd1nxQSkU1gN+vM2OCs6OdbyC0XIsYYILTHz0CnE=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         Mime-Version:Content-Transfer-Encoding:From:Subject:To:Date:Sender:
         Content-Type:Content-Transfer-Encoding:Content-Disposition:
         Mime-Version:Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
        b=BIJeMNt//J3RtgkKMN3jab77Jk+azgR3AHy7V2tVhwUhLLIgi7n0QLaQDucAOiwGF
         JsWdB+V8rUACfCY63BiDFi8suNRq36xWgfY43xFvfDlJ/ZsRLUsWuUkyrMdniYPBF7
         EZ3Fy7ba3mpy1x8QBdt6xgo5S09NJx1Fthacjzf1riM4Bs7byVlw2+NFZzRg7LbRiK
         3q43afMnlyyfIfg22w3zgPJgDQNoYtLJnGf2QJ+e5yI7Unrf3UCiDXYJo/aaG16epw
         qfdB3DL78W3pKbk1tuJN0G5dnSu0WDWRivDZQfIe+6XwDmK0WCCkvUeDlHc8QHRcF4
         NM+GwqAH+qyHw==
To:     git@vger.kernel.org
Cc:     Toon Claes <toon@iotcl.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 0/1] cat-file: quote-format name in error when using -z
Date:   Thu,  5 Jan 2023 07:24:46 +0100
Message-Id: <20230105062447.2943709-1-toon@iotcl.com>
In-Reply-To: <20221209150048.2400648-1-toon@iotcl.com>
References: <20221209150048.2400648-1-toon@iotcl.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the second revision of the patch to quote-format the filename in the
error message of git-cat-file(1), when using option `-z`.

Changes since v1:
* Added the same fix to batch_object_write().
* Removed FUNNYNAMES from the added test.

Toon Claes (1):
  cat-file: quote-format name in error when using -z

 builtin/cat-file.c  | 19 +++++++++++++++++++
 t/t1006-cat-file.sh |  8 ++++++++
 2 files changed, 27 insertions(+)

Range-diff against v1:
1:  c13602e28e ! 1:  4f39eb0719 cat-file: quote-format name in error when using -z
    @@ builtin/cat-file.c
      #include "object-store.h"
      #include "promisor-remote.h"
      #include "mailmap.h"
    +@@ builtin/cat-file.c: static void batch_object_write(const char *obj_name,
    + 						       &data->oid, &data->info,
    + 						       OBJECT_INFO_LOOKUP_REPLACE);
    + 		if (ret < 0) {
    ++			struct strbuf quoted = STRBUF_INIT;
    ++
    ++			if (opt->nul_terminated &&
    ++			    obj_name) {
    ++				quote_c_style(obj_name, &quoted, NULL, 0);
    ++				obj_name = quoted.buf;
    ++			}
    ++
    + 			printf("%s missing\n",
    + 			       obj_name ? obj_name : oid_to_hex(&data->oid));
    ++			strbuf_release(&quoted);
    + 			fflush(stdout);
    + 			return;
    + 		}
     @@ builtin/cat-file.c: static void batch_one_object(const char *obj_name,
      	result = get_oid_with_context(the_repository, obj_name,
      				      flags, &data->oid, &ctx);
    @@ t/t1006-cat-file.sh: test_expect_success FUNNYNAMES '--batch-check, -z with newl
      	test_cmp expect actual
      '

    -+test_expect_success FUNNYNAMES '--batch-check, -z with newline in non-existent named object' '
    ++test_expect_success '--batch-check, -z with newline in non-existent named object' '
     +	printf "HEAD:newline${LF}embedded" >in &&
     +	git cat-file --batch-check -z <in >actual &&
     +
--
2.38.1
