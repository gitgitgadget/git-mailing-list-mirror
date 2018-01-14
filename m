Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F85B1FADF
	for <e@80x24.org>; Sun, 14 Jan 2018 19:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751837AbeANTPV (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Jan 2018 14:15:21 -0500
Received: from eir.is.scarlet.be ([193.74.71.27]:8693 "EHLO eir.is.scarlet.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751766AbeANTPU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jan 2018 14:15:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scarlet.be;
        s=scarlet; t=1515957298;
        bh=ZP81f3G0zeU6CsEuNM1R9hxPONB5+lTJi4uhALHMix4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=gGYXfJE68i2pyXuKi9CEXas1r01tvvhUXaIO6g2ejbc3lP2xwh8DfppsgIIvx/+Hx
         AZaFFNaGLRdDLd9cEft0ST24Oy+NRFFym7HALK8P/xQt40CaxvMOMn9asSUlW/Dek/
         uxfF2mpvJhCDOJSZonnnHmTvsnBUp3bFtgUNq9fE=
Received: from localhost.localdomain (ip-83-134-87-14.dsl.scarlet.be [83.134.87.14])
        by eir.is.scarlet.be (8.14.9/8.14.9) with ESMTP id w0EJEuZa007302
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT);
        Sun, 14 Jan 2018 20:14:57 +0100
X-Scarlet: d=1515957297 c=83.134.87.14
From:   Kim Gybels <kgybels@infogroep.be>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Kim Gybels <kgybels@infogroep.be>
Subject: [PATCH v2] packed_ref_cache: don't use mmap() for small files
Date:   Sun, 14 Jan 2018 20:14:16 +0100
Message-Id: <20180114191416.2368-1-kgybels@infogroep.be>
X-Mailer: git-send-email 2.16.0.rc2.windows.1
In-Reply-To: <20180113161149.9564-1-kgybels@infogroep.be>
References: <20180113161149.9564-1-kgybels@infogroep.be>
X-DCC-scarlet.be-Metrics: eir 20002; Body=5 Fuz1=5 Fuz2=5
X-Virus-Scanned: clamav-milter 0.98.1-exp at eir
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Take a hint from commit ea68b0ce9f8 (hash-object: don't use mmap() for
small files, 2010-02-21) and use read() instead of mmap() for small
packed-refs files.

This also fixes the problem[1] where xmmap() returns NULL for zero
length[2], for which munmap() later fails.

Alternatively, we could simply check for NULL before munmap(), or
introduce xmunmap() that could be used together with xmmap().

[1] https://github.com/git-for-windows/git/issues/1410
[2] Logic introduced in commit 9130ac1e196 (Better error messages for
    corrupt databases, 2007-01-11)

Signed-off-by: Kim Gybels <kgybels@infogroep.be>
---
Change since v1: reworded commit message based on Johannes Schindelin's
feedback: shorter commit hashes, and included commit titles.

 refs/packed-backend.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index dab8a85d9a..7177e5bc2f 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -455,6 +455,8 @@ static void verify_buffer_safe(struct snapshot *snapshot)
 				 last_line, eof - last_line);
 }
 
+#define SMALL_FILE_SIZE (32*1024)
+
 /*
  * Depending on `mmap_strategy`, either mmap or read the contents of
  * the `packed-refs` file into the snapshot. Return 1 if the file
@@ -489,21 +491,21 @@ static int load_contents(struct snapshot *snapshot)
 		die_errno("couldn't stat %s", snapshot->refs->path);
 	size = xsize_t(st.st_size);
 
-	switch (mmap_strategy) {
-	case MMAP_NONE:
+	if (!size) {
+		snapshot->buf = NULL;
+		snapshot->eof = NULL;
+		snapshot->mmapped = 0;
+	} else if (size <= SMALL_FILE_SIZE || mmap_strategy == MMAP_NONE) {
 		snapshot->buf = xmalloc(size);
 		bytes_read = read_in_full(fd, snapshot->buf, size);
 		if (bytes_read < 0 || bytes_read != size)
 			die_errno("couldn't read %s", snapshot->refs->path);
 		snapshot->eof = snapshot->buf + size;
 		snapshot->mmapped = 0;
-		break;
-	case MMAP_TEMPORARY:
-	case MMAP_OK:
+	} else {
 		snapshot->buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
 		snapshot->eof = snapshot->buf + size;
 		snapshot->mmapped = 1;
-		break;
 	}
 	close(fd);
 
-- 
2.16.0.rc2.windows.1

