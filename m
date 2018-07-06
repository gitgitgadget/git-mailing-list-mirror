Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 286F81F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 00:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753910AbeGFAxv (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jul 2018 20:53:51 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:45723 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753868AbeGFAxp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jul 2018 20:53:45 -0400
Received: by mail-qk0-f195.google.com with SMTP id c192-v6so5492790qkg.12
        for <git@vger.kernel.org>; Thu, 05 Jul 2018 17:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2t/3/sNize5BIFZkuYkxQ2QLrOjmLuAX9LnA31S+jiQ=;
        b=pFc82IH9Hy9k181YggixS8fW2lbjP/2hcgqyCElNpRq0BimdppoX4ndpVmNEvQ/cXh
         Ab+00+IfzM13xjzR5ZLn5xYar56fzVLNZBsiypm2PKFP0yVHFHXON6jcaf26sw0Au5/p
         XdgHpt5zw3sbM+aWZi1x6VLxZG5Yyr0MyAma9nzwDVJW4+m92Ia9KiNtRDqXwL6dGRAo
         RkEq+H/cOYtdYJdRp0pMtsx2COBNdHjxzcaalJZwhaiDUhWyHwrNPvaS1N8K4VGIUwkj
         jKFHJz8ap92MOKHlQY0B2AdE9LAWcuRIq3kBtW9ySGvIBoOt3d/IUMXLz1KARB+oP3mG
         XNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2t/3/sNize5BIFZkuYkxQ2QLrOjmLuAX9LnA31S+jiQ=;
        b=OvA9h++5zD0W68C570R9eWrJf2WuDpo1oyzhmfSwQneu9+LhcpZzDsx+KfsWx50EF3
         DagNPwvUBhgIhiAo4djdRkiW3GTK9cM5nmqpsdukq03/bgoRte4BakeTylnC7RWFUwl6
         3SwvYrRRJf1TDbZAo1uasBPRIOECTtScqI49uK1f4pWoMd8axgHHRKHKWn0jqaVx1nd1
         YFk6MlTznf5rdyUZrEZo/55CZXGBEdkN0XfdqXNbQwGW5phwSjpRoUmu2vbHMvIfA1fy
         wH6jNL1u/K53pdl7SjM1icfcAl9ffG8BK6+JEEvhTXF5MAnpb0uKTvzaW4WgzBqw6mvh
         EFvA==
X-Gm-Message-State: APt69E0WsCIy1OHle7PEN7IjyXlY63psxBKZt5tKeDIP3R+qDT6yJq+S
        rPaXB+QDEvBZPLarCb3CbV/8BdbD
X-Google-Smtp-Source: AAOMgpfrsJTnn+mKTVGzXdAPLDbf+RvSLsd4+WvaqvTl+3cprTHGPLuQS2+ogg4WXcvlksTEwECFJw==
X-Received: by 2002:a37:8941:: with SMTP id l62-v6mr6992718qkd.204.1530838424258;
        Thu, 05 Jul 2018 17:53:44 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u25-v6sm4882791qku.3.2018.07.05.17.53.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 17:53:43 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, dstolee@microsoft.com
Subject: [PATCH v3 09/24] multi-pack-index: read packfile list
Date:   Thu,  5 Jul 2018 20:53:06 -0400
Message-Id: <20180706005321.124643-10-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.118.gd4f65b8d14
In-Reply-To: <20180706005321.124643-1-dstolee@microsoft.com>
References: <20180625143434.89044-1-dstolee@microsoft.com>
 <20180706005321.124643-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When constructing a multi-pack-index file for a given object directory,
read the files within the enclosed pack directory and find matches that
end with ".idx" and find the correct paired packfile using
add_packed_git().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c                      | 46 ++++++++++++++++++++++++++++++++++++-
 t/t5319-multi-pack-index.sh | 16 ++++++-------
 2 files changed, 53 insertions(+), 9 deletions(-)

diff --git a/midx.c b/midx.c
index fb388f5858..b0722485df 100644
--- a/midx.c
+++ b/midx.c
@@ -1,6 +1,8 @@
 #include "cache.h"
 #include "csum-file.h"
+#include "dir.h"
 #include "lockfile.h"
+#include "packfile.h"
 #include "object-store.h"
 #include "midx.h"
 
@@ -112,12 +114,39 @@ static size_t write_midx_header(struct hashfile *f,
 	return MIDX_HEADER_SIZE;
 }
 
+struct pack_list {
+	struct packed_git **list;
+	uint32_t nr;
+	uint32_t alloc_list;
+};
+
+static void add_pack_to_midx(const char *full_path, size_t full_path_len,
+			     const char *file_name, void *data)
+{
+	struct pack_list *packs = (struct pack_list *)data;
+
+	if (ends_with(file_name, ".idx")) {
+		ALLOC_GROW(packs->list, packs->nr + 1, packs->alloc_list);
+
+		packs->list[packs->nr] = add_packed_git(full_path,
+							 full_path_len,
+							 0);
+		if (!packs->list[packs->nr]) {
+			warning(_("failed to add packfile '%s'"),
+				full_path);
+			return;
+		}
+	}
+}
+
 int write_midx_file(const char *object_dir)
 {
 	unsigned char num_chunks = 0;
 	char *midx_name;
+	uint32_t i;
 	struct hashfile *f = NULL;
 	struct lock_file lk;
+	struct pack_list packs;
 
 	midx_name = get_midx_filename(object_dir);
 	if (safe_create_leading_directories(midx_name)) {
@@ -126,14 +155,29 @@ int write_midx_file(const char *object_dir)
 			  midx_name);
 	}
 
+	packs.nr = 0;
+	packs.alloc_list = 16;
+	packs.list = NULL;
+	ALLOC_ARRAY(packs.list, packs.alloc_list);
+
+	for_each_file_in_pack_dir(object_dir, add_pack_to_midx, &packs);
+
 	hold_lock_file_for_update(&lk, midx_name, LOCK_DIE_ON_ERROR);
 	f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
 	FREE_AND_NULL(midx_name);
 
-	write_midx_header(f, num_chunks, 0);
+	write_midx_header(f, num_chunks, packs.nr);
 
 	finalize_hashfile(f, NULL, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
 	commit_lock_file(&lk);
 
+	for (i = 0; i < packs.nr; i++) {
+		if (packs.list[i]) {
+			close_pack(packs.list[i]);
+			free(packs.list[i]);
+		}
+	}
+
+	free(packs.list);
 	return 0;
 }
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 1be7be02b8..fd0a3f3be7 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -4,8 +4,9 @@ test_description='multi-pack-indexes'
 . ./test-lib.sh
 
 midx_read_expect () {
+	NUM_PACKS=$1
 	cat >expect <<-EOF
-	header: 4d494458 1 0 0
+	header: 4d494458 1 0 $NUM_PACKS
 	object_dir: .
 	EOF
 	test-tool read-midx . >actual &&
@@ -15,8 +16,7 @@ midx_read_expect () {
 test_expect_success 'write midx with no packs' '
 	test_when_finished rm -f pack/multi-pack-index &&
 	git multi-pack-index --object-dir=. write &&
-	test_path_is_file pack/multi-pack-index &&
-	midx_read_expect
+	midx_read_expect 0
 '
 
 test_expect_success 'create objects' '
@@ -47,13 +47,13 @@ test_expect_success 'write midx with one v1 pack' '
 	pack=$(git pack-objects --index-version=1 pack/test <obj-list) &&
 	test_when_finished rm pack/test-$pack.pack pack/test-$pack.idx pack/multi-pack-index &&
 	git multi-pack-index --object-dir=. write &&
-	midx_read_expect
+	midx_read_expect 1
 '
 
 test_expect_success 'write midx with one v2 pack' '
 	git pack-objects --index-version=2,0x40 pack/test <obj-list &&
 	git multi-pack-index --object-dir=. write &&
-	midx_read_expect
+	midx_read_expect 1
 '
 
 test_expect_success 'Add more objects' '
@@ -83,7 +83,7 @@ test_expect_success 'Add more objects' '
 test_expect_success 'write midx with two packs' '
 	git pack-objects --index-version=1 pack/test-2 <obj-list2 &&
 	git multi-pack-index --object-dir=. write &&
-	midx_read_expect
+	midx_read_expect 2
 '
 
 test_expect_success 'Add more packs' '
@@ -106,7 +106,7 @@ test_expect_success 'Add more packs' '
 		git ls-tree $tree | sed -e "s/.* \\([0-9a-f]*\\)	.*/\\1/"
 		} >obj-list &&
 		git update-ref HEAD $commit &&
-		git pack-objects --index-version=2 test-pack <obj-list &&
+		git pack-objects --index-version=2 pack/test-pack <obj-list &&
 		i=$(expr $i + 1) || return 1 &&
 		j=$(expr $j + 1) || return 1
 	done
@@ -114,7 +114,7 @@ test_expect_success 'Add more packs' '
 
 test_expect_success 'write midx with twelve packs' '
 	git multi-pack-index --object-dir=. write &&
-	midx_read_expect
+	midx_read_expect 12
 '
 
 test_done
-- 
2.18.0.118.gd4f65b8d14

