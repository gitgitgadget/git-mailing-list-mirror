Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7901DC71155
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 12:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C1F020770
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 12:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgLAMPy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 07:15:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:47154 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727813AbgLAMPy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 07:15:54 -0500
Received: (qmail 26347 invoked by uid 109); 1 Dec 2020 12:15:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Dec 2020 12:15:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26118 invoked by uid 111); 1 Dec 2020 12:15:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Dec 2020 07:15:13 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Dec 2020 07:15:13 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?5ZSQ5a6H5aWV?= <winglovet@gmail.com>,
        git@vger.kernel.org
Subject: Re: Bug report: orphaned pack-objects after killing upload-pack on [
Message-ID: <X8Yz0bY1LOHpKxKA@coredump.intra.peff.net>
References: <CAFWsj_UwkQX9y0xPQJE3xguo0z3TMkvKAwei5iryCWXvVP8CjA@mail.gmail.com>
 <badf3777-3970-b714-3ad9-67d2f77f94a5@web.de>
 <20201121002921.GC353076@coredump.intra.peff.net>
 <xmqqd006s7ee.fsf@gitster.c.googlers.com>
 <X7zOKbzR9gwJHMbJ@coredump.intra.peff.net>
 <xmqqy2ipcdvj.fsf@gitster.c.googlers.com>
 <X778eIAr3uzdh0H0@coredump.intra.peff.net>
 <xmqqo8jllyhc.fsf@gitster.c.googlers.com>
 <bd2c4577-4c8c-851c-6045-ba4b306ca612@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd2c4577-4c8c-851c-6045-ba4b306ca612@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 26, 2020 at 09:04:35PM +0100, René Scharfe wrote:

> >>   We spawn an external pack-objects process to actually send objects to
> >>   the remote side. If we are killed by a signal during this process,
> >>   then pack-objects may continue to run. As soon as it starts producing
> >>   output for the pack, it will see a failure writing to upload-pack and
> >>   exit itself. But before then, it may do significant work traversing
> >>   the object graph, compressing deltas, etc, which will all be
> >>   pointless. So let's make sure to kill as soon as we know that the
> >>   caller will not read the result.
> >
> > Thanks, that reads well.
> >
> The patch is trivial, you don't need my sign-off.  You could record Peff
> as its author, as he contributed the most to the version in seen.

I didn't want this topic to be forgotten, so here it is with me as the
author, my signoff, and an overview of the reproduction in the commit
message.

(I am perfectly happy for René to be author, but I am mainly interested
in resolving the signoff issue; I agree most of the work was in the
diagnosis, and I did re-type the single line all by myself ;) ).

-- >8 --
Subject: [PATCH] upload-pack: kill pack-objects helper on signal or exit

We spawn an external pack-objects process to actually send objects to
the remote side. If we are killed by a signal during this process, then
pack-objects may continue to run. As soon as it starts producing output
for the pack, it will see a failure writing to upload-pack and exit
itself. But before then, it may do significant work traversing the
object graph, compressing deltas, etc, which will all be pointless. So
let's make sure to kill as soon as we know that the caller will not read
the result.

There's no test here, since it's inherently racy, but here's an easy
reproduction is on a large-ish repo like linux.git:

  - make sure you don't have pack bitmaps (since they make the enumerating
    phase go quickly). For linux.git it takes ~30s or so to walk the
    whole graph on my machine.

  - run "git clone --no-local -q . dst"; the "-q" is important because
    if pack-objects is writing progress to upload-pack (to get
    multiplexed over the sideband to the client), then it will notice
    pretty quickly the failure to write to stderr

  - kill the client-side clone process in another terminal (don't use
    ^C, as that will send SIGINT to all of the processes)

  - run "ps au | grep git" or similar to observe upload-pack dying
    within 5 seconds (it will send a keepalive that will notice the
    client has gone away)

  - but you'll still see pack-objects consuming 100% CPU (and 1GB+ of
    RAM) during the traversal and delta compression phases. It will exit
    as soon as it starts to write the pack (when it will notice that
    upload-pack went away).

With this patch, pack-objects exits as soon as upload-pack does.

Signed-off-by: Jeff King <peff@peff.net>
---
 upload-pack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/upload-pack.c b/upload-pack.c
index 5dc8e1f844..1006bebd50 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -321,6 +321,7 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 	pack_objects.in = -1;
 	pack_objects.out = -1;
 	pack_objects.err = -1;
+	pack_objects.clean_on_exit = 1;
 
 	if (start_command(&pack_objects))
 		die("git upload-pack: unable to fork git-pack-objects");
-- 
2.29.2.893.g57eb4d1d5a

