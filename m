Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66C611F424
	for <e@80x24.org>; Thu, 10 May 2018 00:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935613AbeEJAMT (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 20:12:19 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42791 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933493AbeEJAMS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 20:12:18 -0400
Received: by mail-pf0-f195.google.com with SMTP id p14-v6so163483pfh.9
        for <git@vger.kernel.org>; Wed, 09 May 2018 17:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3ZFZ9lhlCadGpSI1fHIcyLFNFaKwzf0LyQnKNiHE4Ms=;
        b=gFIQ/QkOSlLSgYLkEhWgSTmm005ZBTnAStDCG5mIAdPwaMIACy3rstDRKkLQMDHQX1
         STmCBPQm/VXA/L0qWxBFUn1rQhUz4xfx6H1QDkv9cpoCFSX6sOWIxGdUVRLKTh9BQuDl
         E02Pp4cIva8pGpSGuVrvKl9o4h4DiUPCm3f53yhZ3QcK3zUTxAqrUtANoxGC9ebpfvwV
         IX9+VdXcR+PobVOyU5G/Ol+IGmxZyt15tgVzvDSCIW7khjEyey8m6bMgxpQkRoHw9LfG
         FVIaEjJ4LoZQUHs762XbAEYObaSNGkXFyoYPNeyNIH8HzSBxSBQikHc81eiPhIzZ36W/
         c3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3ZFZ9lhlCadGpSI1fHIcyLFNFaKwzf0LyQnKNiHE4Ms=;
        b=Ijmu36jGkZ5iMg7wznaFLrSj5eGeoj7F574CHuxP27j8AdCzk9f780VrTm78nnVN6D
         sBAfySgqX3R6tpbhBpZK9xDH+AoEemlpaQHpaRxxPWSplEvXLcFEIh6kxEwvUXPIFGcn
         vpknPJDrgbglTi/Nb3eobrqcWhO0VQ6/bevxvWzSUmDenI3FG+FU/+KDcNqCmZxl7P2u
         9NnGcXOzF8uWt3ldBO/cQG5bzQJhgTGEw7kRocEV2f/uRFiYydO3o/JuyUtcP3zWrKEF
         wKWW2CVT/v106FkCKtw09ZrczyUClOjILIY1da5DV94iBjmMXUB1f3pzX/26/LLe03Mx
         ezdg==
X-Gm-Message-State: ALQs6tAMIhjVVDAngRRKu2vVC5xawQRY19t6z96bxDFDKrLuergRAsBe
        ua+8ZSoNMd2E6tTtS0oIoYPhDQ==
X-Google-Smtp-Source: AB8JxZqaxhnccrjaIRUJMTb36QEGkdjCh800DmXbSthSpShekMQxw9DgMOb9xkRftE5CkDvp7CNO7Q==
X-Received: by 2002:a65:5a81:: with SMTP id c1-v6mr37521243pgt.20.1525911137870;
        Wed, 09 May 2018 17:12:17 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id v10-v6sm41066921pgt.33.2018.05.09.17.12.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 May 2018 17:12:17 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] packfile: close and free packs upon releasing an object store
Date:   Wed,  9 May 2018 17:12:10 -0700
Message-Id: <20180510001211.163692-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In d0b59866223 (object-store: close all packs upon clearing the object
store, 2018-03-23), we made sure to close all packfiles on releasing
an object store, but we also have to free the memory of the closed packs.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 object.c   |  2 +-
 packfile.c | 11 +++++++++++
 packfile.h |  1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/object.c b/object.c
index 66cffaf6e51..3e64a4a26dd 100644
--- a/object.c
+++ b/object.c
@@ -485,6 +485,6 @@ void raw_object_store_clear(struct raw_object_store *o)
 	o->alt_odb_tail = NULL;
 
 	INIT_LIST_HEAD(&o->packed_git_mru);
-	close_all_packs(o);
+	close_and_free_packs(o);
 	o->packed_git = NULL;
 }
diff --git a/packfile.c b/packfile.c
index 6c3ddc3c31d..ba4baa55531 100644
--- a/packfile.c
+++ b/packfile.c
@@ -322,6 +322,17 @@ void close_all_packs(struct raw_object_store *o)
 			close_pack(p);
 }
 
+void close_and_free_packs(struct raw_object_store *o)
+{
+	close_all_packs(o);
+
+	while (o->packed_git) {
+		struct packed_git *p = o->packed_git;
+		o->packed_git = p->next;
+		free(p);
+	}
+}
+
 /*
  * The LRU pack is the one with the oldest MRU window, preferring packs
  * with no used windows, or the oldest mtime if it has no windows allocated.
diff --git a/packfile.h b/packfile.h
index 9c2f8859945..cdab0557979 100644
--- a/packfile.h
+++ b/packfile.h
@@ -67,6 +67,7 @@ extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t
 extern void close_pack_windows(struct packed_git *);
 extern void close_pack(struct packed_git *);
 extern void close_all_packs(struct raw_object_store *o);
+extern void close_and_free_packs(struct raw_object_store *o);
 extern void unuse_pack(struct pack_window **);
 extern void clear_delta_base_cache(void);
 extern struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
-- 
2.17.0.255.g8bfb7c0704

