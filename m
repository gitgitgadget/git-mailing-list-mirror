Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4142020248
	for <e@80x24.org>; Fri, 22 Mar 2019 07:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfCVHdO (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 03:33:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:60458 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726014AbfCVHdN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 03:33:13 -0400
Received: (qmail 7025 invoked by uid 109); 22 Mar 2019 07:33:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Mar 2019 07:33:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17385 invoked by uid 111); 22 Mar 2019 07:33:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 22 Mar 2019 03:33:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Mar 2019 03:33:11 -0400
Date:   Fri, 22 Mar 2019 03:33:11 -0400
From:   Jeff King <peff@peff.net>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org
Subject: Re: How to properly find git config in a libgit.a-using executable?
Message-ID: <20190322073311.GA839@sigill.intra.peff.net>
References: <20190320101941.2xjsjx3zfnnp33a2@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190320101941.2xjsjx3zfnnp33a2@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 20, 2019 at 07:19:41PM +0900, Mike Hommey wrote:

> I thought of a few options (it's worth noting the helper is invoked in a
> way that makes $GIT_EXEC_PATH set, which can help a little):
> - spawn `$GIT_EXEC_PATH/git-config -l -z`, parse its output, and set the
>   internal config from that. That's the barbarian option.
> - build the helper with RUNTIME_PREFIX, and modify the RUNTIME_PREFIX
>   code to use $GIT_EXEC_PATH if it's set, rather than the path the
>   executable is in. That actually sounds reasonable enough that I'd send
>   a patch for git itself. But that doesn't quite address the nitpick case
>   where ETC_GITCONFIG could be either `/etc/gitconfig` or
>   `etc/gitconfig` depending how git was compiled, and there's no way to
>   know which is the right one.

I'm not entirely sure I understand the problem, but it sounds like you
want to know the baked-in ETC_GITCONFIG for a built version of git (that
isn't necessarily the one that shares your build of libgit.a).

There's no direct way to have Git print that out. It would be reasonable
to add one to rev-parse, I think.

Barring that, here's a hack:

  git config --system --show-origin --list -z |
  perl -lne '/^file:(.*?)\0/ and print $1 and exit 0'

If the file is empty, it won't print anything, of course. But then,
you'd know that it also has no config in it. :)

-Peff
