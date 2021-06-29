Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB84C11F67
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 20:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7A9261DBA
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 20:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbhF2UXa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 16:23:30 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:51730 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235319AbhF2UX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 16:23:28 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 6C5921F8C6;
        Tue, 29 Jun 2021 20:21:01 +0000 (UTC)
Date:   Tue, 29 Jun 2021 20:21:01 +0000
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Subject: [HOLD 3/4] check_packed_git_idx: attempt to handle ENOMEM from mmap
Message-ID: <20210629202101.GA18279@dcvr>
References: <20210629081108.28657-1-e@80x24.org>
 <20210629081108.28657-4-e@80x24.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210629081108.28657-4-e@80x24.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> wrote:
> --- a/packfile.c
> +++ b/packfile.c
> @@ -97,7 +97,11 @@ static int check_packed_git_idx(const char *path, struct packed_git *p)
>  		close(fd);
>  		return error("index file %s is too small", path);
>  	}
> -	idx_map = xmmap(NULL, idx_size, PROT_READ, MAP_PRIVATE, fd, 0);
> +	do {
> +		idx_map = xmmap_gently(NULL, idx_size, PROT_READ, MAP_PRIVATE,
> +					fd, 0);
> +	} while (idx_map == MAP_FAILED && errno == ENOMEM
> +		&& unuse_one_window(p));

Oops, I dropped extra error handling here :x

>  	close(fd);
>  
>  	ret = load_idx(path, hashsz, idx_map, idx_size, p);
