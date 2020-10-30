Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0148C00A89
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 04:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DFEA2151B
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 04:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgJ3EkP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 00:40:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:42096 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgJ3EkO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 00:40:14 -0400
Received: (qmail 3698 invoked by uid 109); 30 Oct 2020 04:40:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 30 Oct 2020 04:40:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17645 invoked by uid 111); 30 Oct 2020 04:40:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 30 Oct 2020 00:40:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 30 Oct 2020 00:40:12 -0400
From:   Jeff King <peff@peff.net>
To:     Daniel Duvall <dan@mutual.io>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] upload-pack: allow stateless client EOF just prior to
 haves
Message-ID: <20201030044012.GA3259692@coredump.intra.peff.net>
References: <1604022059-18527-1-git-send-email-dan@mutual.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1604022059-18527-1-git-send-email-dan@mutual.io>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 29, 2020 at 06:40:59PM -0700, Daniel Duvall wrote:

> During stateless packfile negotiation, it is normal behavior for
> stateless RPC clients (e.g. git-remote-curl) to send multiple
> upload-pack requests with the first containing only the
> wants/shallows/deepens/filters followed by a flush.

Hmm, is this normal? I'd expect it to send a "done" after the flush, and
indeed that's what happens if I try it. I see:

E.g., here's GIT_TRACE_CURL output from a v0 request (fetching into an
empty repo):

 Send data: 00a8want 4b379b7a1b97790f805c365b1e58b75b70d3d904 multi_ack_
 Send data: detailed no-done side-band-64k thin-pack ofs-delta deepen-si
 Send data: nce deepen-not agent=git/2.29.2.477.g2cec8aa0af.00000009done
 Send data: .
 Info: upload completely sent off: 181 out of 181 bytes

However, if I add --depth 1 to my fetch, I get:

  Send data: 00a8want 4b379b7a1b97790f805c365b1e58b75b70d3d904 multi_ack_
  Send data: detailed no-done side-band-64k thin-pack ofs-delta deepen-si
  Send data: nce deepen-not agent=git/2.29.2.477.g2cec8aa0af.000cdeepen 1
  Send data: 0000
  Info: upload completely sent off: 184 out of 184 bytes

Which maybe makes sense if we need the shallow response from the server
to determine the next step of the request. It doesn't matter for my
trivial case here (we end up resending the same request with a "done"
added), but I guess it could in other cases.

