Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EABCC433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 16:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B83B60FD7
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 16:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbhJKQnh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:43:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:37054 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhJKQng (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 12:43:36 -0400
Received: (qmail 29213 invoked by uid 109); 11 Oct 2021 16:41:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 11 Oct 2021 16:41:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20028 invoked by uid 111); 11 Oct 2021 16:41:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Oct 2021 12:41:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 11 Oct 2021 12:41:35 -0400
From:   Jeff King <peff@peff.net>
To:     Rob Browning <rlb@defaultvalue.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] signature-format.txt: add space to fix gpgsig
 continuation line
Message-ID: <YWRpPw4eTwTmgVvC@coredump.intra.peff.net>
References: <20211009163338.2175170-1-rlb@defaultvalue.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211009163338.2175170-1-rlb@defaultvalue.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 09, 2021 at 11:33:38AM -0500, Rob Browning wrote:

> Add a space to the blank line after the version header in the example
> gpgsig commit header.

Thanks, this is a good catch. The space is important for the header
continuation.

> diff --git a/Documentation/technical/signature-format.txt b/Documentation/technical/signature-format.txt
> index 2c9406a56a..6acc0b1247 100644
> --- a/Documentation/technical/signature-format.txt
> +++ b/Documentation/technical/signature-format.txt
> @@ -78,7 +78,7 @@ author A U Thor <author@example.com> 1465981137 +0000
>  committer C O Mitter <committer@example.com> 1465981137 +0000
>  gpgsig -----BEGIN PGP SIGNATURE-----
>   Version: GnuPG v1
> -
> + 
>   iQEcBAABAgAGBQJXYRjRAAoJEGEJLoW3InGJ3IwIAIY4SA6GxY3BjL60YyvsJPh/
>   HRCJwH+w7wt3Yc/9/bW2F+gF72kdHOOs2jfv+OZhq0q4OAN6fvVSczISY/82LpS7
>   DVdMQj2/YcHDT4xrDNBnXnviDO9G7am/9OE77kEbXrp7QPxvhjkicHNwy2rEflAA

The patch is quite subtle to read, of course. :) But more importantly,
it is subtle for somebody reading the documentation to notice. Perhaps
it's worth calling it out explicitly? E.g., squashing in something like:

diff --git a/Documentation/technical/signature-format.txt b/Documentation/technical/signature-format.txt
index 6acc0b1247..f418431050 100644
--- a/Documentation/technical/signature-format.txt
+++ b/Documentation/technical/signature-format.txt
@@ -68,7 +68,9 @@ signed tag message body
 - created by: `git commit -S`
 - payload: commit object
 - embedding: header entry `gpgsig`
-  (content is preceded by a space)
+  (content is preceded by a space; note that this includes the
+   "empty" line between the GnuPG header and signature, which
+   consists of a single space).
 - example: commit with subject `signed commit`
 
 ----

>  While investigating this (while parsing commit objects) I also
>  noticed a commit in a repo that had a blank continuation line (" \n")
>  after the "END PGP SIGNATURE" line.
> 
>  Presuming that's valid, I suppose we could consider detailing any
>  additional specifications, i.e. what kind of trailing content a
>  parser should expect/ignore, etc.

It is valid. It looks like GitHub's signed-merges may do this. From our
perspective, we are not really defining what is valid content or not. We
take everything in the gpgsig header (including multiple lines connected
by space-continuation), and feed it to gpg. So if gpg is happy with it,
we are happy with it.

Thinking with a security hat on, it's possible this could lead to
confusion (say, if I include multiple signatures but some tools check
one and some the other). But I'd be hesitant to start adding
restrictions without even a plausible attack scenario.

-Peff
