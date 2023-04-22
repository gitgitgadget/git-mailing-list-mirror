Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC89C7618E
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 10:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjDVKsD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 06:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVKsB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 06:48:01 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF707198D
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 03:47:59 -0700 (PDT)
Received: (qmail 10655 invoked by uid 109); 22 Apr 2023 10:47:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 22 Apr 2023 10:47:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27179 invoked by uid 111); 22 Apr 2023 10:47:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 22 Apr 2023 06:47:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 22 Apr 2023 06:47:58 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Rolf Eike Beer <eb@emlix.com>, git@vger.kernel.org,
        Jaydeep P Das <jaydeepjd.8914@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] gpg-interface: set trust level of missing key to
 "undefined"
Message-ID: <20230422104758.GA2969939@coredump.intra.peff.net>
References: <5926995.lOV4Wx5bFT@devpool47.emlix.com>
 <20230418064846.GA1414@coredump.intra.peff.net>
 <xmqqy1mpduq3.fsf@gitster.g>
 <20230419012957.GA503941@coredump.intra.peff.net>
 <xmqqy1mnanz8.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy1mnanz8.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 19, 2023 at 08:30:35AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Here's the patch that I came up with, though it does not distinguish
> > between "we did not see any trust level" and "gpg told us the trust
> > level was undefined". I think that's OK. That level is still below
> > TRUST_NEVER. But if we really want to distinguish we can introduce a new
> > value for the enum.
> 
> Good.
> 
> In my zeroth draft, I added to the enum a new TRUST_FAILED = -1 to
> be used for the initialization assignment and get stringified in the
> gpg_trust_level_to_str() function, which gave us the distinction and
> made sure the enum is signed.  But in the end, I decided it was not
> worth risking upsetting the end-user scripts that assumed the
> current set of levels with a new "level" that is not known to them.
> 
> Initializing to undefined like this patch is with much less damage
> to the codebase, and existing end-user scripts are probably prepared
> to react to "undefined" already and treat it as even less trustworthy
> than the "never" ones.

One thing that I wondered about for using UNDEFINED is that we do this:

  static enum signature_trust_level configured_min_trust_level = TRUST_UNDEFINED;

which is then later compared with:

  status |= sigc->result != 'G';
  status |= sigc->trust_level < configured_min_trust_level;

So before my patch the uninitialized state is (supposedly) less than the
min level, and after they are the same. For the reasons I gave in the
commit message, I think that less-than comparison was already broken.
And likewise, for the reasons I gave, it hopefully never matters since
the result would never be 'G' in that case.

So I think it's fine, but I definitely had to stare at it for a while.
This all comes from 54887b4689 (gpg-interface: add minTrustLevel as a
configuration option, 2019-12-27), which does discuss some of the
implications, but I think my patch is in line with the logic there.

-Peff
