Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5683BC4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 05:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332F52072D
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 05:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgCTFax (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 01:30:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:44724 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725883AbgCTFax (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 01:30:53 -0400
Received: (qmail 30963 invoked by uid 109); 20 Mar 2020 05:30:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Mar 2020 05:30:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2941 invoked by uid 111); 20 Mar 2020 05:40:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Mar 2020 01:40:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 20 Mar 2020 01:30:52 -0400
From:   Jeff King <peff@peff.net>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/6] fix test failure with busybox
Message-ID: <20200320053052.GC499858@coredump.intra.peff.net>
References: <cover.1584625896.git.congdanhqx@gmail.com>
 <20200319155136.GA3513282@coredump.intra.peff.net>
 <20200320003715.GA1858@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200320003715.GA1858@danh.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 20, 2020 at 07:37:15AM +0700, Danh Doan wrote:

> > The issue in t5703 is the sed call in get_actual_commits(). It's trying
> > to cut off the early (text) part of the file, and pass through the
> > binary goo of the packfile. Presumably busybox's sed isn't binary-clean.
> 
> I've checked, busybox's sed think every input is text file,
> and in POSIX, every line in every text file must be terminated by
> <newline>.
> 
> Thus, busybox's sed append a <newline> after `0000` marker, render the
> pack file invalid.

Ah, thanks for tracking it down.

> > We're also feeding this into a test-tool helper. It's possible that
> > helper could be made smart enough to replace both this sed invocation
> > and the one in get_actual_refs().
> 
> I looked into this direction, I guess you meant something like this:
> [...]
> @@ -53,6 +54,13 @@ static void unpack(void)
>  static void unpack_sideband(void)
>  {
>  	struct packet_reader reader;
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	while (strbuf_getline(&buf, stdin) == 0)
> +		if (strstr(buf.buf, "packfile"))
> +		    break;
> +	strbuf_release(&buf);
> +
>  	packet_reader_init(&reader, 0, NULL, 0,
>  			   PACKET_READ_GENTLE_ON_EOF |
>  			   PACKET_READ_CHOMP_NEWLINE);
> [...]
> But, this doesn't work. as `packet_reader_read` reads directly from fd 0.

You'd want to decode the packets first first, and then skip until after
you see the packet with "packfile" in it. Or to be more generic, just
wait until you see packets with actual sideband data. Something like the
patch below works (though I'm also fine with just switching to perl).

diff --git a/t/helper/test-pkt-line.c b/t/helper/test-pkt-line.c
index 282d536384..12ca698e17 100644
--- a/t/helper/test-pkt-line.c
+++ b/t/helper/test-pkt-line.c
@@ -67,7 +67,7 @@ static void unpack_sideband(void)
 		case PACKET_READ_NORMAL:
 			band = reader.line[0] & 0xff;
 			if (band < 1 || band > 2)
-				die("unexpected side band %d", band);
+				continue; /* skip non-sideband packets */
 			fd = band;
 
 			write_or_die(fd, reader.line + 1, reader.pktlen - 1);
diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index 7fba3063bf..a34460f7d8 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -13,10 +13,7 @@ get_actual_refs () {
 }
 
 get_actual_commits () {
-	sed -n -e '/packfile/,/0000/{
-		/packfile/d
-		p
-		}' <out | test-tool pkt-line unpack-sideband >o.pack &&
+	test-tool pkt-line unpack-sideband <out >o.pack &&
 	git index-pack o.pack &&
 	git verify-pack -v o.idx >objs &&
 	grep commit objs | cut -d" " -f1 | sort >actual_commits
