Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19744C3524D
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 08:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D732070A
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 08:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbgBCIyG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 03:54:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:51080 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727494AbgBCIyG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 03:54:06 -0500
Received: (qmail 1472 invoked by uid 109); 3 Feb 2020 08:54:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 03 Feb 2020 08:54:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23132 invoked by uid 111); 3 Feb 2020 09:02:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Feb 2020 04:02:10 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Feb 2020 03:54:05 -0500
From:   Jeff King <peff@peff.net>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: git-compat-util.h:798:13: =?utf-8?Q?er?=
 =?utf-8?B?cm9yOiBjb25mbGljdGluZyB0eXBlcyBmb3Ig4oCYaW5ldF9udG9w4oCZ?=
Message-ID: <20200203085405.GC2164@coredump.intra.peff.net>
References: <CAH8yC8m3JFvEcfFF3z1rrRnEPK-adHGObmkOhNZiph7QJKUWqA@mail.gmail.com>
 <CAH8yC8mh0gysNz3Dbrph0f8KZ8DEWaH-6rWg6fSOD-_aGh3=3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH8yC8mh0gysNz3Dbrph0f8KZ8DEWaH-6rWg6fSOD-_aGh3=3A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 01, 2020 at 07:12:21AM -0500, Jeffrey Walton wrote:

> Maybe the include should be <arpa/inet.h> on Sun systems?

It is included already. I think the real problem is that we are
declaring our own replacement inet_ntop(), which then conflicts with the
system one.

> I was able to hack around it with the following after configure:
> 
>     # Solaris 11.3 work-around. The OS has inet_ntop and inet_pton
>     for file in $(find "$PWD" -name 'Makefile')
>     do
>         sed '/ifdef NO_INET_NTOP/,+3 d' "$file" > "$file.fixed"
>         mv "$file.fixed" "$file"
>         sed '/ifdef NO_INET_PTON/,+3 d' "$file" > "$file.fixed"
>         mv "$file.fixed" "$file"
>     done

As you found there's a knob for this already. Building with:

  make NO_INET_NTOP= NO_INET_PTON=

to clear those flags would probably work (as would putting those
variables in your config.mak file).

But having those variables unset is already the default. The root of the
problem is likely that the autoconf test seems to get the wrong result
on Solaris (another workaround would be to remove them from
config.mak.autogen, but that will get obliterated next time you run
./configure).

The real fix would be teaching configure.ac to check for the correct
libraries (it looks like it has a -lsocket test already; I'm not sure if
that isn't being used in the test-compile for inet_ntop(), or if we need
to also be adding libraries like -lnsl).

I suspect that running autoconf with CFLAGS='-lsocket -lnsl' in the
environment might also make the problem go away, but it's been a long
enough time since I touched anything related to autoconf that I'm not
sure.

This also seems eerily familiar:

  https://lore.kernel.org/git/CAH8yC8kOj5a5PN4V7mj7xZPoNDr-MH-CkirxRKyfx1-qAvfpqQ@mail.gmail.com/

:) I second Junio's notion there that you may be better off skipping
./configure entirely.

-Peff
