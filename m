Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 728F7207D6
	for <e@80x24.org>; Sun, 23 Apr 2017 07:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427845AbdDWHuQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 03:50:16 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:53233 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1427840AbdDWHuP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2017 03:50:15 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3w9hTd33x7z5tl9;
        Sun, 23 Apr 2017 09:50:13 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id C3E073A5;
        Sun, 23 Apr 2017 09:50:10 +0200 (CEST)
Subject: Re: [PATCH v2] archive-zip: Add zip64 headers when file size is too
 large for 32 bits
To:     Peter Krefting <peter@softwolves.pp.se>, git@vger.kernel.org
References: <37eb7c14-eb61-7a63-bdf0-ee1ccf40723f@kdbg.org>
 <alpine.DEB.2.11.1704222341300.22361@perkele.intern.softwolves.pp.se>
Cc:     Keith Goldfarb <keith@blackthorn-media.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <a1504d15-36d6-51f8-f2c9-a6563789bb6f@kdbg.org>
Date:   Sun, 23 Apr 2017 09:50:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1704222341300.22361@perkele.intern.softwolves.pp.se>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.04.2017 um 00:41 schrieb Peter Krefting:
> Indeed. Last time I implemented zip64 support it was on the reading side,
> and I remember this was a mess...

It is indeed!

>  static void set_zip_header_data_desc(struct zip_local_header *header,
>  				     unsigned long size,
>  				     unsigned long compressed_size,
> -				     unsigned long crc)
> +				     unsigned long crc,
> +				     int *clamped)
>  {
>  	copy_le32(header->crc32, crc);
> -	copy_le32(header->compressed_size, compressed_size);
> -	copy_le32(header->size, size);
> +	copy_le32(header->compressed_size, clamp_max(compressed_size, 0xFFFFFFFFU, clamped));
> +	copy_le32(header->size, clamp_max(size, 0xFFFFFFFFU, clamped));
> +	if (clamped)
> +		zip_zip64 = 1;

This must be

	if (*clamped)

>  }
>
>  static int has_only_ascii(const char *s)
> @@ -279,6 +299,7 @@ static int write_zip_entry(struct archiver_args *args,
>  	int is_binary = -1;
>  	const char *path_without_prefix = path + args->baselen;
>  	unsigned int creator_version = 0;
> +	int clamped = 0;
>
>  	crc = crc32(0, NULL, 0);
>
> @@ -376,7 +397,7 @@ static int write_zip_entry(struct archiver_args *args,
>  	copy_le16(dirent.comment_length, 0);
>  	copy_le16(dirent.disk, 0);
>  	copy_le32(dirent.attr2, attr2);
> -	copy_le32(dirent.offset, zip_offset);
> +	copy_le32(dirent.offset, clamp_max(zip_offset, 0xFFFFFFFFU, &clamped));

I don't see any provisions to write the zip64 extra header in the 
central directory when this offset is clamped. This means that ZIP 
archives whose size exceed 4GB are still unsupported.

>
>  	copy_le32(header.magic, 0x04034b50);
>  	copy_le16(header.version, 10);
> @@ -384,15 +405,26 @@ static int write_zip_entry(struct archiver_args *args,
>  	copy_le16(header.compression_method, method);
>  	copy_le16(header.mtime, zip_time);
>  	copy_le16(header.mdate, zip_date);
> -	set_zip_header_data_desc(&header, size, compressed_size, crc);
> +	set_zip_header_data_desc(&header, size, compressed_size, crc, &clamped);
>  	copy_le16(header.filename_length, pathlen);
> -	copy_le16(header.extra_length, ZIP_EXTRA_MTIME_SIZE);
> +	copy_le16(header.extra_length, ZIP_EXTRA_MTIME_SIZE + (clamped ? ZIP_EXTRA_ZIP64_SIZE : 0));
>  	write_or_die(1, &header, ZIP_LOCAL_HEADER_SIZE);
>  	zip_offset += ZIP_LOCAL_HEADER_SIZE;
>  	write_or_die(1, path, pathlen);
>  	zip_offset += pathlen;
>  	write_or_die(1, &extra, ZIP_EXTRA_MTIME_SIZE);
>  	zip_offset += ZIP_EXTRA_MTIME_SIZE;
> +	if (clamped) {
> +		struct zip_extra_zip64 extra_zip64;
> +		copy_le16(extra_zip64.magic, 0x0001);
> +		copy_le16(extra_zip64.extra_size, ZIP_EXTRA_ZIP64_PAYLOAD_SIZE);
> +		copy_le64(extra_zip64.size, size >= 0xFFFFFFFFU ? size : 0);
> +		copy_le64(extra_zip64.compressed_size, compressed_size >= 0xFFFFFFFFU ? compressed_size : 0);
> +		copy_le64(extra_zip64.offset, zip_offset >= 0xFFFFFFFFU ? zip_offset : 0);
> +		copy_le32(extra_zip64.disk, 0);

These are wrong, I think. Entries that did not overflow must be omitted 
entirely from the zip64 extra record, not filled with 0. This implies 
that the payload size (.extra_size) is dynamic.

As René pointed out, the offset is only written in the central 
directory, but not in the local header for the current file. Therefore, 
it must be omitted here. The disk number also never exceeds 0xffff and 
must be omitted as well.

> +		write_or_die(1, &extra_zip64, ZIP_EXTRA_ZIP64_SIZE);
> +		zip_offset += ZIP_EXTRA_ZIP64_SIZE;
> +	}
>  	if (stream && method == 0) {
>  		unsigned char buf[STREAM_BUFFER_SIZE];
>  		ssize_t readlen;
> @@ -538,7 +570,7 @@ static void write_zip_trailer(const unsigned char *sha1)
>  	copy_le16(trailer.comment_length, sha1 ? GIT_SHA1_HEXSZ : 0);
>
>  	write_or_die(1, zip_dir, zip_dir_offset);
> -	if (clamped)
> +	if (clamped || zip_zip64)
>  		write_zip64_trailer();
>  	write_or_die(1, &trailer, ZIP_DIR_TRAILER_SIZE);
>  	if (sha1)
>

-- Hannes

