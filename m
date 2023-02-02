Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8542FC05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 00:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjBBAXO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 19:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBBAXN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 19:23:13 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDA51BAE0
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 16:23:12 -0800 (PST)
Received: (qmail 7301 invoked by uid 109); 2 Feb 2023 00:23:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Feb 2023 00:23:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26104 invoked by uid 111); 2 Feb 2023 00:23:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Feb 2023 19:23:11 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Feb 2023 19:23:11 -0500
From:   Jeff King <peff@peff.net>
To:     Matthew John Cheetham <mjcheetham@outlook.com>
Cc:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH v2] credential: new attribute password_expiry_utc
Message-ID: <Y9sCbzq0/YuacVz+@coredump.intra.peff.net>
References: <pull.1443.git.git.1674914650588.gitgitgadget@gmail.com>
 <pull.1443.v2.git.git.1675244392025.gitgitgadget@gmail.com>
 <Y9pWxHfgPtgCKO+B@coredump.intra.peff.net>
 <AS2PR03MB9815DDCB7B107E7FD37EC972C0D19@AS2PR03MB9815.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AS2PR03MB9815DDCB7B107E7FD37EC972C0D19@AS2PR03MB9815.eurprd03.prod.outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 01, 2023 at 12:02:16PM -0800, Matthew John Cheetham wrote:

> > So it seems like helpers really do need to support this "expiration"
> > notion. And it's actually Git itself which doesn't need to care about
> > it, assuming the helpers are doing something sensible (though it is OK
> > if Git _also_ throws away expired credentials to support helpers which
> > don't).
> 
> I have often wondered about how, and if, Git should handle expiring credentials
> where the expiration is known. In my opinion I think Git should be doing
> *less* decision making with credentials and authentication in general, and leave
> that up to credential helpers.

FWIW, that is my general philosophy, too.

> The original design of credential helpers from what I can see (and Peff can
> correct me here of course!) is that they were really only thought about as
> storage-style helpers. Helpers are consulted for a known credential, and told
> about bad (erase) or good (store) credentials, all without any context about
> the request or remote responses.
> 
> If no credential helper can respond then Git itself prompts for a user/pass; so
> Git, or rather the user, is the 'generator'.

They were always intended to be generators, too. In the early days we
discussed having more fancy graphical prompts via helpers, though most
people simply use the askpass interface for this.

My personal config for the last, say, 12 years, has been to pull the
password out of a read-only store, and ignore "store" and "erase"
requests entirely. Which I think counts as a generator. :)

But yeah, if there is more context that we can be giving the helpers to
let them make a better decision, I'm all for it. I think your
www-authenticate patches are a good step in that direction. I'm not sure
what other context would be useful.

> It doesn't make sense that a generating helper that knows about expiration would
> instead choose to respond with an expired credential rather than just try and
> generate a new credential.

Yeah, agreed.

> Now in the case of a simple storage helper without such logic, after returning
> an expired credential should Git not be calling 'erase' back to the same helper
> to inform it that it has a stale credential and should be deleted?
> This would also require some affinity between calls to get/erase/store.

That's a good point. I think in practice it would mostly happen that Git
would throw away the expired credential, generate a new one (either from
another helper or via prompting), and then if that works, overwrite the
old one with a 'store' request.

If the new credential doesn't work (or the user aborts), the expired
credential is left in the helper. But in theory that doesn't matter. It
will still be expired when it's served up again later. And it's not a
security problem to hold onto it longer, since it's no longer valid.
Still, it feels a bit clunky compared to having the helper realize it's
holding garbage.

-Peff
