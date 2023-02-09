Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BC5C05027
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 12:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjBIMl6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 07:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjBIMl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 07:41:57 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A4F5ACD3
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 04:41:55 -0800 (PST)
Received: (qmail 550 invoked by uid 109); 9 Feb 2023 12:41:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Feb 2023 12:41:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12581 invoked by uid 111); 9 Feb 2023 12:41:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Feb 2023 07:41:52 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Feb 2023 07:41:52 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Max Gautier <max.gautier@redhat.com>, git@vger.kernel.org
Subject: Re: git rev-list fails to verify ssh-signed commits (but git log
 works)
Message-ID: <Y+TqEM21o+3TGx6D@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh6vwrpce.fsf@gitster.g>
 <xmqqmt5orqgv.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 08, 2023 at 09:56:16AM -0800, Junio C Hamano wrote:

> >   1. Somebody would need to dig into the reasons, if any, for not
> >      calling git_gpg_config() everywhere. It might be fine, but there
> >      may be a good reason which we're now violating. Digging in the
> >      history and looking at the code might yield some hints.
> 
> Hmph, I didn't consider calling gpg_config unconditionally.  It may
> do a bit more than what a typical config callback does (i.e. as
> opposed to just store the string values it gets, it tries table
> look-ups and stuff) but it is not too bad.

It all looks pretty typical for config parsing to me. Matching in a
constant-sized list of strings happens in lots of places (e.g.,
push.default). Performance-wise it's probably fine.

I'd be more worried about correctness (command "foo" must not parse
option "bar" because it is plumbing and must use the default). But
looking over the options, I really don't see anything like that. The one
I'd expect (or worry most about) is "we do/do not bother to enable
signatures at all based on config" but I don't think that is the case.
We default use_format to &gpg_format[0], so there is always a signature
format defined, even if the config is skipped.

The original split comes from your 2f47eae2a1 (Split GPG interface into
its own helper library, 2011-09-07), where it was just moving bits out
of the git-tag config. So I think we just grew into this situation
organically.

> I wonder if gpg-interface functions can and should be taught to
> initialize themselves lazily without relying on the usual
> git_config(git_gpg_config) sequence.  I.e. the first call to
> sign_buffer(), check_signature(), get_signing_key_id(), etc.
> would internally make a git_config(git_gpg_config) call, with the
> current callers of git_config(git_gpg_config) removed.

If the gpg code used git_config_get_string(), etc, then they could just
access each key on demand (efficiently, from an internal hash table),
which reduces the risk of "oops, we forgot to initialize the config
here". It does probably mean restructuring the code a little, though
(since you'd often have an accessor function to get "foo.bar" rather
than assuming "foo.bar" was parsed into an enum already, etc). That may
not be worth the effort (and risk of regression) to convert.

-Peff
