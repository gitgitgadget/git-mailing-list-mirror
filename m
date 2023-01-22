Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD0DC38142
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 16:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjAVQiy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 11:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjAVQix (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 11:38:53 -0500
X-Greylist: delayed 333 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 22 Jan 2023 08:38:52 PST
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8D118B38
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 08:38:52 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C7C791EC845;
        Sun, 22 Jan 2023 11:33:15 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=fjQDijxuLcizK
        m62bmtbOljmYZnWOfOqq6u8/CZ3LI4=; b=mwesVFSDjardSW9UVfChIGsjND3Re
        N+ea1ctV5aMvGWoBOsge77EnN0Ku4NlJ3WIP6gIOnG6hiV0ZomWI7r/Mc0Ntt47u
        7Yh/ek3Kd3Kiwi9UDUAtnUIY2o1XbembTTHU0FUtQl7jM/IQLUoGoPdbmFmP8fN/
        OGDxSsm/BzmxA0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C04391EC843;
        Sun, 22 Jan 2023 11:33:15 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [108.15.224.39])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C2D641EC842;
        Sun, 22 Jan 2023 11:33:11 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Sun, 22 Jan 2023 11:33:07 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: t5559 breaks with apache 2.4.55
Message-ID: <Y81lQwG85+Skujja@pobox.com>
References: <Y8ztIqYgVCPILJlO@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Y8ztIqYgVCPILJlO@coredump.intra.peff.net>
X-Pobox-Relay-ID: 76463AA8-9A72-11ED-A43F-C2DA088D43B2-09356542!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> I noticed that the test suite now fails after upgrading from apache
> 2.4.54 to 2.4.55 (the latter of which just hit debian unstable). The
> problem is with the http2 tests, specifically t5559.30, where we send a
> large fetch negotiation over http2. The output from curl is (including
> some bits of tracing):
>=20
>   =3D=3D Info: Received 101, Switching to HTTP/2
>   =3D=3D Info: Using HTTP2, server supports multiplexing
>   =3D=3D Info: Copying HTTP/2 data in stream buffer to connection buffe=
r after upgrade: len=3D0
>   =3D=3D Info: Closing connection 1
>   error: RPC failed; HTTP 101 curl 16 Error in the HTTP2 framing layer
>=20
> Bisecting within apache's Git repo, the culprit is their 9767274b88,
> which says:
>=20
>   mod_http2: version 2.0.10 of the module, synchronizing changes
>   with the gitgub version. This is a partial rewrite of how connections
>   and streams are handled.
>=20
> which seems like a plausible source. But the diff is 8000 lines. It may
> be possible to bisect within the mod_http2 source itself, but I haven't
> tried it yet.
>=20
> It's also not 100% clear that it's an apache bug. We could be doing
> something weird with git-http-backend, or curl might be doing something
> wrong. Though I tend to doubt it, given the simplicity of the CGI
> interface on the server side and the fact that curl was working reliabl=
y
> with older versions of apache.
>=20
> So I haven't reported the bug further yet. But I thought I'd post this
> here before anybody else wastes time digging in the same hole.

FWIW, I think this is the same issue we discussed about 2
months back, in <Y4fUntdlc1mqwad5@pobox.com>=B9.

I haven't done much else with it since then.  It's almost
surely either an apache httpd/mod_http2 or curl issue.  If I
had to bet, I'd say mod_http2.  (But then, it could be curl
and just has yet to be exposed widely because not many are
using the current mod_http2 code.)

=B9 https://lore.kernel.org/git/Y4fUntdlc1mqwad5@pobox.com/

--=20
Todd
