Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 164601FE90
	for <e@80x24.org>; Sat, 22 Apr 2017 21:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427198AbdDVVwy (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Apr 2017 17:52:54 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:65249 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1427149AbdDVVww (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2017 17:52:52 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3w9RDL07Vvz5tlH;
        Sat, 22 Apr 2017 23:52:49 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 3A1F4101;
        Sat, 22 Apr 2017 23:52:49 +0200 (CEST)
Subject: Re: [PATCH] archive-zip: Add zip64 headers when file size is too
 large for 32 bits
To:     Peter Krefting <peter@softwolves.pp.se>
References: <3C736801-6BB8-41CC-88FF-C42FC853A736@blackthorn-media.com>
 <alpine.DEB.2.11.1704222019420.12779@perkele.intern.softwolves.pp.se>
Cc:     git@vger.kernel.org, Keith Goldfarb <keith@blackthorn-media.com>
Newsgroups: gmane.comp.version-control.git
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <37eb7c14-eb61-7a63-bdf0-ee1ccf40723f@kdbg.org>
Date:   Sat, 22 Apr 2017 23:52:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1704222019420.12779@perkele.intern.softwolves.pp.se>
Content-Type: text/plain; charset=iso-8859-7; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.04.2017 um 21:22 schrieb Peter Krefting:
> @@ -279,6 +299,7 @@ static int write_zip_entry(struct archiver_args *args,
>      int is_binary = -1;
>      const char *path_without_prefix = path + args->baselen;
>      unsigned int creator_version = 0;
> +    int clamped = 0;
>
>      crc = crc32(0, NULL, 0);
>
> @@ -376,7 +397,7 @@ static int write_zip_entry(struct archiver_args *args,
>      copy_le16(dirent.comment_length, 0);
>      copy_le16(dirent.disk, 0);
>      copy_le32(dirent.attr2, attr2);
> -    copy_le32(dirent.offset, zip_offset);
> +    copy_le32(dirent.offset, clamp_max(zip_offset, 0xFFFFFFFFU,
> &clamped));
>
>      copy_le32(header.magic, 0x04034b50);
>      copy_le16(header.version, 10);
> @@ -384,15 +405,26 @@ static int write_zip_entry(struct archiver_args
> *args,
>      copy_le16(header.compression_method, method);
>      copy_le16(header.mtime, zip_time);
>      copy_le16(header.mdate, zip_date);
> -    set_zip_header_data_desc(&header, size, compressed_size, crc);
> +    set_zip_header_data_desc(&header, size, compressed_size, crc,
> &clamped);
>      copy_le16(header.filename_length, pathlen);
> -    copy_le16(header.extra_length, ZIP_EXTRA_MTIME_SIZE);
> +    copy_le16(header.extra_length, ZIP_EXTRA_MTIME_SIZE + (clamped ?
> ZIP_EXTRA_ZIP64_SIZE : 0));
>      write_or_die(1, &header, ZIP_LOCAL_HEADER_SIZE);
>      zip_offset += ZIP_LOCAL_HEADER_SIZE;
>      write_or_die(1, path, pathlen);
>      zip_offset += pathlen;
>      write_or_die(1, &extra, ZIP_EXTRA_MTIME_SIZE);
>      zip_offset += ZIP_EXTRA_MTIME_SIZE;
> +    if (clamped) {
> +        struct zip_extra_zip64 extra_zip64;
> +        copy_le16(extra_zip64.magic, 0x0001);
> +        copy_le16(extra_zip64.extra_size, ZIP_EXTRA_ZIP64_PAYLOAD_SIZE);
> +        copy_le64(extra_zip64.size, size);
> +        copy_le64(extra_zip64.compressed_size, compressed_size);
> +        copy_le64(extra_zip64.offset, zip_offset);
> +        copy_le32(extra_zip64.disk, 0);
> +        write_or_die(1, &extra_zip64, ZIP_EXTRA_ZIP64_SIZE);
> +        zip_offset += ZIP_EXTRA_ZIP64_SIZE;

Is this correct? Not all of the zip64 extra fields are always populated. 
Only those whose regular fields are filled with 0xffffffff must be 
present. Since there is only one flag, it is not possible to know which 
of the fields must be filled in.

Readers will most likely ignore trailing fields that should not be 
there; however, when the offset exceeds 32 bits, but not the compressed 
size, readers will pick the compressed size and interpret it as offset.

> +    }

-- Hannes

