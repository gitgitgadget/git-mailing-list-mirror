Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A61C4332F
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 05:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiDEFWw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 01:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiDEFWb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 01:22:31 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2F12F9
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 22:20:32 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id m12-20020a17090b068c00b001cabe30a98dso1440002pjz.4
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 22:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BjOiEyJuQBWIERTIpXyVAQku9LG/YV978SzY4PMeX3A=;
        b=WcnvyRdaw8wQ/lUGCiorqRrYf04Z3mkOmdtuWe66p+dR3qpbUb8EiBbKypZN84C78i
         vgUPPkZ65IKJrayoKztnZ2UwoavpHK0FblYCAG7CpH/UeM9Fmi7vllAM+oJegYsXxwzx
         HhopFG++7DUtmLqDIDoNRPk8+7D7WDPMZe98mMBVq2yggyh5dZKz+6eExZiziTB83UVJ
         48JdQ3O4oq2GhBZvzsRUhm+sY7DNKJyWfbVanJlC08DO5w4fdb9/3hrdARG9fLaGBHe8
         6KR2xBGAtwVjnRYpNSGdV035/+o2KWAXiVcE8ylkkgtWigM2X5H+dVEQdImbRjf6v6UC
         9kYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BjOiEyJuQBWIERTIpXyVAQku9LG/YV978SzY4PMeX3A=;
        b=N/oH6aJ6OvYpmDM1EfjJrXLXauMML7QAoo351O51cHbbY4HEZudHkS/yAhHehFttGc
         58xUTtKRVmZljQnfhxiCE0ElGXk76gZkhDZUfu8bhaAjVDWdxBUgihh8emmqujuB5Tyf
         1rUM4BzmJkTs0wjvL1hZwZOfifLVNLGsPFDyk4fMJUqsC+c/CdXVEADSjFNnUzhpGjzX
         AdaJECHObqvFROFIgj/YHAUdSpeKO4U1o51XJLYlliLc5QZlmhyVc+3jz4l7TBndqmE9
         kbypERDpkiZlff/VslUitORx7t52BBL9AhK8qlMWmbDiUuHS9o8J8HS9E+q0Cg9zJwfH
         0g+Q==
X-Gm-Message-State: AOAM533HObFUD00kpEhOnMCStyaAHVMJxeu7WlnArZGHyAVitiiNINcK
        oyV//yGOowu86Na0TWDk5V8=
X-Google-Smtp-Source: ABdhPJztluL/3zi/LwdQfZz3dM2Zj07ov6zDFpQ1XHHghgpdKvYNAv69vCJ6xJTnQNIVLps1AGJiEw==
X-Received: by 2002:a17:903:1208:b0:151:93fd:d868 with SMTP id l8-20020a170903120800b0015193fdd868mr1668531plh.121.1649136031862;
        Mon, 04 Apr 2022 22:20:31 -0700 (PDT)
Received: from neerajsi-x1.localdomain (c-24-56-226-231.customer.broadstripe.net. [24.56.226.231])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090a708300b001c7e8ae7637sm808859pjk.8.2022.04.04.22.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 22:20:31 -0700 (PDT)
From:   nksingh85@gmail.com
X-Google-Original-From: neerajsi@microsoft.com
To:     gitgitgadget@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, bagasdotme@gmail.com,
        git@vger.kernel.org, jeffhost@microsoft.com,
        neerajsi@microsoft.com, nksingh85@gmail.com, ps@pks.im,
        worldhello.net@gmail.com
Subject: [PATCH v6 07/12] unpack-objects: use the bulk-checkin infrastructure
Date:   Mon,  4 Apr 2022 22:20:13 -0700
Message-Id: <20220405052018.11247-8-neerajsi@microsoft.com>
X-Mailer: git-send-email 2.34.1.78.g86e39b8f8d
In-Reply-To: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
References: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

The unpack-objects functionality is used by fetch, push, and fast-import
to turn the transfered data into object database entries when there are
fewer objects than the 'unpacklimit' setting.

By enabling an odb-transaction when unpacking objects, we can take advantage
of batched fsyncs.

Here are some performance numbers to justify batch mode for
unpack-objects, collected on a WSL2 Ubuntu VM.

Fsync Mode | Time for 90 objects (ms)
-------------------------------------
       Off | 170
  On,fsync | 760
  On,batch | 230

Note that the default unpackLimit is 100 objects, so there's a 3x
benefit in the worst case. The non-batch mode fsync scales linearly
with the number of objects, so there are significant benefits even with
smaller numbers of objects.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 builtin/unpack-objects.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index dbeb0680a58..56d05e2725d 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "bulk-checkin.h"
 #include "config.h"
 #include "object-store.h"
 #include "object.h"
@@ -503,10 +504,12 @@ static void unpack_all(void)
 	if (!quiet)
 		progress = start_progress(_("Unpacking objects"), nr_objects);
 	CALLOC_ARRAY(obj_list, nr_objects);
+	begin_odb_transaction();
 	for (i = 0; i < nr_objects; i++) {
 		unpack_one(i);
 		display_progress(progress, i + 1);
 	}
+	end_odb_transaction();
 	stop_progress(&progress);
 
 	if (delta_list)
-- 
2.34.1.78.g86e39b8f8d

