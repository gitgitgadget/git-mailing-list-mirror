Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD69D2035F
	for <e@80x24.org>; Tue, 25 Oct 2016 21:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752733AbcJYVdT (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 17:33:19 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:38080 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752794AbcJYVdT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 17:33:19 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 9C8902035F;
        Tue, 25 Oct 2016 21:33:18 +0000 (UTC)
Date:   Tue, 25 Oct 2016 21:33:18 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 3/3] read-cache: make sure file handles are not
 inherited by child processes
Message-ID: <20161025213318.GB8683@starla>
References: <alpine.DEB.2.20.1610251327050.3264@virtualbox>
 <20161025181621.4201-1-gitster@pobox.com>
 <20161025181621.4201-4-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161025181621.4201-4-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> @@ -156,7 +156,14 @@ void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
>  static int ce_compare_data(const struct cache_entry *ce, struct stat *st)
>  {
>  	int match = -1;
> -	int fd = open(ce->name, O_RDONLY);
> +	static int cloexec = O_CLOEXEC;
> +	int fd = open(ce->name, O_RDONLY | cloexec);
> +
> +	if ((cloexec & O_CLOEXEC) && fd < 0 && errno == EINVAL) {
> +		/* Try again w/o O_CLOEXEC: the kernel might not support it */
> +		cloexec &= ~O_CLOEXEC;
> +		fd = open(ce->name, O_RDONLY | cloexec);
> +	}

Seems fine, I prefer not using recursion so it's
easier-to-review.

But I have a _slight_ preference towards Dscho's version in
<alpine.DEB.2.20.1610251230150.3264@virtualbox> in case we
decide to start using another O_* flag in here.
(but I'm not usually a C programmer)
