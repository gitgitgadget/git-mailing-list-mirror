Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D09FC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 16:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 026F960EFE
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 16:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhHPQyJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 12:54:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:48584 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229803AbhHPQyI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 12:54:08 -0400
Received: (qmail 20656 invoked by uid 109); 16 Aug 2021 16:53:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 16 Aug 2021 16:53:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16090 invoked by uid 111); 16 Aug 2021 16:53:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Aug 2021 12:53:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Aug 2021 12:53:35 -0400
From:   Jeff King <peff@peff.net>
To:     "Russell, Scott" <Scott.Russell2@ncr.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git clone corrupts file.
Message-ID: <YRqYD+SszvhhySwl@coredump.intra.peff.net>
References: <BN6PR15MB1426E50F03A0530CA9140F98CBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <BN6PR15MB14261C40E614CC11416388B4CBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <BN6PR15MB14264C9A96F4B5F6B01FA7FACBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <YRbya0UO2+PvOjL5@camp.crustytoothpaste.net>
 <BN6PR15MB1426E99386269CCBDA888D51CBFD9@BN6PR15MB1426.namprd15.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN6PR15MB1426E99386269CCBDA888D51CBFD9@BN6PR15MB1426.namprd15.prod.outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 16, 2021 at 03:24:28PM +0000, Russell, Scott wrote:

> 1.  The files corrupted are in Unicode.   Though the .h file mentioned
>     certainly doesn't have to be Unicode, it can be ANSI, we have
>     other files that must be Unicode.  We use Unicode in quite a
>     number of our text files.

By Unicode, I'll assume you mean UTF-16, since your example below
appears to have a BOM marker at the beginning (FF FE).

Unlike UTF-8, UTF-16 is not a superset of ASCII, and thus can't be
treated as "text" by Git (e.g., the line ending byte is no longer just
hex "0A", but "00 0A").

>           f.    Entries in .gitattributes specified by type are specified for the affected files. 
>                         *.h     text eol=crlf
>                         *.ini   text eol=crlf

So this is your problem. The "text" attribute is telling Git to treat
the file as text (which will handle any ASCII-superset encoding like
UTF-8, ISO8859-1, etc, but not others like UTF-16, UTF-32, EUC-JP, etc).

Depending on what's in your repo and what you want to have happen,
you'll want to:

  - remove that attribute, if all of your ".h" files are UTF-16

  - if only some are UTF-16, you'll need to provide patterns that
    distinguish between the two types by giving them different
    attributes (e.g., "-text" should override for specific files)

  - you can stop there if you don't need line-ending conversion for
    UTF-16 files (and there may be little point; Git will treat them as
    binary for the purposes of diffing, so there is little point in
    matching the canonical in-repo endings)

  - if you do want to do line ending conversion (or any other
    modifications on them), you can do so with a custom clean/smudge
    filter (see the "filter" attribute in "git help attributes")

> I would like git to observe the autocrlf false as directed.

Hopefully the above explains it, but just to be clear, this isn't
autocrlf kicking in, but rather the "text" and "eol" attributes you've
specified.

> We can't convert the files to other encoding for convenience of git.

If you're happy enough not being able to get meaningful text diffs for
these files from Git, then the above should make your problem go away.

But an alternative workflow, if you really want UTF-16 in the working
tree, is to convert between UTF-8 and UTF-16 as the files go in and out
o the working tree. There's no built-in support for that, but you could
do it with a custom clean/smudge filter. That would let Git store UTF-8
internally, do diffs, etc.

One lighter alternative to that is to actually store UTF-16 in the
repository as you are now, but provide a textconv filter (see diff
attributes in "git help attributes") to convert it to UTF-8 on the fly
when showing a diff. You won't be able to apply such a diff, but they're
useful for human eyes.

-Peff
