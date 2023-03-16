Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1173C6FD1F
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 14:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjCPOaB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Mar 2023 10:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjCPOaA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2023 10:30:00 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B7CCDE0
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 07:29:58 -0700 (PDT)
Received: (qmail 1052 invoked by uid 109); 16 Mar 2023 14:29:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Mar 2023 14:29:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14192 invoked by uid 111); 16 Mar 2023 14:29:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Mar 2023 10:29:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Mar 2023 10:29:57 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai <johncai86@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] diff: support bare repositories when reading
 gitattributes for diff algorithm
Message-ID: <ZBMn5T6zfKK+PYUe@coredump.intra.peff.net>
References: <pull.1459.git.git.1678758818.gitgitgadget@gmail.com>
 <ddd7cbb6-4f4d-ba0e-857e-5981779326d0@gmail.com>
 <20230314191833.qmiisyvsu2ppu4sh@pop-os>
 <xmqqttynoyg4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqttynoyg4.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 14, 2023 at 01:44:11PM -0700, Junio C Hamano wrote:

> John Cai <johncai86@gmail.com> writes:
> 
> > I wasn't aware of those config options. Indeed that's a good option! My only
> > concern with that is that there is already some precedence for passing a
> > <tree-ish> as a source for attributes in [1], so I thought adding a command line
> > option would be somewhat consistent.
> >
> > But I can also see the benefit of using a config value since there is also
> > precedence because of mailmap.file and mailmap.blob. Not sure what others think,
> > but this may be the less invasive way to go.
> 
> I actually hate these one-off variables, and I wish we didn't do
> mailmap.file or mailmap.blob at all.  Instead we could have taught
> the machinery to read from $GIT_DIR/info/mailmap just like the
> exclude and the attribute machinery already knows to read excludea
> and attributes files in the directory.

I don't think $GIT_DIR/info/mailmap is a good substitute for
mailmap.blob. The point there is to pull it from the repository, and
you'd have to do:

  git cat-file HEAD:.mailmap >.git/info/mailmap

before each command to get the equivalent. It is even worse for
attributes, because the in-tree representation is not even a single file
that is compatible with $GIT_DIR/ (there can be many attributes spread
throughout the tree).

It's true that mailmap.file, when specified in the local config, is
redundant with a repo-level info/mailmap file. I always assumed that
people put it in their ~/.gitconfig, though, to cover multiple projects
(just like we have core.attributesFile in addition to the in-repo
meta-file).

> As your "per filetype (determined by the attribute) diff algorithm
> in a bare repository" feature already depends on being able to use
> config (as the look-up is "attributes determines the diff filetype
> name, and then diff.<filetype>.algo is looked up in the config") to
> configure, it does not sound too bad to add the attribute info in
> the $GIT_DIR/info/attributes file in your bare repository (and you'd
> set the algorithm in $GIT_DIR/config file there), and it would just
> work without any new "read from HEAD" feature, I would presume?

I don't think that's quite a substitute.

If you have a static list of attributes, that is OK (though you are
presumably better off with /etc/gitattributes or similar that covers all
repos). But if you want to respect in-repo ones, you need to look at the
whole tree (and can't even just dump them out).

It does seem at first glance that you are limited to a static list of
attributes, because any diff "type" you mention has to have a
corresponding entry in the config to do anything useful. But these lists
are only loosely coupled. For example, you could have static entries
like this:

  # in config
  [diff "json"]
  algorithm = patience

  # in attributes
  *.json diff=json

but still tell users that "json" is a well-known name, and if they want
to get the same treatment for an arbitrary file "foo" that they would
get for "foo.json", they have to add attributes mapping it, like:

  foo diff=json

inside their repo.

-Peff
