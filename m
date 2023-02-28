Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43A6C64EC7
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 21:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjB1VbA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 16:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjB1Va7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 16:30:59 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C32305EB
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 13:30:57 -0800 (PST)
Received: (qmail 454 invoked by uid 109); 28 Feb 2023 21:30:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Feb 2023 21:30:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30852 invoked by uid 111); 28 Feb 2023 21:30:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Feb 2023 16:30:56 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Feb 2023 16:30:55 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Danny Smit <danny.smit.0@gmail.com>, git@vger.kernel.org
Subject: Re: gitattributesLarge: .gitattributes too large to parse
Message-ID: <Y/5yj8uAEM3Pz7T7@coredump.intra.peff.net>
References: <CACoz=-x6kVGMq1oCq8-5k2Hb82DCqi94_EmX6w4_9uGXnwBLaQ@mail.gmail.com>
 <Y/5SyNUbVfKFMxsf@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/5SyNUbVfKFMxsf@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 28, 2023 at 02:15:20PM -0500, Taylor Blau wrote:

> On Tue, Feb 28, 2023 at 05:09:01PM +0100, Danny Smit wrote:
> > I couldn't find a lot of documentation about the size limitations of
> > the .gitattributes file, but I did find the change that seems to have
> > introduced it: https://github.com/git/git/commit/27ab4784d5c9e24345b9f5b443609cbe527c51f9
> > The change describes that the file needs to be smaller than 100MB, which it is.
> 
> It's interesting that you can cause `fsck` to produce an error in the
> bare repository but not in the non-bare one. Do you have
> `fsck.gitattributesLarge` set to anything in the non-bare repository?
> Are the affected objects in the `fsck.skipList`?
> 
> Looking at 27ab4784d5, the comment there says:
> 
>     if (!buf || size > ATTR_MAX_FILE_SIZE) {
>       /*
>        * A missing buffer here is a sign that the caller found the
>        * blob too gigantic to load into memory. Let's just consider
>        * that an error.
>        */
>       return report(options, oid, OBJ_BLOB,
>                     FSCK_MSG_GITATTRIBUTES_LARGE,
>                     ".gitattributes too large to parse");
>     }
> 
> ...so it's possible that the caller indeed found the blob too large to
> load into memory, which would cause us to emit the ".gitattributes too
> large to parse" fsck error without a .gitattributes file that actually
> exceeds 100 MiB in size.

I think that "!buf" case would also trigger if the size exceeded
core.bigFileThreshold. It might be worth checking for that, too.

-Peff
