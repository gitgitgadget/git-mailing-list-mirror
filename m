Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB826C433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 17:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1730207FB
	for <git@archiver.kernel.org>; Mon, 18 May 2020 17:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgERR0R (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 13:26:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:49908 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726958AbgERR0R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 13:26:17 -0400
Received: (qmail 20681 invoked by uid 109); 18 May 2020 17:26:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 18 May 2020 17:26:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4280 invoked by uid 111); 18 May 2020 17:26:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 May 2020 13:26:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 18 May 2020 13:26:05 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Force Charlie <charlieio@outlook.com>
Subject: Re: [PATCH v2 7/7] stateless-connect: send response end packet
Message-ID: <20200518172605.GA52384@coredump.intra.peff.net>
References: <cover.1589393036.git.liu.denton@gmail.com>
 <cover.1589816718.git.liu.denton@gmail.com>
 <4b079bcd83ea80b8a0e81b0c1e3d5e083efeb9c6.1589816719.git.liu.denton@gmail.com>
 <20200518164308.GC42240@coredump.intra.peff.net>
 <20200518171249.GA2462058@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200518171249.GA2462058@generichostname>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 18, 2020 at 01:12:49PM -0400, Denton Liu wrote:

> > I just wonder if there is a better place to put this logic that would be
> > more certain to catch every place we'd expect to read to the end of a
> > response. But I suppose not. We could push it down into process_acks(),
> > but it would have the same READY logic that's here. I'll admit part of
> > my complaint is that the existing do_fetch_pack_v2 state-machine switch
> > is kind of hard to follow, but that's not your fault.
> 
> I debated between the current implementation and doing something like
> 
> 	int first_iteration = 1;
> 
> 	...
> 
> 	while (state != FETCH_DONE) {
> 		switch (...) {
> 			...
> 		}
> 
> 		if (args->stateless_rpc && !first_iteration && (state == FETCH_SEND_REQUEST || state == FETCH_DONE)) {
> 			if (packet_reader_read(&reader) != PACKET_READ_RESPONSE_END)
> 				die(_("git fetch-pack: expected response end packet"));
> 			if (packet_reader_read(&reader) != PACKET_READ_FLUSH)
> 				die(_("git fetch-pack: expected flush packet"));
> 		}
> 		first_iteration = 0;
> 	}
> 
> I think that this catches _all_ the cases without fiddling with any of
> the state machine logic.

I think you're right that it does, but TBH I find it harder to follow,
because now we're even further away from the actual response reads. What
I most want to verify is:

  - there is no response-reading code path that does not check the
    delimiters

  - there is no code path where we check delimiters but did not actually
    read a response

So to me, putting the check as close to the response-reads as possible
makes sense. I think the patch below is equivalent and easier to verify,
but I admit it's somewhat subjective:

diff --git a/fetch-pack.c b/fetch-pack.c
index 5325649eda..0bf1e5760c 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1443,6 +1443,17 @@ static void receive_wanted_refs(struct packet_reader *reader,
 		die(_("error processing wanted refs: %d"), reader->status);
 }
 
+static void check_stateless_delimiter(struct fetch_pack_args *args,
+				      struct packet_reader *reader)
+{
+	if (!args->stateless_rpc)
+		return; /* not in stateless mode, no delimiter expected */
+	if (packet_reader_read(reader) != PACKET_READ_RESPONSE_END)
+		die(_("git fetch-pack: expected response end packet"));
+	if (packet_reader_read(reader) != PACKET_READ_FLUSH)
+		die(_("git fetch-pack: expected flush packet"));
+}
+
 enum fetch_state {
 	FETCH_CHECK_LOCAL = 0,
 	FETCH_SEND_REQUEST,
@@ -1469,7 +1480,6 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	struct fetch_negotiator negotiator_alloc;
 	struct fetch_negotiator *negotiator;
 	int seen_ack = 0;
-	int check_http_delimiter;
 
 	if (args->no_dependents) {
 		negotiator = NULL;
@@ -1488,8 +1498,6 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	}
 
 	while (state != FETCH_DONE) {
-		check_http_delimiter = 0;
-
 		switch (state) {
 		case FETCH_CHECK_LOCAL:
 			sort_ref_list(&ref, ref_compare_name);
@@ -1538,15 +1546,19 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			/* Process ACKs/NAKs */
 			switch (process_acks(negotiator, &reader, &common)) {
 			case READY:
+				/*
+				 * Don't check for response delimiter; get_pack() will
+				 * read the rest of this response.
+				 */
 				state = FETCH_GET_PACK;
 				break;
 			case COMMON_FOUND:
 				in_vain = 0;
 				seen_ack = 1;
 				/* fallthrough */
 			case NO_COMMON_FOUND:
 				state = FETCH_SEND_REQUEST;
-				check_http_delimiter = 1;
+				check_stateless_delimiter(args, &reader);
 				break;
 			}
 			break;
@@ -1565,20 +1577,13 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			process_section_header(&reader, "packfile", 0);
 			if (get_pack(args, fd, pack_lockfile, sought, nr_sought))
 				die(_("git fetch-pack: fetch failed."));
+			check_stateless_delimiter(args, &reader);
 
 			state = FETCH_DONE;
-			check_http_delimiter = 1;
 			break;
 		case FETCH_DONE:
 			continue;
 		}
-
-		if (args->stateless_rpc && check_http_delimiter) {
-			if (packet_reader_read(&reader) != PACKET_READ_RESPONSE_END)
-				die(_("git fetch-pack: expected response end packet"));
-			if (packet_reader_read(&reader) != PACKET_READ_FLUSH)
-				die(_("git fetch-pack: expected flush packet"));
-		}
 	}
 
 	if (negotiator)

> > Speaking of which: this is a change to the remote-helper protocol, since
> > we're now expecting stateless-connect helpers to produce these delim
> > packets (and failing if they don't). I kind of doubt that anybody but
> > remote-curl has implemented v2 stateless-connect, but should we be
> > marking this with an extra capability to be on the safe side?
> 
> I think that we're probably safe from breaking anything external.
> According to the gitremote-helpers documentation, 
> 
> 	'stateless-connect'::
> 		Experimental; for internal use only.
> 
> so I think that gives us a bit of leeway in terms of the changes we can
> make to the stateless-connect protocol. They've been warned ;)

OK, I didn't realize we had explicitly marked it as experimental. I
agree we're probably fine here, then (now that v2 is starting to settle
a bit more, we might think about lifting that warning, but this patch
series shows we're not quite there yet :) ).

-Peff
