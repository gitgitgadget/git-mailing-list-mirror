Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 018241F404
	for <e@80x24.org>; Thu,  4 Jan 2018 18:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752553AbeADSA2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 13:00:28 -0500
Received: from siwi.pair.com ([209.68.5.199]:29899 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751957AbeADSA1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 13:00:27 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 2B099844D7;
        Thu,  4 Jan 2018 13:00:27 -0500 (EST)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 9B551844B0;
        Thu,  4 Jan 2018 13:00:26 -0500 (EST)
Subject: Re: [PATCH 14/40] sha1_file: prepare for external odbs
To:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
 <20180103163403.11303-15-chriscool@tuxfamily.org>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <33af3206-b15d-3b01-e121-796cd31eb743@jeffhostetler.com>
Date:   Thu, 4 Jan 2018 13:00:26 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180103163403.11303-15-chriscool@tuxfamily.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/3/2018 11:33 AM, Christian Couder wrote:
> In the following commits we will need some functions that were
> internal to sha1_file.c, so let's first make them non static
> and declare them in "cache.h". While at it, let's rename
> 'create_tmpfile()' to 'create_object_tmpfile()' to make its
> name less generic.
> 
> Let's also split out 'sha1_file_name_alt()' from
> 'sha1_file_name()' and 'open_sha1_file_alt()' from
> 'open_sha1_file()', as we will need both of these new
> functions too.
[...]
> diff --git a/sha1_file.c b/sha1_file.c
> index 261baf800f..785e8dda03 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -322,17 +322,22 @@ static void fill_sha1_path(struct strbuf *buf, const unsigned char *sha1)
>   	}
>   }
>   
> -const char *sha1_file_name(const unsigned char *sha1)
> +const char *sha1_file_name_alt(const char *objdir, const unsigned char *sha1)
>   {
>   	static struct strbuf buf = STRBUF_INIT;

While we are refactoring sha1_file_name() and adding
sha1_file_name_alt(), could we also change the API and
pass in the strbuf so we can get rid of the static buffer?
Granted, it is a little off topic, but it will help out
in the long run.

[...]
> @@ -1551,7 +1562,7 @@ static inline int directory_size(const char *filename)
>    * We want to avoid cross-directory filename renames, because those
>    * can have problems on various filesystems (FAT, NFS, Coda).
>    */
> -static int create_tmpfile(struct strbuf *tmp, const char *filename)
> +int create_object_tmpfile(struct strbuf *tmp, const char *filename)
>   {
>   	int fd, dirlen = directory_size(filename);
>   
> @@ -1591,7 +1602,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
>   	static struct strbuf tmp_file = STRBUF_INIT;

Same thing here, since we are renaming the function anyway, could we
add a strbuf arg and get rid of the static one?


>   	const char *filename = sha1_file_name(sha1);
>   
> -	fd = create_tmpfile(&tmp_file, filename);
> +	fd = create_object_tmpfile(&tmp_file, filename);
>   	if (fd < 0) {
>   		if (errno == EACCES)
>   			return error("insufficient permission for adding an object to repository database %s", get_object_directory());
> 

Jeff
