Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614D2C04A6A
	for <git@archiver.kernel.org>; Sat, 12 Aug 2023 01:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236912AbjHLBEr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 21:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234296AbjHLBEq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 21:04:46 -0400
X-Greylist: delayed 154569 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Aug 2023 18:04:45 PDT
Received: from out-76.mta0.migadu.com (out-76.mta0.migadu.com [IPv6:2001:41d0:1004:224b::4c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA5E30FD
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 18:04:45 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
        t=1691802283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eFjaTYbG+//gmcfQPIajoCc8AOkGCAAt1zK6978WadQ=;
        b=p6iF6NNUt19DMLB1rp8ypqzJuwdw8wN6H3MKAvZRaYJb1cQ718JTyhqXmM/HEAGDYx9Qio
        dCxxTdskJIEclaS76tszKbys9mz1LJ0RFnjw2uGamFRHqeta8xYYmS7wxXIEg1aHIWGGc1
        wKj7feRM+InOVzGR9BvLG0Dzt+k7vUQ=
Date:   Sat, 12 Aug 2023 01:04:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Ronan Pigott" <ronan@rjp.ie>
Message-ID: <053992e6ab7c43d484c46901d31313019494daed@rjp.ie>
TLS-Required: No
Subject: Re: Fetching too many tags?
To:     "Jeff King" <peff@peff.net>
Cc:     git@vger.kernel.org
In-Reply-To: <20230811235820.GA3311880@coredump.intra.peff.net>
References: <20230811235820.GA3311880@coredump.intra.peff.net>
 <20230811180932.GB2816191@coredump.intra.peff.net>
 <274ec1a2152b0fd53b35c1591f5177e0b0713430@rjp.ie>
 <5a0544e570fb962c95840d99994bf45aa638faa8@rjp.ie>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> No, the "negotiation" phase only happens when there are objects to
> fetch, and the client and server have to agree on which ones. That's no=
t
> happening at all in your case (so --negotiation-tip won't have any
> effect).

Ah, I see.

> The feature I was thinking of is that in Git's "v2" protocol, the clien=
t
> gets to speak first, and so it can say "btw, I am only interested in
> these refs". v2 became the default in git v2.29 (of course both client
> and server have to support it, but kernel.org is definitely up to date
> there).
>=20
>=20You can see it in action with something like this:
>=20
>=20 GIT_TRACE_PACKET=3D1 git fetch --no-tags origin master
>=20
>=20The "ref-prefix" lines are the client telling the server which prefix=
es
> it's interested in (we have to ask for several variants because "master=
"
> from the command line gets fully qualified based on what the other side
> offers). Try it without --no-tags and you'll see a wider ref-prefix
> request. If you try:

Thanks. I tried this and indeed without --no-tags there is an additional =
line

> 17:41:29.163545 pkt-line.c:86   packet:   git< ref-prefix refs/tags/

I understand now that this is why the server is telling me about all thos=
e tags.
I had thought it would only need to tell me about tags that point to some=
thing
reachable from master, and was confused why the server was advertising al=
l the
tags.

Thanks,
Ronan
