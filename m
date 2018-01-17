Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3ACF1F406
	for <e@80x24.org>; Wed, 17 Jan 2018 19:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754162AbeAQTfN (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 14:35:13 -0500
Received: from verein.lst.de ([213.95.11.211]:57374 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754152AbeAQTfL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 14:35:11 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 458E768C4E; Wed, 17 Jan 2018 20:35:10 +0100 (CET)
Date:   Wed, 17 Jan 2018 20:35:10 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christoph Hellwig <hch@lst.de>, git@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] enable core.fsyncObjectFiles by default
Message-ID: <20180117193510.GA30657@lst.de>
References: <20180117184828.31816-1-hch@lst.de> <xmqqd128s3wf.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd128s3wf.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 17, 2018 at 11:04:32AM -0800, Junio C Hamano wrote:
> I am somewhat sympathetic to the desire to flip the default to
> "safe" and allow those who know they are already safe to tweak the
> knob for performance, and it also makes sense to document that the
> default is "true" here.  But I do not see the point of removing the
> four lines from this paragraph; the sole effect of the removal is to
> rob information from readers that they can use to decide if they
> want to disable the configuration, no?

Does this sound any better?  It is a little to technical for my
taste, but I couldn't come up with anything better:

---
From ab8f2d38dfe40e74de5399af0d069427c7473b76 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Wed, 17 Jan 2018 19:42:46 +0100
Subject: enable core.fsyncObjectFiles by default

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
 Documentation/config.txt | 11 +++++++----
 environment.c            |  2 +-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0e25b2c92..8b99f1389 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -866,10 +866,13 @@ core.whitespace::
 core.fsyncObjectFiles::
 	This boolean will enable 'fsync()' when writing object files.
 +
-This is a total waste of time and effort on a filesystem that orders
-data writes properly, but can be useful for filesystems that do not use
-journalling (traditional UNIX filesystems) or that only journal metadata
-and not file contents (OS X's HFS+, or Linux ext3 with "data=writeback").
+This option is enabled by default and ensures actual data integrity
+by calling fsync after writing object files.
+
+Note that this might be really slow on ext3 in the traditional
+data=ordered mode, in which case you might want to disable this option.
+ext3 in data=ordered mode will order the actual data writeout with
+metadata operation, but not actually guarantee data integrity either.
 
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



