Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E82B51F404
	for <e@80x24.org>; Wed, 28 Feb 2018 18:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932613AbeB1SWe (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 13:22:34 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:39176 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932126AbeB1SWe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 13:22:34 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id AE9001F404;
        Wed, 28 Feb 2018 18:22:33 +0000 (UTC)
Date:   Wed, 28 Feb 2018 18:22:33 +0000
From:   Eric Wong <e@80x24.org>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Reduce pack-objects memory footprint?
Message-ID: <20180228182233.GC15256@dcvr>
References: <20180228092722.GA25627@ash>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228092722.GA25627@ash>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> wrote:
> which saves 12 bytes (or another 74 MB). 222 MB total is plenty of
> space to keep some file cache from being evicted.

Nice!  I can definitely benefit from lower memory usage when
packing.  Fwiw, I use pahole with other projects to help find
packing opportunities:

	git://git.kernel.org/pub/scm/devel/pahole/pahole.git

> @@ -14,11 +26,10 @@ struct object_entry {
>  	void *delta_data;	/* cached delta (uncompressed) */
>  	unsigned long delta_size;	/* delta data size (uncompressed) */
>  	unsigned long z_delta_size;	/* delta data size (compressed) */
> -	enum object_type type;
> -	enum object_type in_pack_type;	/* could be delta */
>  	uint32_t hash;			/* name hint hash */
> -	unsigned int in_pack_pos;
>  	unsigned char in_pack_header_size;
> +	unsigned type:3;	 /* enum object_type */
> +	unsigned in_pack_type:3; /* enum object_type - could be delta */

For C99 compilers, enums can be bitfields.  I introduced the
following macro into Ruby a few weeks ago to remain compatible
with non-C99 compilers:

/*
 * For declaring bitfields out of non-unsigned int types:
 *   struct date {
 *      BITFIELD(enum months) month:4;
 *      ...
 *   };
 */
#if defined(__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L)
# define BITFIELD(type) type
#else
# define BITFIELD(type) unsigned int
#endif
