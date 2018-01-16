Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEE431F404
	for <e@80x24.org>; Tue, 16 Jan 2018 19:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751434AbeAPTiz (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 14:38:55 -0500
Received: from sif.is.scarlet.be ([193.74.71.28]:65068 "EHLO sif.is.scarlet.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750898AbeAPTix (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 14:38:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scarlet.be;
        s=scarlet; t=1516131511;
        bh=4FT8YWXL0JkER8LpHYHgsy7Fsrx9jug/eJDcsz2cCY4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=mOWUL9TzfKNRtJrSNMLBnbJlKYgx3vD/9m/ad346vxckmNihIGZ3ZAUaY+Wc8iyd7
         dAP9NkEsTOkj5baI5DBhAEUnOVRbGFXxhrBdpBFEH7GsC52plPfAdy+p7nTcqe8xVf
         f6hZoEgpuFtl1gzMob06XmIZ+qojD0UnROvbkqmE=
Received: from localhost.localdomain (ip-62-235-174-105.dsl.scarlet.be [62.235.174.105])
        by sif.is.scarlet.be (8.14.9/8.14.9) with ESMTP id w0GJcTHh014346
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT);
        Tue, 16 Jan 2018 20:38:30 +0100
X-Scarlet: d=1516131510 c=62.235.174.105
From:   Kim Gybels <kgybels@infogroep.be>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Kim Gybels <kgybels@infogroep.be>
Subject: [PATCH v3] packed_ref_cache: don't use mmap() for small files
Date:   Tue, 16 Jan 2018 20:38:15 +0100
Message-Id: <20180116193815.4568-1-kgybels@infogroep.be>
X-Mailer: git-send-email 2.15.1.windows.2
In-Reply-To: <20180115235251.GA21900@sigill.intra.peff.net>
References: <20180115235251.GA21900@sigill.intra.peff.net>
X-DCC-scarlet.be-Metrics: sif 20002; Body=6 Fuz1=6 Fuz2=6
X-Virus-Scanned: clamav-milter 0.98.1-exp at sif
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
introduce xmunmap() that could be used together with xmmap(). However,
always setting snapshot->buf to a valid pointer, by relying on
xmalloc(0)'s fallback to 1-byte allocation, makes using snapshots
easier.

[1] https://github.com/git-for-windows/git/issues/1410
[2] Logic introduced in commit 9130ac1e196 (Better error messages for
    corrupt databases, 2007-01-11)

Signed-off-by: Kim Gybels <kgybels@infogroep.be>
---

Change since v2: removed separate case for zero length as suggested by Peff,
ensuring that snapshot->buf is always a valid pointer.

 refs/packed-backend.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index dab8a85d9a..b6e2bc3c1d 100644
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
@@ -489,21 +491,17 @@ static int load_contents(struct snapshot *snapshot)
 		die_errno("couldn't stat %s", snapshot->refs->path);
 	size = xsize_t(st.st_size);
 
-	switch (mmap_strategy) {
-	case MMAP_NONE:
+	if (size <= SMALL_FILE_SIZE || mmap_strategy == MMAP_NONE) {
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

