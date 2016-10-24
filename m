Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DE2020193
	for <e@80x24.org>; Mon, 24 Oct 2016 18:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933749AbcJXSjC (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 14:39:02 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:43708 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932470AbcJXSjB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 14:39:01 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id A851620193;
        Mon, 24 Oct 2016 18:39:00 +0000 (UTC)
Date:   Mon, 24 Oct 2016 18:39:00 +0000
From:   Eric Wong <e@80x24.org>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, jnareb@gmail.com,
        gitster@pobox.com
Subject: Re: [PATCH v2 2/2] read-cache: make sure file handles are not
 inherited by child processes
Message-ID: <20161024183900.GA12769@starla>
References: <20161024180300.52359-1-larsxschneider@gmail.com>
 <20161024180300.52359-3-larsxschneider@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161024180300.52359-3-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

larsxschneider@gmail.com wrote:
> +++ b/read-cache.c
> @@ -156,7 +156,11 @@ void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
>  static int ce_compare_data(const struct cache_entry *ce, struct stat *st)
>  {
>  	int match = -1;
> -	int fd = open(ce->name, O_RDONLY);
> +	int fd = open(ce->name, O_RDONLY | O_CLOEXEC);
> +
> +	if (O_CLOEXEC && fd < 0 && errno == EINVAL)
> +		/* Try again w/o O_CLOEXEC: the kernel might not support it */
> +		fd = open(ce->name, O_RDONLY);

In the case of O_CLOEXEC != 0 and repeated EINVALs,
it'd be good to use something like sha1_file_open_flag as in 1/2
so we don't repeatedly hit EINVAL.  Thanks.
