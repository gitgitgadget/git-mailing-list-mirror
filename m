Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016BFC433ED
	for <git@archiver.kernel.org>; Fri,  7 May 2021 03:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C712960FEB
	for <git@archiver.kernel.org>; Fri,  7 May 2021 03:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbhEGDoF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 23:44:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:47086 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231299AbhEGDoC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 23:44:02 -0400
Received: (qmail 31990 invoked by uid 109); 7 May 2021 03:43:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 07 May 2021 03:43:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29324 invoked by uid 111); 7 May 2021 03:43:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 06 May 2021 23:43:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 6 May 2021 23:43:00 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jason Gore <Jason.Gore@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git clean enumerates ignored directories (since 2.27)
Message-ID: <YJS3RIEtittWdFSF@coredump.intra.peff.net>
References: <DM6PR00MB06829EC5B85E0C5AC595004E894E9@DM6PR00MB0682.namprd00.prod.outlook.com>
 <YHdzDlAfsuZ21HR7@camp.crustytoothpaste.net>
 <YHf+m7vOQumdJXwX@coredump.intra.peff.net>
 <CABPp-BH3tbTyA9gj=2vb878d1MQVCTqT7=kS5U+sB6CoDX0Jww@mail.gmail.com>
 <YJSzQm2p5bCAd8Fv@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YJSzQm2p5bCAd8Fv@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 06, 2021 at 11:25:54PM -0400, Jeff King wrote:

> > Anyone have any bright ideas about how to tweak this test?  See [3]
> > for the current incarnation of the code, which was basically taken
> > from Brian's sample testcase.
> 
> My guess is that that version of "rm" is trying to feed the entire
> pathname directly to unlink() and rmdir(), and it exceeds PATH_MAX.
> 
> Even with GNU tools, for instance, I get:
> 
>   $ rmdir $(find avoid-traversing-deep-hierarchy -type d | tail -1)
>   rmdir: failed to remove 'avoid-traversing-deep-hierarchy/directory400/
>     [...and so on...]/directory1': File name too long
> 
> because it feeds the whole to a single rmdir() call. Whereas stracing
> GNU "rm -rf", it uses unlinkat() and openat() to delete each level
> individually (probably to avoid this exact problem).
> 
> Is the actual path length important, or just the depth? If the latter,
> then calling it "d400/d399/.../d2/d1" would likely help, as that's less
> than 2000 bytes.

Reading your commit messages a little more carefully, I'm still not
quite sure of the answer to that question.

But if you really do need the long length, a workaround is to avoid
dealing with the full path all at once. E.g., make two strings, one with
"directory400/.../directory200", and one with "directory199/.../directory1".

And then you can probably:

  (cd $one && rm -rf directory199) &&
  rm -rf directory400

to do it in two parts, with each "rm" seeing only a half-length path.

I notice you also run O(n) "mkdir" and "mv" calls to create the
directory. I "mkdir -p" would be much more efficient, though it might
run afoul of similar path-length problems (especially on non-GNU
systems).

It might be worth turning to perl here:

  perl -e '
    for (reverse 1..400) {
      my $d = "directory$_";
      mkdir($d) and chdir($d) or die "mkdir($d): $!";
    }
    open(my $fh, ">", "some-file");
  '

and you could probably do something similar to remove it. Sadly, I don't
think using File::Path makes building it easier, because it hits the
same path limit (it builds up the string internally). However, its
removal does work (and is in the set of core modules that we can count
on always being available):

  perl -MFile::Path=remove_tree -e 'remove_tree("directory400")'

-Peff
