Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-24.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F69C433DB
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 23:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B39C3227BF
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 23:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732528AbhAYXLb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 18:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732614AbhAYXLB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 18:11:01 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98777C061574
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 15:10:19 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id gx5so20427261ejb.7
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 15:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3n0lI32u9GOMr1PARJkef4S80XXeaADvHjP4FMgZ2eU=;
        b=Cng9c+lbA1INV5Ub3eDX6oY0MEiUv9exY65PMBAOZ5VucIt7gAr6CkJsnz+N6Wa9mh
         LWdGJXTqQzZVTDuv6hG1e9lszyTUlceOs2dsLd5vQwBh0NAJNs7W8ALgsr9Z+PjhnJ3M
         8DwzcnOstRHFmvJQOdZCueU27grcogV2/uLL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3n0lI32u9GOMr1PARJkef4S80XXeaADvHjP4FMgZ2eU=;
        b=o3jdddCdbPUKTfcuIJWkVAPgyVCAH0HkleUUYrb6zK7YkVG1W3FCrGQulCr+lmqRDW
         fUDb+Z5QBUKsqKZ491TNodFWNNDKmvYc+AWJrBBendi0CS7zAkLCFLZ79H7nJqPm/PMJ
         2LqB36s+/ellH90BfVAOZeVRiw8iYBake4k+/4NIN0eqhHWBB2HjjiHGBub89esuuBoA
         1iyfGWfT2AeRtbPKPy/Y04/tMZFyg/ZxqyxABWVMFQ47V6O3f9a+bLEKTs0u4rLwyPeg
         /u8DImSufv7gh0zjZZLFQXFc0xMIxc85dRVMlY4WvQ4RdfQGTeptucMaE5hHHdijDN8D
         z5sg==
X-Gm-Message-State: AOAM532EyoLNFtmF2X0hgtVLOphMXK1RCG3wHSNEVRhvEVG7dJWqYTby
        5YnEUjGRlkAGIekTAwzoDELEQ4NZ5Xs9kHYa
X-Google-Smtp-Source: ABdhPJzF0fKpr/U9FKlj1J9lbm0cJTGOA+E0c2ioxFSEvUF9TVOdx2CxS9i/RYFIWkMjWqPTgNTgtQ==
X-Received: by 2002:a17:907:20d5:: with SMTP id qq21mr1768458ejb.340.1611616218291;
        Mon, 25 Jan 2021 15:10:18 -0800 (PST)
Received: from localhost.localdomain (e93008.upc-e.chello.nl. [213.93.93.8])
        by smtp.gmail.com with ESMTPSA id g14sm8946245ejr.105.2021.01.25.15.10.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2021 15:10:17 -0800 (PST)
From:   Jacob Vosmaer <jacob@gitlab.com>
To:     peff@peff.net, gitster@pobox.com, git@vger.kernel.org,
        jeffhost@microsoft.com, jonathantanmy@google.com
Cc:     Jacob Vosmaer <jacob@gitlab.com>
Subject: [PATCH v3 1/1] upload-pack.c: fix filter spec quoting bug
Date:   Tue, 26 Jan 2021 00:09:52 +0100
Message-Id: <20210125230952.15468-2-jacob@gitlab.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210125230952.15468-1-jacob@gitlab.com>
References: <YA81LEon1RPzT0T9@coredump.intra.peff.net>
 <20210125230952.15468-1-jacob@gitlab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes a bug that occurs when you combine partial clone and
uploadpack.packobjectshook. You can reproduce it as follows:

git clone -u 'git -c uploadpack.allowfilter '\
'-c uploadpack.packobjectshook=env '\
'upload-pack' --filter=blob:none --no-local \
src.git dst.git

Be careful with the line endings because this has a long quoted string
as the -u argument.

The error I get when I run this is:

Cloning into '/tmp/broken'...
remote: fatal: invalid filter-spec ''blob:none''
error: git upload-pack: git-pack-objects died with error.
fatal: git upload-pack: aborting due to possible repository corruption on the remote side.
remote: aborting due to possible repository corruption on the remote side.
fatal: early EOF
fatal: index-pack failed

The problem is an unnecessary and harmful layer of quoting. I tried
digging through the history of this function and I think this quoting
was there from the start. My best guess is that it stems from a
misunderstanding what use_shell=1 means. The code seems to assume it
means "arguments get joined into one big string, then fed to /bin/sh".
But that is not what it means: use_shell=1 means that the first
argument in the arguments array may be a shell script and if so should
be passed to /bin/sh. All other arguments are passed as normal
arguments.

The solution is simple: never quote the filter spec.

This commit removes the conditional quoting and adds a test for
partial clone in t5544.

Signed-off-by: Jacob Vosmaer <jacob@gitlab.com>
---
 t/t5544-pack-objects-hook.sh | 9 +++++++++
 upload-pack.c                | 9 +--------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/t/t5544-pack-objects-hook.sh b/t/t5544-pack-objects-hook.sh
index 4357af1525..f5ba663d64 100755
--- a/t/t5544-pack-objects-hook.sh
+++ b/t/t5544-pack-objects-hook.sh
@@ -59,4 +59,13 @@ test_expect_success 'hook does not run from repo config' '
 	test_path_is_missing .git/hook.stdout
 '
 
+test_expect_success 'hook works with partial clone' '
+	clear_hook_results &&
+	test_config_global uploadpack.packObjectsHook ./hook &&
+	test_config_global uploadpack.allowFilter true &&
+	git clone --bare --no-local --filter=blob:none . dst.git &&
+	git -C dst.git rev-list --objects --missing=print HEAD >objects &&
+	grep "^?" objects
+'
+
 test_done
diff --git a/upload-pack.c b/upload-pack.c
index 3b66bf92ba..eae1fdbc55 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -305,14 +305,7 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 	if (pack_data->filter_options.choice) {
 		const char *spec =
 			expand_list_objects_filter_spec(&pack_data->filter_options);
-		if (pack_objects.use_shell) {
-			struct strbuf buf = STRBUF_INIT;
-			sq_quote_buf(&buf, spec);
-			strvec_pushf(&pack_objects.args, "--filter=%s", buf.buf);
-			strbuf_release(&buf);
-		} else {
-			strvec_pushf(&pack_objects.args, "--filter=%s", spec);
-		}
+		strvec_pushf(&pack_objects.args, "--filter=%s", spec);
 	}
 	if (uri_protocols) {
 		for (i = 0; i < uri_protocols->nr; i++)
-- 
2.30.0

