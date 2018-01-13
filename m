Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1368F1F404
	for <e@80x24.org>; Sat, 13 Jan 2018 16:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755159AbeAMQSe (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Jan 2018 11:18:34 -0500
Received: from eir.is.scarlet.be ([193.74.71.27]:19522 "EHLO eir.is.scarlet.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755143AbeAMQSd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jan 2018 11:18:33 -0500
X-Greylist: delayed 366 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Jan 2018 11:18:33 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scarlet.be;
        s=scarlet; t=1515859926;
        bh=/O8PCweOgxAQKGdAMk+KQnrkQcusgkoNdK+oFWMJbiU=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=FUvzwygzfTzWJYlpJ1/nzrm8o9oNZ2h5+QmikeoKtq6M4ojmYxdQPPyuC6IS7C4Q/
         Fi3FELrwxyQ6W92y93NY9ki4rqQ6OqArxxxIPvd7ppt/lCAGh/oE8x97gKJ1XT5QU/
         EPpgVc4r/KjAh8+HcgLLSP2AD0kkY46UP+LyGtng=
Received: from localhost.localdomain (ip-213-49-134-254.dsl.scarlet.be [213.49.134.254])
        by eir.is.scarlet.be (8.14.9/8.14.9) with ESMTP id w0DGC5Tg018524
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT);
        Sat, 13 Jan 2018 17:12:06 +0100
X-Scarlet: d=1515859926 c=213.49.134.254
From:   Kim Gybels <kgybels@infogroep.be>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Kim Gybels <kgybels@infogroep.be>
Subject: [PATCH] packed_ref_cache: don't use mmap() for small files
Date:   Sat, 13 Jan 2018 17:11:49 +0100
Message-Id: <20180113161149.9564-1-kgybels@infogroep.be>
X-Mailer: git-send-email 2.15.1.windows.2
X-DCC-scarlet.be-Metrics: eir 20002; Body=5 Fuz1=5 Fuz2=5
X-Virus-Scanned: clamav-milter 0.98.1-exp at eir
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Take a hint from commit ea68b0ce9f8ce8da3e360aed3cbd6720159ffbee and use
read() instead of mmap() for small packed-refs files.

This also fixes the problem[1] where xmmap() returns NULL for zero
length[2], for which munmap() later fails.

Alternatively, we could simply check for NULL before munmap(), or
introduce an xmunmap() that could be used together with xmmap().

[1] https://github.com/git-for-windows/git/issues/1410
[2] Logic introduced in commit 9130ac1e1966adb9922e64f645730d0d45383495

Signed-off-by: Kim Gybels <kgybels@infogroep.be>
---
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
2.15.1.windows.2

