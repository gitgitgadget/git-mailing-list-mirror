Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-24.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C84C433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 20:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4908664E9E
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 20:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhBAUap (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 15:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhBAUam (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 15:30:42 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97ADCC06174A
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 12:30:01 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id s5so7547605edw.8
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 12:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wcaaOAvJ5H2/+tl+a/AaXveY1tomXFdTacZ0/zLnEUA=;
        b=ZbbEOZOIH9VxpCGvL0JBtDMVWvbLjV2LUVpocn7RECMb0tYPpvrs6ylYERckNgw0/9
         VHGPYohX9yTNF4FSLutt2mNiwaSBzPJuF7aN+0SuV7PG6JqflPPxhGLl8UfP2vaLm/tg
         lq+yySHdBy1UMmcGgrTSTJQgNXJaTjE+OwxPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wcaaOAvJ5H2/+tl+a/AaXveY1tomXFdTacZ0/zLnEUA=;
        b=ZqbsdDr7BbjbDCyttVA54N56hmDgWgIewsP7o6+HTcqpPLoykoeShTqPj5v5AghGta
         +b31rHGlqr11y/wGVN3EkeoXaX7C+1CNCM/Gr3cLpwRL53YZlzElPWLQoCHL0+epVpVf
         a2c8vLGYh13XqjWBNDuFxnIcmPuI9uuM853K9MG4kzYfhqov2svUan0wr6orDSAzBxS0
         sz79k+9k69HKmiIHrN8n+Gn7Ht0AbLIgRzX2rH4ASKU2Q5sU2rRi8AwPPFv3hHe1ATM6
         FoIBVmgvzz3dbQS27O5mF3FRKMiFTuTN/WadFF7ePKS2BxnswS+LfPfFvHam2rKtTVGk
         CN0w==
X-Gm-Message-State: AOAM531LFh705YkMWR0r/3wb2MtfMJE4MVMLhob+k+wjlF07JZU/xvXn
        8LCLXIoLsvqxA4b9wnkrs4NOCQ==
X-Google-Smtp-Source: ABdhPJzDgSMppqG8ZNt/bK6+otp2aRJEJaOeG0doXwXiTcd+388qhpF1DqsOcnLuPnym08ESSINnZQ==
X-Received: by 2002:a05:6402:1bcc:: with SMTP id ch12mr20566481edb.283.1612211400288;
        Mon, 01 Feb 2021 12:30:00 -0800 (PST)
Received: from localhost.localdomain (e93008.upc-e.chello.nl. [213.93.93.8])
        by smtp.gmail.com with ESMTPSA id n16sm4247521ejd.116.2021.02.01.12.29.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 12:29:59 -0800 (PST)
From:   Jacob Vosmaer <jacob@gitlab.com>
To:     peff@peff.net, avarab@gmail.com, gitster@pobox.com,
        git@vger.kernel.org, jeffhost@microsoft.com,
        jonathantanmy@google.com
Cc:     Jacob Vosmaer <jacob@gitlab.com>
Subject: [PATCH v5 1/1] upload-pack.c: fix filter spec quoting bug
Date:   Mon,  1 Feb 2021 21:29:38 +0100
Message-Id: <20210201202938.39576-2-jacob@gitlab.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210201202938.39576-1-jacob@gitlab.com>
References: <xmqqpn1ovi4j.fsf@gitster.c.googlers.com>
 <20210201202938.39576-1-jacob@gitlab.com>
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
 t/t5544-pack-objects-hook.sh | 10 ++++++++++
 upload-pack.c                |  9 +--------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/t/t5544-pack-objects-hook.sh b/t/t5544-pack-objects-hook.sh
index 4357af1525..dd5f44d986 100755
--- a/t/t5544-pack-objects-hook.sh
+++ b/t/t5544-pack-objects-hook.sh
@@ -59,4 +59,14 @@ test_expect_success 'hook does not run from repo config' '
 	test_path_is_missing .git/hook.stdout
 '
 
+test_expect_success 'hook works with partial clone' '
+	clear_hook_results &&
+	test_config_global uploadpack.packObjectsHook ./hook &&
+	test_config_global uploadpack.allowFilter true &&
+	git clone --bare --no-local --filter=blob:none . dst.git &&
+	git -C dst.git rev-list --objects --missing=allow-any --no-object-names --all >objects &&
+	git -C dst.git cat-file --batch-check="%(objecttype)" <objects >types &&
+	! grep blob types
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

