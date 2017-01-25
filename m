Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C97E81F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 22:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752075AbdAYWBE (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 17:01:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:44860 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750930AbdAYWBE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 17:01:04 -0500
Received: (qmail 6498 invoked by uid 109); 25 Jan 2017 22:01:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 22:01:03 +0000
Received: (qmail 16816 invoked by uid 111); 25 Jan 2017 22:01:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 17:01:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jan 2017 17:01:01 -0500
Date:   Wed, 25 Jan 2017 17:01:01 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: Fixing the warning about warning(""); was: Re: [PATCH]
 difftool.c: mark a file-local symbol with static
Message-ID: <20170125220101.et67ebkumsqosaku@sigill.intra.peff.net>
References: <20161201040234.3rnuttitneweedn5@sigill.intra.peff.net>
 <xmqq60n3bjel.fsf@gitster.mtv.corp.google.com>
 <20161201185056.eso5rhec7izlbywa@sigill.intra.peff.net>
 <20170122052608.tpr5pihfgafhoynj@gmail.com>
 <20170124142346.u3d7l6772mtkgpcf@sigill.intra.peff.net>
 <xmqqlgu0ceia.fsf@gitster.mtv.corp.google.com>
 <20170124230500.h3fasbvutjkkke5h@sigill.intra.peff.net>
 <alpine.DEB.2.20.1701251135090.3469@virtualbox>
 <20170125183542.pe5qolexqqx6jhsi@sigill.intra.peff.net>
 <xmqq7f5iakxw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7f5iakxw.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 01:28:27PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The only advantage is that it is self-documenting, so somebody does not
> > come through later and convert ("%s", "") back to (""). We could also
> > write a comment. But I am happy if we simply catch it in review (or
> > preferably the person is clueful enough to read the output of git-blame
> > and see why it is that way in the first place).
> 
> And the last sentence unfortunatly does not reflect reality.  
> 
> I would prefer something self-documenting, like your wrapper with a
> comment.  Then somebody who is looking at the implementation of
> warning_blank_line() will not get tempted to turn "%s", "" into ""
> because of the comment.  And somebody who is looking at the callsite
> of warning_blank_line() will think twice before suggesting to turn
> it into warning("").

I am OK with it either way. I was mostly responding to Dscho's
complaint, and I would just like to get this resolved so we never have
to revisit it again. :)

> In any case, the patch is a minimum effort band-aid that lets us
> punt on the whole issue for now, so I'll queue it as-is.

Here's one other option that I came across. Pragmas feel gross, but I
think it will behave as we want, and it doesn't require cooperation from
the callsites at all.

-- >8 --
Subject: [PATCH] disable -Wzero-length-format via #pragma

Building with "gcc -Wall" will complain that the format in:

  warning("")

is empty. Which is true, but the warning is over-eager. We
are calling the function for its side effect of printing
"warning:", even with an empty string.

We disable this warning already with the DEVELOPER Makefile
knob. But we can't unconditionally add -Wno-format-zero-length
to the normal CFLAGS variable, because not all compilers will
understand it. So we may get reports about the warning from
non-developer users who compile with our default of -Wall.

Instead, we can disable the warning using a gcc-specific
#pragma. This should be ignored by non-gcc compilers, and do
what we want for gcc.

I tested also with clang, which often implements gcc
compatible extensions like this. Clang does not generate the
warning in the first place, but also does not complain about
our pragma.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-compat-util.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 325950426..a6558930d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -413,6 +413,8 @@ extern int error_errno(const char *err, ...) __attribute__((format (printf, 1, 2
 extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
+#pragma GCC diagnostic ignored "-Wformat-zero-length"
+
 #ifndef NO_OPENSSL
 #ifdef APPLE_COMMON_CRYPTO
 #include "compat/apple-common-crypto.h"
-- 
2.11.0.840.gd37c5973a

