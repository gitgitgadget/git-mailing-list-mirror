Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232E2C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 16:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0279161244
	for <git@archiver.kernel.org>; Wed, 19 May 2021 16:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355118AbhESQM1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 12:12:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:59176 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355115AbhESQM1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 12:12:27 -0400
Received: (qmail 23519 invoked by uid 109); 19 May 2021 16:11:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 19 May 2021 16:11:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21255 invoked by uid 111); 19 May 2021 16:11:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 19 May 2021 12:11:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 19 May 2021 12:11:05 -0400
From:   Jeff King <peff@peff.net>
To:     Greg Pflaum <greg.pflaum@pnp-hcl.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] fetch-pack: signal v2 server that we are done making requests
Message-ID: <YKU4mbq/am/liAN4@coredump.intra.peff.net>
References: <OF9ECB0D17.7C6A7258-ON852586DA.0014125E-852586DA.0014B7AB@pnp-hcl.com>
 <YKTbsByUaPEuDNtR@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YKTbsByUaPEuDNtR@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 19, 2021 at 05:34:40AM -0400, Jeff King wrote:

> On Tue, May 18, 2021 at 11:46:17PM -0400, Greg Pflaum wrote:
> 
> > Git's handling of the SSH session during "git clone" changed between Git
> > 2.17.0 and 2.31.1, causing cloning of a large repo to fail when the server
> > closes the idle session during the "Resolving deltas" phase.
> 
> Interesting find.
> 
> During that phase, all communication with the server is finished. We're
> not expecting it to say anything else, and I'd have actually expected us
> to have hung up the connection.

OK, here's the fix I came up with. It's a two-line code change, of
course, but I tried to lay out all of my thinking about why this is the
right thing to do. Apologies in advance for the length. :)

-- >8 --
Subject: [PATCH] fetch-pack: signal v2 server that we are done making requests

When fetching with the v0 protocol over ssh (or a local upload-pack with
pipes), the server closes the connection as soon as it is finished
sending the pack. So even though the client may still be operating on
the data via index-pack (e.g., resolving deltas, checking connectivity,
etc), the server has released all resources.

With the v2 protocol, however, the server considers the ssh session only
as a transport, with individual requests coming over it. After sending
the pack, it goes back to its main loop, waiting for another request to
come from the client. As a result, the ssh session hangs around until
the client process ends, which may be much later (because resolving
deltas, etc, may consume a lot of CPU).

This is bad for two reasons:

  - it's consuming resources on the server to leave open a connection
    that won't see any more use

  - if something bad happens to the ssh connection in the meantime (say,
    it gets killed by the network because it's idle, as happened in a
    real-world report), then ssh will exit non-zero, and we'll propagate
    the error up the stack.

The server is correct here not to hang up after serving the pack. The v2
protocol's design is meant to allow multiple requests like this, and
hanging up would be the wrong thing for a hypothetical client which was
planning to make more requests (though in practice, the git.git client
never would, and I doubt any other implementations would either).

The right thing is instead for the client to signal to the server that
it's not interested in making more requests. We can do that by closing
the pipe descriptor we use to write to ssh. This will propagate to the
server upload-pack as an EOF when it tries to read the next request (and
then it will close its half, and the whole connection will go away).

It's important to do this "half duplex" shutdown, because we have to do
it _before_ we actually receive the pack. This is an artifact of the way
fetch-pack and index-pack (or unpack-objects) interact. We hand the
connection off to index-pack (really, a sideband demuxer which feeds
it), and then wait until it returns. And it doesn't do that until it has
resolved all of the deltas in the pack, even though it was done reading
from the server long before.

