Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 337A820248
	for <e@80x24.org>; Thu,  7 Mar 2019 18:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfCGSIe (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 13:08:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:42878 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726227AbfCGSId (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 13:08:33 -0500
Received: (qmail 4326 invoked by uid 109); 7 Mar 2019 18:08:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Mar 2019 18:08:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26240 invoked by uid 111); 7 Mar 2019 18:08:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 07 Mar 2019 13:08:51 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Mar 2019 13:08:31 -0500
Date:   Thu, 7 Mar 2019 13:08:31 -0500
From:   Jeff King <peff@peff.net>
To:     Jesper =?utf-8?Q?R=C3=B8nn-Jensen?= <jesperrr@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Error fetching submodule from submodule
Message-ID: <20190307180831.GA21404@sigill.intra.peff.net>
References: <CAL-rKu6AcyHdrCsVikwQxTgKHgtV86+BeHOv_sTSu-jvwME75Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL-rKu6AcyHdrCsVikwQxTgKHgtV86+BeHOv_sTSu-jvwME75Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 07, 2019 at 12:07:21PM +0100, Jesper Rønn-Jensen wrote:

> Hi I think I may have found an error in the way git handles a
> submodule's submodule. Read further for the example (extracted from a
> real project).

First off, thank you for the example script. It made understanding
what's going on so much easier. :)

> * I have a main repository which has some submodules defined.
> * One of the submodules is a common submodule which is also included
> in one of the other submodules
> * When running `git fetch --recurse-submodules` I get an error.

I think the presence of common_submodule in the main repo is actually a
red herring. if you remove the last two lines of this stanza:

> git setup main_repos
> pushd main_repos
> git submodule add ../common_submodule
> git commit -m 'added submodule to main_repos'

the outcome is the same.

> # This line fails with error code 1 "Could not access submodule
> 'common_submodule'"
> git fetch --recurse-submodules

It looks like "fetch" is smart enough to initialize a submodule when
necessary, but not smart enough to do so recursively. If I replace that
line with:

  git submodule update --init --recursive

then it works as I'd expect. Likewise, cloning the repository with:

  git clone --recurse-submodules main_repos foo

does what you'd want.

After that, I think "git fetch --recurse-submodules" does what you want,
because the submodule repository is already initialized.

I'm not sure to what degree git-fetch intended to support initializing
submodules. But it certainly seems like a bug that it handles the top
layer but does not recurse (i.e., it should either handle all or none).

Hopefully the commands above at least give you a workaround.

-Peff
