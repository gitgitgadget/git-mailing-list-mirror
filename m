Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C02C433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 09:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 903FD64DDE
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 09:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbhBBJtn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 04:49:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:44244 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229849AbhBBJt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 04:49:28 -0500
Received: (qmail 12696 invoked by uid 109); 2 Feb 2021 09:48:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Feb 2021 09:48:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 541 invoked by uid 111); 2 Feb 2021 09:48:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Feb 2021 04:48:45 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 2 Feb 2021 04:48:44 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 04/14] pkt-line: optionally skip the flush packet in
 write_packetized_from_buf()
Message-ID: <YBkf/KOv+YBZ5hQF@coredump.intra.peff.net>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
 <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
 <0832f7d324da643d7a480111d693ff5559c2b7a7.1612208747.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0832f7d324da643d7a480111d693ff5559c2b7a7.1612208747.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 01, 2021 at 07:45:37PM +0000, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> This function currently has only one caller: `apply_multi_file_filter()`
> in `convert.c`. That caller wants a flush packet to be written after
> writing the payload.
> 
> However, we are about to introduce a user that wants to write many
> packets before a final flush packet, so let's extend this function to
> prepare for that scenario.

I think this is a sign that the function is not very well-designed in
the first place. It seems like the code would be easier to understand
overall if that caller just explicitly did the flush itself. It even
already does so in other cases!

Something like (untested):

 convert.c  | 4 ++++
 pkt-line.c | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/convert.c b/convert.c
index ee360c2f07..3968ac37b9 100644
--- a/convert.c
+++ b/convert.c
@@ -890,6 +890,10 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	if (err)
 		goto done;
 
+	err = packet_flush_gently(process->in);
+	if (err)
+		goto done;
+
 	err = subprocess_read_status(process->out, &filter_status);
 	if (err)
 		goto done;
diff --git a/pkt-line.c b/pkt-line.c
index d633005ef7..014520a9c2 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -256,8 +256,6 @@ int write_packetized_from_fd(int fd_in, int fd_out)
 			break;
 		err = packet_write_gently(fd_out, buf, bytes_to_write);
 	}
-	if (!err)
-		err = packet_flush_gently(fd_out);
 	return err;
 }
 
@@ -277,8 +275,6 @@ int write_packetized_from_buf(const char *src_in, size_t len, int fd_out)
 		err = packet_write_gently(fd_out, src_in + bytes_written, bytes_to_write);
 		bytes_written += bytes_to_write;
 	}
-	if (!err)
-		err = packet_flush_gently(fd_out);
 	return err;
 }
 

-Peff