So just closing the connection fully after index-pack returns would be
too late; we'd have held it open much longer than was necessary. And
teaching index-pack to close the connection is awkward. It's not even
seeing the whole conversation (the sideband demuxer is, but it doesn't
actually know what's in the packets, or when the end comes).

Note that this close() is happening deep within the transport code. It's
possible that a caller would want to perform other operations over the
same ssh transport after receiving the pack. But as of the current code,
none of the callers do, and there haven't been discussions of any plans
to change this. If we need to support that later, we can probably do so
by passing down a flag for "you're the last request on the transport;
it's OK to close" instead of the code just assuming that's true.

The description above all discusses v2 ssh, so it's worth thinking about
how this interacts with other protocols:

  - in v0 protocols, we could do the same half-duplex shutdown (it just
    goes into the v0 do_fetch_pack() instead). This does work, but since
    it doesn't have the same persistence problem in the first place,
    there's little reason to change it at this point.

  - local fetches against git-upload-pack on the same machine will
    behave the same as ssh (they are talking over two pipes, and see EOF
    on their input pipe)

  - fetches against git-daemon will run this same code, and close one of
    the descriptors. In practice, this won't do anything, since there
    our two descriptors are dups of each other, and not part of a
    half-duplex pair. The right thing would probably be to call
    shutdown(SHUT_WR) on it. I didn't bother with that here. It doesn't
    face the same error-code problem (since it's just a TCP connection),
    so it's really only an optimization problem. And git:// is not that
    widely used these days, and has less impact on server resources than
    an ssh termination.

  - v2 http doesn't suffer from this problem in the first place, as our
    pipes terminate at a local git-remote-https, which is passing data
    along as individual requests via curl. Probably curl is keeping the
    TCP/TLS connection open for more requests, and we might be able to
    tell it manually "hey, we are done making requests now". But I think
    that's much less important. It again doesn't suffer from the
    error-code problem, and HTTP keepalive is pretty well understood
    (importantly, the timeouts can be set low, because clients like curl
    know how to reconnect for subsequent requests if necessary). So it's
    probably not worth figuring out how to tell curl that we're done
    (though if we do, this patch is probably the first step anyway;
    fetch-pack closes the pipe back to remote-https, which would be the
    signal that it should tell curl we're done).

The code is pretty straightforward. We close the pipe at the right
moment, and set it to -1 to mark it as invalid. I modified the later
cleanup code to avoid calling close(-1). That's not strictly necessary,
since close(-1) is a noop, but hopefully makes things a bit more obvious
to a reader.

I suspect that trying to call more transport functions after the close()
(e.g., calling transport_fetch_refs() again) would fail, as it's not
smart enough to realize we need to re-open the ssh connection. But
that's already true when v0 is in use. And no current callers want to do
that (and again, the solution is probably a flag in the transport code
to keep things open, which can be added later).

There's no test here, as the situation it covers is inherently racy (the
question is when upload-pack exits, compared to when index-pack finishes
resolving deltas and exits). The rather gross shell snippet below does
recreate the problematic situation; when run on a sufficiently-large
repository (git.git works fine), it kills an "idle" upload-pack while
the client is resolving deltas, leading to a failed clone.

-- >8 --
(
	git clone --no-local --progress . foo.git 2>&1
	echo >&2 "clone exit code=$?"
) |
tr '\r' '\n' |
while read line
do
	case "$done,$line" in
	,Resolving*)
		echo "hit resolving deltas; killing upload-pack"
		killall -9 git-upload-pack
		done=t
		;;
	esac
done
-- >8 --

Reported-by: Greg Pflaum <greg.pflaum@pnp-hcl.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 fetch-pack.c | 9 +++++++++
 transport.c  | 6 ++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index c135635e34..b0c7be717c 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1645,6 +1645,15 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			if (process_section_header(&reader, "packfile-uris", 1))
 				receive_packfile_uris(&reader, &packfile_uris);
 			process_section_header(&reader, "packfile", 0);
+
+			/*
+			 * this is the final request we'll make of the server;
+			 * do a half-duplex shutdown to indicate that they can
+			 * hang up as soon as the pack is sent.
+			 */
+			close(fd[1]);
+			fd[1] = -1;
+
 			if (get_pack(args, fd, pack_lockfiles,
 				     packfile_uris.nr ? &index_pack_args : NULL,
 				     sought, nr_sought, &fsck_options.gitmodules_found))
diff --git a/transport.c b/transport.c
index 6cf3da19eb..50f5830eb6 100644
--- a/transport.c
+++ b/transport.c
@@ -427,7 +427,8 @@ static int fetch_refs_via_pack(struct transport *transport,
 
 cleanup:
 	close(data->fd[0]);
-	close(data->fd[1]);
+	if (data->fd[1] >= 0)
+		close(data->fd[1]);
 	if (finish_connect(data->conn))
 		ret = -1;
 	data->conn = NULL;
@@ -869,7 +870,8 @@ static int disconnect_git(struct transport *transport)
 		if (data->got_remote_heads && !transport->stateless_rpc)
 			packet_flush(data->fd[1]);
 		close(data->fd[0]);
-		close(data->fd[1]);
+		if (data->fd[1] >= 0)
+			close(data->fd[1]);
 		finish_connect(data->conn);
 	}
 
-- 
2.32.0.rc0.424.g95d3bde94f

