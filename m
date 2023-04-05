Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2468DC76188
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 20:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjDEUCi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 16:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjDEUCh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 16:02:37 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263E74C31
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 13:02:06 -0700 (PDT)
Received: (qmail 5930 invoked by uid 109); 5 Apr 2023 20:01:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 Apr 2023 20:01:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15026 invoked by uid 111); 5 Apr 2023 20:01:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 Apr 2023 16:01:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 5 Apr 2023 16:01:53 -0400
From:   Jeff King <peff@peff.net>
To:     Adam Majer <adamm@zombino.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: git clone of empty repositories doesn't preserve hash
Message-ID: <20230405200153.GA525125@coredump.intra.peff.net>
References: <e7a8957e-6251-39f1-5109-87d4dd382e81@zombino.com>
 <xmqqr0syw3pe.fsf@gitster.g>
 <d04c430e-b609-b0a1-fd0f-0f3734d5c3b1@zombino.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d04c430e-b609-b0a1-fd0f-0f3734d5c3b1@zombino.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 05, 2023 at 09:47:55PM +0200, Adam Majer wrote:

> On 4/5/23 21:04, Junio C Hamano wrote:
> > Does such a clone copy the name of the primary branch from the
> > remote repository to the newly created repository?
> 
> Yes it does.
> 
> # git init -b maestro --object-format=sha256 a
> # git clone a b
> # cat b/.git/HEAD
> ref: refs/heads/maestro

Yeah, we send a special capability line in that case. If you do:

  GIT_TRACE_PACKET=1 git clone a b

you can see that upload-pack indicates that ls-refs understands the
"unborn" capability:

  packet:  upload-pack> version 2
  packet:  upload-pack> agent=git/2.40.0.824.g7b678b1f643
  packet:  upload-pack> ls-refs=unborn
  packet:  upload-pack> fetch=shallow wait-for-done
  packet:  upload-pack> server-option
  packet:  upload-pack> object-format=sha256
  packet:  upload-pack> object-info
  packet:  upload-pack> 0000

And then clone asks for it say "yes, I also understand unborn":

  packet:        clone> command=ls-refs
  packet:        clone> agent=git/2.40.0.824.g7b678b1f643
  packet:        clone> object-format=sha256
  packet:        clone> 0001
  packet:        clone> peel
  packet:        clone> symrefs
  packet:        clone> unborn
  packet:        clone> ref-prefix HEAD
  packet:        clone> ref-prefix refs/heads/
  packet:        clone> ref-prefix refs/tags/
  packet:        clone> 0000

And then upload-pack can send us the extra information:

  packet:  upload-pack> unborn HEAD symref-target:refs/heads/maestro
  packet:  upload-pack> 0000

I think we'd need to do something similar here for object-format.

-Peff
