Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DDBC433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 18:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJTSbs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 14:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJTSbq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 14:31:46 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2CD1FAE65
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 11:31:42 -0700 (PDT)
Received: (qmail 7365 invoked by uid 109); 20 Oct 2022 18:31:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 20 Oct 2022 18:31:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22995 invoked by uid 111); 20 Oct 2022 18:31:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 20 Oct 2022 14:31:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 20 Oct 2022 14:31:41 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?TWF0xJtq?= Cepl <mcepl@cepl.eu>, git@vger.kernel.org
Subject: Re: git-send-email with GPG signed commits?
Message-ID: <Y1GUDbtFIGZu0BKD@coredump.intra.peff.net>
References: <4eb8707f-4686-e304-2aab-a6afee11abc9@cepl.eu>
 <Y1GJAart+/yFc5MR@coredump.intra.peff.net>
 <xmqqr0z2s7w4.fsf@gitster.g>
 <xmqqk04us77b.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk04us77b.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2022 at 11:03:52AM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> I think you would need some kind of "author-sig" header that signs the
> >> commit object bytes _without_ the commit header at all. And that assumes
> >> the maintainer's workflow is to never modify a patch in transit, and to
> >> apply it at the exact same spot that you wrote it (so that the parent
> >> and tree ids remain the same).
> >
> > Doesn't it immediately break down once you send a 2-patch series?

Oops, you're right. The parent pointer in subsequent ones is unknowable.

> Ah, if you did not mean "without the committer header", but "without
> any of the header fields of the commit object", then it would
> probably work.  But then that loses the context to apply the patch
> completely, so I can apply a patch you author-signed to a place
> where it wouldn't work and end up with a broken commit.

No, I was not that clever. I just didn't think about the subsequent
commits. I agree that an author-sig that omits the parent pointer is
practically useless. It does record the end tree state faithfully, but
what most people consider interesting in a commit is the diff from the
parent tree. So applied in the wrong spot, it makes it look like your
signed commit made changes you never intended.

> Start from the original commit object, remove the committer, the
> author, the tree, and the parent headers, add a parent-tree header
> that records the tree object of the first parent, and call that a
> "modified commit object".  Then compute the signature over it and
> the patch text.  The e-mailed patch now needs to carry the value of
> the parent-tree header and the signature.
> 
> At the receiving end, the reverse operation can be done and the
> resulting commit may have two new headers (author-sig and
> parent-tree).  In the resulting commit, parent-tree does not have to
> match the tree of its first parent, if the integrator chose to apply
> it on a different commit, and as long as the patch text matches,
> things should verify.

I think it's a bit weird if parent-tree does not match the first parent.
Your final tree must still match what was signed. And so if you applied
it on a commit that didn't match the original parent-tree, then the
commit would be quietly reverting changes between the original
parent-tree and the actual parent it was applied on.

I do think it would work if you enforced that. But I tend to agree with
your other comment that people may be better off just sending bundles at
that point.

> So, some kind of "author-sig" is certainly possible, but is it
> practically useful?  I am not sure.  It still does not even allow
> typofixes on the receiving end.

Yes, like bundles, it is losing some of the flexibility of an
emailed-patch workflow. I haven't played with b4's attestation too much,
but I think it slots into a patch workflow better. You are signing the
patch, not the commit, and commits which are made later can refer back
to the emails, which people can then verify. That's not a signature on
the commit, but it is a paper trail that can be followed.

-Peff
