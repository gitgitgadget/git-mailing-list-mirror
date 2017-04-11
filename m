Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09F1820970
	for <e@80x24.org>; Tue, 11 Apr 2017 16:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751799AbdDKQ7N (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 12:59:13 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:44294 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750721AbdDKQ7M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 12:59:12 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 5590920970;
        Tue, 11 Apr 2017 16:59:11 +0000 (UTC)
Date:   Tue, 11 Apr 2017 16:59:11 +0000
From:   Eric Wong <e@80x24.org>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/5] run-command: avoid potential dangers in forked child
Message-ID: <20170411165911.GA15566@starla>
References: <20170410234919.34586-1-bmwill@google.com>
 <20170411070534.GA10552@whir>
 <20170411162920.GA36152@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170411162920.GA36152@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> wrote:
> On 04/11, Eric Wong wrote:
> > Hi Brandon, this series tickles an old itch of mine, so I
> > started working off of it.  I'm only somewhat concerned
> > with the path resolution in execvp(e) pontentially calling
> > malloc on some libcs; but I suppose that's a separate patch
> > for another time.
> > 
> > Only lightly-tested at the moment, but things seem to work...
> 
> Thanks Eric! I'll spend some time looking at this patch later today.  As
> for the path resolution in execvp(e), I guess we could completely avoid
> that if we did the path resolution ourselves, prior to forking, and then
> just use execv(e) since it shouldn't have any calls to malloc in them
> correct?

Yeah.  I spent some time looking at it last night, but emulating
the existing ENOENT / EACCESS / ENOTDIR mapping made my head
hurt.

And I'm not sure if I introduced any off-by-one errors in
exists_in_PATH when removing strbuf usage; string manipulation
in plain C scares me :x   Since memcpy/strcpy/getenv in there
are not specified as async-signal safe, they could
theoretically take locks and cause breakage inside a child.


I also wonder if there's a way to annotate internal functions as
async-signal safe (and thus vfork-child safe) besides sprinkling
comments in certain functions like xwrite.
