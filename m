Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D98C1FF40
	for <e@80x24.org>; Mon, 20 Jun 2016 22:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbcFTWyq (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 18:54:46 -0400
Received: from mout.web.de ([212.227.15.3]:51460 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932422AbcFTWyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 18:54:25 -0400
Received: from [192.168.178.36] ([79.237.54.32]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MhOpG-1b2OeR2F0c-00Mdsv; Tue, 21 Jun 2016 00:54:17
 +0200
Subject: Re: [PATCH 1/2] archive-tar: write extended headers for file sizes >=
 8GB
To:	Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20160616043523.GA13615@sigill.intra.peff.net>
 <20160616043733.GA18323@sigill.intra.peff.net>
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <57687413.3030609@web.de>
Date:	Tue, 21 Jun 2016 00:54:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20160616043733.GA18323@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:gyavIZjbqRIyolqoBVpI1XMJpUpO9qkBSbUGaK5srFfMpB0Z0+M
 o87l3E3URbE+kL1ytmEPK+nSu0zNwYbisE1zsuWYMopHWD4InM/F551hg4XUL6QpIm6IeEd
 mKgdMwcXzFV9p5m5Ud8DX2MVhkWWpk1wT1wiMm/FMvNf6WW/5BEsAAv6qbqPuKG9jDiQRNs
 2RXlWip0P486bIUOHneAA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:trngme5rzj8=:iteqJ7ZhP9lcqaDbinSqHf
 3YmdwjNHsn30Cbryk8fDkoi+ZVFPkTpZW+1kN8n+qd0LDjPZkW3kXQRx5I4OaZeQfnFYW1vv6
 O16fZlssBpHZGfIkfTLhxQMEcLFkwTP/KC6E7gDmDqu+Sdo4szh/ePgrlfd79DUfiaQ7iY6AW
 Ed+vISVWNyCAlTcs2wEWmi+Ank83PwAczlVI1cjC0/yaZtrj4T30sa/LPsBm3srdEOU6wOBev
 7l/WBZ702byHHFd1+83kvdcDNPNgBIajZfcSUlWXEblC0gZzY5oat/26WDBURBD3tJ3Esn7v1
 l4eICxplrjJR30bWvEK0SBVN9IeKF6c7KIIwsno1d3JXVr4HRl+4Owa3AkOEVi9nPdkip3dMw
 KaMVkKoaaQZCdxashdAn8AYKWW8yaCeSdB6FLuVsKJkejm9muqpZzv4hSyCcHfSJkAOu+5/yZ
 lB8E4iaHPzzoA5DB/53AvLq7ryfSiCyo4CmbhxySaX7W57OHSUgvlwD7reoXnRGqIH2IBaEZg
 uHDBuNHdWCYj2AexypahsrbyDptnfG2tTdm/RnvfoeirCStx0OegA9WZQ0ia7uS8clFb0wKLG
 qOI3/YoMB06uotZvjjp5TjggcH+SKtkpEiD8wAd3PqbG2Ql3I2wW39jjbRiLwxf36yZRRpP4b
 o7TOMvMu+Kjealk9euRhE3eyQ+Aq5voyTdVfMxDT0pvq76ktV38XjBwtCpudIYpm8qudl5y0c
 Fta/lSPYv4qidrI7jrGICfFzssvwDeDH7WLSWy2LTni/TCHLDHYaX5fbbxnSbo0SGWlT2Y1bG
 Ha6sUnV
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 16.06.2016 um 06:37 schrieb Jeff King:
> The ustar format has a fixed-length field for the size of
> each file entry which is supposed to contain up to 11 bytes
> of octal-formatted data plus a NUL or space terminator.
>
> These means that the largest size we can represent is
> 077777777777, or 1 byte short of 8GB. The correct solution
> for a larger file, according to POSIX.1-2001, is to add an
> extended pax header, similar to how we handle long
> filenames. This patch does that, and writes zero for the
> size field in the ustar header (the last bit is not
> mentioned by POSIX, but it matches how GNU tar behaves with
> --format=pax).
>
> This should be a strict improvement over the current
> behavior, which is to die in xsnprintf with a "BUG".
> However, there's some interesting history here.
>
> Prior to f2f0267 (archive-tar: use xsnprintf for trivial
> formatting, 2015-09-24), we silently overflowed the "size"
> field. The extra bytes ended up in the "mtime" field of the
> header, which was then immediately written itself,
> overwriting our extra bytes. What that means depends on how
> many bytes we wrote.
>
> If the size was 64GB or greater, then we actually overflowed
> digits into the mtime field, meaning our value was was
> effectively right-shifted by those lost octal digits. And
> this patch is again a strict improvement over that.
>
> But if the size was between 8GB and 64GB, then our 12-byte
> field held all of the actual digits, and only our NUL
> terminator overflowed. According to POSIX, there should be a
> NUL or space at the end of the field. However, GNU tar seems
> to be lenient here, and will correctly parse a size up 64GB
> (minus one) from the field. So sizes in this range might
> have just worked, depending on the implementation reading
> the tarfile.
>
> This patch is mostly still an improvement there, as the 8GB
> limit is specifically mentioned in POSIX as the correct
> limit. But it's possible that it could be a regression
> (versus the pre-f2f0267 state) if all of the following are
> true:
>
>    1. You have a file between 8GB and 64GB.
>
>    2. Your tar implementation _doesn't_ know about pax
>       extended headers.
>
>    3. Your tar implementation _does_ parse 12-byte sizes from
>       the ustar header without a delimiter.
>
> It's probably not worth worrying about such an obscure set
> of conditions, but I'm documenting it here just in case.
>
> There's no test included here. I did confirm that this works
> (using GNU tar) with:
>
>    $ dd if=/dev/zero seek=64G bs=1 count=1 of=huge
>    $ git add huge
>    $ git commit -q -m foo
>    $ git archive HEAD | head -c 10000 | tar tvf - 2>/dev/null
>    -rw-rw-r-- root/root 68719476737 2016-06-15 21:07 huge
>
> Pre-f2f0267, this would yield a bogus size of 8GB, and
> post-f2f0267, git-archive simply dies.
>
> Unfortunately, it's quite an expensive test to run. For one
> thing, unless your filesystem supports files with holes, it
> takes 64GB of disk space (you might think piping straight to
> `hash-object --stdin` would be better, but it's not; that
> tries to buffer all 64GB in RAM!). Furthermore, hashing and
> compressing the object takes several minutes of CPU time.
>
> We could ship just the resulting compressed object data as a
> loose object, but even that takes 64MB. So sadly, this code
> path remains untested in the test suite.

If we could set the limit to a lower value than 8GB for testing then we 
could at least check if the extended header is written, e.g. if 
ustar_size() could be convinced to return 0 every time using a hidden 
command line parameter or an environment variable or something better.

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>   archive-tar.c | 28 +++++++++++++++++++++++++++-
>   1 file changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/archive-tar.c b/archive-tar.c
> index cb99df2..7340b64 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -137,6 +137,20 @@ static void strbuf_append_ext_header(struct strbuf *sb, const char *keyword,
>   	strbuf_addch(sb, '\n');
>   }
>
> +/*
> + * Like strbuf_append_ext_header, but for numeric values.
> + */
> +static void strbuf_append_ext_header_uint(struct strbuf *sb,
> +					  const char *keyword,
> +					  uintmax_t value)
> +{
> +	char buf[40]; /* big enough for 2^128 in decimal, plus NUL */
> +	int len;
> +
> +	len = xsnprintf(buf, sizeof(buf), "%"PRIuMAX, value);
> +	strbuf_append_ext_header(sb, keyword, buf, len);
> +}
> +
>   static unsigned int ustar_header_chksum(const struct ustar_header *header)
>   {
>   	const unsigned char *p = (const unsigned char *)header;
> @@ -163,12 +177,21 @@ static size_t get_path_prefix(const char *path, size_t pathlen, size_t maxlen)
>   	return i;
>   }
>
> +static inline unsigned long ustar_size(uintmax_t size)
> +{
> +	if (size < 077777777777UL)

Shouldn't that be less-or-equal?

> +		return size;
> +	else
> +		return 0;
> +}
> +
>   static void prepare_header(struct archiver_args *args,
>   			   struct ustar_header *header,
>   			   unsigned int mode, unsigned long size)
>   {
>   	xsnprintf(header->mode, sizeof(header->mode), "%07o", mode & 07777);
> -	xsnprintf(header->size, sizeof(header->size), "%011lo", S_ISREG(mode) ? size : 0);
> +	xsnprintf(header->size, sizeof(header->size), "%011lo",
> +		  S_ISREG(mode) ? ustar_size(size) : 0);
>   	xsnprintf(header->mtime, sizeof(header->mtime), "%011lo", (unsigned long) args->time);
>
>   	xsnprintf(header->uid, sizeof(header->uid), "%07o", 0);
> @@ -267,6 +290,9 @@ static int write_tar_entry(struct archiver_args *args,
>   			memcpy(header.linkname, buffer, size);
>   	}
>
> +	if (ustar_size(size) != size)
> +		strbuf_append_ext_header_uint(&ext_header, "size", size);

It needs "S_ISREG(mode) && " as well, no?  In practice it probably 
doesn't matter (until someone stores a 8GB long symlink target), but the 
size field should only be set for regular files.

> +
>   	prepare_header(args, &header, mode, size);
>
>   	if (ext_header.len > 0) {
>
