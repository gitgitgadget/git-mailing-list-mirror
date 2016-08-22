Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78EFC2018E
	for <e@80x24.org>; Mon, 22 Aug 2016 17:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752876AbcHVR60 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 13:58:26 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:49786 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755186AbcHVR60 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 13:58:26 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id CA0011F859;
        Mon, 22 Aug 2016 17:58:05 +0000 (UTC)
Date:   Mon, 22 Aug 2016 17:58:05 +0000
From:   Eric Wong <e@80x24.org>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Ben Wijen <ben@wijen.net>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/2] mingw: ensure temporary file handles are not
 inherited by child processes
Message-ID: <20160822175805.GA10495@starla>
References: <cover.1471531799.git.johannes.schindelin@gmx.de>
 <cover.1471869985.git.johannes.schindelin@gmx.de>
 <b31d13befa305e46bd51f8c168f42071ce2dc663.1471869985.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b31d13befa305e46bd51f8c168f42071ce2dc663.1471869985.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> wrote:
> As Eric Wong pointed out, we need to be careful to handle the case where
> the Linux headers used to compile Git support O_CLOEXEC but the Linux
> kernel used to run Git does not: it returns an EINVAL.

> +++ b/git-compat-util.h
> @@ -667,6 +667,10 @@ void *gitmemmem(const void *haystack, size_t haystacklen,
>  #define getpagesize() sysconf(_SC_PAGESIZE)
>  #endif
>  
> +#ifndef O_CLOEXEC
> +#define O_CLOEXEC 0
> +#endif

> +++ b/tempfile.c
> @@ -120,7 +120,12 @@ int create_tempfile(struct tempfile *tempfile, const char *path)
>  	prepare_tempfile_object(tempfile);
>  
>  	strbuf_add_absolute_path(&tempfile->filename, path);
> -	tempfile->fd = open(tempfile->filename.buf, O_RDWR | O_CREAT | O_EXCL, 0666);
> +	tempfile->fd = open(tempfile->filename.buf,
> +			    O_RDWR | O_CREAT | O_EXCL | O_CLOEXEC, 0666);
> +	if (O_CLOEXEC && tempfile->fd < 0 && errno == EINVAL)
> +		/* Try again w/o O_CLOEXEC: the kernel might not support it */
> +		tempfile->fd = open(tempfile->filename.buf,
> +				    O_RDWR | O_CREAT | O_EXCL, 0666);
>  	if (tempfile->fd < 0) {
>  		strbuf_reset(&tempfile->filename);
>  		return -1;

Looks good to me from a Linux standpoint.  Thanks.
