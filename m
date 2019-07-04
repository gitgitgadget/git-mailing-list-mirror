Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35BF81F4B6
	for <e@80x24.org>; Thu,  4 Jul 2019 12:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfGDMEM (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jul 2019 08:04:12 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36532 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727600AbfGDMEM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jul 2019 08:04:12 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 9568F1F461;
        Thu,  4 Jul 2019 12:04:11 +0000 (UTC)
Date:   Thu, 4 Jul 2019 12:04:11 +0000
From:   Eric Wong <e@80x24.org>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org
Subject: Re: Surprising use of memory and time when repacking mozilla's gecko
 repository
Message-ID: <20190704120411.2dlzdlsooob4dc7k@dcvr>
References: <20190704100530.smn4rpiekwtfylhz@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190704100530.smn4rpiekwtfylhz@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Hommey <mh@glandium.org> wrote:
> I'm puzzled by the fact writing objects is so much faster with 1 thread.

I/O contention in the multi-threaded cases?

"public-inbox-index" (reading from git, writing to Xapian+SQLite)
on a dev machine got slow because core count exceeded what SATA
could handle and had to cap the default Xapian shard count to 3
by default for v2 inboxes.


As for memory use, does git use the producer/consumer pattern
for malloc+free so free happens in a different thread from the
malloc?

Because current versions of glibc gets pathological with that case
(but I have a long-term fix for it):

https://public-inbox.org/libc-alpha/20180731084936.g4yw6wnvt677miti@dcvr/T/
Only locklessinc malloc seemed OK in the IPC department
(But I haven't kept up with jemalloc, tcmalloc developments in years)
