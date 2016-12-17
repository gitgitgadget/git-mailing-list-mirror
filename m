Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93A541FF76
	for <e@80x24.org>; Sat, 17 Dec 2016 14:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758070AbcLQO4W (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Dec 2016 09:56:22 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34695 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757674AbcLQO4U (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2016 09:56:20 -0500
Received: by mail-wm0-f66.google.com with SMTP id g23so10603745wme.1
        for <git@vger.kernel.org>; Sat, 17 Dec 2016 06:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E/nVXR39ToEj5+J7b24n7fPbUs2regnceuLiMtL5Z/U=;
        b=rWUyf57iBAQy7wHDlccmL5VtlXO8BTSd0HFl6lKIJw0Ax2M58ZZ9s+OGnPHIPJ3hUI
         4cSfaXEfVIV3tf3O7g5yG/gKH/gEq6KamVPQre1OODoB2qVyPFc36caEDI6A+xjNxzHG
         iSr/p5d9HoH6uGoTihN6rH5qw+IBDQqUYPO3IEf7pxeFYh3D8pE+cKZVNJtv6YOT91vn
         i/DfD4EzgfKAIeg6m3HfKdjtlshfNmo83dgt4cJwgc+UCIDJFmAwh+/eGEQzgpoEliTr
         +Gr1CccbexWELTOzUDPb3W1TXoTNLd9tY/dC/OcmNlJ9cu+seDAy/GPpbMLRUQyluqhH
         qW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E/nVXR39ToEj5+J7b24n7fPbUs2regnceuLiMtL5Z/U=;
        b=aY0KNa/6krtfSlsYT9S7IAm/AE2LkWWGlZxSiDVIkmWc63qjULoi7sgkyBXGUJg/cD
         Q+3rKv/w9t+0FLxI+EqbIt33UvUF8qjSQJ2O1ZQCLVuwhFTHDh72DzmEBTp1cFRUVHJG
         jPomZ5KT5wZE921fQdYg8sNfXIc7zjFxDJyLrGj090MYUou6z81ZLPO7RrMO9ujK10GS
         fQJ1jaoeU18Q776Gw/kbP0p+i86HfiNPZIPFOW0+mmJtCHZ97xujP8KbTdlYbs8MQUUv
         zTG4oINDR172r9NFp1nuEabRAdHEte2a8qBpAsdIpES3pnBCUw4aY7C/EanQH4RccPe7
         Gtjg==
X-Gm-Message-State: AIkVDXIWlYdiFsBSTGeliPtDSMhzROupXyXGA179z9W6djpVIIcQ7YHI0NRfWyXbzCRo/w==
X-Received: by 10.28.214.133 with SMTP id n127mr7831443wmg.28.1481986578984;
        Sat, 17 Dec 2016 06:56:18 -0800 (PST)
Received: from localhost.localdomain (85.198.126.78.rev.sfr.net. [78.126.198.85])
        by smtp.gmail.com with ESMTPSA id y4sm11823449wjp.0.2016.12.17.06.56.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Dec 2016 06:56:18 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 14/21] read-cache: touch shared index files when used
Date:   Sat, 17 Dec 2016 15:55:40 +0100
Message-Id: <20161217145547.11748-15-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.49.g2414764.dirty
In-Reply-To: <20161217145547.11748-1-chriscool@tuxfamily.org>
References: <20161217145547.11748-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a split-index file is created, let's update the mtime of the
shared index file that the split-index file is referencing.

In a following commit we will make shared index file expire
depending on their mtime, so updating the mtime makes sure that
the shared index file will not be deleted soon.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 read-cache.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 280b01bd6c..42688261f7 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1685,6 +1685,19 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	die("index file corrupt");
 }
 
+/*
+ * Signal that the shared index is used by updating its mtime.
+ *
+ * This way, shared index can be removed if they have not been used
+ * for some time. It's ok to fail to update the mtime if we are on a
+ * read only file system.
+ */
+void freshen_shared_index(char *base_sha1_hex)
+{
+	const char *shared_index = git_path("sharedindex.%s", base_sha1_hex);
+	check_and_freshen_file(shared_index, 1);
+}
+
 int read_index_from(struct index_state *istate, const char *path)
 {
 	struct split_index *split_index;
@@ -2276,6 +2289,8 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 		int ret = write_shared_index(istate, lock, flags);
 		if (ret)
 			return ret;
+	} else {
+		freshen_shared_index(sha1_to_hex(si->base_sha1));
 	}
 
 	return write_split_index(istate, lock, flags);
-- 
2.11.0.49.g2414764.dirty

