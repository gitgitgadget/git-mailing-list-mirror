Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB4BC61DA4
	for <git@archiver.kernel.org>; Sat,  4 Feb 2023 11:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbjBDLeP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 06:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBDLeO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 06:34:14 -0500
Received: from fame.vanrein.org (2a02-58-157-9b00--7.ip6.tweak.nl [IPv6:2a02:58:157:9b00::7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9607B455
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 03:34:10 -0800 (PST)
Received: by fame.vanrein.org (Postfix, from userid 1000)
        id 7CFBF2C2FC; Sat,  4 Feb 2023 11:34:08 +0000 (UTC)
Date:   Sat, 4 Feb 2023 11:34:08 +0000
From:   Rick van Rein <rick@openfortress.nl>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Matthew John Cheetham <mjcheetham@github.com>
Subject: Re: Git over HTTP; have flexible SASL authentication
Message-ID: <20230204113408.GD21507@openfortress.nl>
References: <20230127163434.GA784@openfortress.nl>
 <xmqq7cx7aov7.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7cx7aov7.fsf@gitster.g>
User-Agent: Mutt/1.5.20 (2009-06-14)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

(Sorry for the late reply)

> > Git providers are inventing proprietary extensions to HTTP authentication
> > for Git.  It seems smarter to use SASL for this purpose, possibly allowing
> > the client a choice and authentication ringback to the client's own domain.
> 
> To adopt things like this, the work to extend how to make extensible
> what is on WWW-Authenticate in the thread that contains this recent
> message https://lore.kernel.org/git/Y9LvFMzriAWUsS58@coredump.intra.peff.net/
> may be relevant, perhaps?

This framework tries to get away from just Basic / Digest auth, but
if I read correctly, it still assumes a single authentication step,
which greatly reduces the strength of authentication.

SASL assumes that the endpoints can hold state and progress through any
challenge/response exchange, in multiple steps if needed.  This is not
trivial with stateless HTTP, but we fixed it with a "s2s" argument which
can hold the (datestamped, signed, encrypted) state on the server side.

A few mechanisms that spring to mind as useful with Git over HTTP-SASL are

 - Kerberos / GSS-API, desirable for companies using its single sign-on
 _ FIDO, currently being added to SASL to benefit all protocols
 - OPAQUE, a very modern crypto, developed in IETF now
 - SXOVER-PLUS, our own work that calls back to a user's domain for login
	(so no server-stored credentials needed, only access control)

I'm curious if this would indeed be considered an improvement to Git.

Cheers,
 -Rick
