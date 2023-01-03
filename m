Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650D1C3DA7D
	for <git@archiver.kernel.org>; Tue,  3 Jan 2023 11:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236816AbjACLHW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Jan 2023 06:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237474AbjACLHH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2023 06:07:07 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2911610A5
        for <git@vger.kernel.org>; Tue,  3 Jan 2023 03:07:05 -0800 (PST)
Received: (qmail 9362 invoked by uid 109); 3 Jan 2023 11:07:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Jan 2023 11:07:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9947 invoked by uid 111); 3 Jan 2023 11:07:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Jan 2023 06:07:10 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Jan 2023 06:07:04 -0500
From:   Jeff King <peff@peff.net>
To:     Tim Hockin <thockin@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: git fetch --dry-run changes the local repo and transfers data
Message-ID: <Y7QMWN86dDLXc4dZ@coredump.intra.peff.net>
References: <CAO_RewZeUBVvqT+UgXL5V5EeTOt14zZ-5vJYA4YvNr-jNyupXg@mail.gmail.com>
 <xmqqcz85t3dr.fsf@gitster.g>
 <CAO_RewbVicTznpDeCDG0Uqng-MdQ_GKtp-Vgz8kmtaXoczQGOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAO_RewbVicTznpDeCDG0Uqng-MdQ_GKtp-Vgz8kmtaXoczQGOg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 27, 2022 at 10:42:25AM -0800, Tim Hockin wrote:

> Thanks.  What threw me is that I expected it to be "very fast" and
> "very cheap" . If I commit a multi-gig file on the server, I see the
> dry-run fetch takes several seconds (clearly indicating some work
> proportional to the server repo size).  I don't want to transfer that
> file on a dry-run, I hoped the server and client were both
> dry-running, andb the server could simply say "here's metadata for
> what I _would have_ returned if this was real".  Not possible?

No, the server has no notion of a dry run.

I think the best you could do with fetch is to ask for a smaller set of
objects. For example:

  git fetch --depth=1 --filter=tree:0 \
    https://github.com/git/git \
    2e71cbbddd64695d43383c25c7a054ac4ff86882

will grab a single object. You can even "git show -s 2e71cbbd" on the
result to see it (the "-s" is important to avoid it fetching the trees
to do a diff!). Two things to be aware of:

  - this may have some lingering effects in your repository, as the
    shallow and partial features store some metadata locally to make
    sense of the situation. You're probably best off doing it in a
    temporary repository.

  - not all servers will support --filter; it has to be enabled in the
    config.

There is potentially a more direct option, though. A while back, commit
a2ba162cda (object-info: support for retrieving object info, 2021-04-20)
added an extension that lets you get the size of an object on the
server. Unfortunately I don't think anybody ever wrote client-side
support. So you'd have to rig up something yourself like:

  # write git's packet format: 4-hex length followed by data
  pkt() {
    printf '%04x%s' "$((4+${#1}))" "$1"
  }

  # a sample input; you should be able to query multiple objects if you
  # want by adding more "oid" lines
  {
    pkt "command=object-info"
    printf "0001"
    pkt "size"
    pkt "oid 2e71cbbddd64695d43383c25c7a054ac4ff86882"
    printf "0000"
  } >input

  # this makes a local request; it's important we're in v2 mode, since
  # the extension only applies there. For http, I think you'd want
  # something like:
  #
  #  curl -H 'Git-Protocol: version=2' https://example.com/repo.git/git-upload-pack
  #
  # but I didn't test it.
  GIT_PROTOCOL=version=2 git-upload-pack /path/to/repo.git <input >output

I've left parsing the output as an exercise for the reader. But you
should be able to notice whether the object is present or not based on
the result.

Not all servers may support the extension. For example, I think GitHub's
servers have disabled it.

-Peff
