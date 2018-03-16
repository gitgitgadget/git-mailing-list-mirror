Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F9541F404
	for <e@80x24.org>; Fri, 16 Mar 2018 20:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753295AbeCPUTO (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 16:19:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:59892 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752918AbeCPUTM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 16:19:12 -0400
Received: (qmail 8053 invoked by uid 109); 16 Mar 2018 20:19:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 16 Mar 2018 20:19:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32654 invoked by uid 111); 16 Mar 2018 20:20:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 16 Mar 2018 16:20:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Mar 2018 16:19:09 -0400
Date:   Fri, 16 Mar 2018 16:19:09 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        git@jeffhostetler.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v6 00/14] Serialized Git Commit Graph
Message-ID: <20180316201908.GA12281@sigill.intra.peff.net>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
 <20180314192736.70602-1-dstolee@microsoft.com>
 <878tasdpqo.fsf@evledraar.gmail.com>
 <CAM0VKjknPZj-qHzf5nVr_RdHtB+pq2+APc1tesexP-eFSP9n_A@mail.gmail.com>
 <xmqq370z3m5o.fsf@gitster-ct.c.googlers.com>
 <CAM0VKjmVgiWsqo8rQWwP9+mEq0tLinc8xoUM=8XdMP3VTBwJxw@mail.gmail.com>
 <20180316200639.GA1845@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180316200639.GA1845@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 16, 2018 at 04:06:39PM -0400, Jeff King wrote:

> > Furthermore, in order to look at an object it has to be zlib inflated
> > first, and since commit objects tend to be much smaller than trees and
> > especially blobs, there are a lot less bytes to inflate:
> > 
> >   $ grep ^commit type-size |cut -d' ' -f2 |avg
> >   34395730 / 53754 = 639
> >   $ cat type-size |cut -d' ' -f2 |avg
> >   3866685744 / 244723 = 15800
> > 
> > So a simple revision walk inflates less than 1% of the bytes that the
> > "enumerate objects packfiles" approach has to inflate.
> 
> I don't think this is quite accurate. It's true that we have to
> _consider_ every object, but Git is smart enough not to inflate each one
> to find its type. For loose objects we just inflate the header. For
> packed objects, we either pick the type directly out of the packfile
> header (for a non-delta) or can walk the delta chain (without actually
> looking at the data bytes!) until we hit the base.

Hmm, so that's a big part of the problem with this patch series. It
actually _does_ unpack every object with --stdin-packs to get the type,
which is just silly. With the patch below, my time for "commit-graph
write --stdin-packs" on linux.git goes from over 5 minutes (I got bored
and killed it) to 17 seconds.

diff --git a/commit-graph.c b/commit-graph.c
index 6348bab82b..cf1da2e8c1 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -491,11 +491,12 @@ static int add_packed_commits(const struct object_id *oid,
 {
 	struct packed_oid_list *list = (struct packed_oid_list*)data;
 	enum object_type type;
-	unsigned long size;
-	void *inner_data;
 	off_t offset = nth_packed_object_offset(pack, pos);
-	inner_data = unpack_entry(pack, offset, &type, &size);
-	FREE_AND_NULL(inner_data);
+	struct object_info oi = OBJECT_INFO_INIT;
+
+	oi.typep = &type;
+	if (packed_object_info(pack, offset, &oi) < 0)
+		die("unable to get type of object %s", oid_to_hex(oid));
 
 	if (type != OBJ_COMMIT)
 		return 0;

-Peff
