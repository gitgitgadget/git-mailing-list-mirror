Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720A6C55179
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 07:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4283A20709
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 07:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507391AbgJ0HMY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 03:12:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:38244 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2507377AbgJ0HMY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 03:12:24 -0400
Received: (qmail 14221 invoked by uid 109); 27 Oct 2020 07:12:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Oct 2020 07:12:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15002 invoked by uid 111); 27 Oct 2020 07:12:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Oct 2020 03:12:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Oct 2020 03:12:22 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] sideband: diagnose more incoming packet anomalies
Message-ID: <20201027071222.GC3005508@coredump.intra.peff.net>
References: <pull.753.v2.git.1603136142.gitgitgadget@gmail.com>
 <pull.753.v3.git.1603728555.gitgitgadget@gmail.com>
 <20201027065250.GB3005508@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201027065250.GB3005508@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 27, 2020 at 02:52:50AM -0400, Jeff King wrote:

>   - we'll report an eof with a more detailed "protocol error: eof while
>     reading sideband packet", rather than the generic "the remote end
>     hung up unexpectedly"

I wasn't sure if "eof" was too jargon-y. This is probably a message
normal users are likely to see if the network drops out on them.

So I'm open to rewording suggestions. Or even dropping the eof bits
entirely. They do give us better flushing behavior:

>   - when we see an eof, we'll flush the sideband scratch buffer, which
>     may provide some hints from the remote about why they hung up
>     (though note we already flush on newlines, so it's likely that most
>     such messages already made it through)

But I suspect that's uncommon in practice.

>  t/t0070-fundamental.sh | 12 ++++++++++++

I added this to t0070 since that's where your earlier test went. It does
feel like this isn't quite as "fundamental" as some of the other things
in that file, though.

> +test_expect_success 'missing sideband designator is reported' '
> +	printf 0004 >input &&
> +	test-tool pkt-line receive-sideband <input 2>err &&
> +	test_i18ngrep "missing sideband" err
> +'

I found it much more straight-forward to just printf the sample input,
rather than writing C code to create it, as your test did. It keeps the
input and expectation together, and makes them easier to extend or
change.

I wonder if it's worth doing this:

 t/helper/test-pkt-line.c | 16 ----------------
 t/t0070-fundamental.sh   |  7 ++++++-
 t/test-lib-functions.sh  | 12 +++++++++++-
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/t/helper/test-pkt-line.c b/t/helper/test-pkt-line.c
index 5e638f0b97..0615833bec 100644
--- a/t/helper/test-pkt-line.c
+++ b/t/helper/test-pkt-line.c
@@ -84,20 +84,6 @@ static void unpack_sideband(void)
 	}
 }
 
-static int send_split_sideband(void)
-{
-	const char *part1 = "Hello,";
-	const char *primary = "\001primary: regular output\n";
-	const char *part2 = " world!\n";
-
-	send_sideband(1, 2, part1, strlen(part1), LARGE_PACKET_MAX);
-	packet_write(1, primary, strlen(primary));
-	send_sideband(1, 2, part2, strlen(part2), LARGE_PACKET_MAX);
-	packet_response_end(1);
-
-	return 0;
-}
-
 static int receive_sideband(void)
 {
 	return recv_sideband("sideband", 0, 1);
@@ -114,8 +100,6 @@ int cmd__pkt_line(int argc, const char **argv)
 		unpack();
 	else if (!strcmp(argv[1], "unpack-sideband"))
 		unpack_sideband();
-	else if (!strcmp(argv[1], "send-split-sideband"))
-		send_split_sideband();
 	else if (!strcmp(argv[1], "receive-sideband"))
 		receive_sideband();
 	else
diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index 936030a5ef..f9fda8d610 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -35,7 +35,12 @@ test_expect_success 'check for a bug in the regex routines' '
 '
 
 test_expect_success 'incomplete sideband messages are reassembled' '
-	test-tool pkt-line send-split-sideband >split-sideband &&
+	{
+		packetize -2 "Hello," &&
+		packetize -1 "primary: regular output" &&
+		packetize -2 " world!" &&
+		printf 0000
+	} >split-sideband &&
 	test-tool pkt-line receive-sideband <split-sideband 2>err &&
 	grep "Hello, world" err
 '
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 8d59b90348..c90ea61747 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1427,10 +1427,20 @@ nongit () {
 # given on stdin, and that empty input becomes an empty packet, not a flush
 # packet (for that you can just print 0000 yourself).
 packetize() {
+	band=
+	bandlen=0
+	case "$1" in
+	-[123])
+		band="\\${1#-}"
+		bandlen=1
+		shift
+		;;
+	esac
+
 	if test $# -gt 0
 	then
 		packet="$*"
-		printf '%04x%s' "$((4 + ${#packet}))" "$packet"
+		printf "%04x$band%s" "$((4 + $bandlen + ${#packet}))" "$packet"
 	else
 		perl -e '
 			my $packet = do { local $/; <STDIN> };

Teaching packetize() about bands isn't strictly necessary (we could
printf the band designators ourselves and pipe it into packetize(); that
would also add the missing newlines, though those do not matter for this
test).

-Peff
