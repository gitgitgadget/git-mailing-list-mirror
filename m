Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B546120A21
	for <e@80x24.org>; Wed, 13 Sep 2017 18:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbdIMSrZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 14:47:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:37430 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751148AbdIMSrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 14:47:25 -0400
Received: (qmail 28964 invoked by uid 109); 13 Sep 2017 18:47:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 18:47:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18581 invoked by uid 111); 13 Sep 2017 18:47:59 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 14:47:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Sep 2017 14:47:22 -0400
Date:   Wed, 13 Sep 2017 14:47:22 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     demerphq <demerphq@gmail.com>, Git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 8/7] read_pack_header: handle signed/unsigned comparison in
 read result
Message-ID: <20170913184722.imcexldnufskugqz@sigill.intra.peff.net>
References: <CANgJU+Wj_sN8Px6rweHMw_iAX8UA3mW9x4NVCctpUCs8_3ytLw@mail.gmail.com>
 <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 13, 2017 at 01:08:07PM -0400, Jeff King wrote:

> Here's the fix, along with some related cleanups. The actual bugfix is
> in the first patch, which I think should go to "maint". The rest are not
> as important, so could go to master (but would also be fine for maint,
> as there should be no user-visible changes).
> 
>   [1/7]: config: avoid "write_in_full(fd, buf, len) < len" pattern
>   [2/7]: get-tar-commit-id: check write_in_full() return against 0
>   [3/7]: avoid "write_in_full(fd, buf, len) != len" pattern
>   [4/7]: convert less-trivial versions of "write_in_full() != len"
>   [5/7]: pkt-line: check write_in_full() errors against "< 0"
>   [6/7]: notes-merge: use ssize_t for write_in_full() return value
>   [7/7]: config: flip return value of store_write_*()

Jonathan pointed out that read_in_full() can suffer from the same issue,
and there is one buggy caller.

A mass cleanup is a bit harder, as described in

  https://public-inbox.org/git/20170913183700.amtrquhg66hjrbsp@sigill.intra.peff.net/

so I punted on it for now.

-- >8 --
Subject: [PATCH] read_pack_header: handle signed/unsigned comparison in read
 result

The result of read_in_full() may be -1 if we saw an error.
But in comparing it to a sizeof() result, that "-1" will be
promoted to size_t. In fact, the largest possible size_t
which is much bigger than our struct size. This means that
our "< sizeof(header)" error check won't trigger.

In practice, we'd go on to read uninitialized memory and
compare it to the PACK signature, which is likely to fail.
But we shouldn't get there.

We can fix this by making a direct "!=" comparison to the
requested size, rather than "<". This means that errors get
lumped in with short reads, but that's sufficient for our
purposes here. There's no PH_ERROR tp represent our case.
And anyway, this function reads from pipes and network
sockets. A network error may racily appear as EOF to us
anyway if there's data left in the socket buffers.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index 5f71bbac3e..c1c6e9021d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1850,7 +1850,7 @@ int index_path(struct object_id *oid, const char *path, struct stat *st, unsigne
 
 int read_pack_header(int fd, struct pack_header *header)
 {
-	if (read_in_full(fd, header, sizeof(*header)) < sizeof(*header))
+	if (read_in_full(fd, header, sizeof(*header)) != sizeof(*header))
 		/* "eof before pack header was fully read" */
 		return PH_ERROR_EOF;
 
-- 
2.14.1.874.ge7b2e05270

