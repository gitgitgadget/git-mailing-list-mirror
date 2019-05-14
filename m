Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 849D31F4B6
	for <e@80x24.org>; Tue, 14 May 2019 12:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfENMNv (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 08:13:51 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:43354 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfENMNv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 08:13:51 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 8FF8A1F461;
        Tue, 14 May 2019 12:13:50 +0000 (UTC)
Date:   Tue, 14 May 2019 12:13:50 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: dumb HTTP things I want to do
Message-ID: <20190514121350.jugxtegpvcxr4vjs@dcvr>
References: <20190511013455.5886-1-e@80x24.org>
 <87v9ygwoj0.fsf@evledraar.gmail.com>
 <20190512040825.GA25370@sigill.intra.peff.net>
 <87tve0w3ao.fsf@evledraar.gmail.com>
 <20190514094729.GA12256@sigill.intra.peff.net>
 <20190514115047.oncvfq24fhnp64re@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190514115047.oncvfq24fhnp64re@dcvr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> wrote:
> Jeff King <peff@peff.net> wrote:
> > That's my reading, too, but I didn't want to be responsible for
> > regressing some obscure case. At least Eric seems to _use_
> > update-server-info. ;)
> 
> I also have something else on my mind for abusing info files with :>
> (another email)

I'm not sure when/if I'll have time for this; but this ought to
be possible:

	GIT_DIR=$HTTP_URL git <any read-only command>

And possible without existing admins to setup or change
anything on their server.

Right now, I could do it by setting up a WebDAV server
and using fusedav[1] on the client.

But, not everybody runs a WebDAV server which allows PROPFIND
for listing files...  However, info/refs and objects/info/packs
can give us all the info we need without needing PROPFIND.  All
we'd need is the common GET/HEAD HTTP methods for read-only
access.

git doesn't need mmap; and curl + Range requests ought to be
able to get us what we need to emulate pread.  It'd be great for
low-latency LANs, maybe not so great with high latency; but
probably better in many cases than cloning a giant repo to cat
one blob.

Also, cloning on a static bundle ought to be doable with:

	git clone $REMOTE_OR_LOCAL_PATH/foo.bundle

And yeah, it also sucks that bundles double storage overhead
for admins; it would be nice if I could use bundles as alternates
or packs...

Anyways, all of this is probably a lot of work and I don't hack
much, anymore.


[1] I have many patches for fusedav, and the debian maintainer
    seems dead, and upstream's moved on: https://bugs.debian.org/fusedav
    davfs2 can't do Range requests, so it won't work for big repos...
