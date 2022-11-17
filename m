Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E844CC433FE
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 22:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239378AbiKQWhe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 17:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235163AbiKQWhb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 17:37:31 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0A68C0B9
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 14:37:30 -0800 (PST)
Received: (qmail 28687 invoked by uid 109); 17 Nov 2022 22:37:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Nov 2022 22:37:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18653 invoked by uid 111); 17 Nov 2022 22:37:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Nov 2022 17:37:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Nov 2022 17:37:29 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kousik Sanagavarapu <five231003@gmail.com>, git@vger.kernel.org
Subject: [PATCH 0/2] fixing parse_object() check for type mismatch
Message-ID: <Y3a3qcqNG8W3ueeb@coredump.intra.peff.net>
References: <Y3Up5Vi75Up8LaGQ@coredump.intra.peff.net>
 <20221116211419.439356-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221116211419.439356-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 16, 2022 at 01:14:18PM -0800, Jonathan Tan wrote:

> > But there may be some subtlety I'm missing. I'm cc-ing Jonathan Tan, who
> > added has_object(), and who added the top call to repo_has_object_file()
> > via df11e19648 (rev-list: support termination at promisor objects,
> > 2017-12-08).
> 
> Thanks for CC-ing me on this. Looking at that commit and the code at that time,
> I'm not sure why I added that call either. My best guess is that I was worried
> that the streaming interface wouldn't support missing objects, but both then
> and now, a call to istream_source() is made before any streaming occurs (which
> does perform the lazy fetch).
> 
> So yes, I also think that you can remove these calls.

Thanks. After staring at this a bit, I noticed there is an even more
subtle issue with the case you touched back then, which is that it fails
to notice when a think we expect to be a blob isn't one. Your old patch
didn't make anything worse there, but it also wasn't sufficient to catch
the problem. See patch 2 for details.

I'm adding Taylor to the cc as the author of t6102, when we were
tracking down all of these "oops, it's not really a blob" cases. This
fixes one of the lingering cases from that test script.

  [1/2]: parse_object(): drop extra "has" check before checking object type
  [2/2]: parse_object(): check on-disk type of suspected blob

 object.c                               | 5 ++---
 t/t6102-rev-list-unexpected-objects.sh | 4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

-Peff
