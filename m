Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DEFB203BD
	for <e@80x24.org>; Fri, 15 Jul 2016 02:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540AbcGOCnO (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 22:43:14 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36674 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbcGOCnN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 22:43:13 -0400
Received: by mail-pf0-f196.google.com with SMTP id y134so1394719pfg.3
        for <git@vger.kernel.org>; Thu, 14 Jul 2016 19:43:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=ZfzzBXhgRDcQEu8VYDJJUxcNqDrFHsp5WdQZquPNhLE=;
        b=Wp6XwedwNK/Yb3XyK/Q9UzkDt7Kp3pUrKsaNOgfNrL/7GNvHMqXOvnDYFy51wLOFbs
         QWZd88yEQsqvavp0ZuCTc8S/IliWgrzi2wVhUC3CyRGWaFx+a1jn/3ht7oS768DsUJqF
         Q+QFThERa4ME8WU4tcuyJl7fsJDAn2Zz+vnWEdGCg13EJHm43yE2Z3eDOEYvMGcioLS/
         JlYVSoQIA7ugbEj7Wf/yaNjO0jT9DZvwUTOkfVBJfgTWcPb/F6hKjTnvneaDTxDoTgcm
         Q1lgqlzMxnxghciPbDx5Ov42MweiXNn6Nuc91h5bLLvtPfN3HtCo1+KvBybk4/t1DPZW
         q6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=ZfzzBXhgRDcQEu8VYDJJUxcNqDrFHsp5WdQZquPNhLE=;
        b=a8o4AKHf1TaPWutOYzog818q/cX575kkAZf2VFWnu8N1zVarve5RiRSCXWX+rkGpWT
         fKVQEbZzza3nZNviM89jTjdMARtci5fNYYdygCZ8E3v1+YVDgE0KhhtKtg/y8mFSFJZN
         98LY0BvLJL1zaZo4sfy3GoCFyPT8PR1+vIJ6+PTCLVXSalXuM9xDrJJjsLjFNHF0yt4z
         U7r5eGhFWT1atrXGqr1cy2Abkl1bLEQUFGduMbjLJ2KsCHi3G4MT/AE5AtYBTr05MNo/
         FOmlb2dJSCNF33mPpZIkvgVdVWCUwxMU+3uVrP7WOkTGg1O+mz3ODEKTtWvsqPpgUvTu
         l2Mg==
X-Gm-Message-State: ALyK8tICJNx3+220pCnZVKvqtMbkHXQGnMysEpOWuYJ9L+hxMQrrFodipdrMPV5xySvnoA==
X-Received: by 10.98.158.218 with SMTP id f87mr17751292pfk.121.1468550592032;
        Thu, 14 Jul 2016 19:43:12 -0700 (PDT)
Received: from laptop.localdomain (c-67-183-159-197.hsd1.wa.comcast.net. [67.183.159.197])
        by smtp.gmail.com with ESMTPSA id x66sm7425911pfi.84.2016.07.14.19.43.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jul 2016 19:43:11 -0700 (PDT)
From:	Andrey Vagin <avagin@openvz.org>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Andrey Vagin <avagin@openvz.org>
Subject: [PATCH] git-clean: remove fifo, devices, socket files
Date:	Thu, 14 Jul 2016 19:42:59 -0700
Message-Id: <1468550579-9298-1-git-send-email-avagin@openvz.org>
X-Mailer: git-send-email 2.5.5
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Currently git-clean removes only links and files, but
there can be special files like fifo, sockets, devices.

I think git-clean has to remove them too.

Signed-off-by: Andrey Vagin <avagin@openvz.org>
---
 cache.h | 8 ++++++++
 dir.c   | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/cache.h b/cache.h
index f1dc289..a2f1258 100644
--- a/cache.h
+++ b/cache.h
@@ -77,10 +77,18 @@ struct object_id {
 #undef DT_DIR
 #undef DT_REG
 #undef DT_LNK
+#undef DT_FIFO
+#undef DT_BLK
+#undef DT_CHR
+#undef DT_SOCK
 #define DT_UNKNOWN	0
 #define DT_DIR		1
 #define DT_REG		2
 #define DT_LNK		3
+#define DT_FIFO		4
+#define DT_BLK		5
+#define DT_CHR		6
+#define DT_SOCK		7
 #define DTYPE(de)	DT_UNKNOWN
 #endif
 
diff --git a/dir.c b/dir.c
index 6172b34..930dd99 100644
--- a/dir.c
+++ b/dir.c
@@ -1470,8 +1470,12 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 		strbuf_addch(path, '/');
 		return treat_directory(dir, untracked, path->buf, path->len,
 				       baselen, exclude, simplify);
+	case DT_BLK:
+	case DT_CHR:
+	case DT_FIFO:
 	case DT_REG:
 	case DT_LNK:
+	case DT_SOCK:
 		return exclude ? path_excluded : path_untracked;
 	}
 }
-- 
2.5.5

