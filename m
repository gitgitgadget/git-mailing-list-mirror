Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA70C433EF
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 03:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237399AbiFIDFl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 23:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiFIDFk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 23:05:40 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BC457171
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 20:05:39 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h192so13860367pgc.4
        for <git@vger.kernel.org>; Wed, 08 Jun 2022 20:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ekL+ncX1UaD0tkZw+Bg9LRh3b1zcXLcMVmx6rIHKEY=;
        b=AdZxcTAKp2DS2YQsqVe4gPpCBTTrk5boWbZVKAt7DOtt6HBim3sGfeO8G7cqSf3tRQ
         7x0rG51ds603ImV+ftxY9Uc/d6iwVqgvQt/3YAMI2s2uxO2v3I+/3CCXnbACaIWKnspF
         3r+XaCxyp8cW3FtCJ/CmTaL4Ardmqg7GWnOh/K+uAP4FGMvjJJv7cdz9M41r9li7CKFQ
         YpXQ0HbL4AhyGvL9WP+HEasQcYHc3GuEQJm5nLRWdTAAvD9/GT+lNeTfdiJZaUZkJV2p
         CUvVlpQ+nHRgr0DGqsAQMLU5pNZ9E/O59FcBQ7qr7HFrtSvRwc5//GWr4NHl5nhV1FCe
         RCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ekL+ncX1UaD0tkZw+Bg9LRh3b1zcXLcMVmx6rIHKEY=;
        b=Rv3XZ2jYO5CUpbOVh1agw+/e69gXUE1vyGt6yJHXdEz0JmOyfMtp/QPF0DnBhEKfxS
         tr0rE3RRQ3yiVkPGN8/rk9vS5HIohat7bp9wpITNKvIF0KNvzc3D2c+ZfIDVtkxTjDxQ
         GLKSZf8q+92rDTT0eV1+SPErnx3aFRKHy292RxTzcy7TzAmiL67RhxJUuBTKzYVU/+yX
         7/TwB5khBdhJwYHJOxh6DGkYAmS1ggXdXW1EEutuC2dBe1d0/hUFJno6N5+61fuEsryp
         NH/uQmcgWmhDshBbUDXjC7NOBocQEXgO/gqCaIo8Yzaela3ZWC9HLjCuInHrJ8zOu+Jh
         lqhw==
X-Gm-Message-State: AOAM530NfXec+M3FPGCzpyQhmxju8OFPwMqI5Rix7ay2ttPvY16XdxK+
        OGBuU+HGAj8Ck+Y+6xsr+4Q=
X-Google-Smtp-Source: ABdhPJzeIL2KzFliPj5q1+G65Ix60owMTea3vwdPu/Ohl/J2kEU7PjU52831wPnfXEs4fQb2r7QZRQ==
X-Received: by 2002:a62:820a:0:b0:51b:d1f9:b45f with SMTP id w10-20020a62820a000000b0051bd1f9b45fmr33928754pfd.63.1654743939090;
        Wed, 08 Jun 2022 20:05:39 -0700 (PDT)
Received: from JMHNXMC7VH.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id j10-20020a17090ae60a00b001e29ddf9f4fsm14719368pjy.3.2022.06.08.20.05.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jun 2022 20:05:38 -0700 (PDT)
From:   Han Xin <chiyutianyi@gmail.com>
To:     nksingh85@gmail.com
Cc:     Han Xin <chiyutianyi@gmail.com>, avarab@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, l.s.r@web.de,
        neerajsi@microsoft.com, newren@gmail.com, philipoakley@iee.email,
        stolee@gmail.com, worldhello.net@gmail.com,
        zhiyou.jx@alibaba-inc.com
Subject: [RFC PATCH] object-file.c: batched disk flushes for stream_loose_object()
Date:   Thu,  9 Jun 2022 11:05:30 +0800
Message-Id: <20220609030530.51746-1-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <7ba4858a-d1cc-a4eb-b6d6-4c04a5dd6ce7@gmail.com>
References: <7ba4858a-d1cc-a4eb-b6d6-4c04a5dd6ce7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neeraj Singh[1] pointed out that if batch fsync is enabled, we should still
call prepare_loose_object_bulk_checkin() to potentially create the bulk checkin
objdir.

1. https://lore.kernel.org/git/7ba4858a-d1cc-a4eb-b6d6-4c04a5dd6ce7@gmail.com/

Signed-off-by: Han Xin <chiyutianyi@gmail.com>
---
 object-file.c                   |  3 +++
 t/t5351-unpack-large-objects.sh | 15 ++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index 2dd828b45b..3a1be74775 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2131,6 +2131,9 @@ int stream_loose_object(struct input_stream *in_stream, size_t len,
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen;
 
+	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
+		prepare_loose_object_bulk_checkin();
+
 	/* Since oid is not determined, save tmp file to odb path. */
 	strbuf_addf(&filename, "%s/", get_object_directory());
 	hdrlen = format_object_header(hdr, sizeof(hdr), OBJ_BLOB, len);
diff --git a/t/t5351-unpack-large-objects.sh b/t/t5351-unpack-large-objects.sh
index 461ca060b2..a66a51f7df 100755
--- a/t/t5351-unpack-large-objects.sh
+++ b/t/t5351-unpack-large-objects.sh
@@ -18,7 +18,10 @@ test_expect_success "create large objects (1.5 MB) and PACK" '
 	test_commit --append foo big-blob &&
 	test-tool genrandom bar 1500000 >big-blob &&
 	test_commit --append bar big-blob &&
-	PACK=$(echo HEAD | git pack-objects --revs pack)
+	PACK=$(echo HEAD | git pack-objects --revs pack) &&
+	git verify-pack -v pack-$PACK.pack |
+	    grep -E "commit|tree|blob" |
+		sed -n -e "s/^\([0-9a-f]*\).*/\1/p" >obj-list
 '
 
 test_expect_success 'set memory limitation to 1MB' '
@@ -45,6 +48,16 @@ test_expect_success 'unpack big object in stream' '
 	test_dir_is_empty dest.git/objects/pack
 '
 
+BATCH_CONFIGURATION='-c core.fsync=loose-object -c core.fsyncmethod=batch'
+
+test_expect_success 'unpack big object in stream (core.fsyncmethod=batch)' '
+	prepare_dest 1m &&
+	git $BATCH_CONFIGURATION -C dest.git unpack-objects <pack-$PACK.pack &&
+	test_dir_is_empty dest.git/objects/pack &&
+	git -C dest.git cat-file --batch-check="%(objectname)" <obj-list >current &&
+	cmp obj-list current
+'
+
 test_expect_success 'do not unpack existing large objects' '
 	prepare_dest 1m &&
 	git -C dest.git index-pack --stdin <pack-$PACK.pack &&
-- 
2.36.1

