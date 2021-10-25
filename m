Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8479BC433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 16:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61929603E7
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 16:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbhJYQ7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 12:59:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:45764 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234047AbhJYQ7x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 12:59:53 -0400
Received: (qmail 6158 invoked by uid 109); 25 Oct 2021 16:57:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 25 Oct 2021 16:57:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20830 invoked by uid 111); 25 Oct 2021 16:57:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Oct 2021 12:57:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 25 Oct 2021 12:57:29 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 00/10] Makefile: make generate-cmdlist.sh much faster
Message-ID: <YXbh+YR19bygRFaX@coredump.intra.peff.net>
References: <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
 <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 22, 2021 at 09:36:04PM +0200, Ævar Arnfjörð Bjarmason wrote:

> This version of this series drops the Makefile-powered version of the
> cmdlist in favor of making the shellscript much faster, mostly with
> suggestions from Jeff King.
> 
> I still think that splitting out the generated data into files may be
> useful for unifying the Documentation/ and C code build processes,
> there's another custom parser for command-list.txt in
> Documentation/cmd-list.perl.
> 
> But if and when I've got something for that I can dig that out of the
> v1, in the meantime the v1 of this should be mostly uncontroversial.

Thanks, up through patch 8 this all looks good to me.

> The last tow patches make things a bit slower for me, but since they
> replace command invocations with pure-shell logic they presumably make
> things a bit less painful on e.g. Windows, and the 8th patch here
> already made things quite very fast already.

These ones I could take or leave. They probably do help a little on
Windows, but I'm much more concerned about O(nr_of_commands) process
invocations than I am in reducing the base number of invocations
(because one gives a 169x speedup over the other).

And in patch 9 in particular, we're trading a grep one-liner for a
much-longer shell loop.  And I don't think this is hypocritical with
respect to patch 8; there we are replacing ugly sed with ugly shell, and
the speed benefit is clear and large.

-Peff
