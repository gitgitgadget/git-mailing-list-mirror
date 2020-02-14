Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7D9C2BA83
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 18:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F40D2086A
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 18:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbgBNScB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:32:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:43814 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729448AbgBNScB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 13:32:01 -0500
Received: (qmail 23113 invoked by uid 109); 14 Feb 2020 18:32:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Feb 2020 18:32:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23929 invoked by uid 111); 14 Feb 2020 18:40:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Feb 2020 13:40:58 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Feb 2020 13:32:00 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nikita Leonov <nykyta.leonov@gmail.com>
Subject: Re: [PATCH] credential.c: fix credential reading with regards to
 CR/LF
Message-ID: <20200214183200.GP150965@coredump.intra.peff.net>
References: <pull.710.git.git.1581688196706.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.710.git.git.1581688196706.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 14, 2020 at 01:49:56PM +0000, Johannes Schindelin via GitGitGadget wrote:

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

This does make it impossible to have a CR at the end of a data value. I
think that should be OK (we already disallow LF with no mechanism for
quoting, because who the hell puts a LF in their password?).

But we should perhaps update the section in git-credential(1) that
describes the rules. I had trouble coming up with a wording that wasn't
totally awkward, though:

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index 6f0c7ca80f..09e4b58321 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -112,7 +112,9 @@ specified by a key-value pair, separated by an `=` (equals) sign,
 followed by a newline. The key may contain any bytes except `=`,
 newline, or NUL. The value may contain any bytes except newline or NUL.
 In both cases, all bytes are treated as-is (i.e., there is no quoting,
-and one cannot transmit a value with newline or NUL in it). The list of
+and one cannot transmit a value with newline or NUL in it). Note that
+Git will treat a carriage return before the final newline as part of
+line ending, and not part of the data. The list of
 attributes is terminated by a blank line or end-of-file.
 Git understands the following attributes:
 

This is talking about the git-credential tool itself, but the actual
helper protocol documentation links to this. (As an aside, I notice that
the protocol documentation recently got moved into credential.h along
with the C API bits. Yuck. That probably should be in
gitcredentials(7)).

-Peff
