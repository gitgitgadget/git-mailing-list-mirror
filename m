Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF83C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbhLIFfN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:35:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:47504 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229854AbhLIFfM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:35:12 -0500
Received: (qmail 13208 invoked by uid 109); 9 Dec 2021 05:31:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Dec 2021 05:31:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13640 invoked by uid 111); 9 Dec 2021 05:31:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Dec 2021 00:31:32 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Dec 2021 00:31:29 -0500
From:   Jeff King <peff@peff.net>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 00/11] Reftable coverity fixes
Message-ID: <YbGUsY+wjDs0UgxQ@coredump.intra.peff.net>
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
 <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 08, 2021 at 09:49:35PM +0000, Han-Wen Nienhuys via GitGitGadget wrote:

>   2:  603bd1d4f6e !  2:  1ddcfe61ebc reftable: fix resource leak in error path
>      @@ reftable/block.c: int block_reader_init(struct block_reader *br, struct reftable
>        
>        	if (typ == BLOCK_TYPE_LOG) {
>        		int block_header_skip = 4 + header_off;
>      +@@ reftable/block.c: int block_reader_init(struct block_reader *br, struct reftable_block *block,
>      + 		uLongf src_len = block->len - block_header_skip;
>      + 		/* Log blocks specify the *uncompressed* size in their header.
>      + 		 */
>      +-		uint8_t *uncompressed = reftable_malloc(sz);
>      ++		uncompressed = reftable_malloc(sz);
>      + 
>      + 		/* Copy over the block header verbatim. It's not compressed. */
>      + 		memcpy(uncompressed, block->data, block_header_skip);

This drops the shadowed variable, but it needs a little more. In one of
the error blocks we still free the variable, and then jump to the
"done" label, which will try to free it again. So you need:

diff --git a/reftable/block.c b/reftable/block.c
index 0bc4a5d84b..6d55817e0d 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -215,7 +215,6 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
 		if (Z_OK !=
 		    uncompress2(uncompressed + block_header_skip, &dst_len,
 				block->data + block_header_skip, &src_len)) {
-			reftable_free(uncompressed);
 			err = REFTABLE_ZLIB_ERROR;
 			goto done;
 		}

to avoid the double-free. I think it's otherwise OK. The other error
case does not try to free, and in the success case we hand off ownership
of "uncompressed" and set it back to NULL.

I doubt this is the cause of the segfault on Windows, though (I saw it
via Coverity). That one still puzzles me, and I suspect will need more
output to figure out. It's possible to get an interactive session on the
Windows VM running the CI:

  https://github.com/marketplace/actions/debugging-with-tmate

but I haven't tried it myself. I'm also not sure what tools are
available there (gdb sure would be nice, but even a backtrace of the
segfault would be quite a lot; I wonder if we could build with ASan on
Windows).

-Peff
