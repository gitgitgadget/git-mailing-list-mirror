Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE5CC433DB
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 17:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10DA322AAC
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 17:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbhAYRKz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 12:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728836AbhAYRKg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 12:10:36 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4436C061786
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:09:49 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id dj23so16291886edb.13
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EWsxJ/dCLEvNI3F3vAJDKgBhRJJlAFYuUl118n3wixc=;
        b=AIvTLWXMvEbJzuyTox1AYBZ1xVx+Fi/MxHSk6a/Wss6r36XdnIKhz6z/KTaDaY3nCC
         NuedNNy1v5D2XM3lnFAWgZoHu0Tr3uJVkpfK6eO6M9KdX1zLOtzi15sJipV5D9tC+ntn
         U3KKMbbEg0VaVhphn6sf2kFcg2/wctB8M/Vpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EWsxJ/dCLEvNI3F3vAJDKgBhRJJlAFYuUl118n3wixc=;
        b=iYkqqZkFZejQ7iL2cJNqogEgnA3Szc+Yuvm1zg8If3O9FK98EQ5QMVnrlw2YswVN4K
         ihBBBTA+igOFqR2ihrsqJZTxUONnGt9EJS43ZtzpGXbMJUTynhwPhb9jJ47NR7FRL8+r
         CR0agtUeQG690+p1euovGw25Z/ccxwAzm8/7JB6zDKMS0PUrr09s6NlMGq/BhTqleOQi
         jPV4MsbCp9zoxU4w4kVmVV4FmjWqm51rppBr8vj5GaE3+Vl3Ukp5+mcyKI3O8Iv0HenX
         qMP6R5FM+U4cEMMqUpcWqCLtlAJdDkEu0ww4z74bBiWBLqWqv+lfRgn/dO0Ntp89t3gp
         5qsg==
X-Gm-Message-State: AOAM530arhx3FKD1S5EPglOD3hYpejTlAyR0svaSYQIIU5Rt2sWTwR+5
        knNiyjlCjl1WlyHH1MJan5SAY0exlKD8HJcH
X-Google-Smtp-Source: ABdhPJydgGZIo60PynAl/QdxegTs9LT7uAWm7SVh0G0MKRSdd6Pt+SORsM8sQvXU7eVLE9GpD+zh3w==
X-Received: by 2002:a50:d484:: with SMTP id s4mr1298393edi.13.1611594588373;
        Mon, 25 Jan 2021 09:09:48 -0800 (PST)
Received: from localhost.localdomain (e93008.upc-e.chello.nl. [213.93.93.8])
        by smtp.gmail.com with ESMTPSA id r11sm10823231edt.58.2021.01.25.09.09.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2021 09:09:45 -0800 (PST)
From:   Jacob Vosmaer <jacob@gitlab.com>
To:     git@vger.kernel.org, peff@peff.net, jeffhost@microsoft.com,
        jonathantanmy@google.com, gitster@pobox.com
Cc:     Jacob Vosmaer <jacob@gitlab.com>
Subject: [PATCH v2] upload-pack.c: fix filter spec quoting bug
Date:   Mon, 25 Jan 2021 18:09:21 +0100
Message-Id: <20210125170921.14291-1-jacob@gitlab.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <YAs2RMT1rEH/2LSp@coredump.intra.peff.net>
References: <YAs2RMT1rEH/2LSp@coredump.intra.peff.net>
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

