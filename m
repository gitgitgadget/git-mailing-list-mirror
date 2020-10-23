Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1BCC388F9
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 08:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14D0320795
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 08:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S460750AbgJWIs3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 04:48:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:40296 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S376016AbgJWIs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 04:48:28 -0400
Received: (qmail 27551 invoked by uid 109); 23 Oct 2020 08:48:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Oct 2020 08:48:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19463 invoked by uid 111); 23 Oct 2020 08:48:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Oct 2020 04:48:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Oct 2020 04:48:27 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 3/3] sideband: add defense against packets missing a
 band designator
Message-ID: <20201023084827.GE4012156@coredump.intra.peff.net>
References: <pull.753.git.1602600323973.gitgitgadget@gmail.com>
 <pull.753.v2.git.1603136142.gitgitgadget@gmail.com>
 <c61e560451c4d7f101a23acec69117ddac563330.1603136143.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c61e560451c4d7f101a23acec69117ddac563330.1603136143.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 19, 2020 at 07:35:42PM +0000, Johannes Schindelin via GitGitGadget wrote:

> diff --git a/pkt-line.c b/pkt-line.c
> index 657a702927..f72048f623 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -461,8 +461,10 @@ int recv_sideband(const char *me, int in_stream, int out)
>  	enum sideband_type sideband_type;
>  
>  	while (1) {
> -		len = packet_read(in_stream, NULL, NULL, buf, LARGE_PACKET_MAX,
> -				  0);
> +		int status = packet_read_with_status(in_stream, NULL, NULL, buf,
> +						     LARGE_PACKET_MAX, &len, 0);
> +		if (!len && status == PACKET_READ_NORMAL)
> +			BUG("missing band designator");
>  		if (!demultiplex_sideband(me, buf, len, 0, &scratch,
>  					  &sideband_type))

I also wonder if this status-check should be pushed down into
demultiplex_sideband() by passing "status", for two reasons:

  1. So we don't have to repeat it (though it isn't that big)

  2. The other half of this weirdness is that if we get an early EOF,
     we'll hit the "missing sideband designator" die() message. But
     that's not really what happened; we probably got a network hangup.
     And we could distinguish that case by checking for status ==
     PACKET_READ_EOF and provide a better message.

Something like this (completely untested):

diff --git a/sideband.c b/sideband.c
index 0a60662fa6..6ad15ed581 100644
--- a/sideband.c
+++ b/sideband.c
@@ -115,6 +115,7 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 #define DUMB_SUFFIX "        "
 
 int demultiplex_sideband(const char *me, char *buf, int len,
+			 enum packet_read_status status,
 			 int die_on_error,
 			 struct strbuf *scratch,
 			 enum sideband_type *sideband_type)
@@ -130,17 +131,29 @@ int demultiplex_sideband(const char *me, char *buf, int len,
 			suffix = DUMB_SUFFIX;
 	}
 
-	if (len == 0) {
-		*sideband_type = SIDEBAND_FLUSH;
-		goto cleanup;
-	}
-	if (len < 1) {
+	if (status == PACKET_READ_EOF) {
 		strbuf_addf(scratch,
-			    "%s%s: protocol error: no band designator",
+			    "%s%s: protocol error: eof while reading packet",
 			    scratch->len ? "\n" : "", me);
 		*sideband_type = SIDEBAND_PROTOCOL_ERROR;
 		goto cleanup;
 	}
+
+	if (len < 0)
+		BUG("negative length on non-eof packet read");
+
+	if (len == 0) {
+		if (status == PACKET_READ_NORMAL) {
+			strbuf_addf(scratch,
+				    "%s%s protocol error: no band designator",
+				    scratch->len ? "\n" : "", me);
+			*sideband_type = SIDEBAND_PROTOCOL_ERROR;
+		} else {
+			*sideband_type = SIDEBAND_FLUSH;
+		}
+		goto cleanup;
+	}
+
 	band = buf[0] & 0xff;
 	buf[len] = '\0';
 	len--;
