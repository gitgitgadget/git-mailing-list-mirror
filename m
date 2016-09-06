Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9EC51F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 21:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964999AbcIFVGo (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 17:06:44 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:60120 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935877AbcIFVGe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 17:06:34 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 945FA1F6BF;
        Tue,  6 Sep 2016 21:06:32 +0000 (UTC)
Date:   Tue, 6 Sep 2016 21:06:32 +0000
From:   Eric Wong <e@80x24.org>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, tboegi@web.de,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v1 2/2] read-cache: make sure file handles are not
 inherited by child processes
Message-ID: <20160906210632.GA28263@starla>
References: <20160905211111.72956-1-larsxschneider@gmail.com>
 <20160905211111.72956-3-larsxschneider@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160905211111.72956-3-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

larsxschneider@gmail.com wrote:
>  static int ce_compare_data(const struct cache_entry *ce, struct stat *st)
>  {
>  	int match = -1;
> -	int fd = open(ce->name, O_RDONLY);
> +	int fd = open(ce->name, O_RDONLY | O_CLOEXEC);
>  
>  	if (fd >= 0) {
>  		unsigned char sha1[20];

Also, this needs to check EINVAL when O_CLOEXEC != 0 the same
way create_tempfile currently does.  Somebody could be building
with modern headers but running an old kernel that doesn't
understand O_CLOEXEC.

There should probably be a open() wrapper for handling this case
since we're now up to 3 places where open(... O_CLOEXEC) is
used.
