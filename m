Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C7BD1F453
	for <e@80x24.org>; Thu,  8 Nov 2018 21:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbeKIGzp (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 01:55:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:45326 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726890AbeKIGzo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 01:55:44 -0500
Received: (qmail 18864 invoked by uid 109); 8 Nov 2018 21:18:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 08 Nov 2018 21:18:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10916 invoked by uid 111); 8 Nov 2018 21:17:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 08 Nov 2018 16:17:44 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Nov 2018 16:18:24 -0500
Date:   Thu, 8 Nov 2018 16:18:24 -0500
From:   Jeff King <peff@peff.net>
To:     Geert Jansen <gerardu@amazon.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC PATCH] index-pack: improve performance on NFS
Message-ID: <20181108211823.GA20145@sigill.intra.peff.net>
References: <87o9bgl9yl.fsf@evledraar.gmail.com>
 <xmqq1s8bc0jp.fsf@gitster-ct.c.googlers.com>
 <20181027093300.GA23974@sigill.intra.peff.net>
 <87lg6jljmf.fsf@evledraar.gmail.com>
 <20181029150453.GH17668@sigill.intra.peff.net>
 <87bm7clf4o.fsf@evledraar.gmail.com>
 <20181029232738.GC24557@sigill.intra.peff.net>
 <20181107225524.GA119693@amazon.com>
 <20181108120256.GA29432@sigill.intra.peff.net>
 <20181108205819.GA93589@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181108205819.GA93589@amazon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 08, 2018 at 08:58:19PM +0000, Geert Jansen wrote:

> On Thu, Nov 08, 2018 at 07:02:57AM -0500, Jeff King wrote:
> 
> > Yes, testing and review. :)
> > 
> > I won't send the series out just yet, as I suspect it could use another
> > read-through on my part. But if you want to peek at it or try some
> > timings, it's available at:
> > 
> >   https://github.com/peff/git jk/loose-cache
> 
> I gave this branch a go. There's a performance regression as I'm getting a
> clone speed of about 100 KiB/s while with the previous patch I got around 20
> MiB/s. The culprint appears to be a very large number of stat() calls on
> ".git/objects/info/alternates". The call stack is:
> 
>  -> quick_has_loose()
>  -> prepare_alt_odb()
>  -> read_info_alternates()

Heh, indeed. Try this on top:

diff --git a/sha1-file.c b/sha1-file.c
index bc35b28e17..9ff27f92ed 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -692,6 +692,7 @@ void prepare_alt_odb(struct repository *r)
 	link_alt_odb_entries(r, r->objects->alternate_db, PATH_SEP, NULL, 0);
 
 	read_info_alternates(r, r->objects->odb->path, 0);
+	r->objects->loaded_alternates = 1;
 }
 
 /* Returns 1 if we have successfully freshened the file, 0 otherwise. */

-Peff
