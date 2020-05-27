Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADA6C433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 22:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 238252073B
	for <git@archiver.kernel.org>; Wed, 27 May 2020 22:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbgE0Ws0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 18:48:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:58234 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgE0Ws0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 18:48:26 -0400
Received: (qmail 24555 invoked by uid 109); 27 May 2020 22:48:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 May 2020 22:48:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9043 invoked by uid 111); 27 May 2020 22:48:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 May 2020 18:48:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 May 2020 18:48:24 -0400
From:   Jeff King <peff@peff.net>
To:     Zach Riggle <zachriggle@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git grep --show-function treats GOTO labels as function names
Message-ID: <20200527224824.GA546534@coredump.intra.peff.net>
References: <CAMP9c5k=Ci8eQyOdzW7a-sssgp9g9TJ+rxAAPF3YLDCr7t6wrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMP9c5k=Ci8eQyOdzW7a-sssgp9g9TJ+rxAAPF3YLDCr7t6wrg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 27, 2020 at 05:29:08PM -0500, Zach Riggle wrote:

> It looks like there is an issue with how the parser handles "goto"
> labels, as it treats them the same as a function name.

By default, the function-finding isn't aware of the specific content in
the file. But you can associate extensions with particular types, like:

  $ echo '*.cpp diff=cpp' >~/.gitattributes
  $ git config --global core.attributesFile ~/.gitattributes
  $ git grep --no-index --show-function -e FOO test2.cpp
  test2.cpp=int main() {
  test2.cpp:    FOO
  test2.cpp:    FOO

Usually this is done in-repo, but since your example used --no-index, I
showed how to set up a per-user attribute file. The "diff" attribute
covers both diff and grep (for diff, the hunk headers will also show the
function).

The "cpp" diff regexes are built-in to the git binary. We just don't
associate any filenames by default. You can also add your own; see the
section "Defining a custom hunk-header" from "git help attributes".

-Peff
