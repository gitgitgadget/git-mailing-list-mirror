Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9EC420281
	for <e@80x24.org>; Tue, 23 May 2017 12:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936931AbdEWMME (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 08:12:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:56655 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935851AbdEWMMD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 08:12:03 -0400
Received: (qmail 4080 invoked by uid 109); 23 May 2017 12:12:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 May 2017 12:12:01 +0000
Received: (qmail 31268 invoked by uid 111); 23 May 2017 12:12:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 May 2017 08:12:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 May 2017 08:12:00 -0400
Date:   Tue, 23 May 2017 08:12:00 -0400
From:   Jeff King <peff@peff.net>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     =?utf-8?B?RsOpbGl4?= Saparelli <felix@passcod.name>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [Bug] cloning a repository with a default MASTER branch tries to
 check out the master branch
Message-ID: <20170523121159.zxxp43o6es7lzcj3@sigill.intra.peff.net>
References: <CACQm2Y1QtKD3M6weNhGrAQSLV8hLF4pKcpHDD7iUc78aWrt6Cw@mail.gmail.com>
 <CAJZjrdWXsuKrFzedLvyE-1mvD0RC5XYDkmvV3wRNWXjFAVt4iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZjrdWXsuKrFzedLvyE-1mvD0RC5XYDkmvV3wRNWXjFAVt4iQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 23, 2017 at 04:01:06AM -0400, Samuel Lijin wrote:

> For some reason the repo on GH does not have a HEAD pointer:
> 
> $ git ls-remote https://github.com/passcod/UPPERCASE-NPM.git
> efc7dbfd6ca155d5d19ce67eb98603896062f35a        refs/heads/MASTER
> e60ea8e6ec45ec45ff44ac8939cb4105b16477da        refs/pull/1/head
> f35a73dcb151d336dc3d30c9a2c7423ecdb7bd1c        refs/pull/2/head
> 0d9b3a1268ff39350e04a7183af0add912b686e6        refs/tags/V1.0.0
> efc7dbfd6ca155d5d19ce67eb98603896062f35a        refs/tags/V1.0.1
> 
> I'm not sure how you managed to do that, since GH rejects attempts to
> delete the current branch, but I believe if you set the default branch
> to MASTER it will work correctly.

The HEAD branch on the server side is still pointing at
refs/heads/master. But since that doesn't exist, upload-pack doesn't
advertise HEAD at all (it has no sha1).

You can recreate this situation with:

  cd /some/repo
  git init --bare dst.git
  git push dst.git HEAD:refs/heads/MASTER
  git ls-remote dst.git

No current-branch deletion required.

Félix should be able to re-point the server-side HEAD to MASTER via
GitHub's web interface.

GitHub's post-receive hook usually does that automatically if you push a
branch to a repository with an unborn HEAD. But I think there may be
corner cases where it gets confused.

-Peff
