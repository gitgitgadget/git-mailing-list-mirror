Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 582641FEAA
	for <e@80x24.org>; Mon, 20 Jun 2016 22:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbcFTWyf (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 18:54:35 -0400
Received: from mout.web.de ([212.227.15.3]:56162 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932480AbcFTWy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 18:54:27 -0400
Received: from [192.168.178.36] ([79.237.54.32]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0LjJaZ-1boCJe1k3b-00damw; Tue, 21 Jun 2016 00:54:21
 +0200
Subject: Re: [PATCH 2/2] archive-tar: write extended headers for far-future
 mtime
To:	Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20160616043523.GA13615@sigill.intra.peff.net>
 <20160616043758.GB18323@sigill.intra.peff.net>
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <57687417.4020009@web.de>
Date:	Tue, 21 Jun 2016 00:54:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20160616043758.GB18323@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:tKfaVBHKD1vAI240lUrPhwO97rW2/p1X5zaoZvWQ/Cx1mEjm/6K
 cGCi3S94II4zBfxDPvLfulzg2FRGkLjVKdkJwOxCxGU51idVkegqaop1/Cb001+P30tWdd1
 lZ0Vj/dJelkWD3TZWApPHje8q6s2hnK44ANaiEZ5c7UNpBj7GW+cwBxheXOmQY5vQ6n4c7T
 3wD6RP50K7MrffIUTpcpg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:cRKSZyNsJ4w=:8Nv15t85GX7YsSXcLxf6hp
 PpYDqEMEaCMkwY9ePpQkxVDPLguvQhC6bU4Smr645+ficLfc63yeuAKg6lNv4dA6c5Uy0jezH
 7c6/WinyxqET1BVZ76ZQbOBcX7KHKdbrzxSMzKiEJKbw3VuI8y3CC8tAN7E9yADr/ebKkxrY4
 m+XzrZx7xIEXxnBgfGIWwHgiKfSM5/TKv/Ds+pux7KfUEzqukV+DfydPBpBbcADBydtY0Xk1Y
 zB6mIqCNEaXPRAk1Pe+F5X0t3qGNnDt6D+xYJ+yBJPDJOW7uLKyRrWKzRylMgQBzZOTXxYA6h
 UX2oufzT33kRVOPO3WekAzMHMZbevRVcBeNlx6D4Xkk1y/l/WApVufwL29WabkXsuS3013BpC
 pRj9N4zlZc2RS0LPoyy87B6SlVsrQOwyyyHZSNkVayKSU3gvkALI/YWnLBjIZlf2QukvTCXB7
 biSyiUljKgQhnaUcIGUK9UJ1Zf2EyzSnlRqwXrKMNjYmt60vFGvVJbDwsyMhoBpQgZ3r8Qbhb
 Tqa+AGGSog1KCYwWkDbSzMFyo29B1F8eCftbci2/ZOZIzE/xSJ3o0Z3fsxFRWcz4cNpBgFoiQ
 4brW3DTdegVC6nzF6Sa+OQ4uTb1wG0ZL4EJ1GjF7JkVndQuYQV1QQUnr0B+TSS6pfMDbWrYI2
 +89q1bv9+i7Bm9VVOa5pEIu8YJMRNU94kxQa7V17PPVGEDgOAEhY8ZKvNwWJbS6gsGoPsIPZy
 YRwSuxyfVIFfM8jPy8TB3ZrIjgWXIAN8Csbw6alCBFdlr5nxdwvj87/qj6ldckwb5kidiX3PN
 Yp0QVAk
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 16.06.2016 um 06:37 schrieb Jeff King:
> The ustar format represents timestamps as seconds since the
> epoch, but only has room to store 11 octal digits.  To
> express anything larger, we need to use an extended header.
> This is exactly the same case we fixed for the size field in
> the previous commit, and the solution here follows the same
> pattern.
>
> This is even mentioned as an issue in f2f0267 (archive-tar:
> use xsnprintf for trivial formatting, 2015-09-24), but since
> it only affected things far in the future, it wasn't worth
> dealing with. But note that my calculations claiming
> thousands of years were off there; because our xsnprintf
> produces a NUL byte, we only have until the year 2242 to
> fix this.
>
> Given that this is just around the corner (geologically
> speaking), and because the fix for "size" makes doing this
> on top trivial, let's just make it work.
>
> Note that we don't (and never did) handle negative
> timestamps (i.e., before 1970). This would probably not be
> too hard to support in the same way, but since git does not
> support negative timestamps at all, I didn't bother here.
>
> Unlike the last patch for "size", this one is easy to test
> efficiently (the magic date is octal 01000000000001):
>
>    $ echo content >file
>    $ git add file
>    $ GIT_COMMITTER_DATE='@68719476737 +0000' \
>      git commit -q -m 'tempori parendum'
>    $ git archive HEAD | tar tvf -
>    -rw-rw-r-- root/root         8 4147-08-20 03:32 file
>
> With the current tip of master, this dies in xsnprintf (and
> prior to f2f0267, it overflowed into the checksum field, and
> the resulting tarfile claimed to be from the year 2242).
>
> However, I decided not to include this in the test suite,
> because I suspect it will create portability headaches,
> including:
>
>    1. The exact format of the system tar's "t" output.

Probably not worth it.

>    2. System tars that cannot handle pax headers.

In t5000 there is a simple interpreter for path headers for systems 
whose tar doesn't handle them.  Adding one for mtime headers may be 
feasible.

It's just a bit complicated to link a pax header file to the file it 
applies to when it doesn't also contain a path header.  But we know that 
the mtime of all entries in tar files created by git archive are is the 
same, so we could simply read one header and then adjust the mtime of 
all files accordingly.

>    3. System tars tha cannot handle dates that far in the
>       future.
>
>    4. If we replace "tar t" with "tar x", then filesystems
>       that cannot handle dates that far in the future.

We can test that by supplying a test archive and set a prerequisite if 
tar (possibly with our header interpreter) and the filesystem can cope 
with that.

> In other words, we do not really have a reliable tar reader
> for these corner cases, so the best we could do is a
> byte-for-byte comparison of the output.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>   archive-tar.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/archive-tar.c b/archive-tar.c
> index 7340b64..749722f 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -185,6 +185,14 @@ static inline unsigned long ustar_size(uintmax_t size)
>   		return 0;
>   }
>
> +static inline unsigned long ustar_mtime(time_t mtime)
> +{
> +	if (mtime < 077777777777)

That should be less-or-equal, right?

> +		return mtime;
> +	else
> +		return 0;
> +}
> +
>   static void prepare_header(struct archiver_args *args,
>   			   struct ustar_header *header,
>   			   unsigned int mode, unsigned long size)
> @@ -192,7 +200,8 @@ static void prepare_header(struct archiver_args *args,
>   	xsnprintf(header->mode, sizeof(header->mode), "%07o", mode & 07777);
>   	xsnprintf(header->size, sizeof(header->size), "%011lo",
>   		  S_ISREG(mode) ? ustar_size(size) : 0);
> -	xsnprintf(header->mtime, sizeof(header->mtime), "%011lo", (unsigned long) args->time);
> +	xsnprintf(header->mtime, sizeof(header->mtime), "%011lo",
> +		  ustar_mtime(args->time));
>
>   	xsnprintf(header->uid, sizeof(header->uid), "%07o", 0);
>   	xsnprintf(header->gid, sizeof(header->gid), "%07o", 0);
> @@ -292,6 +301,8 @@ static int write_tar_entry(struct archiver_args *args,
>
>   	if (ustar_size(size) != size)
>   		strbuf_append_ext_header_uint(&ext_header, "size", size);
> +	if (ustar_mtime(args->time) != args->time)
> +		strbuf_append_ext_header_uint(&ext_header, "mtime", args->time);
>
>   	prepare_header(args, &header, mode, size);
>
>
