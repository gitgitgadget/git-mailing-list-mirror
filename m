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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C734C433E6
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 16:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45C8864DEE
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 16:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbhA1QGo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 11:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbhA1QGg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 11:06:36 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AC6C061574
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 08:05:54 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id c2so7190744edr.11
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 08:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sgUtecuVW6w64bF1Mko8FvzgUyKH+KIfLc+uA2vy5sQ=;
        b=byZ4+CVG/P91vMUjxT+83EICumwY8ULrZG1gBQS+spHmRCoMJAdyDgZQjlbUwzdBxH
         RGnmKYeH1lwEFOghn3Oc+XW/vAUaF7O/ehVghCfFZK/rpTPlL3Xju1aRq3VRPgS2cH9r
         8kJzZs2/GG5+6IytJPA0Ut0Qw6qc/QWIsN7KI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sgUtecuVW6w64bF1Mko8FvzgUyKH+KIfLc+uA2vy5sQ=;
        b=crWKFZTsOobRNZnhLMG6AnrqPv8HonPLsvZAWcC9E4m+scxSqOge0k3A8aDHz1f2T6
         YEVneFg5SmF6qUWrIUBR9sd2pOu2MXy6/Df4sWhv8aMIfJqHvtfI7ieVGeSVFe7cWZmR
         sLipesOfi3WRYPuUB3gAweVKUk7kBnKmZvIo6E5CD5g1RHH/7VwnyXrbA3gZM2ak+5EG
         PgEy8+rr49hGARYVFRZsErvBp86bxS7VqjEd95mZp9tCEVmYXP77N03ps+abNsuHR0X2
         8IvgcKutjmpSGZlbTZ6hM6NEzWiUmpGdI3Ex5mU6Mqx4BiudC9YRsfae44ZiSIUZ3DDF
         Q1xw==
X-Gm-Message-State: AOAM5300qdDrPglIVfxGuekn3La1Mjtho0J48vFjTukREKpR5D9/S6aj
        DxzHppYqPZumz9gHgWsTto2wvw==
X-Google-Smtp-Source: ABdhPJyZhl+H98/3m2Vi/J9CZLxxEg5b4IQNtTyUZhSDX/J4K/vJtCUyweCWEzr59hG3xiyzbJv9Rg==
X-Received: by 2002:a05:6402:c16:: with SMTP id co22mr202436edb.175.1611849953582;
        Thu, 28 Jan 2021 08:05:53 -0800 (PST)
Received: from localhost.localdomain (e93008.upc-e.chello.nl. [213.93.93.8])
        by smtp.gmail.com with ESMTPSA id e10sm2458909ejx.48.2021.01.28.08.05.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jan 2021 08:05:52 -0800 (PST)
From:   Jacob Vosmaer <jacob@gitlab.com>
To:     peff@peff.net, avarab@gmail.com, gitster@pobox.com,
        git@vger.kernel.org, jeffhost@microsoft.com,
        jonathantanmy@google.com
Cc:     Jacob Vosmaer <jacob@gitlab.com>
Subject: [PATCH v4] upload-pack.c: fix filter spec quoting bug
Date:   Thu, 28 Jan 2021 17:04:53 +0100
Message-Id: <20210128160453.79169-1-jacob@gitlab.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <YBCFBivBLgqEAUr1@coredump.intra.peff.net>
References: <YBCFBivBLgqEAUr1@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bug in upload-pack.c that occurs when you combine partial clone and
uploadpack.packObjectsHook. You can reproduce it as follows:

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

The problem is caused by unneeded quoting. This bug was already
present in 10ac85c785 (upload-pack: add object filtering for partial
clone, 2017-12-08) when the server side filter support was introduced.
In fact, in 10ac85c785 this was broken regardless of
uploadpack.packObjectsHook. Then in 0b6069fe0a (fetch-pack: test
support excluding large blobs, 2017-12-08) the quoting was removed but
only behind a conditional that depends on whether
uploadpack.packObjectsHook is set. Because uploadpack.packObjectsHook
is apparently rarely used, nobody noticed the problematic quoting
could still happen.

This commit removes the conditional quoting and adds a test for
partial clone in t5544-pack-objects-hook.

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

