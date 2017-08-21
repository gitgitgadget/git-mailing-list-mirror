Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B7121F667
	for <e@80x24.org>; Mon, 21 Aug 2017 06:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751077AbdHUGmp (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 02:42:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53670 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751050AbdHUGmo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 02:42:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 395708A943;
        Mon, 21 Aug 2017 02:42:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K0MsQG3tWf03niMhp5mWLP1lF2E=; b=pPFAdA
        DfKMdCJJeCHH6lznWjz4Rc0dEOMLoLnhdos2dex9bfKpQlFGp+9ow5T/hFmSyfPV
        nPja98J2hZZcPpTKttQoDBPcPOIbfOcTOt7GKNNUelSpgQMAyChWA5TmSgRzafoB
        atK/oNri4DGctZFI2Dfx99awvu75heovb6v0U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lOdDigTCsa5mA56dofSkG/ICH/KqsUe9
        2EBaf+8MOs+65Huo2PaTNqYYv6fSBs4+/82pxE1fbp5rlsHggAUmEMSu+ALfAqCQ
        scdWzOGFySc5XasYocbtOVsRa/xNGF1PYEB3NiTLIQIMDTLtjtRkOoqqv0Qhf3af
        TlBpNvLyrkA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 30D368A93F;
        Mon, 21 Aug 2017 02:42:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 98A498A93E;
        Mon, 21 Aug 2017 02:42:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin Koegler <martin.koegler@chello.at>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [Patch size_t V3 15/19] Convert archive functions to size_t
References: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
        <1502914591-26215-16-git-send-email-martin@mail.zuhause>
Date:   Sun, 20 Aug 2017 23:42:35 -0700
In-Reply-To: <1502914591-26215-16-git-send-email-martin@mail.zuhause> (Martin
        Koegler's message of "Wed, 16 Aug 2017 22:16:27 +0200")
Message-ID: <xmqqvalh5smc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EB449B3E-863B-11E7-9110-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Koegler <martin.koegler@chello.at> writes:

> From: Martin Koegler <martin.koegler@chello.at>
>
> Signed-off-by: Martin Koegler <martin.koegler@chello.at>
> ---
>  archive-tar.c | 16 ++++++++--------
>  archive-zip.c | 22 +++++++++++-----------
>  2 files changed, 19 insertions(+), 19 deletions(-)

I feel that this needs a careful review from somebody who knows the
definition of archive formats well.

I am reasonably confident to say that the part of this patch that
updates the variable used to interact with zlib to size_t.  Use of
fixed-width uint32_t for CRC32 may also be correct, I would think.

But for all the other changes, it makes me nervous to see that
size_t is used to describe size of things in an archive, and makes
me suspect that some may want to be off_t, because an archive is a
concatenation of files, whose sizes are better measured in off_t
rather than size_t.



> diff --git a/archive-tar.c b/archive-tar.c
> index 719673d..ee56b2b 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -12,7 +12,7 @@
>  #define BLOCKSIZE	(RECORDSIZE * 20)
>  
>  static char block[BLOCKSIZE];
> -static unsigned long offset;
> +static size_t offset;
>  
>  static int tar_umask = 002;
>  
> @@ -50,12 +50,12 @@ static void write_if_needed(void)
>   * queues up writes, so that all our write(2) calls write exactly one
>   * full block; pads writes to RECORDSIZE
>   */
> -static void do_write_blocked(const void *data, unsigned long size)
> +static void do_write_blocked(const void *data, size_t size)
>  {
>  	const char *buf = data;
>  
>  	if (offset) {
> -		unsigned long chunk = BLOCKSIZE - offset;
> +		size_t chunk = BLOCKSIZE - offset;
>  		if (size < chunk)
>  			chunk = size;
>  		memcpy(block + offset, buf, chunk);
> @@ -77,7 +77,7 @@ static void do_write_blocked(const void *data, unsigned long size)
>  
>  static void finish_record(void)
>  {
> -	unsigned long tail;
> +	size_t tail;
>  	tail = offset % RECORDSIZE;
>  	if (tail)  {
>  		memset(block + offset, 0, RECORDSIZE - tail);
> @@ -86,7 +86,7 @@ static void finish_record(void)
>  	write_if_needed();
>  }
>  
> -static void write_blocked(const void *data, unsigned long size)
> +static void write_blocked(const void *data, size_t size)
>  {
>  	do_write_blocked(data, size);
>  	finish_record();
> @@ -198,10 +198,10 @@ static size_t get_path_prefix(const char *path, size_t pathlen, size_t maxlen)
>  
>  static void prepare_header(struct archiver_args *args,
>  			   struct ustar_header *header,
> -			   unsigned int mode, unsigned long size)
> +			   unsigned int mode, size_t size)
>  {
>  	xsnprintf(header->mode, sizeof(header->mode), "%07o", mode & 07777);
> -	xsnprintf(header->size, sizeof(header->size), "%011lo", S_ISREG(mode) ? size : 0);
> +	xsnprintf(header->size, sizeof(header->size), "%011lo", S_ISREG(mode) ? (unsigned long)size : 0);
>  	xsnprintf(header->mtime, sizeof(header->mtime), "%011lo", (unsigned long) args->time);
>  
>  	xsnprintf(header->uid, sizeof(header->uid), "%07o", 0);
> @@ -219,7 +219,7 @@ static void prepare_header(struct archiver_args *args,
>  
>  static void write_extended_header(struct archiver_args *args,
>  				  const unsigned char *sha1,
> -				  const void *buffer, unsigned long size)
> +				  const void *buffer, size_t size)
>  {
>  	struct ustar_header header;
>  	unsigned int mode;
> diff --git a/archive-zip.c b/archive-zip.c
> index 4492d64..3a54d80 100644
> --- a/archive-zip.c
> +++ b/archive-zip.c
> @@ -186,12 +186,12 @@ static uint32_t clamp32(uintmax_t n)
>  	return (n < max) ? n : max;
>  }
>  
> -static void *zlib_deflate_raw(void *data, unsigned long size,
> +static void *zlib_deflate_raw(void *data, size_t size,
>  			      int compression_level,
> -			      unsigned long *compressed_size)
> +			      size_t *compressed_size)
>  {
>  	git_zstream stream;
> -	unsigned long maxsize;
> +	size_t maxsize;
>  	void *buffer;
>  	int result;
>  
> @@ -219,9 +219,9 @@ static void *zlib_deflate_raw(void *data, unsigned long size,
>  	return buffer;
>  }
>  
> -static void write_zip_data_desc(unsigned long size,
> -				unsigned long compressed_size,
> -				unsigned long crc)
> +static void write_zip_data_desc(size_t size,
> +				size_t compressed_size,
> +				uint32_t crc)
>  {
>  	if (size >= 0xffffffff || compressed_size >= 0xffffffff) {
>  		struct zip64_data_desc trailer;
> @@ -243,9 +243,9 @@ static void write_zip_data_desc(unsigned long size,
>  }
>  
>  static void set_zip_header_data_desc(struct zip_local_header *header,
> -				     unsigned long size,
> -				     unsigned long compressed_size,
> -				     unsigned long crc)
> +				     size_t size,
> +				     size_t compressed_size,
> +				     uint32_t crc)
>  {
>  	copy_le32(header->crc32, crc);
>  	copy_le32(header->compressed_size, compressed_size);
> @@ -287,8 +287,8 @@ static int write_zip_entry(struct archiver_args *args,
>  	size_t header_extra_size = ZIP_EXTRA_MTIME_SIZE;
>  	int need_zip64_extra = 0;
>  	unsigned long attr2;
> -	unsigned long compressed_size;
> -	unsigned long crc;
> +	size_t compressed_size;
> +	uint32_t crc;
>  	int method;
>  	unsigned char *out;
>  	void *deflated = NULL;
