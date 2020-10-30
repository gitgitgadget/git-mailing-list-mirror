Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED08CC56201
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 09:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93ED1206DB
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 09:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgJ3JJG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 05:09:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:42162 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbgJ3JJE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 05:09:04 -0400
Received: (qmail 5628 invoked by uid 109); 30 Oct 2020 09:09:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 30 Oct 2020 09:09:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18742 invoked by uid 111); 30 Oct 2020 09:09:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 30 Oct 2020 05:09:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 30 Oct 2020 05:09:02 -0400
From:   Jeff King <peff@peff.net>
To:     Daniel Duvall <dan@mutual.io>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] upload-pack: allow stateless client EOF just prior to
 haves
Message-ID: <20201030090902.GA3268509@coredump.intra.peff.net>
References: <1604022059-18527-1-git-send-email-dan@mutual.io>
 <20201030044012.GA3259692@coredump.intra.peff.net>
 <CANo+1gv0otfjRexAVW6E+yPEvGLo55_tQWN-81mQMm4U0seCJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANo+1gv0otfjRexAVW6E+yPEvGLo55_tQWN-81mQMm4U0seCJQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 30, 2020 at 12:47:29AM -0700, Daniel Duvall wrote:

> >   - the client doesn't care; by definition it has hung up at this point
> >     and will keep going with its next request
> 
> That's true in the case where the server doesn't surface the non-zero
> exit code from git-upload-pack—which results in git-http-backend
> existing non-zero as well. An apache setup I used in testing doesn't
> seem to care about the failure—it responds 200 and so the client is
> happy—but in our (dayjob) case, we're running a Phabricator instance
> which handles a non-zero exit from git-http-backend by responding 500,
> and the client dies.
> 
> $ git fetch --depth 1
> https://phabricator.wikimedia.org/source/phabricator.git HEAD
> error: RPC failed; HTTP 500 curl 22 The requested URL returned error: 500
> fatal: the remote end hung up unexpectedly

Thanks, that's a really helpful data point. The flaw in my reasoning is
that the client connection is bidirectional: just because the client
hung up does not mean they are not still listening to the remainder of
what the server has to say.

It sounds like Phabricator should probably be ignoring the exit code
from http-backend. Or at least doing so when the CGI managed to produce
an HTTP status code, and assuming that Git's response was either
well-formed, or that the client will realize it was broken. (Or possibly
http-backend should be less eager to pass along a non-zero exit code,
but it amounts to the same thing).

But regardless, we should make sure that upload-pack is doing the right
thing at least for this case.

> > If we're _not_ going to be strict, then I actually wonder if we ought to
> > simply teach get_common_commits() that seeing an EOF is OK in stateless
> > mode, wherever it comes. It can't possibly impact the correctness of the
> > protocol conversation (since we're stateless and the client is gone),
> > but maybe it's useful if you're trying to count how often clients really
> > do hang up.
> 
> I originally took that approach, but gently handling an EOF in the
> get_common_commits loop resulted in a NAK being sent back because of:
> 
>                 if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
>                         [...]
>                         if (data->have_obj.nr == 0 || data->multi_ack)
>                                 packet_write_fmt(1, "NAK\n");
>                         [...]
>                         if (data->stateless_rpc)
>                                 exit(0);
>                         [...]
>                 }
> 
> which the client died on with an "expected shallow list" message. I
> didn't see a straightforward way of modifying the conditions _inside_
> the loop while ensuring I wasn't changing any expected behavior upon
> EOF.

I was thinking something more like:

diff --git a/upload-pack.c b/upload-pack.c
index 2b128e4ad8..f6d3ef3e13 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -520,10 +520,18 @@ static int get_common_commits(struct upload_pack_data *data,
 
 	for (;;) {
 		const char *arg;
+		enum packet_read_status status;
 
 		reset_timeout(data->timeout);
 
-		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
+		status = packet_reader_read(reader);
+		if (status == PACKET_READ_EOF) {
+			if (data->stateless_rpc)
+				exit(0);
+			die("the remote end hung up unexpectedly");
+		}
+
+		if (status != PACKET_READ_NORMAL) {
 			if (data->multi_ack == MULTI_ACK_DETAILED
 			    && got_common
 			    && !got_other

But after reading the rest of your response, I think it probably does
make sense to be more strict here, and only handle the unexpected EOF
before entering get_common_commits(). I don't _think_ it should matter
to the client, because this whole "status != PACKET_READ_NORMAL" path
would never be entered with the current code (we'd die() when we see the
EOF inside packet_reader_read()).

> > This function only handles the v0 protocol. For v2, we end up in
> > upload_pack_v2(). But my reading of the client side do_fetch_pack_v2()
> > is that it _doesn't_ send this extra request. And a simple test seems to
> > confirm it. Which gives me further pause as to whether the extra request
> > is necessary for v0.
> 
> When I do a trace using v2, I see two roundtrip requests as well. I
> haven't tested the exit status of git-upload-pack in that case
> however. It's getting late for me but I'll investigate tomorrow.

There's an extra round-trip in v2: we probe for v2 and get the
capabilities in the initial request, then we get the ref advertisement,
then we start the object negotiation. In v0 the ref advertisement is
lumped into the initial response.

Here's what I see with:

  $ git init
  $ GIT_TRACE_CURL=$PWD/trace.out \
      git -c protocol.version=2 fetch --depth 1 \
      https://github.com/git/git master
  $ perl -lne '/(Send data:|Info: upload completely sent) .*/ and print $&' trace.out
  Send data: 0014command=ls-refs.0024agent=git/2.29.2.477.g2cec8aa0af0001
  Send data: 0009peel.000csymrefs.0016ref-prefix master.001bref-prefix re
  Send data: fs/master.0020ref-prefix refs/tags/master.0021ref-prefix ref
  Send data: s/heads/master.0023ref-prefix refs/remotes/master.0028ref-pr
  Send data: efix refs/remotes/master/HEAD.001aref-prefix refs/tags/.0000
  Info: upload completely sent off: 300 out of 300 bytes
  Send data: 0011command=fetch0024agent=git/2.29.2.477.g2cec8aa0af0001000
  Send data: dthin-pack000dofs-delta000cdeepen 10032want ad27df6a5cff694a
  Send data: dd500ab8c7f97234feb4a91f.0009done.0000
  Info: upload completely sent off: 158 out of 158 bytes

So the first one POST is getting the ref advertisement, and the second
one is the full negotiation request, including the "done".

I'm still uncertain whether it could all be done in one request for v0.
But one possible solution is: let's not care. If v2 does it correctly,
that's the future anyway (or present; it's now the default in v2.29).
And the change you're proposing in upload-pack would be desirable anyway
to help deal with older clients.

If that's the route we go, we should make sure the commit message
explains it.

-Peff
