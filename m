Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EECC1F955
	for <e@80x24.org>; Thu, 28 Jul 2016 16:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759054AbcG1QDM (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 12:03:12 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35934 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758947AbcG1QDI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 12:03:08 -0400
Received: by mail-wm0-f65.google.com with SMTP id x83so11813789wma.3
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 09:03:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QMkFet5g8DdyNzEULujvya8XIReHX/640JxfLpp4Spk=;
        b=Al6FI0CyrvHfH602bwlcMMPhay763UHVjHBLxg1ZR2+HzhAi9gLWIFPVD7ct/GxQlF
         si0XXDMzhBRsQmUoZ1tRY3rTEgE3KAToNFliyHUJQD6cH3nOaXhScEd5lAMAZdltLjHW
         5JFq+nEYPYfUAWvoSXneoDpbTMeYOLOMpF6+5PSpNbH7BqpbgMeDeNTStvf91I/7Rx1e
         bCixap7MR9fBR59CTI3UaZ9ttYqOmoYDPOj3fTw9VEiohvshZ0z49yi2rThov5KVTNIi
         o70ZBcwnIw193RS7qRWanH6ZqkXifbEuq47sX1w7/r4B5h+SgfWceW16Eii09pHINgcv
         nJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QMkFet5g8DdyNzEULujvya8XIReHX/640JxfLpp4Spk=;
        b=YFSKPtQ/vyu0XhSEF+9iVrUmLynkfPpNfuiZz0MvZMtztj6vjg00unx3qyV03oKt1o
         4Gz0JsDCw/tV4PriK/Kn6J5FblJZ6jjcQJgq02xMrNbBgP9TCIFJbOFA2do+4PHizRfR
         Gk6c6X5BGjwYlDCPIB/xnQt+Pi5ubNJ8FPzCUuNHSGqwWyQrHeZa/7xfwWd4Vh/xY0Me
         Y6KTqJN6pPxSrxoaJ/Xd6keW9XW60TmTxHX6irN97h/2RggNl0Ath7PXzyW8093ybmYk
         xeXWmBQL16DcioFFydJ/SrXxufX0RfSqBS+bF5zq3uWdDZK8vYHWk60X++GkB8+e8ox8
         10KQ==
X-Gm-Message-State: ALyK8tIgF44lXRmE/KavLFWlLc1djkq+c+C/JcSbzccn0iMVIt0JuZR0B90Frw3CzDIIYw==
X-Received: by 10.28.153.70 with SMTP id b67mr60982656wme.84.1469721786343;
        Thu, 28 Jul 2016 09:03:06 -0700 (PDT)
Received: from localhost.localdomain (p54A20961.dip0.t-ipconnect.de. [84.162.9.97])
        by smtp.gmail.com with ESMTPSA id ka6sm12118232wjb.38.2016.07.28.09.03.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jul 2016 09:03:05 -0700 (PDT)
From:	Robin Ruede <r.ruede@gmail.com>
To:	git@vger.kernel.org
Cc:	Robin Ruede <r.ruede@gmail.com>
Subject: [PATCH/RFC 2/7] pack-objects: add sparse-prefix
Date:	Thu, 28 Jul 2016 18:02:21 +0200
Message-Id: <20160728160226.24018-3-r.ruede@gmail.com>
X-Mailer: git-send-email 2.9.2.472.g105ab30
In-Reply-To: <20160728160226.24018-1-r.ruede@gmail.com>
References: <20160728160226.24018-1-r.ruede@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

this allows creating packs that contain only the blobs relevant to a
specific subdirectory, e.g.

    echo HEAD | git pack-objects --revs --sparse-prefix=/contrib/

will create a pack containing the complete history of HEAD, including
all commits, all trees, and the files in the contrib directory.

Signed-off-by: Robin Ruede <r.ruede@gmail.com>
---
 builtin/pack-objects.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a2f8cfd..0674f57 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2621,6 +2621,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	struct argv_array rp = ARGV_ARRAY_INIT;
 	int rev_list_unpacked = 0, rev_list_all = 0, rev_list_reflog = 0;
 	int rev_list_index = 0;
+	const char *sparse_prefix = NULL;
+
 	struct option pack_objects_options[] = {
 		OPT_SET_INT('q', "quiet", &progress,
 			    N_("do not show progress meter"), 0),
@@ -2685,6 +2687,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			 N_("create thin packs")),
 		OPT_BOOL(0, "shallow", &shallow,
 			 N_("create packs suitable for shallow fetches")),
+		OPT_STRING(0, "sparse-prefix", &sparse_prefix, N_("path"),
+		  N_("only include blobs relevant for sparse checkout (implies --revs)")),
 		OPT_BOOL(0, "honor-pack-keep", &ignore_packed_keep,
 			 N_("ignore packs that have companion .keep file")),
 		OPT_INTEGER(0, "compression", &pack_compression_level,
@@ -2725,6 +2729,13 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	} else
 		argv_array_push(&rp, "--objects");
 
+	if (sparse_prefix) {
+		use_internal_rev_list = 1;
+		// with bitmaps the path of the blobs is not known
+		use_bitmap_index = 0;
+		argv_array_push(&rp, "--sparse-prefix");
+		argv_array_push(&rp, sparse_prefix);
+	}
 	if (rev_list_all) {
 		use_internal_rev_list = 1;
 		argv_array_push(&rp, "--all");
-- 
2.9.1.283.g3ca5b4c.dirty