This client side code is in fetch-pack.c:

  static int find_common(struct fetch_negotiator *negotiator,
  [...]
  {
          [...]
          if (args->deepen) {
		  [...]
                  send_request(args, fd[1], &req_buf);
                  while (packet_reader_read(&reader) == PACKET_READ_NORMAL) {
                          if (skip_prefix(reader.line, "shallow ", &arg)) {
				[...etc...]
                  }
          } else if (!args->stateless_rpc)
                  send_request(args, fd[1], &req_buf);


and dates all the way back to 249b2004d8 (Smart fetch over HTTP: client
side, 2009-10-30). Curiously we don't send it in non-stateless-rpc mode,
even if we're shallow. So I'm a little puzzled why we need the response
first in the stateless case, as we start writing "have" lines at the
server whether before we get the shallow lines back from the server in
either case.

So I'm not entirely convinced there isn't a small bug lurking on the
client side here. Not one that produces a wrong answer, but one which
wastes an extra round trip to the server. I won't be at all surprised if
there is some subtle timing dependency here, though, and the extra
request really is necessary.

But even if it is a client-side bug, it has been in the wild for a long
time, and it may be worth having the server side handle this more
gracefully.

> When run in stateless mode, continuing on without first checking that
> the client request has reached EOF can result in a bad file descriptor
> during get_common_commits.

When you say "bad file descriptor" that makes me think we're getting
EBADF after trying to use a closed descriptor. But we'd die() as soon as
the pkt-line code tries to read and gets eof, right?

That's also worth fixing, but I want to make sure I understand the
problem completely. I think this part of the commit message would be a
good place to talk about the real-world effects:

  - the client doesn't care; by definition it has hung up at this point
    and will keep going with its next request

  - likewise, the server doesn't care in terms of its response; by
    definition it is stateless, so the next request the client makes
    will start fresh

  - it is annoying for server admins who get a bunch of useless logs
    with "remote end hung up unexpected", or if they are tracking exit
    codes from upload-pack

As somebody who has admin'd a busy git site, unexpected client network
drops are just a fact of life and you have to look past them in your
logs. But I still think it's worth keeping it as uncluttered as possible
and having upload-pack handle this without an error message.

> Instead, upload-pack should gently peek for an EOF between the sending
> of shallow/unshallow lines (followed by flush) and the reading of client
> haves. If the client has hung up at this point, exit normally.

Should we do this only if we saw a deepen line? From my reading of the
client code, that's the only thing that would cause this early request.
I don't know if there's any particular advantage to being more strict
here.

If we're _not_ going to be strict, then I actually wonder if we ought to
simply teach get_common_commits() that seeing an EOF is OK in stateless
mode, wherever it comes. It can't possibly impact the correctness of the
protocol conversation (since we're stateless and the client is gone),
but maybe it's useful if you're trying to count how often clients really
do hang up.

> --- /dev/null
> +++ b/t/t9904-upload-pack-stateless-timely-eof.sh

We usually try to group related tests by number. Maybe t5705 would be a
better spot? I also wondered if this could go into t5704, but its title
is "protocol violations". It's not clear to me yet if this is a
violation that happens to be mostly harmless, or something we need to be
doing. :)

> +test_expect_success 'upload-pack outputs flush and exits ok' '
> +	test_commit initial &&
> +	head=$(git rev-parse HEAD) &&
> +	hexsz=$(test_oid hexsz) &&
> +
> +	printf "%04xwant %s\n%04xshallow %s\n000ddeepen 1\n0000" \
> +		$(($hexsz + 10)) $head $(($hexsz + 13)) $head >request &&

We have a helper function that makes this a bit easier to read:

diff --git a/t/t9904-upload-pack-stateless-timely-eof.sh b/t/t9904-upload-pack-stateless-timely-eof.sh
index f8385a7ebd..1108401e8f 100755
--- a/t/t9904-upload-pack-stateless-timely-eof.sh
+++ b/t/t9904-upload-pack-stateless-timely-eof.sh
@@ -9,10 +9,13 @@ D=$(pwd)
 test_expect_success 'upload-pack outputs flush and exits ok' '
 	test_commit initial &&
 	head=$(git rev-parse HEAD) &&
-	hexsz=$(test_oid hexsz) &&
 
-	printf "%04xwant %s\n%04xshallow %s\n000ddeepen 1\n0000" \
-		$(($hexsz + 10)) $head $(($hexsz + 13)) $head >request &&
+	{
+		packetize "want $head" &&
+		packetize "shallow $head" &&
+		packetize "deepen 1" &&
+		printf "0000"
+	} >request &&
 
 	git upload-pack --stateless-rpc "$(pwd)" <request >actual &&
 

> +	git upload-pack --stateless-rpc "$(pwd)" <request >actual &&

You can just use "." here, which is a little shorter. It's not entirely
cosmetic; the difference between $PWD and $(pwd) on Windows always trips
me up, so I try to avoid using either whenever I can. ;)

It would be nice if we could test this through a real use of Git, but it
might not be worth the hassle. I guess we'd have to mine the apache logs
in one of our http test scripts to see if upload-pack failed. And I
guess if we _do_ change the client side to stop sending the extra
request but want to treat historical clients more gracefully, we'd still
need a manual test like this.

> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -1344,7 +1344,18 @@ void upload_pack(struct upload_pack_options *options)
>  				   PACKET_READ_DIE_ON_ERR_PACKET);

The actual fix looks correct to me, modulo the alternatives I raised
earlier.

This function only handles the v0 protocol. For v2, we end up in
upload_pack_v2(). But my reading of the client side do_fetch_pack_v2()
is that it _doesn't_ send this extra request. And a simple test seems to
confirm it. Which gives me further pause as to whether the extra request
is necessary for v0.


Well, that review ended up a bit longer than I had imagined. So let me
add what I should have said at the top: welcome to the Git list, and
thanks for looking into this issue. :)

-Peff
