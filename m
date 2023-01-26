Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4332EC54E94
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 10:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236484AbjAZKJj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Jan 2023 05:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbjAZKJi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2023 05:09:38 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6999465B1
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 02:09:37 -0800 (PST)
Received: (qmail 19201 invoked by uid 109); 26 Jan 2023 10:09:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Jan 2023 10:09:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21945 invoked by uid 111); 26 Jan 2023 10:09:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Jan 2023 05:09:36 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Jan 2023 05:09:35 -0500
From:   Jeff King <peff@peff.net>
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v7 10/12] http: replace unsafe size_t multiplication with
 st_mult
Message-ID: <Y9JRX02RLHmIKzwo@coredump.intra.peff.net>
References: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
 <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
 <4b1635b3f6968f8d755bdf6bc4ec7af77aefd315.1674252531.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4b1635b3f6968f8d755bdf6bc4ec7af77aefd315.1674252531.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 20, 2023 at 10:08:48PM +0000, Matthew John Cheetham via GitGitGadget wrote:

> Replace direct multiplication of two size_t parameters in curl response
> stream handling callback functions with `st_mult` to guard against
> overflows.

Hmm. So part of me says that more overflow detection is better than
less, but...I really doubt this is doing anything, and it feels odd to
me to do overflow checks when there is no allocation.

There are tons of integer multiplications in Git. Our usual strategy is
to try to handle overflow like this when we're about to allocate a
buffer, with the idea that we'll avoid a truncated size (that we may
later fill with too many bytes).

In these cases, we could possibly avoid a weird or wrong result due to
truncation, but I don't see how that is different than most of the rest
of Git. What makes these worth touching?

Moreover...

> @@ -176,7 +176,7 @@ curlioerr ioctl_buffer(CURL *handle, int cmd, void *clientp)
>  
>  size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
>  {
> -	size_t size = eltsize * nmemb;
> +	size_t size = st_mult(eltsize, nmemb);
>  	struct strbuf *buffer = buffer_;
>  
>  	strbuf_add(buffer, ptr, size);

The caller is already claiming to have eltsize*nmemb bytes accessible
via "ptr". How did it get such a buffer if that overflows size_t?

> diff --git a/http.c b/http.c
> index 8a5ba3f4776..a2a80318bb2 100644
> --- a/http.c
> +++ b/http.c
> @@ -146,7 +146,7 @@ static int http_schannel_use_ssl_cainfo;
>  
>  size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
>  {
> -	size_t size = eltsize * nmemb;
> +	size_t size = st_mult(eltsize, nmemb);
>  	struct buffer *buffer = buffer_;
>  
>  	if (size > buffer->buf.len - buffer->posn)

Likewise the caller is asking us to fill a buffer that is eltsize*nmemb.
So they must have allocated it already. How can it be bigger than a
size_t?

In practice, of course, these are both coming from curl, and I strongly
suspect that curl always sets "1" for eltsize anyway, since it's working
with bytes. The two fields only exist to conform to the weird fread()
interface for historical reasons.

So I don't think this patch is really hurting much. It just feels like a
weird one-off that makes the code inconsistent. If somebody who was
wanting to write similar code later asks "why is this one st_mult(), but
not other multiplications", I wouldn't have an answer for them.

-Peff
