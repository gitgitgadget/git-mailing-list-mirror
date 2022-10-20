Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE8CC4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 17:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiJTRoj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 13:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiJTRoi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 13:44:38 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F16B1FCF6
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 10:44:34 -0700 (PDT)
Received: (qmail 7230 invoked by uid 109); 20 Oct 2022 17:44:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 20 Oct 2022 17:44:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22387 invoked by uid 111); 20 Oct 2022 17:44:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 20 Oct 2022 13:44:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 20 Oct 2022 13:44:33 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?TWF0xJtq?= Cepl <mcepl@cepl.eu>
Cc:     git@vger.kernel.org
Subject: Re: git-send-email with GPG signed commits?
Message-ID: <Y1GJAart+/yFc5MR@coredump.intra.peff.net>
References: <4eb8707f-4686-e304-2aab-a6afee11abc9@cepl.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4eb8707f-4686-e304-2aab-a6afee11abc9@cepl.eu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2022 at 06:26:49AM +0200, Matěj Cepl wrote:

> did anybody even think about %subj%? Is there some effort somewhere making
> git-send-email(1) supporting transfer of signed commits, where I could join?
> I like hosting sites like sr.ht, which support git-send-email(1), but
> unfortunately using that clears my submission off its GPG signatures. I
> guess, it would be necessary to make some modifications to git-send-email(1)
> and git-am(1). Is there some effort somewhere in that direction?

I think there's an inherent problem here. A commit signature is over the
entire commit object. But when you send a patch, you don't know the
exact bytes of the resulting commit object. In particular, the
"committer" line will have the ident and timestamp from when the
receiver applies the patch and turns it into a commit.

So commit signatures are generally an attestation by the committer, not
by the author. It's just that the two are usually the same when you are
committing locally.

I think you would need some kind of "author-sig" header that signs the
commit object bytes _without_ the commit header at all. And that assumes
the maintainer's workflow is to never modify a patch in transit, and to
apply it at the exact same spot that you wrote it (so that the parent
and tree ids remain the same).

-Peff
