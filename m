Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D02EC432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 07:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F6B20898
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 07:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfKUH6i (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 02:58:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:56804 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725842AbfKUH6i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 02:58:38 -0500
Received: (qmail 10331 invoked by uid 109); 21 Nov 2019 07:58:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Nov 2019 07:58:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9187 invoked by uid 111); 21 Nov 2019 08:02:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Nov 2019 03:02:26 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 21 Nov 2019 02:58:37 -0500
From:   Jeff King <peff@peff.net>
To:     M Lewis <picevio@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: GitAttributes feature export-ignore works, but -export-ignore
 (with dash) should also work
Message-ID: <20191121075837.GA30966@sigill.intra.peff.net>
References: <01e0a4ab-d809-d968-5671-b731438c2bc4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01e0a4ab-d809-d968-5671-b731438c2bc4@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 20, 2019 at 08:44:52AM -0800, M Lewis wrote:

> When running 'git archive', the .gitattributes file is used to determine
> paths that should be ignored when building the archive by using
> 'export-ignore'.
> But it would be useful to include certain sub-paths in the ignored path.

Yeah, that seems like a reasonable goal, and I think we can make it
work, but the syntax is slightly different.

> The git-attribute document says a dash '-' prefix should unset the
> attribute. It should work with 'export-ignore'
> 
> So if I want for example '/mostly_unuseful/needed_a' in my archive, I
> should be able to specify that in my .gitattributes file like this:
> 
>     /mostly_unuseful              export-ignore # do not archive
>     /mostly_unuseful/needed_a    -export-ignore # do add to archive
>     /mostly_unuseful/needed_b    -export-ignore # do add to archive

It doesn't work because the attributes are not applied recursively[1];
they are applied to the path you specified. By putting the attribute on
"mostly_unuseful", that doesn't say anything about "needed_a" (from the
perspective of the attributes system). So removing it from that path
likewise does nothing; the attribute is still set on the directory.

Instead, if you write it like this:

  /mostly_unuseful/**        export-ignore
  /mostly_unuseful/needed_a -export-ignore
  /mostly_unuseful/needed_b -export-ignore

Then the attributes are applied directly to the file paths in the first
line, and the subsequent lines counteract them. This does mean that the
subdirectory itself isn't marked as export-ignore, and will always be
included (as an empty directory if need be, though of course in your
example we do actually end up with some files in it).

Now obviously there is recursion happening inside git-archive, as it
walks the tree. And the current behavior is that it sees the ignored
subtree and doesn't walk into it at all. So it _could_ make your
original example work by actually searching within the tree for any
paths marked -export-ignore, and including the directory if and only if
it has unignored entries.

I can't offhand think of anything that would break if we started doing
that, but I haven't thought too hard. And given that there's already a
solution using `**`, it might not be worth it.

-Peff

[1] If you're curious, there's some philosophical discussion about this exact issue in
    https://public-inbox.org/git/7v1uasg8e0.fsf@alter.siamese.dyndns.org/
