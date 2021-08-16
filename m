Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FF4C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 18:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 389F060F35
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 18:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhHPSt5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 14:49:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:48772 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230273AbhHPSt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 14:49:56 -0400
Received: (qmail 22503 invoked by uid 109); 16 Aug 2021 18:49:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 16 Aug 2021 18:49:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17291 invoked by uid 111); 16 Aug 2021 18:49:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Aug 2021 14:49:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Aug 2021 14:49:23 -0400
From:   Jeff King <peff@peff.net>
To:     "Russell, Scott" <Scott.Russell2@ncr.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git clone corrupts file.
Message-ID: <YRqzM1D6w4bDYjKY@coredump.intra.peff.net>
References: <BN6PR15MB1426E50F03A0530CA9140F98CBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <BN6PR15MB14261C40E614CC11416388B4CBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <BN6PR15MB14264C9A96F4B5F6B01FA7FACBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <YRbya0UO2+PvOjL5@camp.crustytoothpaste.net>
 <BN6PR15MB1426E99386269CCBDA888D51CBFD9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <YRqYD+SszvhhySwl@coredump.intra.peff.net>
 <BN6PR15MB1426D70E338F6B2A988565A9CBFD9@BN6PR15MB1426.namprd15.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN6PR15MB1426D70E338F6B2A988565A9CBFD9@BN6PR15MB1426.namprd15.prod.outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 16, 2021 at 05:39:12PM +0000, Russell, Scott wrote:

> We don't want any EOL handling of any file.  That's why we specify autocrlf false.

Right, but it's not the whole story. autocrlf is an older and broader
mechanism for doing line-ending conversion. From its documentation in
"git help config":

  core.autocrlf
    Setting this variable to "true" is the same as setting the text
    attribute to "auto" on all files and core.eol to "crlf".[...]

You obviously don't want that, but you _also_ don't want to set the text
and eol attributes on individual paths, either.

> We would like git to not any cr lf conversion on any file.   Whether
> they be ANSI or Unicode.   They had the right endings when we checked
> them in.
> We don't want them adjusted.
> 
> Does removing the eol = cr lf fix that?

That might be sufficient. You may also need to drop "text", as well.
Otherwise core.eol will kick in and do conversions. (Sorry, I don't use
Windows and it has been a long time since I looked into these options,
so you may have to do some experimenting).

> 	You said:  UTF-16 ...  can't be treated as "text" by Git.
> 
> We can't make any changes to the files to suit git.   We just need git to store and retrieve files as committed.

Right. That's what it does by default (if you don't set any .gitattributes).

What I mean by "can't be treated as text" is that Git will not correctly
implement text features like CRLF conversion, nor diffs, for such an
encoding. It is effectively a binary file from Git's perspective.

> Will removing the 
> 
> 	eol=cr lf 
> 
> from the line 
> 
> *.ini text 
> 
> from the attributes file stop the issue?
> 
> If not, does .gitattributes allow a path?  Such that we could say 
> 
> \config\Language Specific\*   type  -    If these are Unicode, what would we say here.   Can it not be text?  Then binary?  
> *.ini	text

If you simply drop the attributes entirely, Git will use its
auto-detection to determine whether a file is binary, which looks for
NULs (and UTF-16 files are generally full of them). So I suspect that
would do it. You can also provide the "-text" attribute to override that
and make sure no line-ending conversion is done.

If you want to override a specific file, then yes, you can provide paths
(I don't recall offhand whether we allow backslashes in the patterns;
you may need to use forward slashes). You can also put the pattern "*"
in the "config/Language Specific/.gitattributes" to have it apply only
to that directory (and ones below it).

The patterns are the same as those in .gitignore files; see the section
"PATTERN FORMAT" in "git help ignore".

-Peff
