Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CACC001B0
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 19:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjGCTQn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 15:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjGCTQm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 15:16:42 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4D3E5E
        for <git@vger.kernel.org>; Mon,  3 Jul 2023 12:16:37 -0700 (PDT)
Received: (qmail 9549 invoked by uid 109); 3 Jul 2023 19:16:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Jul 2023 19:16:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10808 invoked by uid 111); 3 Jul 2023 19:16:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Jul 2023 15:16:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Jul 2023 15:16:36 -0400
From:   Jeff King <peff@peff.net>
To:     Tiago d'Almeida <tjamadeira@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: index.skipHash doesn't work with split index, was Re: Bug Report
Message-ID: <20230703191636.GA3546592@coredump.intra.peff.net>
References: <CAO=RawtAvOna1xrBNY+T-fo4UQe-ipC6OvFODvOSdu4wUML3Ng@mail.gmail.com>
 <20230629083859.GA585934@coredump.intra.peff.net>
 <2FG8XR.63MILGOHGRJ91@gmail.com>
 <UCH8XR.AR4M4C9D538Q1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <UCH8XR.AR4M4C9D538Q1@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[re-adding list to cc, so everybody can benefit from the answer]

On Mon, Jul 03, 2023 at 07:43:42PM +0100, Tiago d'Almeida wrote:

> Meanwhile, just a question:
> 
> How can I correct the corrupted git repos that are in my computer with
> unstaged changes?

Probably the best path forward is:

  1. Disable one or both of the problematic config options:

       git config --global core.splitIndex false

  2. Blow away the old index, and have git re-populate it from the HEAD
     commit:

       rm -f .git/index
       git reset

     Usually "git reset" would be enough here, but since we don't know
     what funny or possibly corrupted state the index file is in,
     deleting it first seems wise). Because the default for git-reset is
     "--mixed", this won't touch your working tree files at all.

  3. You should then be able to run "git status" to see any differences
     between the working tree and the fresh index (including any
     untracked ones). And now "git add", etc, should work.

-Peff
