Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637C0C4338F
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 13:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45EE260F11
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 13:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhGYM3g (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Jul 2021 08:29:36 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:38660 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230441AbhGYM27 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jul 2021 08:28:59 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id BC2C440F72;
        Sun, 25 Jul 2021 15:09:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:references:in-reply-to
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1627218540; x=1629032941;
         bh=lPmtv4bRQ09TN5IjM56n2WMLnpAgUIeY4fQlM2QADh8=; b=h0z5Ya6WSBTz
        kz4lW8yJONi09GA+hyYhf6oHKDvLRWd4UQPFGHMhqWsSHUQft3we+LUW/LFqHSmA
        rg40u+nqhldzP2LUfbFE4mS8kNOsuufksBa3KxbluUotH5NLaZPW6j6GypD8+ZD2
        ktpfq9N35N8B9JRthz6lMZZXHSoVwvb4KKRpO/AMD3EJnfu3o41wPUbyJXX6mMBE
        hM9Y3vHfFZ0h3AwaGWD1/9nRFq89rR8oAYLMjkBfSM1w+kdtMhf8BMntJW7rv5/Q
        hdWo+UXhbYPncLRsUB7p2RcBmDwjc226DUhvcDv8ZYnuUcAC9+NRKDLRli1yLkuf
        KivDs/ch5HK6cDV253bwGY6mCpdxNhrvN9aJzQz4bhzihnkhPaFWJd43ru5q1L/B
        d1+m9SUOZZNyh0TWBHoEFcz2kN4doWCnQjEI9tFy7KzcJkePX/t7Ktd+TtIp40qf
        c8nSVtjqRPKkOWd1xZxVg75M/f0TtvfhBXkzP96sO5Kw2v3jVoGVTNTaRnn2mHTe
        57cX6MoJtiZ+KQm+NdZ04WSEyktL6fCvWb5AgzzzJnNM6QyLn4UVJkp5o/CzLezb
        tdLOmwYmditEOO1GEvM+vn6CQ9+aKIue9+MnsWQBRLSOJKJXLw+P3KDgKSHOXc2R
        QUP+h98WkMz6d4b+2t6oxsGy2doufx8=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TLTLWYAx0oQV; Sun, 25 Jul 2021 15:09:00 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 3B1AA404BD;
        Sun, 25 Jul 2021 15:09:00 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 8028649B;
        Sun, 25 Jul 2021 15:08:57 +0200 (CEST)
From:   andrzej@ahunt.org
To:     git@vger.kernel.org
Cc:     andrzej@ahunt.org, phillip.wood123@gmail.com, newren@gmail.com
Subject: [PATCH v2 11/12] builtin/rebase: fix options.strategy memory lifecycle
Date:   Sun, 25 Jul 2021 15:08:29 +0200
Message-Id: <20210725130830.5145-12-andrzej@ahunt.org>
In-Reply-To: <20210725130830.5145-1-andrzej@ahunt.org>
References: <20210620151204.19260-1-andrzej@ahunt.org>
 <20210725130830.5145-1-andrzej@ahunt.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

- cmd_rebase populates rebase_options.strategy with newly allocated
  strings, hence we need to free those strings at the end of cmd_rebase
  to avoid a leak.
- In some cases: get_replay_opts() is called, which prepares replay_opts
  using data from rebase_options. We used to simply copy the pointer
  from rebase_options.strategy,  however that would now result in a
  double-free because sequencer_remove_state() is eventually used to
  free replay_opts.strategy. To avoid this we xstrdup() strategy when
  adding it to replay_opts.

The original leak happens because we always populate
rebase_options.strategy, but we don't always enter the path that calls
get_replay_opts() and later sequencer_remove_state() - in  other words
we'd always allocate a new string into rebase_options.strategy but
only sometimes did we free it. We now make sure that rebase_options
and replay_opts both own their own copies of strategy, and each copy
is free'd independently.

This was first seen when running t0021 with LSAN, but t2012 helped catch
the fact that we can't just free(options.strategy) at the end of
cmd_rebase (as that can cause a double-free). LSAN output from t0021:

LSAN output from t0021:

Direct leak of 4 byte(s) in 1 object(s) allocated from:
    #0 0x486804 in strdup ../projects/compiler-rt/lib/asan/asan_interceptors.cpp:452:3
    #1 0xa71eb8 in xstrdup wrapper.c:29:14
    #2 0x61b1cc in cmd_rebase builtin/rebase.c:1779:22
    #3 0x4ce83e in run_builtin git.c:475:11
    #4 0x4ccafe in handle_builtin git.c:729:3
    #5 0x4cb01c in run_argv git.c:818:4
    #6 0x4cb01c in cmd_main git.c:949:19
    #7 0x6b3fad in main common-main.c:52:11
    #8 0x7f267b512349 in __libc_start_main (/lib64/libc.so.6+0x24349)

SUMMARY: AddressSanitizer: 4 byte(s) leaked in 1 allocation(s).

Signed-off-by: Andrzej Hunt <andrzej@ahunt.org>
---
 builtin/rebase.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 12f093121d..33e0961900 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -139,7 +139,7 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	replay.ignore_date = opts->ignore_date;
 	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
 	if (opts->strategy)
-		replay.strategy = opts->strategy;
+		replay.strategy = xstrdup_or_null(opts->strategy);
 	else if (!replay.strategy && replay.default_strategy) {
 		replay.strategy = replay.default_strategy;
 		replay.default_strategy = NULL;
@@ -2109,6 +2109,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	free(options.head_name);
 	free(options.gpg_sign_opt);
 	free(options.cmd);
+	free(options.strategy);
 	strbuf_release(&options.git_format_patch_opt);
 	free(squash_onto_name);
 	return ret;
-- 
2.26.2

