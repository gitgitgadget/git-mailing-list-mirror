Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 534D31F406
	for <e@80x24.org>; Wed, 17 Jan 2018 18:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753812AbeAQSsc (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 13:48:32 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:58245 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752368AbeAQSsb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 13:48:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lpIMjsnBgU/SCSWDSVYrkjZJISF+016voBb/hZG2oQ0=; b=R/eCzOnD5J+Aw7DbsMM9ldDqJ
        KST273VwgGnDUVmzgVyFkT7GPy5m8b3sNyEP/hOo5oC0EFzdkMS0N14VGCXdWqU6XwJUyFW3o0jp5
        32mke9AxaYvGGJBLqvGdaZBFYU5tW8S+44R2gXh+XC0eaorzZNfKzipNndWgYzjhwzpaD/L4FBWt6
        XK5Tls2sF9x88f1QAb1i/a0+851rVcU4sIRWi3g6EbisVl7LxYe+H3tfb0WXtw/WqnfE6s7CyndeG
        QKLBuQc3P5sG88jj6p0MdcTj2Z+3I2fdU0aUyeicw2sYxI6aKyYMctfmG5K5STxCy4/0XWhrBFE6H
        YuoQlATlQ==;
Received: from 77.117.185.35.wireless.dyn.drei.com ([77.117.185.35] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1ebslD-0006Gz-1W; Wed, 17 Jan 2018 18:48:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     git@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] enable core.fsyncObjectFiles by default
Date:   Wed, 17 Jan 2018 19:48:28 +0100
Message-Id: <20180117184828.31816-1-hch@lst.de>
X-Mailer: git-send-email 2.14.2
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fsync is required for data integrity as there is no gurantee that
data makes it to disk at any specified time without it.  Even for
ext3 with data=ordered mode the file system will only commit all
data at some point in time that is not guaranteed.

I've lost data on development machines with various times countless
times due to the lack of this option, and now lost trees on a
git server with ext4 as well yesterday.  It's time to make git
safe by default.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/config.txt | 6 ++----
 environment.c            | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0e25b2c92..9a1cec5c8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -866,10 +866,8 @@ core.whitespace::
 core.fsyncObjectFiles::
 	This boolean will enable 'fsync()' when writing object files.
 +
-This is a total waste of time and effort on a filesystem that orders
-data writes properly, but can be useful for filesystems that do not use
-journalling (traditional UNIX filesystems) or that only journal metadata
-and not file contents (OS X's HFS+, or Linux ext3 with "data=writeback").
+This option is enabled by default and ensures actual data integrity
+by calling fsync after writing object files.
 
 core.preloadIndex::
 	Enable parallel index preload for operations like 'git diff'
diff --git a/environment.c b/environment.c
index 63ac38a46..c74375b5e 100644
--- a/environment.c
+++ b/environment.c
@@ -36,7 +36,7 @@ const char *git_hooks_path;
 int zlib_compression_level = Z_BEST_SPEED;
 int core_compression_level;
 int pack_compression_level = Z_DEFAULT_COMPRESSION;
-int fsync_object_files;
+int fsync_object_files = 1;
 size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
 size_t delta_base_cache_limit = 96 * 1024 * 1024;
-- 
2.14.2

