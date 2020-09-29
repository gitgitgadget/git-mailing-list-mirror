Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB85C2D0A8
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 00:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 463F92184D
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 00:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgI2AmV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 20:42:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:43898 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725272AbgI2AmV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 20:42:21 -0400
Received: (qmail 6938 invoked by uid 109); 29 Sep 2020 00:42:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Sep 2020 00:42:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13639 invoked by uid 111); 29 Sep 2020 00:42:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Sep 2020 20:42:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 28 Sep 2020 20:42:20 -0400
From:   Jeff King <peff@peff.net>
To:     Nikita Leonov via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nikita Leonov <nykyta.leonov@gmail.com>
Subject: Re: [PATCH v2 1/3] credential.c: fix credential reading with regards
 to CR/LF
Message-ID: <20200929004220.GC898702@coredump.intra.peff.net>
References: <pull.710.git.git.1581688196706.gitgitgadget@gmail.com>
 <pull.710.v2.git.git.1601293224.gitgitgadget@gmail.com>
 <27f6400a21412d762b290a34a78ebe7296d36bf3.1601293224.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <27f6400a21412d762b290a34a78ebe7296d36bf3.1601293224.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 28, 2020 at 11:40:22AM +0000, Nikita Leonov via GitGitGadget wrote:

> From: Nikita Leonov <nykyta.leonov@gmail.com>
> 
> This fix makes using Git credentials more friendly to Windows users. In
> previous version it was unable to finish input correctly without
> configuration changes (tested in PowerShell, CMD, Cygwin).
> 
> We know credential filling should be finished by empty input, but the
> current implementation does not take into account CR/LF ending, and
> hence instead of the empty string we get '\r', which is interpreted as
> an incorrect string.
> 
> So this commit changes default reading function to a more Windows
> compatible reading function.

Unlike the credential-store file case, where we expect the data to be
URL-encoded anyway (and so any true "\r" in the data would not be found
in raw form), this means that the credential protocol can no longer
represent "\r" at the end of a value.

And we'd match "example.com\r" and "example.com" as the same (unlikely,
since carriage returns aren't allowed in hostnames, and curl will
complain about this). We'd also match "cert://some/path\r" and
"cert://some/path". Or "https://example.com/path\r" and its match, if
you have credential.useHTTPPath set.

That may be acceptable if it makes things more convenient. Those are all
pretty obscure cases, and I find it hard to believe an attacker could
hijack credentials using this (it implies that the only difference
between their malicious url and a known-good one is a trailing CR).

This part of the commit message confused me a little:

> We know credential filling should be finished by empty input, but the
> current implementation does not take into account CR/LF ending, and
> hence instead of the empty string we get '\r', which is interpreted as
> an incorrect string.

If all we care about is the empty line, and not data lines, then we
could do this:

diff --git a/credential.c b/credential.c
index efc29dc5e1..73143c5ed0 100644
--- a/credential.c
+++ b/credential.c
@@ -206,7 +206,7 @@ int credential_read(struct credential *c, FILE *fp)
 		char *key = line.buf;
 		char *value = strchr(key, '=');
 
-		if (!line.len)
+		if (!line.len || (line.len == 1 && line.buf[0] == '\r'))
 			break;
 
 		if (!value) {

without impacting the ability to send raw CR in the lines with actual
data. But I imagine that a trailing CR in all of the data would also
cause problems.

-Peff
