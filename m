Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7448208C4
	for <e@80x24.org>; Sat, 12 Aug 2017 13:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750968AbdHLNra (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Aug 2017 09:47:30 -0400
Received: from avasout05.plus.net ([84.93.230.250]:55933 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbdHLNra (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Aug 2017 09:47:30 -0400
Received: from [10.0.2.15] ([143.159.212.52])
        by avasout05 with smtp
        id wDnS1v00218PUFB01DnUdl; Sat, 12 Aug 2017 14:47:28 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Iav3YSia c=1 sm=1 tr=0
 a=CKmocqUIrzA4K3l9YJ19NQ==:117 a=CKmocqUIrzA4K3l9YJ19NQ==:17
 a=IkcTkHD0fZMA:10 a=6ej9espHV8j6OOup_okA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 1/9] Convert pack-objects to size_t
To:     Martin Koegler <martin.koegler@chello.at>, git@vger.kernel.org,
        gitster@pobox.com, Johannes.Schindelin@gmx.de
References: <1502527643-21944-1-git-send-email-martin@mail.zuhause>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <87fc215e-b860-10f5-5c5e-60652502fae8@ramsayjones.plus.com>
Date:   Sat, 12 Aug 2017 14:47:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1502527643-21944-1-git-send-email-martin@mail.zuhause>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/08/17 09:47, Martin Koegler wrote:
> From: Martin Koegler <martin.koegler@chello.at>
> 
> Signed-off-by: Martin Koegler <martin.koegler@chello.at>
> ---
>  builtin/pack-objects.c | 48 ++++++++++++++++++++++++------------------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index aa70f80..f8db283 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -56,7 +56,7 @@ static struct pack_idx_option pack_idx_opts;
>  static const char *base_name;
>  static int progress = 1;
>  static int window = 10;
> -static unsigned long pack_size_limit;
> +static size_t pack_size_limit;
>  static int depth = 50;
>  static int delta_search_threads;
>  static int pack_to_stdout;
> @@ -72,11 +72,11 @@ static int use_bitmap_index = -1;
>  static int write_bitmap_index;
>  static uint16_t write_bitmap_options;
>  
> -static unsigned long delta_cache_size = 0;
> -static unsigned long max_delta_cache_size = 256 * 1024 * 1024;
> -static unsigned long cache_max_small_delta_size = 1000;
> +static size_t delta_cache_size = 0;
> +static size_t max_delta_cache_size = 256 * 1024 * 1024;
> +static size_t cache_max_small_delta_size = 1000;
>  
> -static unsigned long window_memory_limit = 0;
> +static size_t window_memory_limit = 0;
>  
>  /*
>   * stats
> @@ -124,11 +124,11 @@ static void *get_delta(struct object_entry *entry)
>  	return delta_buf;
>  }
>  
> -static unsigned long do_compress(void **pptr, unsigned long size)
> +static size_t do_compress(void **pptr, size_t size)
>  {
>  	git_zstream stream;
>  	void *in, *out;
> -	unsigned long maxsize;
> +	size_t maxsize;
>  
>  	git_deflate_init(&stream, pack_compression_level);
>  	maxsize = git_deflate_bound(&stream, size);
> @@ -149,13 +149,13 @@ static unsigned long do_compress(void **pptr, unsigned long size)
>  	return stream.total_out;
>  }
>  
> -static unsigned long write_large_blob_data(struct git_istream *st, struct sha1file *f,
> +static size_t write_large_blob_data(struct git_istream *st, struct sha1file *f,
>  					   const unsigned char *sha1)
>  {
>  	git_zstream stream;
>  	unsigned char ibuf[1024 * 16];
>  	unsigned char obuf[1024 * 16];
> -	unsigned long olen = 0;
> +	size_t olen = 0;
>  
>  	git_deflate_init(&stream, pack_compression_level);
>  
> @@ -196,7 +196,7 @@ static int check_pack_inflate(struct packed_git *p,
>  		struct pack_window **w_curs,
>  		off_t offset,
>  		off_t len,
> -		unsigned long expect)
> +		size_t expect)
>  {
>  	git_zstream stream;
>  	unsigned char fakebuf[4096], *in;
> @@ -238,13 +238,13 @@ static void copy_pack_data(struct sha1file *f,
>  }
>  
>  /* Return 0 if we will bust the pack-size limit */
> -static unsigned long write_no_reuse_object(struct sha1file *f, struct object_entry *entry,
> -					   unsigned long limit, int usable_delta)
> +static size_t write_no_reuse_object(struct sha1file *f, struct object_entry *entry,
> +				    size_t limit, int usable_delta)
>  {
>  	size_t size, datalen;
>  	unsigned char header[MAX_PACK_OBJECT_HEADER],
>  		      dheader[MAX_PACK_OBJECT_HEADER];
> -	unsigned hdrlen;
> +	size_t hdrlen;
>  	enum object_type type;
>  	void *buf;
>  	struct git_istream *st = NULL;
> @@ -350,17 +350,17 @@ static unsigned long write_no_reuse_object(struct sha1file *f, struct object_ent
>  
>  /* Return 0 if we will bust the pack-size limit */
>  static off_t write_reuse_object(struct sha1file *f, struct object_entry *entry,
> -				unsigned long limit, int usable_delta)
> +				size_t limit, int usable_delta)
>  {
>  	struct packed_git *p = entry->in_pack;
>  	struct pack_window *w_curs = NULL;
>  	struct revindex_entry *revidx;
>  	off_t offset;
>  	enum object_type type = entry->type;
> -	off_t datalen;
> +	size_t datalen;

On 32-bit Linux, off_t is 64-bit and size_t is 32-bit.

Later in this function, datalen is set the the difference of
two (revidx) off_t offsets. I haven't applied and tried this
on my 32-bit Linux install yet (that installation only gets
booted about once a week), but I suspect a 'possible data-loss'
warning.

For other reasons, I don't think it is not possible for
a 32-bit system to create a packfile with an individual object
of size > 4GB anyway, so this may not be a problem in practice.
(a 32-bit system should be able to read such a packfile, presumably
created on a 64-bit system, and refuse to load such an object, of
course).

ATB,
Ramsay Jones
