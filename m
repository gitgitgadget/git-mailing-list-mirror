Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC16DC433DF
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 08:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81280206B5
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 08:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgHGI4v (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 04:56:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:51528 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726940AbgHGI4v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 04:56:51 -0400
Received: (qmail 30231 invoked by uid 109); 7 Aug 2020 08:56:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 07 Aug 2020 08:56:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12183 invoked by uid 111); 7 Aug 2020 08:56:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 07 Aug 2020 04:56:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 7 Aug 2020 04:56:49 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: [PATCH] sideband: mark "remote error:" prefix for translation
Message-ID: <20200807085649.GA34210@coredump.intra.peff.net>
References: <20200805084240.GA1802257@coredump.intra.peff.net>
 <20200805090641.GR2898@szeder.dev>
 <20200805092658.GA1803042@coredump.intra.peff.net>
 <xmqqwo2dnjk5.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwo2dnjk5.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 05, 2020 at 09:28:42AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > By the way, grepping for "remote error:" shows that when we get an error
> > over sideband 3 we produce the same message but _don't_ translate it.
> > That seems inconsistent.
> 
> IOW
> 
>     die(_("remote error: %s"), buf + 1);
> 
> in sideband.c?  I think it makes sense.

Yes. Patch is below so we don't forget about it. I'm not sure if we
ought to be going further, though. The "remote:" prefix for sideband 2
isn't translated either. It would be easy to do so, but it's much more
lego-like. We don't have "remote: %s" ever as a string. We just have
"remote:", and then we maybe_colorize_sideband() the result.

Would that be annoying for translators, especially with RTL languages?
Do people actually want to see "remote:" (or "remote error:" for that
matter) translated, or does mixing translated and untranslated messages
on one line end up more confusing? I'm out of my element here, as I
wouldn't ever use the translations myself.

> IIRC, the current thinking is to let the remote side localize their
> message before sending them over the wire and we'll worry about how
> we let the receiving end tell what l10n it wants later.  So "remote
> error:" prefix may have to be translated on receiving end and the
> remainder of the line, which is already localized, can just be
> interpolated.

Yeah, that part makes sense. The local client shouldn't be translating
what it gets from the server (and won't, because it is filled in via the
%s). Adding a capability for preferred language would be easy, though I
imagine it might be irritating in practice.  As a server admin, I want
to see everything in the C locale; but what gets shown to users and what
might get dumped into server logs is not well specified in Git. I have a
feeling that just setting LANG based on the user's request would be a
bit broad.

Anyway, here's the patch. It doesn't seem to cause any test failures,
even with GETTEXT_POISON. :)

-- >8 --
Subject: [PATCH] sideband: mark "remote error:" prefix for translation

A Git client may produce a "remote error:" message (along with whatever
error the other side sent us) in two places:

  - when we see an ERR packet

  - when we're using a sideband and see sideband 3

We can't reliably translate the message the other side sent us, but we
can do so for our own prefix. However, we translate only the ERR-packet
case but not the sideband-3 case. Let's make them consistent (by marking
both for translation).

Signed-off-by: Jeff King <peff@peff.net>
---
I really just care about consistency between the two spots, so swapping
this to translate neither would be to me, too. I guess this does create
inconsistency with "remote: " though. Not sure if it's incremental
forward progress, or just a bad idea. ;)

 sideband.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sideband.c b/sideband.c
index ef851113c4..0a60662fa6 100644
--- a/sideband.c
+++ b/sideband.c
@@ -147,7 +147,7 @@ int demultiplex_sideband(const char *me, char *buf, int len,
 	switch (band) {
 	case 3:
 		if (die_on_error)
-			die("remote error: %s", buf + 1);
+			die(_("remote error: %s"), buf + 1);
 		strbuf_addf(scratch, "%s%s", scratch->len ? "\n" : "",
 			    DISPLAY_PREFIX);
 		maybe_colorize_sideband(scratch, buf + 1, len);
-- 
2.28.0.520.g10e2ce7e11

