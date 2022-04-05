Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B589C433F5
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 05:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiDEFWl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 01:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiDEFW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 01:22:27 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC58A2AC2
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 22:20:28 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id t4so10150086pgc.1
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 22:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kxpscCbiOXLWSX42PERUczSJRBEcxinkXjMj0JcnIYI=;
        b=mCnULzldGjifS+FdOOPpFOwY9be2k4w+g4S0dMl12u/A2oxDYkMh2A51hh3eIYnfZB
         yUtDfx3C3YCAehde/OJwXdWeg9htHbHwY5TiDw0XhBfkHR3OWfZhKJWvixQRe+OCKH47
         ANVWtFvZjGSpemiwDTiPnIeYZ78pBnTSgQKHQ58lpO8UvYUf9RZv7HIU9ljOnu0wurA1
         hfpLb7MXuD/iJp5dAvGB+RS7lr3B1WpoDdkOZOiLln7SbOYUxerfs1kIVinQMdcBFj7r
         TWAaiPpoHKjsA0ZdMQnlJPSKwmuwkMnOqRldGJH2wb7Zh4PV2Kwm5oXvfTF6IXI59dWb
         9uOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kxpscCbiOXLWSX42PERUczSJRBEcxinkXjMj0JcnIYI=;
        b=aP9auylPqiQgKF+18fIO5kn1VAPl3wYqzvtMQG11Hx2X8mL2zTGLiH/VGvhd4McIuI
         Z22tt8j2g7vXOqTVEUvNE1rV0aOCAkrwpRq07ttT+7hiBY3t/OMEYTG7BuM3eccua+TL
         rVWrQQWMnkQH6OGDsIru65+D5NewvJwIA+GLDYXO6nAMQxDzNfykCmJ064+pWWnJSUSs
         hljsyqpGT5+/BjUJvEme4nYR3aCfu9Zotu9S6rNknGIZThEvuLv2Mwty0HxiYy0pW47a
         41hTtxclxsLFhiohHcLIz9se/8SNJofZ9BNSJ9RJg6+g2ZGtaT+EFLQJEP4hOyhfg6mm
         pS2w==
X-Gm-Message-State: AOAM5308/yw/6xvkWB60M7KwVJK65GsLHRxmKTqRPWuEpGqjsF7LnbzD
        28eBaoAiqGIQLiP/hs4DeTgI0RchYHIHhQ==
X-Google-Smtp-Source: ABdhPJw5UzZ3UOjxKXwtaNXz9Fxp9azBT+DD2FZQPmJ7VTKcALl68zkLUkAnID7R6pQDRIOYmcJZ2g==
X-Received: by 2002:a63:44f:0:b0:385:fa8a:1889 with SMTP id 76-20020a63044f000000b00385fa8a1889mr1427905pge.160.1649136028322;
        Mon, 04 Apr 2022 22:20:28 -0700 (PDT)
Received: from neerajsi-x1.localdomain (c-24-56-226-231.customer.broadstripe.net. [24.56.226.231])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090a708300b001c7e8ae7637sm808859pjk.8.2022.04.04.22.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 22:20:27 -0700 (PDT)
From:   nksingh85@gmail.com
X-Google-Original-From: neerajsi@microsoft.com
To:     gitgitgadget@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, bagasdotme@gmail.com,
        git@vger.kernel.org, jeffhost@microsoft.com,
        neerajsi@microsoft.com, nksingh85@gmail.com, ps@pks.im,
        worldhello.net@gmail.com
Subject: [PATCH v6 04/12] cache-tree: use ODB transaction around writing a tree
Date:   Mon,  4 Apr 2022 22:20:10 -0700
Message-Id: <20220405052018.11247-5-neerajsi@microsoft.com>
X-Mailer: git-send-email 2.34.1.78.g86e39b8f8d
In-Reply-To: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
References: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

Take advantage of the odb transaction infrastructure around writing the
cached tree to the object database.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 cache-tree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/cache-tree.c b/cache-tree.c
index 6752f69d515..8c5e8822716 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -3,6 +3,7 @@
 #include "tree.h"
 #include "tree-walk.h"
 #include "cache-tree.h"
+#include "bulk-checkin.h"
 #include "object-store.h"
 #include "replace-object.h"
 #include "promisor-remote.h"
@@ -474,8 +475,10 @@ int cache_tree_update(struct index_state *istate, int flags)
 
 	trace_performance_enter();
 	trace2_region_enter("cache_tree", "update", the_repository);
+	begin_odb_transaction();
 	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
 		       "", 0, &skip, flags);
+	end_odb_transaction();
 	trace2_region_leave("cache_tree", "update", the_repository);
 	trace_performance_leave("cache_tree_update");
 	if (i < 0)
-- 
2.34.1.78.g86e39b8f8d

