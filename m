Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D481C433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 07:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15D93610FA
	for <git@archiver.kernel.org>; Tue, 18 May 2021 07:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241980AbhERHcr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 03:32:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:57446 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240235AbhERHcq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 03:32:46 -0400
Received: (qmail 11241 invoked by uid 109); 18 May 2021 07:31:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 May 2021 07:31:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5388 invoked by uid 111); 18 May 2021 07:31:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 May 2021 03:31:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 May 2021 03:31:28 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
        git@jeffhostetler.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 2/4] csum-file.h: increase hashfile buffer size
Message-ID: <YKNtUKIHoCCOMYmn@coredump.intra.peff.net>
References: <pull.916.git.1616785928.gitgitgadget@gmail.com>
 <pull.916.v2.git.1621254292.gitgitgadget@gmail.com>
 <9dc602f6c4221e2259778842ec3d1eda57508333.1621254292.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9dc602f6c4221e2259778842ec3d1eda57508333.1621254292.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 17, 2021 at 12:24:50PM +0000, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The hashfile API uses a hard-coded buffer size of 8KB and has ever since
> it was introduced in c38138c (git-pack-objects: write the pack files
> with a SHA1 csum, 2005-06-26). It performs a similar function to the
> hashing buffers in read-cache.c, but that code was updated from 8KB to
> 128KB in f279894 (read-cache: make the index write buffer size 128K,
> 2021-02-18). The justification there was that do_write_index() improves
> from 1.02s to 0.72s.
> 
> There is a buffer, check_buffer, that is used to verify the check_fd
> file descriptor. When this buffer increases to 128K to fit the data
> being flushed, it causes the stack to overflow the limits placed in the
> test suite. By moving this to a static buffer, we stop using stack data
> for this purpose, but we lose some thread-safety. This change makes it
> unsafe to write to multiple hashfiles across different threads.
> 
> By adding a new trace2 region in the chunk-format API, we can see that
> the writing portion of 'git multi-pack-index write' lowers from ~1.49s
> to ~1.47s on a Linux machine. These effects may be more pronounced or
> diminished on other filesystems. The end-to-end timing is too noisy to
> have a definitive change either way.

I think there is one thing missing from this commit message: why we want
to do this. You mentioned that read-cache got larger by using a bigger
buffer. But here we use a bigger buffer, and it produces no improvement
larger than the noise. And on top of it, you describe the static-buffer
downsides. So why not just skip it? :)

And the answer is in the larger series: we want to be able to make use
of the hashfile API in read-cache, but without regressing the
performance. One sentence at the end of the first paragraph would
clarify that quite a bit, I think.

> +static void verify_buffer_or_die(struct hashfile *f,
> +				 const void *buf,
> +				 unsigned int count)
> +{
> +	static unsigned char check_buffer[WRITE_BUFFER_SIZE];
> +	ssize_t ret = read_in_full(f->check_fd, check_buffer, count);
> +
> +	if (ret < 0)
> +		die_errno("%s: sha1 file read error", f->name);
> +	if (ret != count)
> +		die("%s: sha1 file truncated", f->name);
> +	if (memcmp(buf, check_buffer, count))
> +		die("sha1 file '%s' validation error", f->name);
> +}

Does this have to use the same-size buffer? We could read and check
smaller chunks, like:

  while (count > 0) {
	static unsigned char chunk[1024];
	unsigned int chunk_len = sizeof(chunk) < count ? sizeof(chunk) : count;
	ssize_t ret = read_in_full(f->check_fd, chunk, chunk_len);

        if (ret < 0)
	   ...
	if (ret != count)
	   ...
	if (memcmp(buf, chunk, chunk_len))
	   ...
	buf += chunk_len;
	count -= chunk_len;
  }

We may prefer to use the larger buffer size for performance, but I think
this "check" mode is only used for "index-pack --verify" and similar.
The performance may matter a lot less to us there than for more
frequently used code paths like index writing.

I don't have a strong preference either way, but it's nice to avoid
introducing non-reentrancy to a function (Junio's heap suggestion is
also quite reasonable).

-Peff
