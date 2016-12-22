Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B6E31FF6D
	for <e@80x24.org>; Thu, 22 Dec 2016 20:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1765853AbcLVU0u (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 15:26:50 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:6951 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936495AbcLVU0g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 15:26:36 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3tl32b1y8lz5tlQ;
        Thu, 22 Dec 2016 21:26:30 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 742272222;
        Thu, 22 Dec 2016 21:26:30 +0100 (CET)
Subject: Re: [PATCH v2 3/3] mingw: replace isatty() hack
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <cover.1482342791.git.johannes.schindelin@gmx.de>
 <cover.1482426497.git.johannes.schindelin@gmx.de>
 <5e3c505a206a735e6ba0bfaf4c73965e95a928eb.1482426497.git.johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Beat Bolli <dev+git@drbeat.li>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <e9f8a015-4106-fa88-082a-9e8c06ff61f3@kdbg.org>
Date:   Thu, 22 Dec 2016 21:26:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <5e3c505a206a735e6ba0bfaf4c73965e95a928eb.1482426497.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've only one request for clarification below. Otherwise, the patch 
looks good.

(lines removed by the patch trimmed)

Am 22.12.2016 um 18:09 schrieb Johannes Schindelin:
> +static HANDLE swap_osfhnd(int fd, HANDLE new_handle)
> +{
> +	/*
> +	 * Create a copy of the original handle associated with fd
> +	 * because the original will get closed when we dup2().
> +	 */
> +	HANDLE handle = (HANDLE)_get_osfhandle(fd);
> +	HANDLE duplicate = duplicate_handle(handle);
>
> +	/* Create a temp fd associated with the already open "new_handle". */
> +	int new_fd = _open_osfhandle((intptr_t)new_handle, O_BINARY);
>
> +	assert((fd == 1) || (fd == 2));
>
> +	/*
> +	 * Use stock dup2() to re-bind fd to the new handle.  Note that
> +	 * this will implicitly close(1) and close both fd=1 and the
> +	 * originally associated handle.  It will open a new fd=1 and
> +	 * call DuplicateHandle() on the handle associated with new_fd.
> +	 * It is because of this implicit close() that we created the
> +	 * copy of the original.
> +	 *
> +	 * Note that the OS can recycle HANDLE (numbers) just like it
> +	 * recycles fd (numbers), so we must update the cached value
> +	 * of "console".  You can use GetFileType() to see that
> +	 * handle and _get_osfhandle(fd) may have the same number
> +	 * value, but they refer to different actual files now.

Certainly, the OS does not recycle handle values that are in use (open). 
Then I do not quite get the point of this paragraph. See...

> +	 *
> +	 * Note that dup2() when given target := {0,1,2} will also
> +	 * call SetStdHandle(), so we don't need to worry about that.
> +	 */
> +	dup2(new_fd, fd);
> +	if (console == handle)
> +		console = duplicate;

... This is where "the cached value of console is updated", right? If 
console == handle, then this is not because a handle value was recycled, 
but because fd *was* console. Since the old value of console has been 
closed by the dup2(), we must refer to the back-up value in the future. 
Am I missing something?

> +	handle = INVALID_HANDLE_VALUE;
>
> +	/* Close the temp fd.  This explicitly closes "new_handle"
> +	 * (because it has been associated with it).
> +	 */
> +	close(new_fd);
>
> +	fd_is_interactive[fd] |= FD_SWAPPED;
>
> +	return duplicate;
>  }

