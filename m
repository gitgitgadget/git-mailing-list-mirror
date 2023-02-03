Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B78C636D4
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 17:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjBCRxV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 12:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjBCRxT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 12:53:19 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B864E2528F
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 09:53:18 -0800 (PST)
Received: (qmail 26804 invoked by uid 109); 3 Feb 2023 17:53:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Feb 2023 17:53:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10499 invoked by uid 111); 3 Feb 2023 17:53:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Feb 2023 12:53:17 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 3 Feb 2023 12:53:17 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Bernhard Reiter <ockham@raz.or.at>,
        Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH v2 6/6] imap-send: correctly report "host" when using
 "tunnel"
Message-ID: <Y91J+P5P9gV1Dygm@coredump.intra.peff.net>
References: <patch-1.1-3bea1312322-20230201T225915Z-avarab@gmail.com>
 <cover-v2-0.6-00000000000-20230202T093706Z-avarab@gmail.com>
 <patch-v2-6.6-686febb8cdc-20230202T093706Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-6.6-686febb8cdc-20230202T093706Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 02, 2023 at 10:44:17AM +0100, Ævar Arnfjörð Bjarmason wrote:

> Before [1] we'd force the "imap.host" to be set, even if the
> "imap.tunnel" was set, and then proceed to not use the "host" for
> establishing a connection, as we'd use the tunneling command.
> 
> However, we'd still use the "imap.host" if it was set as the "host"
> field given to the credential helper, and in messages that were shared
> with the non-tunnel mode, until a preceding commit made these OpenSSL
> codepaths tunnel-only.
> 
> Let's always give "host=tunnel" to the credential helper when in the
> "imap.tunnel" mode, and rephrase the relevant messages to indicate
> that we're tunneling. This changes the existing behavior, but that
> behavior was emergent and didn't make much sense. If we were using
> "imap.tunnel" the value in "imap.host" might be entirely unrelated to
> the host we're tunneling to. Let's not pretend to know more than we do
> in that case.

If you tunnel to two different hosts, how is the credential system
supposed to know which is which?

If you really want to distinguish connecting to $host versus tunneling
to $host, I think you'd have to invent some new URL scheme
(imap-tunnel:// or something).

But IMHO it is not really worth it. Your statement of "the value in
imap.host might be entirely unrelated" does not match my experience.  I
don't use imap-send, but I've been doing imap-tunneling with various
programs for two decades, and it's pretty normal to configure both, and
to consider the tunnel command as an implementation detail for getting
to the host. For example, my mutt config is like[1]:

  set folder = imap://example.com/
  set tunnel = "ssh example.com /etc/rimapd"

and I expect to be able to refer to folders as imap://example.com/foo,
etc (well, in mutt you'd use the shorthand "=foo", but the idea is the
same). So if we see:

  [imap]
  host = example.com
  tunnel = ssh example.com /etc/rimapd

we should likewise think of it as example.com, but with an
implementation detail of how to contact the server.

Of course if you don't set imap.host, then we don't have anything useful
to say. But as you saw, in that case imap-send will default the host
field to the word "tunnel".

-Peff

[1] In my experience the main reason to tunnel is to avoid auth
    altogether, so for those cases the credential code wouldn't matter
    either way. But I imagine there may be some people who use it to pierce
    a firewall or some other network obstacle, and really do want it to
    be otherwise just like a connection to $host.
